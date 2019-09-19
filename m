Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEECC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67A121848
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OWreBDgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67A121848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAqFH-0007Yi-OZ
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 02:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAqEJ-0006tv-HR
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAqEH-0005G0-K6
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:47:51 -0400
Received: from mail-ve1eur01on071e.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::71e]:10411
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAqE5-00054W-SY; Thu, 19 Sep 2019 02:47:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJXf5tCSnoO0gy86bVW9cIz14roFszHpI6cY+d9K43l9LfO0LdQY+od5jS3qg4ISRoPSHxRa/5PkGqSxn+wAl1OSI8chmdq10YW0Um2m4dkjR4gakOoYov0W3mnFvEcTzNlrPpDjqkez+ePyoooyKtHWDSqNDV56EfDukdsbA3kFLrcHAOlGj/RvYowYRlAQammy7GjDf4NKP9WLCF8V2HhqeA1uOmEfgov2uT3abcZrHZ/cHFpje/bdF/guaSpWKh0ctM3rOFSh9j9n+V1xGapfFz65/3k79tkO7e1mN6hV+ZOmOxxGXzkolNAjtA7eu8eS6FExZvxuANB5t+NtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yow5mhuHOGbfe5qSpW+yoqb1DKmIWKCcPWE9dp/clc8=;
 b=XcXhWAXIW8t0cfWPnwsaeEjhRsOFzh2zL1l//475kndvpJCqgKzF1E+5AzmrZHFqIAsLWnThKToaSsfksQ9zktxBy2RhlMx+bZj1EoREb8fsMq0ADKE1diNMVgMWEjiNIKF0AVk8XeY+GlDMLAyGzUoZ3c9/cKK0qlGzSKDDKE65F4xvHvpPup4Ws8gribQf2hePj0TVPJ5ruGSkVpCn2vIWVZUNOkZ6UCbDx0SIJMNRKxsgIRX2wqvJpIHutBQL1RosvbOIkX2kg0z1bG9UVqwereq8EBA80k4b5vNtlmom/qfgk3tEqk9C5sJaSLWm8MNJUGexuOTEfXZYzBrDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yow5mhuHOGbfe5qSpW+yoqb1DKmIWKCcPWE9dp/clc8=;
 b=OWreBDgsiQu1d0hmBBQisXqIGY9LMdhQEWf3M6QZWuqUBRVHqsfvbrJamBCscv8wIvALylOldWlCFMDZ86oxGLbCYAsKfhHNEhZqTGCQvncB+CcBivL8hjNJwWroraoL8LfnD2iJ2AywbuERxkuHEULNeNw//RtA51eHkvE9W08=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4058.eurprd08.prod.outlook.com (20.179.10.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Thu, 19 Sep 2019 06:47:35 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 06:47:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKcxq6KAgAAJ94CAAAV2AIAAB5aAgADNTgA=
Date: Thu, 19 Sep 2019 06:47:34 +0000
Message-ID: <1c82faa5-9443-bc3d-6df2-dbfd82a7b830@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
 <0497ac1e-c841-39cd-9944-48dd54c5b0f0@virtuozzo.com>
 <9450fbfd-0f8b-d10f-7577-64805917f67a@redhat.com>
 <26217614-77cf-9519-f94b-d606864f4d46@redhat.com>
