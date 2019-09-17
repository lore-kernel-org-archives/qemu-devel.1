Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41051C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09748206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="V64nRF7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09748206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADVD-00044o-AV
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iADU2-0003Fu-MZ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iADU0-0006Pq-LP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:25:30 -0400
Received: from mail-ve1eur02on0708.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::708]:15656
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iADTf-00065c-1b; Tue, 17 Sep 2019 09:25:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcBOoRunf+DERgb0unwconNBCjGJoDat5tybaOxbLYhcYSPlVDJCyG4IO82LecektYFuHMC9Dt3moJsfI1V6FxVrwQdv+S/D6tvxdzvZ7T4eMZUdDAZYpKKJ0dI51/mG5Z5Trpd91j6wKazll3mT3BEx/x0XFNejW5mjOXtNBO3Koe+gVoG/LOlgwbvrUDeotJTc5IKleJ7deJQ8tEPiyznveAVOVq+rR1pCCjdNBNT8XQ5JZITqYj2z4yJHcNJq5nSK9uIjeRGiGH5slDcMVJeDksEdwZVnQhWOyG9Bmd8C934ZsL7AFMvEivIpvQX51+rYJVoejvS+73dUF2ig/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXuWdDVs40TB3xfTNLIvUcHu7AMh+xydOxD//8KaFcs=;
 b=MyMKWY+VqRgYw7fQEs/qERfzLa4PhPOMQ8t6Fl8/3JYz8olmbOTe342xTId8fCP4eq521pPY7w0Iz5MbcRdBdwmDzHMwh9xCz4GzqzEOGoMYr9yf5mhGYWkJ4DDkM21XMsN3UPD9uCNIf1xC82Vam7v29uuksjYD178yHBfObDwTxiknqpVI8tVZqyHkP+wVLFDbNF2X/c1wB655VSJvulQdy+rEhAT6q0JQe9jbR1StvFooShHp5SCgrYKPFQw7a/l7PXxcz9c98fMJ+PRcVMPRt+YqXH/uJPyOVci7iFBG/DtZB5twpCGNVbFES4/jYrQxNl1Aa/rlZ8wIoXHUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXuWdDVs40TB3xfTNLIvUcHu7AMh+xydOxD//8KaFcs=;
 b=V64nRF7TEi2nx0WV+BsBh/+pumUTFJyiRQnm0ErSwxCOJAV4/jC16BD8jxfvRTkeerkK9Jut4jjWv+fEogEmirBT06W9NORZRTdzqvMCMKQ3x+8IiUKr4557dPKxNhzZE/ep1GSPmObb+ytK6bYnRMp/TuysSVfT3iSVlLsRjV0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5194.eurprd08.prod.outlook.com (10.255.18.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.26; Tue, 17 Sep 2019 13:25:03 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 13:25:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Greg Kurz <groug@kaod.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 02/17] block: Pass local error object
 pointer to error_append_hint()
Thread-Index: AQHVbUH6TzrJ58vIKEO+OGTVPIfvz6cv3BeA
Date: Tue, 17 Sep 2019 13:25:03 +0000
Message-ID: <5dba090e-8a59-6f42-a93a-eb676422211e@virtuozzo.com>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
 <156871564329.196432.5930574495661947805.stgit@bahia.lan>
