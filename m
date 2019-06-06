Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AB0C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72D22070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bX4wK/e3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72D22070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58787 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqef-0002es-W1
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:34:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYqdp-0002JF-1h
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYqdo-0007z1-2i
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:33:08 -0400
Received: from mail-eopbgr130123.outbound.protection.outlook.com
	([40.107.13.123]:1252
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYqdn-0007vg-A6
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=E+9VrkyUyjIufd1pKJ/I1wkal1STKW308TTzbBgGMDc=;
	b=bX4wK/e3FDqNxaiZ2cIg0NwVbXXS7IyKHkYNi5NZK0z4MNBhp3wOHxZDunOoTpf87Q5G9ez6Fu0+9EwMBS1BErq/Jxg22VvqZ/ts6t71lkqGpr5Imr5bG7eRO7gdbBmlhX5ex6Pu/Sg/QF84+gqdvw5oi0GE5sld5kSwQaK8Ucw=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB4130.eurprd08.prod.outlook.com (20.178.202.221) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Thu, 6 Jun 2019 11:33:03 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011;
	Thu, 6 Jun 2019 11:33:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH] qapi: InitSocketAddress: add keepalive
	option
Thread-Index: AQHVHFDRDxz2DhKj+k6v6TBL3MsCfaaOejSAgAAEXIA=
Date: Thu, 6 Jun 2019 11:33:03 +0000
Message-ID: <f42975be-51cf-c6b6-0148-514dfac7c2fa@virtuozzo.com>
References: <20190606101533.20228-1-vsementsov@virtuozzo.com>
	<20190606111725.GH14300@redhat.com>
