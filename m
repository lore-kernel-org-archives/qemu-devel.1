Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE91C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 11:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E72208C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 11:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LA1jGi/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E72208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx8Dn-0002ER-8k
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 07:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60289)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hx8Cw-0001ZH-NS
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 07:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hx8Cv-0004lu-9a
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 07:09:46 -0400
Received: from mail-eopbgr50101.outbound.protection.outlook.com
 ([40.107.5.101]:40582 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hx8Cu-0004ii-Nw; Mon, 12 Aug 2019 07:09:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EF1HGz0XrnjHfXt/9pg300ZceRgs0E2c48RAgsS5mjZ36Kop6ragBU415d1fne49EE/C+IdAVrZQK2hL2FeTqvtUnSc8P43HVXqSgFY3GbasNTNryVHO2MNE01o9iGM9z61GAItKL5kXKEk1H1x8DyjIpMMV8KVp0wUdhOCb2H63HUlRUGebFPQSkwgjvQ9CcZCP3lZV06OtXgW0uekDSD+ERxElYo10c2Qtd9XsBPnXWSsfs2C4b/XxmXYI7zKDUKkbhPqHntc1D6wVbY7jWjgh8gBGN+HAOxVqy8AH9ujS17H6BU+erYf7mR2WWL34DABnOcHmE0hBiKK7mYTdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=youc6AORTyum/WpSrj8AqIx4dK0ShX6Slp4uS8H08hQ=;
 b=aqH/MqrsSKNeX3vR1FIDFwaaAgZO+qTomv6GQL+w7vOhWVAD42oTkF/R9JBOQTcs9zy5Zu0jhbp8pZ5GtTBymo7cAK18Cbq4BaFYVz48loYMXAu2ZcIcS/FPXQFFmwl/qClx5BSK8yZWXPNsatI1InOv5IHScLZxSKt/R4Et0a16fEw3//6Rn/LfrRbZrE2MkTytwSqofXCeXF7hvszJ5cQNhZk9L4WJkaZP+SjUMcLZjJmGQfhtJvWOZlaa5DY0fThh2wSs5agt1GqJS9k8WXI05pdgibToVM/LBVWpJk26siOIW2NFP5FyBnlaUOjmn5Q14SZr+RMnrSUnEFWR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=youc6AORTyum/WpSrj8AqIx4dK0ShX6Slp4uS8H08hQ=;
 b=LA1jGi/FyDYHQrDp60H0ooG5R4QNU5BDLfOtFqF7ACIeMuoVhZqQuts/gFi0r2FGSO98DZHvZxsliCuBoEMovQQUxLnH4Bh/Mc74Sg2dEFmNwNi8M5oA+bMkQ0Rh60lLvQCdDSD+7Wi+6xk5nyaqfq9yYHyflWHhXxTZwJDUSpE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5178.eurprd08.prod.outlook.com (10.255.19.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Mon, 12 Aug 2019 11:09:41 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 11:09:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 25/42] mirror: Deal with filters
Thread-Index: AQHVTs2fW9lDc3qUnk+iNbQLgM6ojqb3X0KA
Date: Mon, 12 Aug 2019 11:09:41 +0000
Message-ID: <586c3836-66b6-2a67-3f2c-de38f9a52bcd@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-26-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-26-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::13) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190812140939406
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 947ed3a1-b1fb-4aad-100c-08d71f1592c4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5178; 
x-ms-traffictypediagnostic: DB8PR08MB5178:
x-microsoft-antispam-prvs: <DB8PR08MB517886E35814D4EEA798547DC1D30@DB8PR08MB5178.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(136003)(39840400004)(346002)(366004)(199004)(189003)(6436002)(102836004)(6246003)(54906003)(52116002)(8676002)(110136005)(25786009)(476003)(2616005)(5660300002)(446003)(99286004)(76176011)(14454004)(386003)(6486002)(6506007)(2906002)(478600001)(316002)(11346002)(31686004)(66446008)(64756008)(66556008)(66476007)(66946007)(486006)(26005)(6512007)(66066001)(36756003)(31696002)(186003)(86362001)(71200400001)(71190400001)(53936002)(305945005)(2501003)(6116002)(3846002)(229853002)(14444005)(4326008)(256004)(8936002)(81156014)(81166006)(7736002)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5178;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3GSn0GC6ZDhy0P2mZmEZC4V1K9m+JiiPCvBHJ2PphtF1UeUJXbtaC7+jjxqt4yigrcpPckie2V3cqiuU7OWxEDNLIRN47ue8Jji4i3hoWoaUoyxT5te5Cq0KM5Gev6NHcl8nOPvMe0gAbJrDiXdjfSG/G8kaCRAdFT2/aKpeHS7EAwTRhJXf9rCrWdnD6M5bsQ3TawH4Npz4XWqzmG69HGKhfs328V6mvVJ37EEyNc+fdcSV1PqTDkhLpG6DvOnKS+I6CG/qK+mQ4oI4xCgZR8MVWoxVXwWDD4w6yn7iIeeg+AD1lNecGZ5de3gn0crWqx4tesQ+ALZ5gukwdtG7ztQTEavfDa/iAA/eOhx8WE/Wm2VxYY3KKCV4nyp2oFXsrzgMDKz2OGZHNe6O8bsblYAVz3NMWOk90mCq/KAWfOA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B86FF1E635EA741BD9DB008DC6C2DCC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947ed3a1-b1fb-4aad-100c-08d71f1592c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 11:09:41.6223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s66jUGXeZX1G+yfgGqdYUBqe4GhvmgFV3aZ1N1PmJyiobMOgCxmpMpKYkLleD7UsHz1mFKTR5JAn+sZeHOGWeJZnYsqYb4rz0ZgFceTJ7kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5178
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.101
Subject: Re: [Qemu-devel] [PATCH v6 25/42] mirror: Deal with filters
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxOToxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGlzIGluY2x1ZGVzIHNvbWUg
cGVybWlzc2lvbiBsaW1pdGluZyAoZm9yIGV4YW1wbGUsIHdlIG9ubHkgbmVlZCB0bw0KPiB0YWtl
IHRoZSBSRVNJWkUgcGVybWlzc2lvbiBmb3IgYWN0aXZlIGNvbW1pdHMgd2hlcmUgdGhlIGJhc2Ug
aXMgc21hbGxlcg0KPiB0aGFuIHRoZSB0b3ApLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJl
aXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgYmxvY2svbWlycm9yLmMgfCAxMTcg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAgIGJs
b2NrZGV2LmMgICAgIHwgIDQ3ICsrKysrKysrKysrKysrKysrLS0tDQo+ICAgMiBmaWxlcyBjaGFu
Z2VkLCAxMzEgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYmxvY2svbWlycm9yLmMgYi9ibG9jay9taXJyb3IuYw0KPiBpbmRleCA1NGJhZmRmMTc2Li42
ZGRiZmI5NzA4IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9taXJyb3IuYw0KPiArKysgYi9ibG9jay9t
aXJyb3IuYw0KDQoNClsuLl0NCg0KPiBAQCAtMTY5MywxNSArMTczNCwzOSBAQCBzdGF0aWMgQmxv
Y2tKb2IgKm1pcnJvcl9zdGFydF9qb2IoDQo+ICAgICAgIC8qIEluIGNvbW1pdF9hY3RpdmVfc3Rh
cnQoKSBhbGwgaW50ZXJtZWRpYXRlIG5vZGVzIGRpc2FwcGVhciwgc28NCj4gICAgICAgICogYW55
IGpvYnMgaW4gdGhlbSBtdXN0IGJlIGJsb2NrZWQgKi8NCj4gICAgICAgaWYgKHRhcmdldF9pc19i
YWNraW5nKSB7DQo+IC0gICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKml0ZXI7DQo+IC0gICAgICAg
IGZvciAoaXRlciA9IGJhY2tpbmdfYnMoYnMpOyBpdGVyICE9IHRhcmdldDsgaXRlciA9IGJhY2tp
bmdfYnMoaXRlcikpIHsNCj4gLSAgICAgICAgICAgIC8qIFhYWCBCTEtfUEVSTV9XUklURSBuZWVk
cyB0byBiZSBhbGxvd2VkIHNvIHdlIGRvbid0IGJsb2NrDQo+IC0gICAgICAgICAgICAgKiBvdXJz
ZWx2ZXMgYXQgcy0+YmFzZSAoaWYgd3JpdGVzIGFyZSBibG9ja2VkIGZvciBhIG5vZGUsIHRoZXkg
YXJlDQo+IC0gICAgICAgICAgICAgKiBhbHNvIGJsb2NrZWQgZm9yIGl0cyBiYWNraW5nIGZpbGUp
LiBUaGUgb3RoZXIgb3B0aW9ucyB3b3VsZCBiZSBhDQo+IC0gICAgICAgICAgICAgKiBzZWNvbmQg
ZmlsdGVyIGRyaXZlciBhYm92ZSBzLT5iYXNlICg9PSB0YXJnZXQpLiAqLw0KPiArICAgICAgICBC
bG9ja0RyaXZlclN0YXRlICppdGVyLCAqZmlsdGVyZWRfdGFyZ2V0Ow0KPiArICAgICAgICB1aW50
NjRfdCBpdGVyX3NoYXJlZF9wZXJtczsNCj4gKw0KPiArICAgICAgICAvKg0KPiArICAgICAgICAg
KiBUaGUgdG9wbW9zdCBub2RlIHdpdGgNCj4gKyAgICAgICAgICogYmRydl9za2lwX3J3X2ZpbHRl
cnMoZmlsdGVyZWRfdGFyZ2V0KSA9PSBiZHJ2X3NraXBfcndfZmlsdGVycyh0YXJnZXQpDQo+ICsg
ICAgICAgICAqLw0KPiArICAgICAgICBmaWx0ZXJlZF90YXJnZXQgPSBiZHJ2X2ZpbHRlcmVkX2Nv
d19icyhiZHJ2X2ZpbmRfb3ZlcmxheShicywgdGFyZ2V0KSk7DQo+ICsNCj4gKyAgICAgICAgYXNz
ZXJ0KGJkcnZfc2tpcF9yd19maWx0ZXJzKGZpbHRlcmVkX3RhcmdldCkgPT0NCj4gKyAgICAgICAg
ICAgICAgIGJkcnZfc2tpcF9yd19maWx0ZXJzKHRhcmdldCkpOw0KPiArDQo+ICsgICAgICAgIC8q
DQo+ICsgICAgICAgICAqIFhYWCBCTEtfUEVSTV9XUklURSBuZWVkcyB0byBiZSBhbGxvd2VkIHNv
IHdlIGRvbid0IGJsb2NrDQo+ICsgICAgICAgICAqIG91cnNlbHZlcyBhdCBzLT5iYXNlIChpZiB3
cml0ZXMgYXJlIGJsb2NrZWQgZm9yIGEgbm9kZSwgdGhleSBhcmUNCj4gKyAgICAgICAgICogYWxz
byBibG9ja2VkIGZvciBpdHMgYmFja2luZyBmaWxlKS4gVGhlIG90aGVyIG9wdGlvbnMgd291bGQg
YmUgYQ0KPiArICAgICAgICAgKiBzZWNvbmQgZmlsdGVyIGRyaXZlciBhYm92ZSBzLT5iYXNlICg9
PSB0YXJnZXQpLg0KPiArICAgICAgICAgKi8NCj4gKyAgICAgICAgaXRlcl9zaGFyZWRfcGVybXMg
PSBCTEtfUEVSTV9XUklURV9VTkNIQU5HRUQgfCBCTEtfUEVSTV9XUklURTsNCj4gKw0KPiArICAg
ICAgICBmb3IgKGl0ZXIgPSBiZHJ2X2ZpbHRlcmVkX2JzKGJzKTsgaXRlciAhPSB0YXJnZXQ7DQo+
ICsgICAgICAgICAgICAgaXRlciA9IGJkcnZfZmlsdGVyZWRfYnMoaXRlcikpDQo+ICsgICAgICAg
IHsNCj4gKyAgICAgICAgICAgIGlmIChpdGVyID09IGZpbHRlcmVkX3RhcmdldCkgew0KPiArICAg
ICAgICAgICAgICAgIC8qDQo+ICsgICAgICAgICAgICAgICAgICogRnJvbSBoZXJlIG9uLCBhbGwg
bm9kZXMgYXJlIGZpbHRlcnMgb24gdGhlIGJhc2UuDQo+ICsgICAgICAgICAgICAgICAgICogVGhp
cyBhbGxvd3MgdXMgdG8gc2hhcmUgQkxLX1BFUk1fQ09OU0lTVEVOVF9SRUFELg0KPiArICAgICAg
ICAgICAgICAgICAqLw0KPiArICAgICAgICAgICAgICAgIGl0ZXJfc2hhcmVkX3Blcm1zIHw9IEJM
S19QRVJNX0NPTlNJU1RFTlRfUkVBRDsNCg0KDQpIbW0sIEkgZG9uJ3QgdW5kZXJzdGFuZCwgd2h5
IHJlYWQgZnJvbSB1cHBlciBub2RlcyBpcyBub3Qgc2hhcmVkPw0KDQo+ICsgICAgICAgICAgICB9
DQo+ICsNCj4gICAgICAgICAgICAgICByZXQgPSBibG9ja19qb2JfYWRkX2JkcnYoJnMtPmNvbW1v
biwgImludGVybWVkaWF0ZSBub2RlIiwgaXRlciwgMCwNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBCTEtfUEVSTV9XUklURV9VTkNIQU5HRUQgfCBCTEtfUEVSTV9XUklU
RSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJwKTsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpdGVyX3NoYXJlZF9wZXJtcywgZXJy
cCk7DQo+ICAgICAgICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4gICAgICAgICAgICAgICAgICAg
Z290byBmYWlsOw0KPiAgICAgICAgICAgICAgIH0NCg0KWy4uXQ0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=

