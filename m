Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9DBC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F731208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Gs/FzBIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F731208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdo5-0002M7-7l
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iAdAR-0003UV-HG
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iAdAQ-0005Y1-26
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:50:58 -0400
Received: from mail-eopbgr00117.outbound.protection.outlook.com
 ([40.107.0.117]:21924 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iAdAP-0005W1-9L; Wed, 18 Sep 2019 12:50:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvCWC5A6Bus+HE6GoTxr0BWyNt5R79kKJcSmoE9UprKyZWKD9xBLhr6FhT5CgEVcHeWkwkfr+8DpIXXlBn/ut9KLqdyJ+v1k6DcMBFpdLbf5fcwBuvf6YtJa/H5QZ8dj2/M1q5BZ3sHFax+MoBE2f4Ld+Njk6t+KtCfKm0ly2ohDokWgTk1bCqs1byGz8EkwWa/AFYDl0Wamhy4hwXL55YiRBrSpGYaLoklEotLAIHCZUxfaQvQ7iS+/20R4F5OBpDhdY+dqqXtt71IiW+atvB4Gqa9ZoaeqZRPbc/cktzb7ylJXtDoFs7CP4wcUiVQ491KprAzuMiohJfr1tkGX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzbWEp8M8LDGVF+dJi+ic1DEDgKH70tsPimSBpadjNo=;
 b=Dl9a7gyl4n3L7QoV14feRa7HnFLgNgdWQ4FHqYQxGlPhYoCDVB970tVw8LxvixQ43afbtYFhmmptGBhfZoMCsERH11HBd0MLwXBTXmv3wlHkYLtZB1+1Qi9iQ61sRJKHe8HkNgCdb4bHhpxziVMWq4GcJoOTnMh2N9c9KIRMGiWEYL0M19Pq46oQ2sGEjpnkTnbAr57ettegfx4x1GxhlYkbEk8zdt+E77CKgR4xvBb8/SNuenscxHsvlLJtZU/Gjn8o7y82NcTOUnze+HjzBTLQGQ+YFxrPmFFr04s1ID2RqWibDOegwMzkmktlmzw2B0CZysSm7d86xyrTFdEfrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzbWEp8M8LDGVF+dJi+ic1DEDgKH70tsPimSBpadjNo=;
 b=Gs/FzBIPxXX6lXnFT/WYLb7d+cPJHmDv4doVhaa9Q3ePbePcZommZo0swjtrARrRBw3zPB394t9NJ7XFMRU1sCw7ASzLg9ukPz3epdCdiTQarxEoslm08/z1GoRxVEg6jRovGArCjCpcz/zrMvK1krrox8ZuwJQyPEJYTyqM93c=
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com (10.175.33.138) by
 HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Wed, 18 Sep 2019 16:50:53 +0000
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10]) by HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10%6]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 16:50:53 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 5/7] iotests: Test driver whitelisting in 093
Thread-Index: AQHVbTkpPYQu7ydmKEWdRwl8TyK6I6cwH0sAgADa+oCAAK29gA==
Date: Wed, 18 Sep 2019 16:50:53 +0000
Message-ID: <03b66802-79f2-2027-e0aa-b7f25308d623@virtuozzo.com>
References: <20190917092004.999-1-mreitz@redhat.com>
 <20190917092004.999-6-mreitz@redhat.com>
 <fb3673f7-8694-2be1-f843-8786167049c4@virtuozzo.com>
 <0cf07aa2-d17c-5ad8-0bb4-828215136cb5@redhat.com>
