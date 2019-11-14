Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CC1C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFC12071B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AwxxUWRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFC12071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVKEq-0002sz-Pz
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 13:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVKDt-00020t-4e
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 13:52:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVKDq-0005J8-PU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 13:52:04 -0500
Received: from mail-he1eur04on072b.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::72b]:12272
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVKDo-0005Cx-HM; Thu, 14 Nov 2019 13:52:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH7MUtxQw9U1iYJ4bobmBDct0xNBgsg413eFc3X/Vf++0RyBDScHxljhjfTaFaW7LkZW4JWwu1w6SpK5cdnwDDuVbOCcnX6qMhVO+gYJVezF7A4Rp6jxME7cqmYwyYlsY9mYDIGQv1kenjCFzPhxWrhdLh5UdT/gwkzk9K/vijwoUq0RrypuvDF8PB9xnZ/CHalhGTTjqaQzs61FQU3f82iFl2tMu0xtfPgfNILsa8ls+946zoBPqeqT7b0xXHOajUmwNh4qa7yDMowgwzWCQ+pvpci66O37RRUcHmFZdp5nZGs3D/gu6nnLmhur6kA+fExCcE1jsJufEFiUsBCYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbwY32a0gw5/LS7wglPnpg4RGAcvlDZ3qrE/AsQfcZo=;
 b=ns+UFoVgG9Z43DPJAC9qq5xomSTDcnSdtYNlccd4+PdX28hG/ltPLezJzKQZkuVRknGnL72GwgPejVEHdilc+EDWj1zL5NF7FvmJ8lnK9XBbdg3MQy4SNpe3bthSaZ60p4X/yWErPt0+/bNvU7Iu+MYlEPGQDdhCSlsGOH4VV6pG0Ay48HKhpLjN2b04Mdy9NkMZRh3boxLK6Ggq+wATmZoDjY7xJIVWvN1tsM6wFheKDZSdjnA8uMn3VywXfLOFWZGOVcuzbCTmIBQQOcCmJrMgv6dIHhA1iWc08/cyp5WMzcSTM79ebM/ItMqaf2bzY4pIKULbQiTtfludoxmfNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbwY32a0gw5/LS7wglPnpg4RGAcvlDZ3qrE/AsQfcZo=;
 b=AwxxUWRSIdMvDjABKtQkBBtWFOUQMmqcgpRXJvxCmZBdUptoBjznMJk2lyX8u7pmmph75cJSSWfX0vaMjFrTV2nfj1+QGW4b6O2DA8AgxOZRg979wlj9ztuL8lkfWvBfoy36L+12tLUoWjwRsI/ndY/yk5+GYISerSHuTst5xRo=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3352.eurprd08.prod.outlook.com (52.135.167.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Thu, 14 Nov 2019 18:51:57 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.024; Thu, 14 Nov 2019
 18:51:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 00/10] Further bitmaps improvements
Thread-Topic: [PATCH v2 00/10] Further bitmaps improvements
Thread-Index: AQHViNhxBdlNGPIt3E6XFSYoHa8CdaeLJkuAgAABLYA=
Date: Thu, 14 Nov 2019 18:51:57 +0000
Message-ID: <d0039f5d-9877-59f0-218d-a3a8f41e096f@virtuozzo.com>
References: <20191022125839.12633-1-vsementsov@virtuozzo.com>
 <4aec835a-a894-03a0-11e4-0407e0f18a84@redhat.com>
