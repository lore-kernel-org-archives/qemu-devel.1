Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9233CC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6472146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="g99mvX7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6472146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibmj6-00078i-Hc
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 09:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ibmi7-0006bQ-0h
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ibmi5-0006iN-LT
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:29:58 -0500
Received: from mail-eopbgr150120.outbound.protection.outlook.com
 ([40.107.15.120]:5095 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ibmi5-0006i9-0T; Mon, 02 Dec 2019 09:29:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfoFfZi25NnUHj4EJ0wI49PLmqdceS/JCvxhOYGiW2A2ibrs4Q/8ajUZyCvEZ4sl9FaQiu9dvIqbzV1vw9fjhl9Wcl3/ahl3Q6GNeIqgU7RloJwllaM/CLy4q2oiY6PB/B4oe20vtAd5KrzOmf/OJa/SCYvFL2OiI6nYTVpdFkQQfKnKa2zzKtYE6ieduho4dEh9vkVYDjsEB7w63q+0id+BFOMrZ5bNtW03Gcz+w2YHAk3s8mWRhvnhtS6NYLH/RnkFxkDUZNMqj+S5Ayh8fl8RCW55TUthnU67YNGacMlvmT4I6LUZ9aMgXRHF0WRDMhup3XIsynQbUW/PjTX4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mwZO9aeLPCGJkGV4vCQamXTvyvOcsWwuNYSvCxOnTk=;
 b=SdUuuModuvZRhbpnb8CWE1GOXukvP4cWiyY2xIdcWjj2FwrciXV8QT2uDZcQlNMfRGqUEBCuWIPtAx2YnYBHi68otUhoT9Cgue4Elw2YZrHGy+M0+6P6fwDcE7qATx72/36HLU3vBrdyn/+U/xyjtrybmOJaE7Qe+eONbitudfhL5qOwIHW/YYS2IRh2LRKSJ1hKC0TRw8vd51FeFtzfCNYoj3C9CGULf6LNf25aU6Kob70AsYHZHafhOOfOXh3wrPxVGb779SDwuuNENodakM9066Z2mCgEQz8NJrBVIp8GW6XY8B4MK6CMQqrU7Kp2uXOX0jrXs4Gy3v8p2Wz4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mwZO9aeLPCGJkGV4vCQamXTvyvOcsWwuNYSvCxOnTk=;
 b=g99mvX7+/reIuybKSeA37zEu6PNNIR0vrVHcw0EJPTmFHuvaOhtC99dQTkwk5Jfbq+XJE4YCK1Y8DH/dKgob+nM6r0wItYB4LlO8zfXtdX4sGDgTQHxpXxm4mz3/GHfjaTlJK8OIP0glQ7I64NLUlo5ZXEbmVrKrRxiHzezGaLc=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4739.eurprd08.prod.outlook.com (10.255.97.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 14:29:54 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 14:29:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH 0/5] fix migration with bitmaps and mirror
Thread-Topic: [PATCH 0/5] fix migration with bitmaps and mirror
Thread-Index: AQHVessC0060zPak00+qTjXkhg9qSaenRFQA
Date: Mon, 2 Dec 2019 14:29:54 +0000
Message-ID: <e4cc9d3d-ca5c-424d-468e-515783094c49@virtuozzo.com>
References: <20191004154701.3202-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191004154701.3202-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0016.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::26) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191202172952118
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c53104a-7766-474d-8b59-08d77734195c
x-ms-traffictypediagnostic: AM6PR08MB4739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4739721E8FE3A2F9152D8FAFC1430@AM6PR08MB4739.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:59;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(39840400004)(136003)(53754006)(189003)(199004)(6486002)(8936002)(2501003)(11346002)(14454004)(36756003)(52116002)(229853002)(66066001)(66946007)(71200400001)(6246003)(6306002)(31686004)(478600001)(966005)(31696002)(5660300002)(99286004)(446003)(6512007)(86362001)(76176011)(305945005)(7736002)(256004)(316002)(102836004)(2906002)(6916009)(186003)(6436002)(2616005)(71190400001)(5640700003)(26005)(2351001)(107886003)(25786009)(4326008)(6116002)(54906003)(386003)(66476007)(6506007)(8676002)(81156014)(81166006)(3846002)(66556008)(64756008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4739;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a+YXSldoTKyKDv1xlx6eb+SKq3Ym9hOD39Ty9yFOV5CbVhOGB1M6o68KDUki4Hj3On2oAOanZeRDa+j838JvJzADzhZVsCySuvqj2XnRl5XVxVnSLN7NMOGZGMDNmVKeRPu3tHuS3fdREzb0lK6vKWGtqlARIAHwfyKd1udZ9KUmtORpNir1JnlJdrzXURAhlKTXhXFnLtVVxYAzlIWUDGAXH7jkCwCiA4OuXA4XrsXNA6z8LrYxC6lkHbvw1ESE+N6ns6d0veRPG6xQGUsSinSxcOKXNYvRrhzo5KhVbeeqkUK6B0D8F6Uv18jROYycdhwPxwk7gPuwHLMrEYK/sbHOzMhcjiaGz82DztW/amRDim2B7W6NwQXk/6nsokyldjpPTQehkNmuwGlXL8iV3XhBRaqR7zo49Ws3soMGFROza5AjwbhAiVnF1blXgi7vVQ4bj09btfbjTQ+3mXXqVui/kT8ggEWPVUVSNyqNW+k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA7298D6A4901842B210BE2313FB6371@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c53104a-7766-474d-8b59-08d77734195c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 14:29:54.6802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8F9oM+MCPWzEwapmuvY+VaaeU8u/LCbf/vy27fUmNNur32QLxv5MAXPWh47DWVliX0STG9spEDXOtlXltsESuUfmAMhzqDf7+Q2lPWUh4cE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4739
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, "quintela@redhat.com" <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQowNC4xMC4yMDE5IDE4OjQ2LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIaSBhbGwhDQo+IA0KPiBJdCdzIGEgY29udGludWF0aW9uIGZvcg0KPiAiYml0bWFw
IG1pZ3JhdGlvbiBidWcgd2l0aCAtZHJpdmUgd2hpbGUgYmxvY2sgbWlycm9yIHJ1bnMiDQo+IDwz
MTVjZmY3OC1kY2RiLWEzY2UtMjc0Mi1kYTNjYzlmMGNhOTdAcmVkaGF0LmNvbT4NCj4gaHR0cHM6
Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDkvbXNnMDcyNDEu
aHRtbA0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhhdCBiaXRtYXBzIG1pZ3JhdGVkIHRvIG5vZGUg
d2l0aCBzYW1lIG5vZGUtbmFtZSBvcg0KPiBibGstcGFyZW50IG5hbWUuIEFuZCBjdXJyZW50bHkg
b25seSB0aGUgbGF0dGVyIGFjdHVhbGx5IHdvcmsgaW4gbGlidmlydC4NCj4gQW5kIHdpdGggbWly
cm9yLXRvcCBmaWx0ZXIgaXQgZG9lc24ndCB3b3JrLCBiZWNhdXNlDQo+IGJkcnZfZ2V0X2Rldmlj
ZV9vcl9ub2RlX25hbWUgZG9uJ3QgZ28gdGhyb3VnaCBmaWx0ZXJzLg0KPiANCj4gRml4IHRoaXMg
YnkgaGFuZGxpbmcgZmlsdGVyZWQgY2hpbGRyZW4gb2YgYmxvY2sgYmFja2VuZHMgaW4gc2VwYXJh
dGUuDQo+IA0KPiBNYXggUmVpdHogKDEpOg0KPiAgICBibG9jazogTWFyayBjb21taXQgYW5kIG1p
cnJvciBhcyBmaWx0ZXIgZHJpdmVycw0KPiANCj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSAoNCk6DQo+ICAgIG1pZ3JldGlvbi9ibG9jay1kaXJ0eS1iaXRtYXA6IHJlZmFjdG9yIGluaXRf
ZGlydHlfYml0bWFwX21pZ3JhdGlvbg0KPiAgICBibG9jay9kaXJ0eS1iaXRtYXA6IGFkZCBiZHJ2
X2hhc19uYW1lZF9iaXRtYXBzIGhlbHBlcg0KPiAgICBtaWdyYXRpb24vYmxvY2stZGlydHktYml0
bWFwOiBmaXggYml0bWFwcyBtaWdyYXRpb24gZHVyaW5nIG1pcnJvciBqb2INCj4gICAgaW90ZXN0
czogMTk0OiB0ZXN0IGFsc28gbWlncmF0aW9uIG9mIGRpcnR5IGJpdG1hcA0KPiANCj4gICBpbmNs
dWRlL2Jsb2NrL2Jsb2NrX2ludC5oICAgICAgfCAgIDggKystDQo+ICAgaW5jbHVkZS9ibG9jay9k
aXJ0eS1iaXRtYXAuaCAgIHwgICAxICsNCj4gICBibG9jay9jb21taXQuYyAgICAgICAgICAgICAg
ICAgfCAgIDIgKw0KPiAgIGJsb2NrL2RpcnR5LWJpdG1hcC5jICAgICAgICAgICB8ICAxMyArKysr
DQo+ICAgYmxvY2svbWlycm9yLmMgICAgICAgICAgICAgICAgIHwgICAyICsNCj4gICBtaWdyYXRp
b24vYmxvY2stZGlydHktYml0bWFwLmMgfCAxMTggKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzE5NCAgICAgICAgIHwgIDE0ICsrLS0NCj4g
ICB0ZXN0cy9xZW11LWlvdGVzdHMvMTk0Lm91dCAgICAgfCAgIDYgKysNCj4gICA4IGZpbGVzIGNo
YW5nZWQsIDEyMSBpbnNlcnRpb25zKCspLCA0MyBkZWxldGlvbnMoLSkNCj4gDQoNCg0KLS0gDQpC
ZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

