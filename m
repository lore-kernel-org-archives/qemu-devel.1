Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E11C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 12:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CD421929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 12:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wM6cPLDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CD421929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAvDj-0005o1-8t
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 08:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAv78-0008Bb-IZ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAv77-0004bT-6a
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:00:46 -0400
Received: from mail-eopbgr10108.outbound.protection.outlook.com
 ([40.107.1.108]:19774 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAv6j-0004JL-2d; Thu, 19 Sep 2019 08:00:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5BrXE4msMPDzPSv2+rNbdTwxLQwN+/vqb29oN8fm8kH+V7lEJU029azCCNgs9UzZ+CvHnHcdEbE1QJua3hrO+w7b/j8fI5kxNAwo1pjsR6D1j3mhtfYvShhOUw7CkUjHFwGTZ8q/fGUTGZ/2kPiuvEXt34i9gFVTy6rP9E41PWqc7afKpLEtrhicXxtzgURP2rn1EKevt7Hy2wvjjph9injbH66UJ6ggMKrnX4p+knyiUs89WoPtzfTVGfplqePBRLLqf9jB8slQ1dnl2OfVXEj4lJlv42wJdSbIZW0fT4zEXgH2RjMOtKQoPuHLnlwJmIRmuQg8KkFle5CVUG0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDy1rVf6dSAyX6nLkqCWQqw4nubV9lEY+yaMMYo3jrI=;
 b=i5i6pcdrqTSLHMm60l3g/uD/U/YkbzExV6dEVowuDzUvB88c1KDO6TtINl4z7bwvQ/nDuTl6kCrQiobU+d5TregvEsEeXA4/EFKrIRp5zH0FgpziCm+mE2PkggKV/ZPhKq5vyAi1yP+z1i8ieIkNUpZaKgjlikj3BY436tKAO5iNDcOE31gArxvQzX9xzFUs0oQpGVrstnRjD+zK9QP0hSBcvw5rkwyDHLrnBjY3iJQFl4iZva1uftk4LNEBzcy9GIghki1wawqzFtIlxaj7LmXf/eIsWcvMYvTf9r5pcrCbJM9mPrtOaNyKJtwY0hIxEGtyOTBo1x01pgs0Ly1QAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDy1rVf6dSAyX6nLkqCWQqw4nubV9lEY+yaMMYo3jrI=;
 b=wM6cPLDqF8AFVYYZtuWCNgkMM6gOzgTVfPClJEYTVmelOxKG3Zqx7OjXzsHlw6TUWnyfrBTT8QhvZ6rP34pTFjbegDJ1WNB5bXWmM888Aqjbdn+3WGzAJP8lPBlm02+Omf5p7fllBagfHcbDo6pTiGja4c9BcF5HKAhxO0OAeKU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5514.eurprd08.prod.outlook.com (52.133.243.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 12:00:15 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 12:00:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKcxq6KAgAEOLgCAAC2AgA==
Date: Thu, 19 Sep 2019 12:00:15 +0000
Message-ID: <1ee95d94-d3f9-2f56-a0bb-61d31e3ceeb7@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
 <20190919091720.GB10163@localhost.localdomain>
In-Reply-To: <20190919091720.GB10163@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0018.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::28)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919150011597
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f4fdcc0-fba1-42e4-de6a-08d73cf8eeeb
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5514; 
x-ms-traffictypediagnostic: DB8PR08MB5514:
x-microsoft-antispam-prvs: <DB8PR08MB5514CB4CDB9BCC75C48DCD8DC1890@DB8PR08MB5514.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(396003)(39850400004)(346002)(199004)(189003)(66066001)(81156014)(4326008)(66446008)(5660300002)(8676002)(7416002)(81166006)(6436002)(110136005)(7736002)(8936002)(54906003)(6512007)(6486002)(7406005)(14454004)(305945005)(478600001)(31686004)(186003)(66946007)(11346002)(2906002)(6506007)(386003)(25786009)(53546011)(256004)(26005)(66556008)(52116002)(229853002)(316002)(102836004)(446003)(6116002)(66476007)(64756008)(86362001)(36756003)(14444005)(6246003)(76176011)(71200400001)(3846002)(31696002)(99286004)(476003)(486006)(71190400001)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5514;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3XA/26qfkURGWtcGfLjbN6U0LQCaGGIUAllVGp/+tAyuM+aT0jemvLRv8BpYuB+I/g+mXFVDGTTd87zgQIKYzyzuaOcyj84dJzqKcvUMEkEGsRwGH0hH5q6xMNg00yRZfCc7kb1gRaW/cfaeobc3QqFsrKIvSJgT+n/rZkesVrkq1A+n2ix9JuSydzyqAXmMp4rfbParu0Rrk4DGt7sm16+6ef3DKeNqGhf7RKvT3sILyuyLRZ/iwrq52Nbi7nNMcIm6DmXlcGRDTXsDJUU4Hw0Cc4Lzl4fZED2NDxfoIqSmgI74alAqPuZmOsQxIpb69CNqEMCwHF/S5xccrFg5SSxMsCJoqpOMKv8SxaefGJ92e7t8CsgVm19ITwwSkF6yEndRKJ/KvfVeh7qIB7BRM6mY09/x2dTpX6XCXltFVF8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AE41068D7705242A9273BC1F6A32BCB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4fdcc0-fba1-42e4-de6a-08d73cf8eeeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 12:00:15.6587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFK76qC0FX+uxOQAqoGhgcdCMvUFDqsc7V4MNu1f18jEKyGjt9F+ZvDvwRoxtc840SoYBFSUY7G1bz6syIhTf61Eop+UHK7e6BLySLBKNls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5514
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.108
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
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
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDkuMjAxOSAxMjoxNywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTguMDkuMjAxOSB1bSAx
OToxMCBoYXQgRXJpYyBCbGFrZSBnZXNjaHJpZWJlbjoNCj4+IE9uIDkvMTgvMTkgODowMiBBTSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+PiArICovDQo+Pj4gKyNkZWZp
bmUgTUFLRV9FUlJQX1NBRkUoZXJycCkgXA0KPj4+ICtnX2F1dG8oRXJyb3JQcm9wYWdhdGlvblN0
cnVjdCkgKF9fYXV0b19lcnJwX3Byb3ApID0gey5lcnJwID0gKGVycnApfTsgXA0KPj4+ICtpZiAo
KGVycnApID09IE5VTEwgfHwgKihlcnJwKSA9PSBlcnJvcl9hYm9ydCB8fCAqKGVycnApID09IGVy
cm9yX2ZhdGFsKSB7IFwNCj4+PiArICAgIChlcnJwKSA9ICZfX2F1dG9fZXJycF9wcm9wLmxvY2Fs
X2VycjsgXA0KPj4+ICt9DQo+Pg0KPj4gTm90IHdyaXR0ZW4gdG8gdGFrZSBhIHRyYWlsaW5nIHNl
bWljb2xvbiBpbiB0aGUgY2FsbGVyLg0KPj4NCj4+IFlvdSBjb3VsZCBldmVuIHNldCBfX2F1dG9f
ZXJycF9wcm9wIHVuY29uZGl0aW9uYWxseSByYXRoZXIgdGhhbiB0cnlpbmcNCj4+IHRvIHJldXNl
IGluY29taW5nIGVycnAgKHRoZSBkaWZmZXJlbmNlIGJlaW5nIHRoYXQgZXJyb3JfcHJvcGFnYXRl
KCkgZ2V0cw0KPj4gY2FsbGVkIG1vcmUgZnJlcXVlbnRseSkuDQo+IA0KPiBJIHRoaW5rIHRoaXMg
ZGlmZmVyZW5jZSBpcyBhY3R1YWxseSBhIHByb2JsZW0uDQo+IA0KPiBXaGVuIGRlYnVnZ2luZyB0
aGluZ3MsIEkgaGF0ZSBlcnJvcl9wcm9wYWdhdGUoKS4gSXQgbWVhbnMgdGhhdCB0aGUgRXJyb3IN
Cj4gKHNwZWNpZmljYWxseSBpdHMgZmllbGRzIHNyYy9mdW5jL2xpbmUpIHBvaW50cyB0byB0aGUg
b3V0ZXJtb3N0DQo+IGVycm9yX3Byb3BhZ2F0ZSgpIHJhdGhlciB0aGFuIHRoZSBwbGFjZSB3aGVy
ZSB0aGUgZXJyb3IgcmVhbGx5IGhhcHBlbmVkLg0KPiBJdCBhbHNvIG1ha2VzIGVycm9yX2Fib3J0
IGNvbXBsZXRlbHkgdXNlbGVzcyBiZWNhdXNlIGF0IHRoZSBwb2ludCB3aGVyZQ0KPiB0aGUgcHJv
Y2VzcyBnZXRzIGFib3J0ZWQsIHRoZSBpbnRlcmVzdGluZyBpbmZvcm1hdGlvbiBpcyBhbHJlYWR5
IGxvc3QuDQo+IA0KPiBTbyBJJ2QgcmVhbGx5IGxpa2UgdG8gcmVzdHJpY3QgdGhlIHVzZSBvZiBl
cnJvcl9wcm9wYWdhdGUoKSB0byBwbGFjZXMNCj4gd2hlcmUgaXQncyBhYnNvbHV0ZWx5IG5lY2Vz
c2FyeS4gVW5sZXNzLCBvZiBjb3Vyc2UsIHlvdSBjYW4gZml4IHRoZXNlDQo+IHByYWN0aWNhbCBw
cm9ibGVtcyB0aGF0IGVycm9yX3Byb3BhZ2F0ZSgpIGNhdXNlcyBmb3IgZGVidWdnaW5nLg0KPiAN
Cj4gSW4gZmFjdCwgaW4gdGhlIGNvbnRleHQgb2YgR3JlZydzIHNlcmllcywgSSB0aGluayB3ZSBy
ZWFsbHkgb25seSBuZWVkIHRvDQo+IHN1cHBvcnQgaGludHMgZm9yIGVycm9yX2ZhdGFsLCB3aGlj
aCBhcmUgY2FzZXMgdGhhdCB1c2VycyBhcmUgc3VwcG9zZWQNCj4gdG8gc2VlLiBXZSBzaG91bGQg
ZXhjbHVkZSBlcnJvcl9hYm9ydCBpbiBNQUtFX0VSUlBfU0FGRSgpIGJlY2F1c2UgdGhlc2UNCj4g
YXJlIHRoaW5ncyB0aGF0IGFyZSBuZXZlciBzdXBwb3NlZCB0byBoYXBwZW4uIEEgZ29vZCBzdGFj
ayB0cmFjZSBpcyBtb3JlDQo+IGltcG9ydGFudCB0aGVyZSB0aGFuIGFkZGluZyBhIGhpbnQgdG8g
dGhlIG1lc3NhZ2UuDQo+IA0KDQpJbnRlcmVzdGluZywgdGhhdCB0byBoYW5kbGUgZXJyb3JfYXBw
ZW5kX2hpbnQgcHJvYmxlbSwgd2UgZG9uJ3QgbmVlZCB0bw0KY3JlYXRlIGxvY2FsX2VyciBpbiBj
YXNlIG9mIGVycnA9PU5VTEwgZWl0aGVyLi4NCg0KU28sIHBvc3NpYmx5LCB3ZSBuZWVkIHRoZSBm
b2xsb3dpbmcgc3RlcHM6DQoNCjEuIGltcGxlbWVudCBNQUtFX0VSUlBfU0FGRV9GT1JfSElOVCAo
d2hpY2ggb25seSBsZWF2ZSAiKihlcnJwKSA9PSBlcnJvcl9mYXRhbCIgaW4gdGhlIGlmIGNvbmRp
dGlvbg0KMi4gcmViYXNlIEdyZWcncyBzZXJpZXMgb24gaXQsIHRvIGZpeCBoaW50cyBmb3IgZmF0
YWwgZXJyb3JzDQozLiBpbXBsZW1lbnQgTUFLRV9FUlJQX1NBRkVfRk9SX0RFUkVGRVJFTkNFICh3
aGljaCBvbmx5IGxlYXZlICIoZXJycCkgPT0gTlVMTCIgaW4gdGhlIGlmIGNvbmRpdGlvbg0KNC4g
Y29udmVydCBhbGwgKGFsbW9zdCBhbGwpIGxvY2FsX2VyciB1c2FnZSB0byB1c2UgTUFLRV9FUlJQ
X1NBRkVfRk9SX0RFUkVGRVJFTkNFLCB3aGljaCB3aWxsDQogICAgZml4IHByb2JsZW0gd2l0aCBl
cnJvcl9hYm9ydCAoYW5kIGFsc28gZHJvcCBhIGxvdCBvZiBjYWxscyBvZiBlcnJvcl9wcm9wYWdh
dGUpDQo1LiBtZXJlbHkgY29udmVydCAidm9pZCBmdW5jKC4uLCBlcnJwKSIgdG8gImludCBmdW5j
KC4uLCBlcnJwKSIgYW5kIGRyb3AgTUFLRV9FUlJQX1NBRkVfRk9SX0RFUkVGRVJFTkNFKCkNCiAg
ICBtYWdpYywgdG9nZXRoZXIgd2l0aCBkZXJlZmVyZW5jaW5nLg0KDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==