In-Reply-To: <156871564329.196432.5930574495661947805.stgit@bahia.lan>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0032.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::42) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190917162459382
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9ed40e0-0611-464a-79ec-08d73b727272
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5194; 
x-ms-traffictypediagnostic: DB8PR08MB5194:
x-microsoft-antispam-prvs: <DB8PR08MB51948E3D7A13AD975E9A606BC18F0@DB8PR08MB5194.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(39850400004)(346002)(396003)(136003)(199004)(189003)(54906003)(66066001)(14454004)(76176011)(6116002)(186003)(7416002)(3846002)(316002)(6486002)(81166006)(102836004)(31696002)(8676002)(2616005)(66476007)(64756008)(386003)(26005)(478600001)(6506007)(81156014)(66446008)(11346002)(66556008)(99286004)(476003)(52116002)(446003)(86362001)(8936002)(71190400001)(71200400001)(256004)(110136005)(31686004)(66946007)(36756003)(305945005)(7736002)(7406005)(6246003)(2906002)(229853002)(6436002)(6512007)(486006)(2501003)(25786009)(5660300002)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5194;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E/cilThfA1f+GMAZknA8SvT5WRzDF4nIhgGal2lA5dIOgMkMGgobjSVGorFsQ+bQg7AOF15EGEll5eR2JCeycAO3v4wbwAzbXjk6PQL2OIAxIUsbISCRCQRf0O3/PERbkFV5J6lJewp2x8YO34l/4wfhHxrrkUidtW3hP2/Ca3jXBjBpSegFSpdMcAmvJlH6lPtFIcxIn63RdwERkeusr7IbHaOz/9YebQOh5O+hcK2Iv7el0VPuUt0cOPSAT1lMnHE5MQYN6cmKtagcfUpBrV0ieGmoxIYnkPqw2ZmH5nQd+gxueaV1WB0rEPSL3OeeHEd4Uhwl5NQg5CDFGbKR4ij/b1pAKdp294oNNqCo2ZP0hhXSjhe9/w58pROirC7jbpx7uP9DoGO7Ri9ziISvI6Avc1D7W6b4FfkQQKfh0gk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8B5FE710A208B46973C4FA1BAE14C85@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ed40e0-0611-464a-79ec-08d73b727272
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 13:25:03.1662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4twgcrWcCTGKqa0A0exxy43yPP4gkGnNrq4i4l5hmRnGEINITUn4i1g+qKC0x9gpVhmYW3MlqMFUnWKTFHEfy2qYLuVpz5VFdbgyVLY+pQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5194
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe06::708
Subject: Re: [Qemu-devel] [PATCH 02/17] block: Pass local error object
 pointer to error_append_hint()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "\"qemu-s390x@nongnu.org\\\"\"@d06av22.portsmouth.uk.ibm.com"
 <"qemu-s390x@nongnu.org\""@d06av22.portsmouth.uk.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTcuMDkuMjAxOSAxMzoyMCwgR3JlZyBLdXJ6IHdyb3RlOg0KPiBFbnN1cmUgdGhhdCBoaW50cyBh