In-Reply-To: <26217614-77cf-9519-f94b-d606864f4d46@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0372.eurprd05.prod.outlook.com
 (2603:10a6:7:94::31) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919094730617
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62cd9efa-efc3-4ccb-7149-08d73ccd4088
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4058; 
x-ms-traffictypediagnostic: DB8PR08MB4058:
x-microsoft-antispam-prvs: <DB8PR08MB40580C899ACAD9367EF6BF90C1890@DB8PR08MB4058.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(366004)(396003)(346002)(376002)(199004)(189003)(36756003)(54906003)(386003)(446003)(11346002)(25786009)(6506007)(229853002)(31686004)(14454004)(66066001)(256004)(14444005)(6246003)(71190400001)(6436002)(99286004)(71200400001)(6512007)(5660300002)(66476007)(66946007)(7736002)(305945005)(2906002)(478600001)(102836004)(4326008)(26005)(52116002)(2501003)(53546011)(6486002)(476003)(2616005)(7406005)(7416002)(486006)(76176011)(6116002)(81156014)(81166006)(186003)(66556008)(3846002)(66446008)(64756008)(8676002)(86362001)(31696002)(110136005)(316002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4058;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pUViq+88IcjrAq5JpcJLwgOqHOJQ/3MPGmuVUhMN5qZL+acsQRWXB1V0kv9xA5fW7Q3TZEJw64HDwEGwL8W+R+ffB5cHJz8IPy5QWgTX+b7J78BnxPyDzpRnJaAlEfuRrZBuPDZG0x2xh/GnXIGYh6BjlDoN4+MAbbgriYfQz7gMDge/+c6GfphIUDk7609ikmJdcpLdMpOjT6voXLyKpS752rFCMC6ZzcMQodm//Z9DF7UDGxyHMosOrq1Cx/fiqTgHnRdWaxSzC/Kv8+mDjVP7GIC79b8bqEXQxi1PX15JHpYv/9wj1fxNHOTiCWfDouoDu6BWLToMhXLW4prP8pJvLVNelHvkuY0zO5mxXdzEsHzEYB/PppkVvdjxc1YHMfMUW2ocFZdcJBbBplHOCcT6nvHAGooUyi9wKAHumQc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9D2A0C2BEB81C4D800FA7625B2DB630@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62cd9efa-efc3-4ccb-7149-08d73ccd4088
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 06:47:34.9503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsMdYsDQhUDVvNfAbAvz2d3feVdhVGFj+Ew2ZMn6u2X03NPOKE34kdgQ1vx6YI96JbX9nNlre0bfzZQyPeTOsv36bHKVWVPsAm41edr2ee0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4058
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::71e
Subject: Re: [Qemu-devel] [RFC] error: auto propagated local_err
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "codyprime@gmail.com" <codyprime@gmail.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMDkuMjAxOSAyMTozMiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS8xOC8xOSAxOjA1IFBN
LCBFcmljIEJsYWtlIHdyb3RlOg0KPiANCj4+Pj4gI2RlZmluZSBNQUtFX0VSUlBfU0FGRSgpIFwN
Cj4+Pj4gZ19hdXRvKEVycm9yUHJvcGFnYXRpb25TdHJ1Y3QpIChfX2F1dG9fZXJycF9wcm9wKSA9
IHsuZXJycCA9IGVycnB9OyBcDQo+Pj4+IGVycnAgPSAmX19hdXRvX2VycnBfcHJvcC5sb2NhbF9l
cnINCj4+Pj4NCj4gDQo+IEkgdHJpZWQgdG8gc2VlIGlmIHRoaXMgY291bGQgYmUgZG9uZSB3aXRo
IGp1c3QgYSBzaW5nbGUgZGVjbGFyYXRpb24NCj4gbGluZSwgYXMgaW46DQo+IA0KPiB0eXBlZGVm
IHN0cnVjdCBFcnJvclByb3BhZ2F0b3Igew0KPiAgICAgIEVycm9yICoqZXJycDsNCj4gICAgICBF
cnJvciAqbG9jYWxfZXJyOw0KPiB9IEVycm9yUHJvcGFnYXRvcjsNCj4gDQo+ICNkZWZpbmUgTUFL
RV9FUlJQX1NBRkUoKSBcDQo+ICAgIGdfYXV0byhFcnJvclByb3BhZ2F0b3IpIF9fYXV0b19lcnJw
X3Byb3AgPSB7IFwNCj4gICAgICBlcnJwLCAoKGVycnAgPSAmX19hdXRvX2VycnBfcHJvcC5sb2Nh
bF9lcnIpLCBOVUxMKSB9DQo+IA0KPiBCdXQgc2FkbHksIEMxNyBwYXJhZ3JhcGggNi43LjlQMjMg
c3RhdGVzOg0KPiANCj4gIlRoZSBldmFsdWF0aW9ucyBvZiB0aGUgaW5pdGlhbGl6YXRpb24gbGlz
dCBleHByZXNzaW9ucyBhcmUNCj4gaW5kZXRlcm1pbmF0ZWx5IHNlcXVlbmNlZCB3aXRoIHJlc3Bl
Y3QgdG8gb25lIGFub3RoZXIgYW5kIHRodXMgdGhlIG9yZGVyDQo+IGluIHdoaWNoIGFueSBzaWRl
IGVmZmVjdHMgb2NjdXIgaXMgdW5zcGVjaWZpZWQuIg0KPiANCj4gd2hpY2ggZG9lcyBub3QgYm9k
ZSB3ZWxsIGZvciB0aGUgYXNzaWdubWVudCB0byBfX2F1dG9fZXJycF9wcm9wLmVycnAuDQo+IEFs
bCBjaGFuZ2VzIHRvIGVycnAgd291bGQgaGF2ZSB0byBiZSB3aXRoaW4gdGhlIHNhbWUgaW5pdGlh
bGl6ZXIuICBNYXliZToNCj4gDQo+ICNkZWZpbmUgTUFLRV9FUlJQX1NBRkUoKSBcDQo+ICAgIGdf
YXV0byhFcnJvclByb3BhZ2F0b3IpIF9fYXV0b19lcnJwX3Byb3AgPSB7IFwNCj4gICAgICAubG9j
YWxfZXJyID0gKF9fYXV0b19lcnJwX3Byb3AuZXJyID0gZXJycCwgXA0KPiAgICAgICAgICAoZXJy
cCA9ICZfX2F1dG9fZXJycF9wcm9wLmxvY2FsX2VyciksIE5VTEwpIH0NCg0KSXMgaXQgZ3VhcmFu
dGVlZCB0aGF0IC5lcnJwIHdpbGwgbm90IGJlIGluaXRpYWxpemVkIHRvIE5VTEwgYWZ0ZXIgZXZh
bHVhdGluZyBvZg0KLmxvY2FsX2VyciBpbml0aWFsaXplcj8NCg0KPiANCj4gYnV0IGJ5IHRoZSB0
aW1lIHlvdSBnZXQgdGhhdCBjb21wbGljYXRlZCwganVzdCB1c2luZyBhIHN0YXRlbWVudCBpcw0K
PiBlYXNpZXIgdG8gcmVhZC4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

