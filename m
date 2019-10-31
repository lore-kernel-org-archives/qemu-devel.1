Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799AFCA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 13:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDDB2080F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 13:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J9F5RjbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDDB2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQA9a-0004BD-Ap
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 09:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQA7z-0002kj-7S
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 09:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQA7x-0003j0-MO
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 09:04:38 -0400
Received: from mail-eopbgr130093.outbound.protection.outlook.com
 ([40.107.13.93]:9015 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iQA7w-0003fs-VW; Thu, 31 Oct 2019 09:04:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdwX6Kj8mLvEaZbqtiBY3ncpuyOZyTk1lV6sLzxq1wXXjhEcjIcjUcsYMnuKtU8GbuhyU8VK+vBKLdQRViiRjInhCzldpukKVraxlYx/W4sWEpfFGOZsvj3uU/ebmtnTBvGk6cadlkTRIlg/Jk1ePoTIm1bgQAsqTOUap4POxMeg8W5gSurWCk09Nm+Iv8GgQLg5HQdPDETG+3Ek+qsn7N7yLmok9GbU3Cba0zuDwyc/+d5ZKJR0TmfZPf0h9QGANFhCoXU7GYAc3csh6zbSR3vf0SqoGDggFc6S0orIkDBzdH9ea6JbretZni898VXU0d+q6I/pMVtieXO1Ip50Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSPXs+xUtiHrxSB83R35XO0SCEAXteztZfnsjwD5f0o=;
 b=aJroIP80O/qy6QhqL6XyltJI/bwo6sxQm6ayS5hXT8WPfVzPo181s7bOyZ+fVssPcTQxGzp/NA1vlrjp8ZDYbaNStWW11oU+1rSCQBkzHuB8JVa4AJF40wuBiw5LK6yQSryWnOkn8oq96k+CkcLcTo7LOSSfEY7kicxOefD+rc4MSo13o1LL6A/dn3Yu5JOD6CuyHkJj/fn3fGJ6cKypKXWVUDMPIjuWoCUjZWgYkGdOOyAlB0BQZ9uu1awiVQKwfCyDDPHEDhkO+TOUXeLlIaf+8Ed5fKwUrO2b2akpUz+7LELwygq1allrgh1+r0fpUvj/vlUePVgXsHP7z9q2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSPXs+xUtiHrxSB83R35XO0SCEAXteztZfnsjwD5f0o=;
 b=J9F5RjbDc2a6GQ+jOYZmdo0q4e/XwJ1v9Ud+/BqtQxlk85RN9YvOXZcIQQS/ZeR+DHQQsw7qqs/MTtbNxXKC2jAszC1l3ctNBS4JnQ9dWJOdNBzImD+4/VFKK68/8MzHAw36m/Icr4ZuZBkqOhrmIul26HI41XWFmlqYIXq57pI=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3250.eurprd08.prod.outlook.com (52.134.94.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Thu, 31 Oct 2019 13:04:30 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2408.019; Thu, 31 Oct 2019
 13:04:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Tuguoyi <tu.guoyi@h3c.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Topic: [PATCH v3] qcow2-bitmap: Fix uint64_t left-shift overflow
Thread-Index: AdWPFo/e/4bra9yKTuSMM3n9Yap7HgA1SmqA
Date: Thu, 31 Oct 2019 13:04:29 +0000
Message-ID: <e50ae813-944a-4b78-d8df-fb98594c988d@virtuozzo.com>
References: <f26933e80e434b5f875e7db24ef9d02f@h3c.com>
In-Reply-To: <f26933e80e434b5f875e7db24ef9d02f@h3c.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0038.eurprd09.prod.outlook.com
 (2603:10a6:7:15::27) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191031160427464
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dadb65ba-49e0-40d9-e876-08d75e02dda0
x-ms-traffictypediagnostic: AM0PR08MB3250:
x-microsoft-antispam-prvs: <AM0PR08MB3250B79587022DFBB323941CC1630@AM0PR08MB3250.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:117;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39850400004)(366004)(396003)(136003)(376002)(189003)(199004)(52314003)(71200400001)(256004)(6116002)(11346002)(54906003)(6486002)(6436002)(7736002)(229853002)(2501003)(7416002)(2616005)(476003)(2906002)(486006)(3846002)(478600001)(14454004)(71190400001)(110136005)(25786009)(316002)(81166006)(66066001)(2201001)(8936002)(86362001)(305945005)(446003)(31696002)(66946007)(8676002)(4326008)(6512007)(6246003)(81156014)(186003)(31686004)(52116002)(386003)(76176011)(26005)(5660300002)(99286004)(66556008)(66446008)(36756003)(64756008)(66476007)(6506007)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3250;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ugk0Aw008ikJ1LN9igePuRfjHRrprAaL5O1l7tjVC0ajseKe5nuLGV6CInySb0Kwx+TLWKXBlaL/lvCOS+XnERnq62N6d4wleKXERSkitUobARG/8d1C4Dg2koetYeecBDnCGVvsYn5cNA6N7oCe9jjRPWoqLieRuXKZjakXPtFFD9SSYRduRUDY+RRiQyUfwLg8qoMyFG3XXEgAZHpKUCRBNfUiY0FTwWwIHJQGIGoo+sFxcqmVNfTNuhuKVCxMt3P09KsZAlluhB6qBs5beUu7u8H8twjfhzTjUbLqVoR3/k1N0GrdHhhuuBCFCW0gqXWvi6BNUUlLsOEywq6Dcrs0vGdoiOd3ZJE0J4Wq8ZdHUbiRfwtnShuLVyzmM46nl3UWPZ8EUCq7X+f8B8YYvPnE3YIrU0kR3WLQfSz0esgTK3P+A+xohte25jfTQFbC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3BAC3372DDC184EA1D3E7671CE8BC2B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadb65ba-49e0-40d9-e876-08d75e02dda0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 13:04:29.9438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZYA0iqTafBwjDsDA0w292qwZjdqiG/oK+HRI97cw+bf1+8jj0IkbXxHG+ClOIl/h/fJ5JSXtpngSq6bEHZMJ4oxEdZF2caOmWklUrJ4+dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3250
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.93
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Wangyongqing <w_yongqing@h3c.com>, Changlimin <changlimin@h3c.com>,
 Gaoliang <liang_gao@h3c.com>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMTAuMjAxOSAxNDo0NiwgVHVndW95aSB3cm90ZToNCj4gVGhlcmUgYXJlIHR3byBpc3N1ZXMg
aW4gSW4gY2hlY2tfY29uc3RyYWludHNfb25fYml0bWFwKCksDQo+IDEpIFRoZSBzYW5pdHkgY2hl
Y2sgb24gdGhlIGdyYW51bGFyaXR5IHdpbGwgY2F1c2UgdWludDY0X3QNCj4gaW50ZWdlciBsZWZ0
LXNoaWZ0IG92ZXJmbG93IHdoZW4gY2x1c3Rlcl9zaXplIGlzIDJNIGFuZCB0aGUNCj4gZ3JhbnVs
YXJpdHkgaXMgQklHR0VSIHRoYW4gMzJLLg0KPiAyKSBUaGUgd2F5IHRvIGNhbGN1bGF0ZSBpbWFn
ZSBzaXplIHRoYXQgdGhlIG1heGltdW0gYml0bWFwDQo+IHN1cHBvcnRlZCBjYW4gbWFwIHRvIGlz
IGEgYml0IGluY29ycmVjdC4NCj4gVGhpcyBwYXRjaCBmaXggaXQgYnkgYWRkIGEgaGVscGVyIGZ1
bmN0aW9uIHRvIGNhbGN1bGF0ZSB0aGUNCj4gbnVtYmVyIG9mIGJ5dGVzIG5lZWRlZCBieSBhIG5v
cm1hbCBiaXRtYXAgaW4gaW1hZ2UgYW5kIGNvbXBhcmUNCj4gaXQgdG8gdGhlIG1heGltdW0gYml0
bWFwIGJ5dGVzIHN1cHBvcnRlZCBieSBxZW11Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VveWkg
VHUgPHR1Lmd1b3lpQGgzYy5jb20+DQoNClBsZWFzZSwgd2hlcmUgcG9zc2libGUsIG1lbnRpb24g
Y29tbWl0IHdoZXJlIGJ1ZyB3YXMgaW50cm9kdWNlZCBpbg0KY29tbWl0IG1lc3NhZ2UuIEFsc28s
IGFkZCBxZW11LXN0YWJsZUBub25nbnUub3JnIHRvIENDIHdoZW4gZml4aW5nDQpyZWxlYXNlZCBi
dWdzLg0KDQoNCkZpeGVzOiA1ZjcyODI2ZTdmYzYyMTY3Y2YzYQ0KUmV2aWV3ZWQtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KVGhh
bmtzIGZvciBmaXhpbmchDQoNCj4gLS0tDQo+ICAgYmxvY2svcWNvdzItYml0bWFwLmMgfCAxNSAr
KysrKysrKysrKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9xY293Mi1iaXRtYXAuYyBiL2Js
b2NrL3Fjb3cyLWJpdG1hcC5jDQo+IGluZGV4IDk4Mjk0YTcuLjM0OTM1YmIgMTAwNjQ0DQo+IC0t
LSBhL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+ICsrKyBiL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+
IEBAIC0xNDIsNiArMTQyLDE0IEBAIHN0YXRpYyBpbnQgY2hlY2tfdGFibGVfZW50cnkodWludDY0
X3QgZW50cnksIGludCBjbHVzdGVyX3NpemUpDQo+ICAgICAgIHJldHVybiAwOw0KPiAgIH0NCj4g
ICANCj4gK3N0YXRpYyBpbmxpbmUgaW50NjRfdCBnZXRfYml0bWFwX2J5dGVzX25lZWRlZChpbnQ2
NF90IGxlbiwNCg0KQUZBSUsgImlubGluZSIgaXMgbm8tb3AgaW4gdGhpcyBjb250ZXh0LCBjb21w
aWxlciB3aWxsIG1vc3QgcHJvYmFibHkgaW5saW5lIGl0IGFueXdheSwNCmFuZCAiaW5saW5lIiB3
b3JkIGRvbid0IGluZmx1ZW5jZSBvbiB0aGlzIHByb2JhYmlsaXR5LiBTbywgYmV0dGVyIGRyb3Ag
aXQuDQoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50MzJfdCBncmFudWxhcml0eSkNCj4gK3sNCj4gKyAgICBpbnQ2NF90IG51bV9iaXRzID0gRElW
X1JPVU5EX1VQKGxlbiwgZ3JhbnVsYXJpdHkpOw0KPiArDQo+ICsgICAgcmV0dXJuIERJVl9ST1VO
RF9VUChudW1fYml0cywgOCk7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgaW50IGNoZWNrX2NvbnN0
cmFpbnRzX29uX2JpdG1hcChCbG9ja0RyaXZlclN0YXRlICpicywNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGdyYW51bGFyaXR5LA0KPiBA
QCAtMTUwLDYgKzE1OCw3IEBAIHN0YXRpYyBpbnQgY2hlY2tfY29uc3RyYWludHNfb25fYml0bWFw
KEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgICAgICBCRFJWUWNvdzJTdGF0ZSAqcyA9IGJzLT5v
cGFxdWU7DQo+ICAgICAgIGludCBncmFudWxhcml0eV9iaXRzID0gY3R6MzIoZ3JhbnVsYXJpdHkp
Ow0KPiAgICAgICBpbnQ2NF90IGxlbiA9IGJkcnZfZ2V0bGVuZ3RoKGJzKTsNCj4gKyAgICBpbnQ2
NF90IGJpdG1hcF9ieXRlczsNCj4gICANCj4gICAgICAgYXNzZXJ0KGdyYW51bGFyaXR5ID4gMCk7
DQo+ICAgICAgIGFzc2VydCgoZ3JhbnVsYXJpdHkgJiAoZ3JhbnVsYXJpdHkgLSAxKSkgPT0gMCk7
DQo+IEBAIC0xNzEsOSArMTgwLDkgQEAgc3RhdGljIGludCBjaGVja19jb25zdHJhaW50c19vbl9i
aXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsN
Cj4gICAgICAgfQ0KPiAgIA0KPiAtICAgIGlmICgobGVuID4gKHVpbnQ2NF90KUJNRV9NQVhfUEhZ
U19TSVpFIDw8IGdyYW51bGFyaXR5X2JpdHMpIHx8DQo+IC0gICAgICAgIChsZW4gPiAodWludDY0
X3QpQk1FX01BWF9UQUJMRV9TSVpFICogcy0+Y2x1c3Rlcl9zaXplIDw8DQo+IC0gICAgICAgICAg
ICAgICBncmFudWxhcml0eV9iaXRzKSkNCj4gKyAgICBiaXRtYXBfYnl0ZXMgPSBnZXRfYml0bWFw
X2J5dGVzX25lZWRlZChsZW4sIGdyYW51bGFyaXR5KTsNCj4gKyAgICBpZiAoKGJpdG1hcF9ieXRl
cyA+ICh1aW50NjRfdClCTUVfTUFYX1BIWVNfU0laRSkgfHwNCj4gKyAgICAgICAgKGJpdG1hcF9i
eXRlcyA+ICh1aW50NjRfdClCTUVfTUFYX1RBQkxFX1NJWkUgKiBzLT5jbHVzdGVyX3NpemUpKQ0K
PiAgICAgICB7DQo+ICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJUb28gbXVjaCBzcGFjZSB3
aWxsIGJlIG9jY3VwaWVkIGJ5IHRoZSBiaXRtYXAuICINCj4gICAgICAgICAgICAgICAgICAgICAg
IlVzZSBsYXJnZXIgZ3JhbnVsYXJpdHkiKTsNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K