In-Reply-To: <0cf07aa2-d17c-5ad8-0bb4-828215136cb5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0010.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::20) To HE1PR0802MB2460.eurprd08.prod.outlook.com
 (2603:10a6:3:dd::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2e7cdc2-c037-4387-fcf7-08d73c585e5c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:HE1PR0802MB2507; 
x-ms-traffictypediagnostic: HE1PR0802MB2507:
x-microsoft-antispam-prvs: <HE1PR0802MB25074D833CD2D871C4031287F48E0@HE1PR0802MB2507.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(39850400004)(396003)(346002)(376002)(189003)(199004)(26005)(52116002)(316002)(229853002)(186003)(66446008)(31696002)(7736002)(31686004)(446003)(53546011)(81156014)(2616005)(11346002)(44832011)(478600001)(386003)(305945005)(14454004)(8676002)(8936002)(86362001)(476003)(6506007)(6512007)(102836004)(256004)(99286004)(64756008)(66476007)(66946007)(66556008)(36756003)(3846002)(4326008)(71200400001)(110136005)(6116002)(71190400001)(486006)(76176011)(81166006)(2501003)(2906002)(66066001)(25786009)(6246003)(6486002)(54906003)(6436002)(4744005)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2507;
 H:HE1PR0802MB2460.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a0z7OTO8whNb4yktVXEr56ijd+T7KTf+1kRdGbrVVV+yg38yfqEUYpOgbeXnJH+bDMugO5Q2fZJk2qWL8IVFd1shZZImiHMZy/j2D3hFonuoTW/ChZyWeIHhd+L3ce60GXZW41xhStKPzpZT/udzAwwl/yGENFaB4YVjlZgI88AUH9nTlEWg3S7NcSmkLZJU6xjXPgySaMLFkQANsgfOeaDuM6du5nl3idTDTUXM3k/r2u6hWz1Ck3kAW+oTzEUa0AJMDqGMT4LqHg0s6XeJ6h7RTPyxXNEt7ivrGiSaz6qHb/jtnB04jQaHLRlQCWlcb9mdnqiFG4EIXnEAki/ZwPd7MGVxz3oyLb401P/wJOtT4p6KovUo9H4NqorHvYxdsgZqgPII2ee/uIgJfh4fM/3TISt7pY/RJWALgmohjiQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9E669F9EDF0614FAF9937608634CB1B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e7cdc2-c037-4387-fcf7-08d73c585e5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 16:50:53.6564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKJIXfLDMbIKRDYuvrWmwiskOE3SDdY06KtadAeyF3qBMAOoHbJ3TgkXv1GAHczd5n+GUatDRfndmQfiwDwi6SueHNZjct3tcu2ARhhFt3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2507
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.117
Subject: Re: [Qemu-devel] [PATCH v4 5/7] iotests: Test driver whitelisting
 in 093
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE4LzA5LzIwMTkgMDk6MjksIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMTcuMDkuMTkg
MTY6MjUsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAxNy8wOS8yMDE5
IDEyOjIwLCBNYXggUmVpdHogd3JvdGU6DQo+Pj4gbnVsbC1haW8gbWF5IG5vdCBiZSB3aGl0ZWxp
c3RlZC4gIFNraXAgYWxsIHRlc3QgY2FzZXMgdGhhdCByZXF1aXJlIGl0Lg0KPj4+DQo+Pj4gKEFu
ZCBza2lwIHRoZSB3aG9sZSB0ZXN0IGlmIG51bGwtY28gaXMgbm90IHdoaXRlbGlzdGVkLikNCj4+
IFRoaXMgc29sdXRpb24gaGFzIGJlZW4gcGVyc2lzdGluZyBzaW5jZSB2MS4gTmV2ZXJ0aGVsZXNz
LCBJIGFtIHN0aWxsIG5vdA0KPj4gY2xlYXIgd2h5IG5vdCB0byBydW4gdGhlIHRlc3QgaWYgdGhl
IG51bGwtYWlvIGlzIHRoZSBvbmx5IHdoaXRlbGlzdGVkDQo+PiBkcml2ZXI/IFdpbGwgdGhlIG51
bGwtYWlvIGJlIHN1cHBvcnRlZCBpbiBmdXR1cmU/DQo+IA0KPiBJIGRvbuKAmXQgc2VlIGEgcmVh
c29uIHdoeSB3ZeKAmWQgcmVtb3ZlIGl0LiAgQnV0IGNoYW5jZXMgYXJlLCBpZiBhbnkgb2YgdGhl
DQo+IG51bGwqIGRyaXZlcnMgaXMgd2hpdGVsaXN0ZWQsIGl04oCZbGwgYmUgbnVsbC1jbyAoYmVj
YXVzZSB3ZSBiYXJlbHkgdXNlDQo+IHRoZSBBSU8gYmxvY2sgZHJpdmVyIGludGVyZmFjZSBhbnlt
b3JlKS4NCj4gDQo+IE1heA0KPiANCg0KVGhhbmsgeW91IE1heC4NCg0KQW5kcmV5DQotLSANCldp
dGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQoNCg==

