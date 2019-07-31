Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DCDC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362CF206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hZ5S7Rc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362CF206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hslql-0004sl-HQ
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 06:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57471)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hslqG-0004OE-2M
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hslqE-0005Ay-MY
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:28:20 -0400
Received: from mail-eopbgr00095.outbound.protection.outlook.com
 ([40.107.0.95]:44089 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hslqB-00057w-54; Wed, 31 Jul 2019 06:28:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifFhJExfu75Qzn/qmcz1tgAU49IIJVk7TwcBewzMiOatfwL7HfCDMNwbTh4NXdISn6HXj+fplIUQ7RFWNAUHJ37FEDSHCFbsD1tXyj+xI0hmG50jCEAvm8AFfY2N0ajyb2muyIaVSClTLXfa6UHjqUIz/VptUUWougtCe9iTSO+Jv6dx6o73iWpgyvx/SJCDRucSaWFmII3V3JHC7rnLQWSFx6OGrFxUPL3OQXu7+7Z0GhDftKhGHGJn1oblTBf7/s+kt2JZ/alQR3+t1nJvtxIBsG9daI16+T4a79XVSl430+X44nmDaeaERxZKKfgwjyBe+VT3jsFHnAu6EvzXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WIOLVZW8/YNerGHfWrRbC6mrOWP6aSGc2UC9kMNujo=;
 b=bmeboJuw8VQJJtb/XCv4VTrtaT8NKDLgdNATx8UItUUt9JxoVvGKvfIDEiZByNdLBbJDO6pUV2r17wqiQcpIAkKnXEEGGNx1tti6JRr6vhZ2/PN36Ec9vTjjfz/gzOs+QfoGJQ3gumyv0gUTDuY24aB2FUG1XXbbJVe7FtN6FSo93eNfriaRoeN/eGpXKCoyt5d97d9IrmsMpPT4WSC2gdj9V8aXQmOaLW6Kodf/SYD//JhP/fS3WYuM71WEj1LRF2yufiItfGoiK8YtFX2U/L0YFbdoWClEjjUnfkpFpZYxCsnSwhY8SQGpleGiB4iGK4s5A7Eqvz/ugEBQl/iI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WIOLVZW8/YNerGHfWrRbC6mrOWP6aSGc2UC9kMNujo=;
 b=hZ5S7Rc+qLtzfTloH+JV7chXWbN8sHzyiOXm6azdYPdFZG9DwW+XmffwAxchQNIdcoWiMGMeshobqR7hM3uaFPpw/rKgQM41eJoLdraM/7SXzbNoNmdR1HXk4bKzbbuh7rP/FZaosrVwkLmECiL6CQFLQltE50fBEhu7krVhHe4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5243.eurprd08.prod.outlook.com (20.179.15.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 31 Jul 2019 10:28:12 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 10:28:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v3] blockjob: drain all job nodes in
 block_job_drain
Thread-Index: AQHVQgPWOM3rZQFWBkKVwWST3b48QqbjkTMAgAEAEgA=
Date: Wed, 31 Jul 2019 10:28:12 +0000
Message-ID: <d8138170-aecd-dbab-3576-3b2e9d458cd5@virtuozzo.com>
References: <20190724094025.12442-1-vsementsov@virtuozzo.com>
 <1977e825-0a1f-e575-2ffa-0ea8c65531bb@redhat.com>
In-Reply-To: <1977e825-0a1f-e575-2ffa-0ea8c65531bb@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0010.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::20) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190731132810221
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b1b2c83-ad08-44dd-c971-08d715a1ca31
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5243; 
x-ms-traffictypediagnostic: DB8PR08MB5243:
x-microsoft-antispam-prvs: <DB8PR08MB5243EBE71E2E422F8D6DC7D6C1DF0@DB8PR08MB5243.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:227;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(39850400004)(366004)(376002)(396003)(199004)(189003)(8676002)(81156014)(68736007)(8936002)(81166006)(486006)(446003)(11346002)(476003)(2616005)(66946007)(66476007)(66446008)(66556008)(64756008)(478600001)(14454004)(5660300002)(6116002)(71200400001)(71190400001)(36756003)(3846002)(25786009)(2906002)(31696002)(86362001)(4326008)(6246003)(66066001)(99286004)(2501003)(7736002)(305945005)(31686004)(386003)(76176011)(54906003)(316002)(6436002)(6486002)(6512007)(102836004)(229853002)(2201001)(6506007)(53546011)(26005)(53936002)(186003)(52116002)(256004)(14444005)(5024004)(110136005)(309714004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5243;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mn+x6wFTcwb7STNMAdWZT/1KCfY4m5taiHJssDrucz0PAPmn2QiTGAwtcAD2ng9/ODqwprfeKDmszyr2XU3kSu+dOcuez4jtHcRkXn1m5plrplqoNyZ/jx2ZfTtUOvbJZ6ykcZsYIOaGxsBRBL4EO4tRhSc58K9nZfa+QyTNIFrxTgsX3GGX1ny5i1ytTZWYZy9DldtFzvIs6Ul1W+0WUtdesAjqxltBqM/Naf2sJXctX+CMGH/hGFmMapCEOokc6WzUz52agWlFUKG6dEvrF/n2a2Fy79vh7rchSDE/joOJcJm9rf06MhneF5OXKND+yo7pIviV+jRMrsCvWLcD66y/havl1FPD7vKdIfzbRIhN0z4uc9Of/aWCXR2JGsoAH/QRXteSxEAEPVCOzrhUkazXGbrdtlOsSRwBUW2bWcY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1FF748856737248941446C02FBCA2B9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1b2c83-ad08-44dd-c971-08d715a1ca31
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 10:28:12.3143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5243
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.95
Subject: Re: [Qemu-devel] [PATCH v3] blockjob: drain all job nodes in
 block_job_drain
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMDcuMjAxOSAyMjoxMSwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDcvMjQvMTkg
NTo0MCBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEluc3RlYWQg
b2YgZHJhaW5pbmcgYWRkaXRpb25hbCBub2RlcyBpbiBlYWNoIGpvYiBjb2RlLCBsZXQncyBkbyBp
dCBpbg0KPj4gY29tbW9uIGJsb2NrX2pvYl9kcmFpbiwgZHJhaW5pbmcganVzdCBhbGwgam9iJ3Mg
Y2hpbGRyZW4uDQo+PiBCbG9ja0pvYkRyaXZlci5kcmFpbiBiZWNvbWVzIHVudXNlZCwgc28sIGRy
b3AgaXQgYXQgYWxsLg0KPj4NCj4+IEl0J3MgYWxzbyBhIGZpcnN0IHN0ZXAgdG8gZmluYWxseSBn
ZXQgcmlkIG9mIGJsb2Nram9iLT5ibGsuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIg
U2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+
Pg0KPj4gdjM6IGp1c3QgcmVzZW5kLCBhcyBJJ3ZlIHNvbWUgYXV0byByZXR1cm5lZCBtYWlscyBh
bmQgbm90IHN1cmUgdGhhdA0KPj4gICAgICB2MiByZWFjaGVkIHJlY2lwaWVudHMuDQo+Pg0KPj4g
djI6IGFwcGx5IE1heCdzIHN1Z2dlc3Rpb25zOg0KPj4gICAtIGRyb3AgQmxvY2tKb2JEcml2ZXIu
ZHJhaW4NCj4+ICAgLSBkbyBmaXJ0bHkgbG9vcCBvZiBiZHJ2X2RyYWluZWRfYmVnaW4gYW5kIHRo
ZW4gc2VwYXJhdGUgbG9vcA0KPj4gICAgIG9mIGJkcnZfZHJhaW5lZF9lbmQuDQo+Pg0KPj4gICAg
IEhtbSwgYSBxdWVzdGlvbiBoZXJlOiBzaG91bGQgSSBjYWxsIGJkcnZfZHJhaW5lZF9lbmQgaW4g
cmV2ZXJzZQ0KPj4gICAgIG9yZGVyPyBPciBpdCdzIE9LIGFzIGlzPw0KPj4NCj4gDQo+IEkgdGhp
bmsgaXQgc2hvdWxkIGJlIE9LLiBUaGVzZSBub2RlcyBkb24ndCBuZWNlc3NhcmlseSBoYXZlIGEg
d2VsbA0KPiBkZWZpbmVkIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIGVhY2ggb3RoZXIsIGRvIHRoZXk/
DQo+IA0KPj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2Nram9iX2ludC5oIHwgMTEgLS0tLS0tLS0tLS0N
Cj4+ICAgYmxvY2svYmFja3VwLmMgICAgICAgICAgICAgICB8IDE4ICstLS0tLS0tLS0tLS0tLS0t
LQ0KPj4gICBibG9jay9taXJyb3IuYyAgICAgICAgICAgICAgIHwgMjYgKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4+ICAgYmxvY2tqb2IuYyAgICAgICAgICAgICAgICAgICB8IDEzICsrKysr
KysrLS0tLS0NCj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA1NiBkZWxl
dGlvbnMoLSkNCj4+DQo+IA0KPiBOaWNlIGRpZmZzdGF0IDopDQo+IA0KPj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvYmxvY2svYmxvY2tqb2JfaW50LmggYi9pbmNsdWRlL2Jsb2NrL2Jsb2Nram9iX2lu
dC5oDQo+PiBpbmRleCBlNGEzMThkZDE1Li5lMWFiZjRlZTg1IDEwMDY0NA0KPj4gLS0tIGEvaW5j
bHVkZS9ibG9jay9ibG9ja2pvYl9pbnQuaA0KPj4gKysrIGIvaW5jbHVkZS9ibG9jay9ibG9ja2pv
Yl9pbnQuaA0KPj4gQEAgLTUyLDE3ICs1Miw2IEBAIHN0cnVjdCBCbG9ja0pvYkRyaXZlciB7DQo+
PiAgICAgICAgKiBiZXNpZGVzIGpvYi0+YmxrIHRvIHRoZSBuZXcgQWlvQ29udGV4dC4NCj4+ICAg
ICAgICAqLw0KPj4gICAgICAgdm9pZCAoKmF0dGFjaGVkX2Fpb19jb250ZXh0KShCbG9ja0pvYiAq
am9iLCBBaW9Db250ZXh0ICpuZXdfY29udGV4dCk7DQo+PiAtDQo+PiAtICAgIC8qDQo+PiAtICAg
ICAqIElmIHRoZSBjYWxsYmFjayBpcyBub3QgTlVMTCwgaXQgd2lsbCBiZSBpbnZva2VkIHdoZW4g
dGhlIGpvYiBoYXMgdG8gYmUNCj4+IC0gICAgICogc3luY2hyb25vdXNseSBjYW5jZWxsZWQgb3Ig
Y29tcGxldGVkOyBpdCBzaG91bGQgZHJhaW4gQmxvY2tEcml2ZXJTdGF0ZXMNCj4+IC0gICAgICog
YXMgcmVxdWlyZWQgdG8gZW5zdXJlIHByb2dyZXNzLg0KPj4gLSAgICAgKg0KPj4gLSAgICAgKiBC
bG9jayBqb2JzIG11c3QgdXNlIHRoZSBkZWZhdWx0IGltcGxlbWVudGF0aW9uIGZvciBqb2JfZHJp
dmVyLmRyYWluLA0KPj4gLSAgICAgKiB3aGljaCB3aWxsIGluIHR1cm4gY2FsbCB0aGlzIGNhbGxi
YWNrIGFmdGVyIGRvaW5nIGdlbmVyaWMgYmxvY2sgam9iDQo+PiAtICAgICAqIHN0dWZmLg0KPj4g
LSAgICAgKi8NCj4+IC0gICAgdm9pZCAoKmRyYWluKShCbG9ja0pvYiAqam9iKTsNCj4gDQo+IEkg
d2FzIGFib3V0IHRvIHNheSAiaHVoPyIgLi4uIGJ1dCB0aGVuIHJlYWxpemVkIHlvdSdyZSBkZWxl
dGluZyB0aGlzDQo+IGNvbmZ1c2luZyBnbG9iLiBHb29kLg0KPiANCj4+ICAgfTsNCj4+ICAgDQo+
PiAgIC8qKg0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2JhY2t1cC5jIGIvYmxvY2svYmFja3VwLmMN
Cj4+IGluZGV4IDcxNWUxZDNiZTguLjc5MzAwMDRiYmQgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9i
YWNrdXAuYw0KPj4gKysrIGIvYmxvY2svYmFja3VwLmMNCj4+IEBAIC0zMjAsMjEgKzMyMCw2IEBA
IHZvaWQgYmFja3VwX2RvX2NoZWNrcG9pbnQoQmxvY2tKb2IgKmpvYiwgRXJyb3IgKiplcnJwKQ0K
Pj4gICAgICAgaGJpdG1hcF9zZXQoYmFja3VwX2pvYi0+Y29weV9iaXRtYXAsIDAsIGJhY2t1cF9q
b2ItPmxlbik7DQo+PiAgIH0NCj4+ICAgDQo+PiAtc3RhdGljIHZvaWQgYmFja3VwX2RyYWluKEJs
b2NrSm9iICpqb2IpDQo+PiAtew0KPj4gLSAgICBCYWNrdXBCbG9ja0pvYiAqcyA9IGNvbnRhaW5l
cl9vZihqb2IsIEJhY2t1cEJsb2NrSm9iLCBjb21tb24pOw0KPj4gLQ0KPj4gLSAgICAvKiBOZWVk
IHRvIGtlZXAgYSByZWZlcmVuY2UgaW4gY2FzZSBibGtfZHJhaW4gdHJpZ2dlcnMgZXhlY3V0aW9u
DQo+PiAtICAgICAqIG9mIGJhY2t1cF9jb21wbGV0ZS4uLg0KPj4gLSAgICAgKi8NCj4+IC0gICAg
aWYgKHMtPnRhcmdldCkgew0KPj4gLSAgICAgICAgQmxvY2tCYWNrZW5kICp0YXJnZXQgPSBzLT50
YXJnZXQ7DQo+PiAtICAgICAgICBibGtfcmVmKHRhcmdldCk7DQo+PiAtICAgICAgICBibGtfZHJh
aW4odGFyZ2V0KTsNCj4+IC0gICAgICAgIGJsa191bnJlZih0YXJnZXQpOw0KPj4gLSAgICB9DQo+
PiAtfQ0KPj4gLQ0KPiANCj4gQWRpb3MgLi4uDQo+IA0KPj4gICBzdGF0aWMgQmxvY2tFcnJvckFj
dGlvbiBiYWNrdXBfZXJyb3JfYWN0aW9uKEJhY2t1cEJsb2NrSm9iICpqb2IsDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCByZWFkLCBpbnQgZXJy
b3IpDQo+PiAgIHsNCj4+IEBAIC00OTMsOCArNDc4LDcgQEAgc3RhdGljIGNvbnN0IEJsb2NrSm9i
RHJpdmVyIGJhY2t1cF9qb2JfZHJpdmVyID0gew0KPj4gICAgICAgICAgIC5jb21taXQgICAgICAg
ICAgICAgICAgID0gYmFja3VwX2NvbW1pdCwNCj4+ICAgICAgICAgICAuYWJvcnQgICAgICAgICAg
ICAgICAgICA9IGJhY2t1cF9hYm9ydCwNCj4+ICAgICAgICAgICAuY2xlYW4gICAgICAgICAgICAg
ICAgICA9IGJhY2t1cF9jbGVhbiwNCj4+IC0gICAgfSwNCj4+IC0gICAgLmRyYWluICAgICAgICAg
ICAgICAgICAgPSBiYWNrdXBfZHJhaW4sDQo+PiArICAgIH0NCj4+ICAgfTsNCj4+ICAgDQo+IA0K
PiBUaGlzIHBsZWFzZXMgdGhlIGV5ZXMuDQo+IA0KPj4gICBzdGF0aWMgaW50NjRfdCBiYWNrdXBf
Y2FsY3VsYXRlX2NsdXN0ZXJfc2l6ZShCbG9ja0RyaXZlclN0YXRlICp0YXJnZXQsDQo+PiBkaWZm
IC0tZ2l0IGEvYmxvY2svbWlycm9yLmMgYi9ibG9jay9taXJyb3IuYw0KPj4gaW5kZXggOGNiNzVm
YjQwOS4uODQ1NmNjZDg5ZCAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL21pcnJvci5jDQo+PiArKysg
Yi9ibG9jay9taXJyb3IuYw0KPj4gQEAgLTY0NCwxNCArNjQ0LDExIEBAIHN0YXRpYyBpbnQgbWly
cm9yX2V4aXRfY29tbW9uKEpvYiAqam9iKQ0KPj4gICAgICAgYmRydl9yZWYobWlycm9yX3RvcF9i
cyk7DQo+PiAgICAgICBiZHJ2X3JlZih0YXJnZXRfYnMpOw0KPj4gICANCj4+IC0gICAgLyogUmVt
b3ZlIHRhcmdldCBwYXJlbnQgdGhhdCBzdGlsbCB1c2VzIEJMS19QRVJNX1dSSVRFL1JFU0laRSBi
ZWZvcmUNCj4+ICsgICAgLyoNCj4+ICsgICAgICogUmVtb3ZlIHRhcmdldCBwYXJlbnQgdGhhdCBz
dGlsbCB1c2VzIEJMS19QRVJNX1dSSVRFL1JFU0laRSBiZWZvcmUNCj4gDQo+IChUaGFua3MsIHBh
dGNoZXcuLi4pDQo+IA0KPj4gICAgICAgICogaW5zZXJ0aW5nIHRhcmdldF9icyBhdCBzLT50b19y
ZXBsYWNlLCB3aGVyZSB3ZSBtaWdodCBub3QgYmUgYWJsZSB0byBnZXQNCj4+ICAgICAgICAqIHRo
ZXNlIHBlcm1pc3Npb25zLg0KPj4gLSAgICAgKg0KPj4gLSAgICAgKiBOb3RlIHRoYXQgYmxrX3Vu
cmVmKCkgYWxvbmUgZG9lc24ndCBuZWNlc3NhcmlseSBkcm9wIHBlcm1pc3Npb25zIGJlY2F1c2UN
Cj4+IC0gICAgICogd2UgbWlnaHQgYmUgcnVubmluZyBuZXN0ZWQgaW5zaWRlIG1pcnJvcl9kcmFp
bigpLCB3aGljaCB0YWtlcyBhbiBleHRyYQ0KPj4gLSAgICAgKiByZWZlcmVuY2UsIHNvIHVzZSBh
biBleHBsaWNpdCBibGtfc2V0X3Blcm0oKSBmaXJzdC4gKi8NCj4+IC0gICAgYmxrX3NldF9wZXJt
KHMtPnRhcmdldCwgMCwgQkxLX1BFUk1fQUxMLCAmZXJyb3JfYWJvcnQpOw0KPj4gKyAgICAgKi8N
Cj4+ICAgICAgIGJsa191bnJlZihzLT50YXJnZXQpOw0KPj4gICAgICAgcy0+dGFyZ2V0ID0gTlVM
TDsNCj4+ICAgDQo+PiBAQCAtMTE0MywyMSArMTE0MCw2IEBAIHN0YXRpYyBib29sIG1pcnJvcl9k
cmFpbmVkX3BvbGwoQmxvY2tKb2IgKmpvYikNCj4+ICAgICAgIHJldHVybiAhIXMtPmluX2ZsaWdo
dDsNCj4+ICAgfQ0KPj4gICANCj4+IC1zdGF0aWMgdm9pZCBtaXJyb3JfZHJhaW4oQmxvY2tKb2Ig
KmpvYikNCj4+IC17DQo+PiAtICAgIE1pcnJvckJsb2NrSm9iICpzID0gY29udGFpbmVyX29mKGpv
YiwgTWlycm9yQmxvY2tKb2IsIGNvbW1vbik7DQo+PiAtDQo+PiAtICAgIC8qIE5lZWQgdG8ga2Vl
cCBhIHJlZmVyZW5jZSBpbiBjYXNlIGJsa19kcmFpbiB0cmlnZ2VycyBleGVjdXRpb24NCj4+IC0g
ICAgICogb2YgbWlycm9yX2NvbXBsZXRlLi4uDQo+PiAtICAgICAqLw0KPj4gLSAgICBpZiAocy0+
dGFyZ2V0KSB7DQo+PiAtICAgICAgICBCbG9ja0JhY2tlbmQgKnRhcmdldCA9IHMtPnRhcmdldDsN
Cj4+IC0gICAgICAgIGJsa19yZWYodGFyZ2V0KTsNCj4+IC0gICAgICAgIGJsa19kcmFpbih0YXJn
ZXQpOw0KPj4gLSAgICAgICAgYmxrX3VucmVmKHRhcmdldCk7DQo+PiAtICAgIH0NCj4+IC19DQo+
PiAtDQo+PiAgIHN0YXRpYyBjb25zdCBCbG9ja0pvYkRyaXZlciBtaXJyb3Jfam9iX2RyaXZlciA9
IHsNCj4+ICAgICAgIC5qb2JfZHJpdmVyID0gew0KPj4gICAgICAgICAgIC5pbnN0YW5jZV9zaXpl
ICAgICAgICAgID0gc2l6ZW9mKE1pcnJvckJsb2NrSm9iKSwNCj4+IEBAIC0xMTcyLDcgKzExNTQs
NiBAQCBzdGF0aWMgY29uc3QgQmxvY2tKb2JEcml2ZXIgbWlycm9yX2pvYl9kcml2ZXIgPSB7DQo+
PiAgICAgICAgICAgLmNvbXBsZXRlICAgICAgICAgICAgICAgPSBtaXJyb3JfY29tcGxldGUsDQo+
PiAgICAgICB9LA0KPj4gICAgICAgLmRyYWluZWRfcG9sbCAgICAgICAgICAgPSBtaXJyb3JfZHJh
aW5lZF9wb2xsLA0KPj4gLSAgICAuZHJhaW4gICAgICAgICAgICAgICAgICA9IG1pcnJvcl9kcmFp
biwNCj4+ICAgfTsNCj4+ICAgDQo+PiAgIHN0YXRpYyBjb25zdCBCbG9ja0pvYkRyaXZlciBjb21t
aXRfYWN0aXZlX2pvYl9kcml2ZXIgPSB7DQo+PiBAQCAtMTE4OSw3ICsxMTcwLDYgQEAgc3RhdGlj
IGNvbnN0IEJsb2NrSm9iRHJpdmVyIGNvbW1pdF9hY3RpdmVfam9iX2RyaXZlciA9IHsNCj4+ICAg
ICAgICAgICAuY29tcGxldGUgICAgICAgICAgICAgICA9IG1pcnJvcl9jb21wbGV0ZSwNCj4+ICAg
ICAgIH0sDQo+PiAgICAgICAuZHJhaW5lZF9wb2xsICAgICAgICAgICA9IG1pcnJvcl9kcmFpbmVk
X3BvbGwsDQo+PiAtICAgIC5kcmFpbiAgICAgICAgICAgICAgICAgID0gbWlycm9yX2RyYWluLA0K
Pj4gICB9Ow0KPj4gICANCj4+ICAgc3RhdGljIHZvaWQgY29yb3V0aW5lX2ZuDQo+PiBkaWZmIC0t
Z2l0IGEvYmxvY2tqb2IuYyBiL2Jsb2Nram9iLmMNCj4+IGluZGV4IDIwYjdmNTU3ZGEuLjc4Y2Y3
MWQ2YzggMTAwNjQ0DQo+PiAtLS0gYS9ibG9ja2pvYi5jDQo+PiArKysgYi9ibG9ja2pvYi5jDQo+
PiBAQCAtOTIsMTIgKzkyLDE1IEBAIHZvaWQgYmxvY2tfam9iX2ZyZWUoSm9iICpqb2IpDQo+PiAg
IHZvaWQgYmxvY2tfam9iX2RyYWluKEpvYiAqam9iKQ0KPj4gICB7DQo+PiAgICAgICBCbG9ja0pv
YiAqYmpvYiA9IGNvbnRhaW5lcl9vZihqb2IsIEJsb2NrSm9iLCBqb2IpOw0KPj4gLSAgICBjb25z
dCBKb2JEcml2ZXIgKmRydiA9IGpvYi0+ZHJpdmVyOw0KPj4gLSAgICBCbG9ja0pvYkRyaXZlciAq
YmpkcnYgPSBjb250YWluZXJfb2YoZHJ2LCBCbG9ja0pvYkRyaXZlciwgam9iX2RyaXZlcik7DQo+
PiArICAgIEdTTGlzdCAqbDsNCj4+ICAgDQo+PiAtICAgIGJsa19kcmFpbihiam9iLT5ibGspOw0K
Pj4gLSAgICBpZiAoYmpkcnYtPmRyYWluKSB7DQo+PiAtICAgICAgICBiamRydi0+ZHJhaW4oYmpv
Yik7DQo+PiArICAgIGZvciAobCA9IGJqb2ItPm5vZGVzOyBsOyBsID0gbC0+bmV4dCkgew0KPj4g
KyAgICAgICAgQmRydkNoaWxkICpjID0gbC0+ZGF0YTsNCj4+ICsgICAgICAgIGJkcnZfZHJhaW5l
ZF9iZWdpbihjLT5icyk7DQo+PiArICAgIH0NCj4+ICsgICAgZm9yIChsID0gYmpvYi0+bm9kZXM7
IGw7IGwgPSBsLT5uZXh0KSB7DQo+PiArICAgICAgICBCZHJ2Q2hpbGQgKmMgPSBsLT5kYXRhOw0K
Pj4gKyAgICAgICAgYmRydl9kcmFpbmVkX2VuZChjLT5icyk7DQo+PiAgICAgICB9DQo+PiAgIH0N
Cj4+ICAgDQo+Pg0KPiANCj4gU2VlbXMgbXVjaCBuaWNlciB0byBtZS4gV2hhdCBiZWNvbWVzIG9m
IHRoZSByZWYvdW5yZWYgcGFpcnM/DQo+IA0KPiBJIGd1ZXNzIG5vdCBuZWVkZWQgYW55bW9yZT8s
IHNpbmNlIGpvYiBjbGVhbnVwIG5lY2Vzc2FyaWx5IGhhcHBlbnMgaW4NCj4gdGhlIG1haW4gbG9v
cCBjb250ZXh0IG5vdyBhbmQgd2UgZG9uJ3QgaGF2ZSBhIGJhY2t1cF9jb21wbGV0ZSBmdW5jdGlv
bg0KPiBhbnltb3JlIC4uLj8NCg0KV2hhdCBwYWlycyBkbyB5b3UgbWVhbj8NCg0KPiANCj4gSW4g
dGhlIGNhc2VzIHdoZXJlIGF1dG9fZmluYWxpemU9dHJ1ZSwgZG8gd2UgaGF2ZSBhbnkgZ3VhcmFu
dGVlIHRoYXQgdGhlDQo+IGNvbXBsZXRpb24gY2FsbGJhY2tzIGNhbm5vdCBiZSBzY2hlZHVsZWQg
d2hpbGUgd2UgYXJlIGhlcmU/DQo+IA0KDQpIbW0sIG5vdCBzaW1wbGUgZm9yIG1lIHRvIGFzc3Vt
ZS4uIElzIGl0IGEgcHJvYmxlbT8gQW5kIGlzIGl0IGFib3V0IHRoaXMgcGF0Y2g/DQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

