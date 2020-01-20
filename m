Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015B9C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03E720684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K2igUef7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03E720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itT1s-0006Wr-Je
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itSzO-0003di-NI
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itSzN-0000MS-8K
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:04:54 -0500
Received: from mail-ve1eur01on072a.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::72a]:22785
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itSzM-0000Lk-If; Mon, 20 Jan 2020 04:04:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvW7uu2eDQ2dGgYsaJ8JOL/IRW9OEYBNLVG0xt8o3WH5ggNkYOalCnQGDIm8d9xbf3/RxNAV4TvNUE4kS6MVFbNOLYWUYNwA2Q1NqqDcybay51NZUOksTxQ4FuKnGCkd8OefG3DAJhDtzD80dzmYdfKDNyHjUZzwGQbV9tDwTrBf5kle0QOmZhTHyetTBjx9BHf567OZtgzbTNNgxsTVEm0dDN+3HNx9yA1ZK+d3jzLQZDuNBFqx8bPRYPuxPCfZIDHBI9x5rqmJO9jNJuh8ffRxuDzA2oko6KgtLqb0O/KID2nvC+n3O2W9YDcBxkCW/Qe3GUeiw5nHctRcYO3X4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f0B4UYTCG98PD9zgwfTUOLeMVQH7wvx0hgViWgQwaQ=;
 b=NuX6ZnTDPJiLQoN/otIr4D/Kne0ABpGR5lfwxFkZXoQz8gGrf7JYdlji4WCsxPlW7I+ceSkHyvggFFZEDCN7+HiNjQ0TQ4RnhSK0mFLft7YySbXlWs2Sx85cd9L2CT2OXySKnkQqYQY2WrrtQs2hw6nKGw6LOWbKFaPfRX9GgEIjleROhSWpKkIX6LneljBrqGk6uKMr0PKN2qi58PVhIFgtChz7eAhSlD0tLo+4ltHlva8fq/UB+CwRHg7kFJdtbThNj0FoD1aJzEWYH7I9cnLJ42F83gyO1pcfJzitUFKBqDuE/lbtnEPqmqmiIeEsdnDym6zb6lBhvvapN8B0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f0B4UYTCG98PD9zgwfTUOLeMVQH7wvx0hgViWgQwaQ=;
 b=K2igUef7q36qeRSUTHMHjWEJ+mVWgLkf2jBQKkNI+tugMTOV17tNLHr/JjIiXklQR7dFuUE9HQtyRbH09XmaEvn6hXoI5iQVpBo02XmCFy0aFtIWcfdXsNZQueovLMft7bdKTdNU/8a0rlhy5r7HbbahqcciQFhi7BIRLn4Qigw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5016.eurprd08.prod.outlook.com (10.255.122.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 09:04:49 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 09:04:49 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0202CA0013.eurprd02.prod.outlook.com (2603:10a6:3:8c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 09:04:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 0/5] fix migration with bitmaps and mirror
Thread-Topic: [PATCH v2 0/5] fix migration with bitmaps and mirror
Thread-Index: AQHVtkmClxBjAFsANkahPv5xTkXxQqfzdL8A
Date: Mon, 20 Jan 2020 09:04:49 +0000
Message-ID: <531a9a94-2d43-1de9-327a-5af723d72268@virtuozzo.com>
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191219085106.22309-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0013.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::23) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120120446811
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26a0a1e9-98fc-4c7c-5b73-08d79d87cda8
x-ms-traffictypediagnostic: AM6PR08MB5016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB5016B3219477F0A60CA4DE16C1320@AM6PR08MB5016.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:131;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(396003)(136003)(346002)(376002)(199004)(189003)(8676002)(66946007)(6916009)(71200400001)(316002)(66446008)(81156014)(186003)(66556008)(16576012)(66476007)(64756008)(7416002)(36756003)(5660300002)(6486002)(26005)(966005)(8936002)(31696002)(31686004)(52116002)(4326008)(956004)(478600001)(2616005)(16526019)(54906003)(2906002)(86362001)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5016;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S+ewfAmGYuTw6JvumqiOI9QGz1EXtuUJUqZ24yqhClK/b+4hM9msQyzDa/lF4SYZ+nVFO4KMQwlI5qVAetsa8eZYHfdBH87h1HtGIFhYqbMxWZnrMYAu0scCN6KqiBVkbEP1hIkYxyfgHz1PqYWOKI+b49YsnaSJIxKQmHhjqcpKiG0qoXzV99iXQGj+/Cl9S5O2LJOg9S8bfwe0yllpiLSuEw4OyvJJOZOvQdCouF0j/u836NhfTycMPMcOkN2oTCTmo2PM249tkyInTjhK+sn7jciTX4IrW9Wme7P6d6u3im50ptwuurr9te2L/vAOYxgWR2favBYnEKYuoiF2E+gg4MZL6wfF+A5AUsrELkLcQ+IclDf1FVD9nU1BnmIic5lI8NB71SM4k/kOpsYezbqlf+PqRxwlmLj765hZ4hw52FGbIB2XtXZCSgKPZToZDJ8ULn5fZJ/GfVrHAjmbyBDh+gLfvO0yziQvThd4+o4w5g8y1XrSJevUrOKRMWF+zf1vnzDnMxi+IZ/hB1lxzA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E37D3E8467309242836424AE2DF9AE11@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a0a1e9-98fc-4c7c-5b73-08d79d87cda8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 09:04:49.6520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uMs8FcvCt4FSCWwt0tUDd+LheqiwnDnSZS94k2y82xilRdDDNa/sTv2Vu6WAsednWkqozZ0ob43OjPCfqLSZOsFA0gJQi4hvDqGJo5beGiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::72a
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