In-Reply-To: <4aec835a-a894-03a0-11e4-0407e0f18a84@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0213.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::13) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191114215153827
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd6b5efd-40c9-46ff-5456-08d76933b977
x-ms-traffictypediagnostic: AM6PR08MB3352:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3352E23840EBCACE68606C06C1710@AM6PR08MB3352.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39850400004)(199004)(189003)(81156014)(6486002)(81166006)(8936002)(31696002)(6436002)(14454004)(316002)(386003)(6506007)(478600001)(107886003)(53546011)(6512007)(6246003)(36756003)(186003)(52116002)(6116002)(99286004)(86362001)(3846002)(25786009)(4326008)(5660300002)(26005)(7736002)(2906002)(8676002)(31686004)(66556008)(64756008)(66446008)(66946007)(305945005)(66476007)(102836004)(256004)(446003)(486006)(110136005)(54906003)(229853002)(2501003)(476003)(11346002)(2616005)(14444005)(71190400001)(71200400001)(66066001)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3352;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z2hT5jxcwyeB75NpKTX6lonwImp4wZEUox3TkAWl9uQviCtUnlx88L/5jMRD82Ni1F0HuMwWBy1G3oA+oD57ra1APU8gCE+bn0BCS5QZLNS2dmM37NZAkVSIvoNRsTAfQ+kGV7w8Lo2NoIOooPdLeBGvYbWGFPXdzV63wu6lyFeSSBQ+7Cf/kEK1OxaOYcVFl5IR49ivAikUicF/BjAdY8b47nJ05t+dz+jXfbePfG8AyDT79Ad2646wJFM065tqf5P3QGcB9kESf+LC2Z9Su0/KAzGnnoptaBMkTmi9t+jKPLkrH5TC2ImRpFZez3bcPf/yNBhHCGseAli7v+k3OlRN42t+g4TR/RT/iMz+tbTgXSqK0gOboJxUuFoPhXSSo3TpK/wfbMefut1zswwLognjcyh6NgwAdhGd+Gu4s/TH134Z7y3pKMDGBu2K/2nG
Content-Type: text/plain; charset="utf-8"
Content-ID: <E756C8957473A0498CDE1432415267C5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6b5efd-40c9-46ff-5456-08d76933b977
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 18:51:57.3517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfBv9zu/ldxbr9l0zMdyOc+dZ4al4ca9BBf8muNfFnqzoIwTMAc69+mJ3eqIjT46ZVdoR7a1ANTbbHIJ/7o1rLqpQ/Fuodcs1nSG71OWtUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3352
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::72b
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTQuMTEuMjAxOSAyMTo0NywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMjIvMTkgNzo1OCBB
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhpIQ0KPj4NCj4+IFRo
ZSBtYWluIGZlYXR1cmUgaGVyZSBpcyBpbXByb3ZlbWVudCBvZiBfbmV4dF9kaXJ0eV9hcmVhIEFQ
SSwgd2hpY2ggSSdtDQo+PiBnb2luZyB0byB1c2UgdGhlbiBmb3IgYmFja3VwIC8gYmxvY2stY29w
eS4NCj4+DQo+PiB2MjoNCj4+IDAxOiBqdXN0IHVzZSBJTlQ2NF9NQVggaW5zdGVhZCBvZiBhZGRp
bmcgbmV3IGNvbnN0YW50DQo+PiAwODogYWRkIHNlcGFyYXRlIGZ1bmN0aW9uIG5iZF9leHRlbnRf
YXJyYXlfY29udmVydF90b19iZSBhbmQgY29udmVydGVkDQo+PiDCoMKgwqDCoCBzdGF0ZSBvZiBO
QkRFeHRlbnRBcnJheSwgdG8gbWFrZSB0aGVzZSB0aGluZ3MgZXhwbGljaXQsIGFuZCBhdm9pZA0K
Pj4gwqDCoMKgwqAgZXh0cmEgbWVtZHVwLg0KPj4gMDk6IFNhdmUgcGFydCBvZiBjb21tZW50IGZv
ciBiaXRtYXBfdG9fZXh0ZW50cygpLCBhZGQgRXJpYydzIHItYg0KPiANCj4gSXMgYW55IG9mIHRo
aXMgc2VyaWVzIGEgYnVnIGZpeCBpbXBvcnRhbnQgdG8gZ2V0IGludG8gLXJjMj8NCg0KTm90aGlu
Zw0KDQo+IE9yIGlzIGl0IHNhZmUgdG8gZGVmZXIgdG8gdGhlIDUuMCB0aW1lZnJhbWU/DQoNClll
cywgbm8gZG91YnRzLg0KDQo+IA0KPj4NCj4+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkg
KDEwKToNCj4+IMKgwqAgaGJpdG1hcDogYXNzZXJ0IHRoYXQgd2UgZG9uJ3QgY3JlYXRlIGJpdG1h
cCBsYXJnZXIgdGhhbiBJTlQ2NF9NQVgNCj4+IMKgwqAgaGJpdG1hcDogbW92ZSBoYml0bWFwX2l0
ZXJfbmV4dF93b3JkIHRvIGhiaXRtYXAuYw0KPj4gwqDCoCBoYml0bWFwOiB1bnB1Ymxpc2ggaGJp
dG1hcF9pdGVyX3NraXBfd29yZHMNCj4+IMKgwqAgaGJpdG1hcDogZHJvcCBtZXRhIGJpdG1hcHMg
YXMgdGhleSBhcmUgdW51c2VkDQo+PiDCoMKgIGJsb2NrL2RpcnR5LWJpdG1hcDogc3dpdGNoIF9u
ZXh0X2RpcnR5X2FyZWEgYW5kIF9uZXh0X3plcm8gdG8gaW50NjRfdA0KPj4gwqDCoCBibG9jay9k
aXJ0eS1iaXRtYXA6IGFkZCBfbmV4dF9kaXJ0eSBBUEkNCj4+IMKgwqAgYmxvY2svZGlydHktYml0
bWFwOiBpbXByb3ZlIF9uZXh0X2RpcnR5X2FyZWEgQVBJDQo+PiDCoMKgIG5iZC9zZXJ2ZXI6IGlu
dHJvZHVjZSBOQkRFeHRlbnRBcnJheQ0KPj4gwqDCoCBuYmQvc2VydmVyOiB1c2UgYmRydl9kaXJ0
eV9iaXRtYXBfbmV4dF9kaXJ0eV9hcmVhDQo+PiDCoMKgIGJsb2NrL3Fjb3cyLWJpdG1hcDogdXNl
IGJkcnZfZGlydHlfYml0bWFwX25leHRfZGlydHkNCj4+DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==