cmUgYWRkZWQgZXZlbiBpZiBlcnJwIGlzICZlcnJvcl9mYXRhbCBvciAmZXJyb3JfYWJvcnQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBHcmVnIEt1cnogPGdyb3VnQGthb2Qub3JnPg0KPiAtLS0NCj4g
ICBibG9jay9iYWNrdXAuYyAgICAgICB8ICAgIDcgKysrKystLQ0KPiAgIGJsb2NrL2RpcnR5LWJp
dG1hcC5jIHwgICAgNyArKysrKy0tDQo+ICAgYmxvY2svZmlsZS1wb3NpeC5jICAgfCAgIDIwICsr
KysrKysrKysrKystLS0tLS0tDQo+ICAgYmxvY2svZ2x1c3Rlci5jICAgICAgfCAgIDIzICsrKysr
KysrKysrKysrKy0tLS0tLS0tDQo+ICAgYmxvY2svcWNvdy5jICAgICAgICAgfCAgIDEwICsrKysr
Ky0tLS0NCj4gICBibG9jay9xY293Mi5jICAgICAgICB8ICAgIDcgKysrKystLQ0KPiAgIGJsb2Nr
L3ZoZHgtbG9nLmMgICAgIHwgICAgNyArKysrKy0tDQo+ICAgYmxvY2svdnBjLmMgICAgICAgICAg
fCAgICA3ICsrKysrLS0NCj4gICA4IGZpbGVzIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKyksIDI5
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2JhY2t1cC5jIGIvYmxvY2sv
YmFja3VwLmMNCj4gaW5kZXggNzYzZjBkN2ZmNmRiLi5kOGM0MjJhMGUzYmMgMTAwNjQ0DQo+IC0t
LSBhL2Jsb2NrL2JhY2t1cC5jDQo+ICsrKyBiL2Jsb2NrL2JhY2t1cC5jDQo+IEBAIC02MDIsMTEg
KzYwMiwxNCBAQCBzdGF0aWMgaW50NjRfdCBiYWNrdXBfY2FsY3VsYXRlX2NsdXN0ZXJfc2l6ZShC
bG9ja0RyaXZlclN0YXRlICp0YXJnZXQsDQo+ICAgICAgICAgICAgICAgICAgICAgICBCQUNLVVBf
Q0xVU1RFUl9TSVpFX0RFRkFVTFQpOw0KPiAgICAgICAgICAgcmV0dXJuIEJBQ0tVUF9DTFVTVEVS
X1NJWkVfREVGQVVMVDsNCj4gICAgICAgfSBlbHNlIGlmIChyZXQgPCAwICYmICF0YXJnZXQtPmJh
Y2tpbmcpIHsNCj4gLSAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCAtcmV0LA0KPiArICAg
ICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4gKw0KPiArICAgICAgICBlcnJvcl9zZXRn
X2Vycm5vKCZsb2NhbF9lcnIsIC1yZXQsDQo+ICAgICAgICAgICAgICAgIkNvdWxkbid0IGRldGVy
bWluZSB0aGUgY2x1c3RlciBzaXplIG9mIHRoZSB0YXJnZXQgaW1hZ2UsICINCj4gICAgICAgICAg
ICAgICAid2hpY2ggaGFzIG5vIGJhY2tpbmcgZmlsZSIpOw0KPiAtICAgICAgICBlcnJvcl9hcHBl
bmRfaGludChlcnJwLA0KPiArICAgICAgICBlcnJvcl9hcHBlbmRfaGludCgmbG9jYWxfZXJyLA0K
PiAgICAgICAgICAgICAgICJBYm9ydGluZywgc2luY2UgdGhpcyBtYXkgY3JlYXRlIGFuIHVudXNh
YmxlIGRlc3RpbmF0aW9uIGltYWdlXG4iKTsNCj4gKyAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVy
cnAsIGxvY2FsX2Vycik7DQo+ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAgICB9IGVsc2Ug
aWYgKHJldCA8IDAgJiYgdGFyZ2V0LT5iYWNraW5nKSB7DQo+ICAgICAgICAgICAvKiBOb3QgZmF0
YWw7IGp1c3QgdHJ1ZGdlIG9uIGFoZWFkLiAqLw0KDQoNClBhaW4uLiBEbyB3ZSBuZWVkIHRoZXNl
IGhpbnRzLCBpZiB0aGV5IGFyZSBzbyBwYWluZnVsPw0KDQpBdCBsZWFzdCBmb3IgY2FzZXMgbGlr
ZSB0aGlzLCB3ZSBjYW4gY3JlYXRlIGhlbHBlciBmdW5jdGlvbg0KDQplcnJvcl9zZXRnX2Vycm5v
X2hpbnQoLi4uLCBlcnJvciwgaGludCkNCg0KQnV0IHdoYXQgY291bGQgYmUgZG9uZSB3aGVuIHdl
IGNhbGwgZnVuY3Rpb24sIHdoaWNoIG1heSBvciBtYXkgbm90IHNldCBlcnJwPw0KDQpyZXQgPSBm
KGVycnApOw0KaWYgKHJldCkgew0KICAgIGVycm9yX2FwcGVuZF9oaW50KGVycnAsIGhpbnQpOw0K
fQ0KDQpIbW1tLi4NCg0KQ2FuIGl0IGxvb2sgbGlrZQ0KDQpyZXQgPSBmKC4uLiwgaGludF9oZWxw
ZXIoZXJycCwgaGludCkpDQoNCj8NCg0KSSBjYW4ndCBpbWFnaW5lIGhvdyB0byBkbyBpdCwgYXMg
c29tZW9uZSBzaG91bGQgcmVtb3ZlIGhpbnQgZnJvbSBlcnJvcl9hYm9ydCBvYmplY3Qgb24NCnN1
Y2Nlc3MgcGF0aC4uDQoNCkJ1dCBzZWVtcywgdGhlIGZvbGxvd2luZyBpcyBwb3NzaWJsZSwgd2hp
Y2ggc2VlbXMgYmV0dGVyIGZvciBtZSB0aGFuIGxvY2FsLWVycm9yIGFwcHJvYWNoOg0KDQplcnJv
cl9wdXNoX2hpbnQoZXJycCwgaGludCk7DQpyZXQgPSBmKC4uLCBlcnJwKTsNCmVycm9yX3BvcF9o
aW50KGVycnApOw0KDQo9PT0NCg0KQ29udGludWUgdGhpbmtpbmcgb24gdGhpczoNCg0KSXQgbWF5
IGxvb2sgbGlrZSBqdXN0DQpyZXQgPSBmKC4uLiwgc2V0X2hpbnQoZXJycCwgaGludCkpOw0KDQpv
ciAoanVzdCB0byBzcGxpdCBsb25nIGxpbmUpOg0Kc2V0X2hpbnQoZXJycCwgaGludCk7DQpyZXQg
PSBmKC4uLiwgZXJycCk7DQoNCmlmIGluIGVhY2ggZnVuY3Rpb24gd2l0aCBlcnJwIGRvZXMgZXJy
b3JfcHVzaF9oaW50KGVycnApIG9uIHN0YXJ0IGFuZCBlcnJvcl9wb3BfaGludChlcnJwKSBvbiBl
eGl0LA0Kd2hpY2ggbWF5IGJlIGp1c3Qgb25lIGNhbGwgYXQgZnVuY3Rpb24gc3RhcnQgb2YgbWFj
cm8sIHdoaWNoIHdpbGwgY2FsbCBlcnJvcl9wdXNoX2hpbnQoZXJycCkgYW5kDQpkZWZpbmUgbG9j
YWwgdmFyaWFibGUgYnkgZ19hdXRvLCB3aXRoIGNsZWFudXAgd2hpY2ggd2lsbCBjYWxsIGVycm9y
X3BvcF9oaW50KGVycnApIG9uIGZ1bmN0aW9uDQpleGl0Li4NCg0KT3IsIG1heSBiZSwgbW9yZSBk
aXJlY3Qgd2F5IHRvIHNldCBjbGVhbnVwIGZvciBmdW5jdGlvbiBleGlzdHM/DQoNCj09PQ0KDQpB
bHNvLCB3ZSBjYW4gaW1wbGVtZW50IHNvbWUgY29kZSBnZW5lcmF0aW9uLCB0byBnZW5lcmF0ZSBm
b3IgZnVuY3Rpb25zIHdpdGggZXJycCBhcmd1bWVudA0Kd3JhcHBlcnMgd2l0aCBhZGRpdGlvbmFs
IGhpbnQgcGFyYW1ldGVyLCBhbmQganVzdCB1c2UgdGhlc2Ugd3JhcHBlcnMuLg0KDQo9PT0NCg0K
SWYgbm9ib2R5IGxpa2VzIGFueSBvZiBteSBzdWdnZXN0aW9ucywgdGhlbiBpZ25vcmUgdGhlbS4g
SSB1bmRlcnN0YW5kIHRoYXQgdGhpcyBzZXJpZXMgZml4ZXMNCnJlYWwgaXNzdWUgYW5kIG11Y2gg
ZWZmb3J0IGhhcyBhbHJlYWR5IGJlZW4gc3BlbnQuIE1heSBiZSBvbmUgZGF5IEknbGwgdHJ5IHRv
IHJld3JpdGUgaXQuLi4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

