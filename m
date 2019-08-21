Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457E4C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A57206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QX8RZjiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A57206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0RoT-0007zT-7l
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 10:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0Rnj-0007R8-BX
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i0Rnh-0002T6-Ti
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:41:27 -0400
Received: from mail-eopbgr40102.outbound.protection.outlook.com
 ([40.107.4.102]:39214 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i0Rna-0002Lj-RK; Wed, 21 Aug 2019 10:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YX2JQnCBGR+0PjuEx6LukSGJM4nKoeEmiQs8U41k2TcQ4CMGttwaciU/aNHoRMJk4KOldHDzdwu03mBNlch3ElFen/z4BlD4YifoSpMCCEDtQnJnV95Nyqd9WEMlk+ehRWtZvM0n9q00JtjwZVBvanX6ryBdPpBgTymrQBR7cCubrM5AKPRwVJcJ4kcopzxkxzzsPToJDsjIOtTWguGm9os9N2h6Z07JdIKnoHa8yDmGsk5cnQDkCCBRhqm6cx7rW9u9MXl72NLDZq/MI7k2C36lzrMw/Htj9MxNzHEfKJowYronmBgEwnDgCISJA352U5uMyKsjLEOWsFMytAE7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vggMS3r5JI7yrS1FIVU0nTMqgOiBM9XegjeOlpvTUog=;
 b=hLKv/tdYLUMCVEOdPONswmtO5Buk3GQWmtROQpStOCG4brUfGWaNGjIv4Av4EMD51ij76xS4PQ9FxgZjPt96IafbR5F/SaklJm6HyVuuV+tZr0qh2kIJ1XsyHApHbpWtCxWJU4hYRsB7IfAo2FBTFBsEqXVJSthGAcsbUNL63PMOjPnwYL1xCBHrHvrsDmlwPNCXhwhj3b6RDMgNXTYrL1GKd0wPCVTNizKSicwQuPVX7bhth9n1KmjiqR93w8EdSx/qGTlu53LgJBwXT1hlG/kF5UKnhkJrVw85slPahU2sO2bXjH9xlqAtQqI9eTbpalKbdpYr7r2UePfHrknWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vggMS3r5JI7yrS1FIVU0nTMqgOiBM9XegjeOlpvTUog=;
 b=QX8RZjiqY37cQ+8aiQAQPeWsRxYUz28cTQR73Vd7oHZCRAY/XlysHxoXEGlwybTrG4POvo7DAe8HcDr40ioLPQuBusGxImczrthv4bQ7Rj9Sne77eZe4pfqYGlqsw7V4qKwe5uJSfiEgg3EQGfgb4Ylipwd9f5ADvkuYELia7w8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4122.eurprd08.prod.outlook.com (20.179.11.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 14:41:16 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 14:41:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH] block/backup: install notifier during creation
Thread-Index: AQHVTu7v5GJB5n7vl0itOMdQhozpxacFvxkA
Date: Wed, 21 Aug 2019 14:41:16 +0000
Message-ID: <b85698e6-cd79-a9c5-554c-c92487060280@virtuozzo.com>
References: <20190809201333.29033-1-jsnow@redhat.com>
In-Reply-To: <20190809201333.29033-1-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0041.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::30) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190821174114208
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81683ca2-23ba-4b8d-4e83-08d726459f31
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4122; 
x-ms-traffictypediagnostic: DB8PR08MB4122:
x-microsoft-antispam-prvs: <DB8PR08MB41229EA99DAC879B4688AAA0C1AA0@DB8PR08MB4122.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:118;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(396003)(346002)(376002)(136003)(189003)(199004)(31696002)(25786009)(2906002)(316002)(6436002)(6116002)(229853002)(6486002)(3846002)(5660300002)(6512007)(86362001)(478600001)(81166006)(8936002)(81156014)(31686004)(14454004)(66446008)(386003)(2501003)(446003)(2616005)(76176011)(66066001)(6506007)(66476007)(66556008)(8676002)(64756008)(66946007)(54906003)(110136005)(102836004)(26005)(4326008)(36756003)(53936002)(476003)(256004)(52116002)(6246003)(14444005)(7736002)(486006)(186003)(305945005)(2201001)(71190400001)(11346002)(99286004)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4122;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wt4WxNg90drAJI6CvUX5B8u++L4tdGVkmLd7mbrUASeK0uKLLyLjBEWyHVzyHvA4bcF6TVGN4G62u1TTe9hMN/tAquWwhyGmPRkUBWDU1U9m7W1KMQeIIn62P+12oZ1SsoIFLrD+4AFDO2omoE711mNXziCycfm53fO5caWrq937oC/IRoX7dZZfdGhuiD8hl+JCg/O8GTziXvDB07T/dvw9M22T2CzfVicJsw5in09fWzfRQwXM0tpjh1OvIYytdN3Rpi1ccllYAXNK9Oaj1ayqDNCJLMCtAtY3rOeZNSWYTGfWekKBmg1OWSAHrRIE+rHe4el9N7W5PVx+gUBQHLMQQ1y1z+A61hDLPpY/i04aPYlZCOmzbDDrz8s961ZOTcIHOTB9cP5nxW+hMVHnBB8CYbaGEixUIgpNLc5O3DY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <42FB42435FC9684F86A78FAB21F9E989@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81683ca2-23ba-4b8d-4e83-08d726459f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 14:41:16.3213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8fX5g7gtgTpOun2TjD2Wio3yhVCQz+817859ZD27ag1/peX4v6ja9EzxdDgWQrDz5jK0QwuSrV0hOW0pkw/txjDo1leJbfbCHyn+B4F0Cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4122
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.102
Subject: Re: [Qemu-devel] [PATCH] block/backup: install notifier during
 creation
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
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAyMzoxMywgSm9obiBTbm93IHdyb3RlOg0KPiBCYWNrdXAgam9icyBtYXkgeWll
bGQgcHJpb3IgdG8gaW5zdGFsbGluZyB0aGVpciBoYW5kbGVyLCBiZWNhdXNlIG9mIHRoZQ0KPiBq
b2JfY29fZW50cnkgc2hpbSB3aGljaCBndWFyYW50ZWVzIHRoYXQgYSBqb2Igd29uJ3QgYmVnaW4g
d29yayB1bnRpbA0KPiB3ZSBhcmUgcmVhZHkgdG8gc3RhcnQgYW4gZW50aXJlIHRyYW5zYWN0aW9u
Lg0KPiANCj4gVW5mb3J0dW5hdGVseSwgdGhpcyBtYWtlcyBwcm92aW5nIGNvcnJlY3RuZXNzIGFi
b3V0IHRyYW5zYWN0aW9uYWwNCj4gcG9pbnRzLWluLXRpbWUgZm9yIGJhY2t1cCBoYXJkIHRvIHJl
YXNvbiBhYm91dC4gTWFrZSBpdCBleHBsaWNpdGx5IGNsZWFyDQo+IGJ5IG1vdmluZyB0aGUgaGFu
ZGxlciByZWdpc3RyYXRpb24gdG8gY3JlYXRpb24gdGltZSwgYW5kIGNoYW5naW5nIHRoZQ0KPiB3
cml0ZSBub3RpZmllciB0byBhIG5vLW9wIHVudGlsIHRoZSBqb2IgaXMgc3RhcnRlZC4NCj4gDQo+
IFJlcG9ydGVkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZp
cnR1b3p6by5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNv
bT4NCj4gLS0tDQo+ICAgYmxvY2svYmFja3VwLmMgICAgIHwgMzIgKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0NCj4gICBpbmNsdWRlL3FlbXUvam9iLmggfCAgNSArKysrKw0KPiAgIGpv
Yi5jICAgICAgICAgICAgICB8ICAyICstDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRp
b25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9iYWNrdXAu
YyBiL2Jsb2NrL2JhY2t1cC5jDQo+IGluZGV4IDA3ZDc1MWFlYTQuLjRkZjViOTU0MTUgMTAwNjQ0
DQo+IC0tLSBhL2Jsb2NrL2JhY2t1cC5jDQo+ICsrKyBiL2Jsb2NrL2JhY2t1cC5jDQo+IEBAIC0z
NDQsNiArMzQ0LDEzIEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGJhY2t1cF9iZWZvcmVfd3Jp
dGVfbm90aWZ5KA0KPiAgICAgICBhc3NlcnQoUUVNVV9JU19BTElHTkVEKHJlcS0+b2Zmc2V0LCBC
RFJWX1NFQ1RPUl9TSVpFKSk7DQo+ICAgICAgIGFzc2VydChRRU1VX0lTX0FMSUdORUQocmVxLT5i
eXRlcywgQkRSVl9TRUNUT1JfU0laRSkpOw0KPiAgIA0KPiArICAgIC8qIFRoZSBoYW5kbGVyIGlz
IGluc3RhbGxlZCBhdCBjcmVhdGlvbiB0aW1lOyB0aGUgYWN0dWFsIHBvaW50LWluLXRpbWUNCj4g
KyAgICAgKiBzdGFydHMgYXQgam9iX3N0YXJ0KCkuIFRyYW5zYWN0aW9ucyBndWFyYW50ZWUgdGhv
c2UgdHdvIHBvaW50cyBhcmUNCj4gKyAgICAgKiB0aGUgc2FtZSBwb2ludCBpbiB0aW1lLiAqLw0K
PiArICAgIGlmICgham9iX3N0YXJ0ZWQoJmpvYi0+Y29tbW9uLmpvYikpIHsNCj4gKyAgICAgICAg
cmV0dXJuIDA7DQo+ICsgICAgfQ0KDQpIbW0sIHNvcnJ5IGlmIGl0IGlzIGEgc3R1cGlkIHF1ZXN0
aW9uLCBJJ20gbm90IGdvb2QgaW4gbXVsdGlwcm9jZXNzaW5nIGFuZCBpbg0KUWVtdSBpb3RocmVh
ZHMuLg0KDQpqb2Jfc3RhcnRlZCBqdXN0IHJlYWRzIGpvYi0+Y28uIElmIGJzIHJ1bnMgaW4gaW90
aHJlYWQsIGFuZCB0aGVyZWZvcmUgd3JpdGUtbm90aWZpZXINCmlzIGluIGlvdGhyZWFkLCB3aGVu
IGpvYl9zdGFydCBpcyBjYWxsZWQgZnJvbSBtYWluIHRocmVhZC4uIElzIGl0IGd1YXJhbnRlZWQg
dGhhdA0Kd3JpdGUtbm90aWZpZXIgd2lsbCBzZWUgam9iLT5jbyB2YXJpYWJsZSBjaGFuZ2UgZWFy
bHkgZW5vdWdoIHRvIG5vdCBtaXNzIGd1ZXN0IHdyaXRlPw0KU2hvdWxkIG5vdCBqb2ItPmNvIGJl
IHZvbGF0aWxlIGZvciBleGFtcGxlIG9yIHNvbWV0aGluZyBsaWtlIHRoaXM/DQoNCklmIG5vdCB0
aGluayBhYm91dCB0aGlzIHBhdGNoIGxvb2tzIGdvb2QgZm9yIG1lLg0KDQo+ICsNCj4gICAgICAg
cmV0dXJuIGJhY2t1cF9kb19jb3coam9iLCByZXEtPm9mZnNldCwgcmVxLT5ieXRlcywgTlVMTCwg
dHJ1ZSk7DQo+ICAgfQ0KPiAgIA0KPiBAQCAtMzk4LDYgKzQwNSwxMiBAQCBzdGF0aWMgdm9pZCBi
YWNrdXBfY2xlYW4oSm9iICpqb2IpDQo+ICAgICAgIEJhY2t1cEJsb2NrSm9iICpzID0gY29udGFp
bmVyX29mKGpvYiwgQmFja3VwQmxvY2tKb2IsIGNvbW1vbi5qb2IpOw0KPiAgICAgICBCbG9ja0Ry
aXZlclN0YXRlICpicyA9IGJsa19icyhzLT5jb21tb24uYmxrKTsNCj4gICANCj4gKyAgICAvKiBj
YW5jZWxsZWQgYmVmb3JlIGpvYl9zdGFydDogcmVtb3ZlIHdyaXRlX25vdGlmaWVyICovDQo+ICsg
ICAgaWYgKHMtPmJlZm9yZV93cml0ZS5ub3RpZnkpIHsNCj4gKyAgICAgICAgbm90aWZpZXJfd2l0
aF9yZXR1cm5fcmVtb3ZlKCZzLT5iZWZvcmVfd3JpdGUpOw0KPiArICAgICAgICBzLT5iZWZvcmVf
d3JpdGUubm90aWZ5ID0gTlVMTDsNCj4gKyAgICB9DQo+ICsNCj4gICAgICAgaWYgKHMtPmNvcHlf
Yml0bWFwKSB7DQo+ICAgICAgICAgICBiZHJ2X3JlbGVhc2VfZGlydHlfYml0bWFwKGJzLCBzLT5j
b3B5X2JpdG1hcCk7DQo+ICAgICAgICAgICBzLT5jb3B5X2JpdG1hcCA9IE5VTEw7DQo+IEBAIC01
MjcsMTcgKzU0MCw4IEBAIHN0YXRpYyB2b2lkIGJhY2t1cF9pbml0X2NvcHlfYml0bWFwKEJhY2t1
cEJsb2NrSm9iICpqb2IpDQo+ICAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmFja3VwX3J1bihK
b2IgKmpvYiwgRXJyb3IgKiplcnJwKQ0KPiAgIHsNCj4gICAgICAgQmFja3VwQmxvY2tKb2IgKnMg
PSBjb250YWluZXJfb2Yoam9iLCBCYWNrdXBCbG9ja0pvYiwgY29tbW9uLmpvYik7DQo+IC0gICAg
QmxvY2tEcml2ZXJTdGF0ZSAqYnMgPSBibGtfYnMocy0+Y29tbW9uLmJsayk7DQo+ICAgICAgIGlu
dCByZXQgPSAwOw0KPiAgIA0KPiAtICAgIFFMSVNUX0lOSVQoJnMtPmluZmxpZ2h0X3JlcXMpOw0K
PiAtICAgIHFlbXVfY29fcndsb2NrX2luaXQoJnMtPmZsdXNoX3J3bG9jayk7DQo+IC0NCj4gLSAg
ICBiYWNrdXBfaW5pdF9jb3B5X2JpdG1hcChzKTsNCj4gLQ0KPiAtICAgIHMtPmJlZm9yZV93cml0
ZS5ub3RpZnkgPSBiYWNrdXBfYmVmb3JlX3dyaXRlX25vdGlmeTsNCj4gLSAgICBiZHJ2X2FkZF9i
ZWZvcmVfd3JpdGVfbm90aWZpZXIoYnMsICZzLT5iZWZvcmVfd3JpdGUpOw0KPiAtDQo+ICAgICAg
IGlmIChzLT5zeW5jX21vZGUgPT0gTUlSUk9SX1NZTkNfTU9ERV9UT1ApIHsNCj4gICAgICAgICAg
IGludDY0X3Qgb2Zmc2V0ID0gMDsNCj4gICAgICAgICAgIGludDY0X3QgY291bnQ7DQo+IEBAIC01
NzIsNiArNTc2LDcgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmFja3VwX3J1bihKb2IgKmpv
YiwgRXJyb3IgKiplcnJwKQ0KPiAgIA0KPiAgICBvdXQ6DQo+ICAgICAgIG5vdGlmaWVyX3dpdGhf
cmV0dXJuX3JlbW92ZSgmcy0+YmVmb3JlX3dyaXRlKTsNCj4gKyAgICBzLT5iZWZvcmVfd3JpdGUu
bm90aWZ5ID0gTlVMTDsNCj4gICANCj4gICAgICAgLyogd2FpdCB1bnRpbCBwZW5kaW5nIGJhY2t1
cF9kb19jb3coKSBjYWxscyBoYXZlIGNvbXBsZXRlZCAqLw0KPiAgICAgICBxZW11X2NvX3J3bG9j
a193cmxvY2soJnMtPmZsdXNoX3J3bG9jayk7DQo+IEBAIC03NjcsNiArNzcyLDE1IEBAIEJsb2Nr
Sm9iICpiYWNrdXBfam9iX2NyZWF0ZShjb25zdCBjaGFyICpqb2JfaWQsIEJsb2NrRHJpdmVyU3Rh
dGUgKmJzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9yX2Fib3J0KTsNCj4gICAg
ICAgam9iLT5sZW4gPSBsZW47DQo+ICAgDQo+ICsgICAgLyogRmluYWxseSwgaW5zdGFsbCBhIHdy
aXRlIG5vdGlmaWVyIHRoYXQgdGFrZXMgZWZmZWN0IGFmdGVyIGpvYl9zdGFydCgpICovDQo+ICsg
ICAgYmFja3VwX2luaXRfY29weV9iaXRtYXAoam9iKTsNCj4gKw0KPiArICAgIFFMSVNUX0lOSVQo
JmpvYi0+aW5mbGlnaHRfcmVxcyk7DQo+ICsgICAgcWVtdV9jb19yd2xvY2tfaW5pdCgmam9iLT5m
bHVzaF9yd2xvY2spOw0KPiArDQo+ICsgICAgam9iLT5iZWZvcmVfd3JpdGUubm90aWZ5ID0gYmFj
a3VwX2JlZm9yZV93cml0ZV9ub3RpZnk7DQo+ICsgICAgYmRydl9hZGRfYmVmb3JlX3dyaXRlX25v
dGlmaWVyKGJzLCAmam9iLT5iZWZvcmVfd3JpdGUpOw0KPiArDQo+ICAgICAgIHJldHVybiAmam9i
LT5jb21tb247DQo+ICAgDQo+ICAgIGVycm9yOg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11
L2pvYi5oIGIvaW5jbHVkZS9xZW11L2pvYi5oDQo+IGluZGV4IDllN2NkMWU0YTAuLjczM2FmYjY5
NmIgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvcWVtdS9qb2IuaA0KPiArKysgYi9pbmNsdWRlL3Fl
bXUvam9iLmgNCj4gQEAgLTM5NCw2ICszOTQsMTEgQEAgdm9pZCBqb2JfZW50ZXJfY29uZChKb2Ig
KmpvYiwgYm9vbCgqZm4pKEpvYiAqam9iKSk7DQo+ICAgICovDQo+ICAgdm9pZCBqb2Jfc3RhcnQo
Sm9iICpqb2IpOw0KPiAgIA0KPiArLyoqDQo+ICsgKiBqb2Jfc3RhcnRlZCByZXR1cm5zIHRydWUg
aWYgdGhlIEBqb2IgaGFzIHN0YXJ0ZWQuDQo+ICsgKi8NCj4gK2Jvb2wgam9iX3N0YXJ0ZWQoSm9i
ICpqb2IpOw0KPiArDQo+ICAgLyoqDQo+ICAgICogQGpvYjogVGhlIGpvYiB0byBlbnRlci4NCj4g
ICAgKg0KPiBkaWZmIC0tZ2l0IGEvam9iLmMgYi9qb2IuYw0KPiBpbmRleCAyOGRkNDhmOGE1Li43
NDVhZjY1OWZmIDEwMDY0NA0KPiAtLS0gYS9qb2IuYw0KPiArKysgYi9qb2IuYw0KPiBAQCAtMjQz
LDcgKzI0Myw3IEBAIGJvb2wgam9iX2lzX2NvbXBsZXRlZChKb2IgKmpvYikNCj4gICAgICAgcmV0
dXJuIGZhbHNlOw0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBib29sIGpvYl9zdGFydGVkKEpvYiAq
am9iKQ0KPiArYm9vbCBqb2Jfc3RhcnRlZChKb2IgKmpvYikNCj4gICB7DQo+ICAgICAgIHJldHVy
biBqb2ItPmNvOw0KPiAgIH0NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