Sm9obiwgSSBkb24ndCBxdWl0ZSBmb2xsb3cgZGlzY3Vzc2lvbiBpbiBidWd6aWxsYS4gRG8gd2Ug
bmVlZCB0aGVzZSBzZXJpZXMNCmFzIGF0IGxlYXN0IHRlbXBvcmFyeSB3b3JrYXJvdW5kLCBvciBu
b3Q/IFNob3VsZCBJIHJlc2VuZD8NCg0KDQoxOS4xMi4yMDE5IDExOjUxLCBWbGFkaW1pciBTZW1l
bnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPiBIaSBhbGwhDQo+IA0KPiBJdCdzIGEgY29udGludWF0
aW9uIGZvcg0KPiAiYml0bWFwIG1pZ3JhdGlvbiBidWcgd2l0aCAtZHJpdmUgd2hpbGUgYmxvY2sg
bWlycm9yIHJ1bnMiDQo+IDwzMTVjZmY3OC1kY2RiLWEzY2UtMjc0Mi1kYTNjYzlmMGNhOTdAcmVk
aGF0LmNvbT4NCj4gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVs
LzIwMTktMDkvbXNnMDcyNDEuaHRtbA0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhhdCBiaXRtYXBz
IG1pZ3JhdGVkIHRvIG5vZGUgd2l0aCBzYW1lIG5vZGUtbmFtZSBvcg0KPiBibGstcGFyZW50IG5h
bWUuIEFuZCBjdXJyZW50bHkgb25seSB0aGUgbGF0dGVyIGFjdHVhbGx5IHdvcmsgaW4gbGlidmly
dC4NCj4gQW5kIHdpdGggbWlycm9yLXRvcCBmaWx0ZXIgaXQgZG9lc24ndCB3b3JrLCBiZWNhdXNl
DQo+IGJkcnZfZ2V0X2RldmljZV9vcl9ub2RlX25hbWUgZG9uJ3QgZ28gdGhyb3VnaCBmaWx0ZXJz
Lg0KPiANCj4gRml4IHRoaXMgYnkgaGFuZGxpbmcgZmlsdGVyZWQgY2hpbGRyZW4gb2YgYmxvY2sg
YmFja2VuZHMgaW4gc2VwYXJhdGUuDQo+IA0KPiB2MjogcmViYXNlIG9uIGN1cnJlbnQgbWFzdGVy
DQo+IA0KPiBNYXggUmVpdHogKDEpOg0KPiAgICBibG9jazogTWFyayBjb21taXQgYW5kIG1pcnJv
ciBhcyBmaWx0ZXIgZHJpdmVycw0KPiANCj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSAo
NCk6DQo+ICAgIG1pZ3JldGlvbi9ibG9jay1kaXJ0eS1iaXRtYXA6IHJlZmFjdG9yIGluaXRfZGly
dHlfYml0bWFwX21pZ3JhdGlvbg0KPiAgICBibG9jay9kaXJ0eS1iaXRtYXA6IGFkZCBiZHJ2X2hh
c19uYW1lZF9iaXRtYXBzIGhlbHBlcg0KPiAgICBtaWdyYXRpb24vYmxvY2stZGlydHktYml0bWFw
OiBmaXggYml0bWFwcyBtaWdyYXRpb24gZHVyaW5nIG1pcnJvciBqb2INCj4gICAgaW90ZXN0czog
MTk0OiB0ZXN0IGFsc28gbWlncmF0aW9uIG9mIGRpcnR5IGJpdG1hcA0KPiANCj4gICBpbmNsdWRl
L2Jsb2NrL2Jsb2NrX2ludC5oICAgICAgfCAgIDggKystDQo+ICAgaW5jbHVkZS9ibG9jay9kaXJ0
eS1iaXRtYXAuaCAgIHwgICAxICsNCj4gICBibG9jay9jb21taXQuYyAgICAgICAgICAgICAgICAg
fCAgIDIgKw0KPiAgIGJsb2NrL2RpcnR5LWJpdG1hcC5jICAgICAgICAgICB8ICAxMyArKysrDQo+
ICAgYmxvY2svbWlycm9yLmMgICAgICAgICAgICAgICAgIHwgICAyICsNCj4gICBtaWdyYXRpb24v
YmxvY2stZGlydHktYml0bWFwLmMgfCAxMTQgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzE5NCAgICAgICAgIHwgIDE0ICsrLS0NCj4gICB0
ZXN0cy9xZW11LWlvdGVzdHMvMTk0Lm91dCAgICAgfCAgIDYgKysNCj4gICA4IGZpbGVzIGNoYW5n
ZWQsIDExOSBpbnNlcnRpb25zKCspLCA0MSBkZWxldGlvbnMoLSkNCj4gDQoNCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