In-Reply-To: <20190606111725.GH14300@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0020.eurprd03.prod.outlook.com
	(2603:10a6:3:76::30) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190606143301609
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f67e1ac7-7632-44fc-1af2-08d6ea72bcc4
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB4130; 
x-ms-traffictypediagnostic: AM0PR08MB4130:
x-microsoft-antispam-prvs: <AM0PR08MB413077674BB702CDD73CD21AC1170@AM0PR08MB4130.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(396003)(366004)(39840400004)(346002)(376002)(199004)(189003)(53754006)(446003)(476003)(256004)(6506007)(386003)(86362001)(14444005)(52116002)(36756003)(14454004)(7736002)(5660300002)(486006)(2616005)(11346002)(6486002)(71190400001)(71200400001)(186003)(478600001)(54906003)(31696002)(102836004)(81166006)(76176011)(316002)(8676002)(26005)(68736007)(66476007)(6916009)(73956011)(6512007)(66066001)(81156014)(66946007)(66446008)(107886003)(6436002)(6246003)(25786009)(8936002)(2906002)(64756008)(99286004)(229853002)(3846002)(305945005)(6116002)(4326008)(53936002)(66556008)(31686004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4130;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3Isnzn2y/Oic7JgWiMDteE42SUU+MNl/ahaXltm3s2YNnZNZ60wc7+bZzQ1MUBIreqykcPqwS0197BP0XV+o7ZAKe8Rue08FO4MxiM1vrV6er+e9qPocBbAklLg1SZwFIk9Ck30NJXGHceX591TlUIIW/piGx2tJBihNTi3FkyOKiovpxUhXlywjKhxz4s3BYo5pqivzs/3iDmabDT1jaJMf/x4i2FmwTXZNgt/LWlIB5Kdvi3d8g2qz0JWMwJddTWkMFo/mryhwZLRlPvYTXh5Yhh9M4/v4jPKXnhLuQEBuTuaT9URvHniJNWBzkgfH2sGxSouZDSx5q42JWaPU2s2k2C+K06TK17UMokJ7xCLyS+LHbYMahyOOfHg1K1lBbC4B719B3TbC9nT6Jn4YyUBOkeI2TzdNTXVd9GbNM8Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6335A28DF2C6AC42B090641A14326E22@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67e1ac7-7632-44fc-1af2-08d6ea72bcc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 11:33:03.6821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4130
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.123
Subject: Re: [Qemu-devel] [PATCH] qapi: InitSocketAddress: add keepalive
 option
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Denis Lunev <den@virtuozzo.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDYuMjAxOSAxNDoxNywgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24gVGh1LCBK
dW4gMDYsIDIwMTkgYXQgMDE6MTU6MzNQTSArMDMwMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSB3cm90ZToNCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4NCj4+IEhpIGFsbCENCj4+
DQo+PiBUaGlzIGlzIGEgY29udGludWF0aW9uIG9mICJbUEFUQ0ggdjIgMC8yXSBuYmQ6IGVuYWJs
ZSBrZWVwYWxpdmUiLCBidXQNCj4+IGl0J3MgYSB0cnkgZnJvbSBhbm90aGVyIHNpZGUsIHNvIGFs
bW9zdCBub3RoaW5nIGNvbW1vbiB3aXRoIHYyLg0KPj4NCj4+DQo+PiAgIHFhcGkvc29ja2V0cy5q
c29uICAgfCAgNSArKysrLQ0KPj4gICB1dGlsL3FlbXUtc29ja2V0cy5jIHwgMTMgKysrKysrKysr
KysrKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvcWFwaS9zb2NrZXRzLmpzb24gYi9xYXBpL3NvY2tldHMu
anNvbg0KPj4gaW5kZXggZmM4MWQ4ZDVlOC4uYWVmYTAyNDA1MSAxMDA2NDQNCj4+IC0tLSBhL3Fh
cGkvc29ja2V0cy5qc29uDQo+PiArKysgYi9xYXBpL3NvY2tldHMuanNvbg0KPj4gQEAgLTUzLDYg
KzUzLDggQEANCj4+ICAgIw0KPj4gICAjIEBpcHY2OiB3aGV0aGVyIHRvIGFjY2VwdCBJUHY2IGFk
ZHJlc3NlcywgZGVmYXVsdCB0cnkgYm90aCBJUHY0IGFuZCBJUHY2DQo+PiAgICMNCj4+ICsjIEBr
ZWVwYWxpdmU6IGVuYWJsZSBrZWVwYWxpdmUgd2hlbiBjb25uZWN0aW5nIHRvIHRoaXMgc29ja2V0
IChTaW5jZSA0LjEpDQo+PiArIw0KPj4gICAjIFNpbmNlOiAxLjMNCj4+ICAgIyMNCj4+ICAgeyAn
c3RydWN0JzogJ0luZXRTb2NrZXRBZGRyZXNzJywNCj4+IEBAIC02MSw3ICs2Myw4IEBADQo+PiAg
ICAgICAnKm51bWVyaWMnOiAgJ2Jvb2wnLA0KPj4gICAgICAgJyp0byc6ICd1aW50MTYnLA0KPj4g
ICAgICAgJyppcHY0JzogJ2Jvb2wnLA0KPj4gLSAgICAnKmlwdjYnOiAnYm9vbCcgfSB9DQo+PiAr
ICAgICcqaXB2Nic6ICdib29sJywNCj4+ICsgICAgJyprZWVwYWxpdmUnOiAnYm9vbCcgfSB9DQo+
PiAgIA0KPj4gICAjIw0KPj4gICAjIEBVbml4U29ja2V0QWRkcmVzczoNCj4+IGRpZmYgLS1naXQg
YS91dGlsL3FlbXUtc29ja2V0cy5jIGIvdXRpbC9xZW11LXNvY2tldHMuYw0KPj4gaW5kZXggODg1
MGEyODBhOC4uZDJjZDJhOWQ0ZiAxMDA2NDQNCj4+IC0tLSBhL3V0aWwvcWVtdS1zb2NrZXRzLmMN
Cj4+ICsrKyBiL3V0aWwvcWVtdS1zb2NrZXRzLmMNCj4+IEBAIC00NTcsNiArNDU3LDE5IEBAIGlu
dCBpbmV0X2Nvbm5lY3Rfc2FkZHIoSW5ldFNvY2tldEFkZHJlc3MgKnNhZGRyLCBFcnJvciAqKmVy
cnApDQo+PiAgICAgICB9DQo+PiAgIA0KPj4gICAgICAgZnJlZWFkZHJpbmZvKHJlcyk7DQo+PiAr
DQo+PiArICAgIGlmIChzYWRkci0+a2VlcGFsaXZlKSB7DQo+IA0KPiBJSVVDLCBiZXN0IHByYWN0
aWNlIGlzIHRvIHVzZSAnc2FkZHItPmhhc19rZWVwYWxpdmUgJiYgc2FkZHItPmtlZXBhbGl2ZScN
Cg0KQXMgSSByZW1lbWJlciwgbm93IGFsbCBvcHRpb25hbCBmaWVsZHMgYXJlIHplcm9lZC4gQnV0
IEknbSBub3QgYWdhaW5zdCBzdHJpY3RlciBjb25kaXRpb24uDQoNCj4gDQo+PiArICAgICAgICBp
bnQgdmFsID0gMTsNCj4+ICsgICAgICAgIGludCByZXQgPSBxZW11X3NldHNvY2tvcHQoc29jaywg
U09MX1NPQ0tFVCwgU09fS0VFUEFMSVZFLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmdmFsLCBzaXplb2YodmFsKSk7DQo+PiArDQo+PiArICAgICAgICBpZiAocmV0IDwg
MCkgew0KPj4gKyAgICAgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sICJVbmFi
bGUgdG8gc2V0IEtFRVBBTElWRSIpOw0KPj4gKyAgICAgICAgICAgIGNsb3NlKHNvY2spOw0KPj4g
KyAgICAgICAgICAgIHJldHVybiAtMTsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgfQ0KPj4gKw0K
Pj4gICAgICAgcmV0dXJuIHNvY2s7DQo+PiAgIH0NCj4gDQo+IFJlZ2FyZHMsDQo+IERhbmllbA0K
PiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

