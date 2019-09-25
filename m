Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D057C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55AC52054F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ryPm9ncJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AC52054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1w9-00010F-23
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD1ee-0001PG-8e
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD1ed-0008Sl-2u
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:24:04 -0400
Received: from mail-eopbgr10095.outbound.protection.outlook.com
 ([40.107.1.95]:47430 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD1ec-0008SS-RJ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:24:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lr+hbwFJbErP5R7HfkIOLv/Bu34GSI0/8OHo8GJf1uyr+aisG0C0c0ZEPsGeDbJ3IqPEu7V8s0LAwEr5r5NGGYVQTdezoQHZu1LVxpjs2b4Fy5Eb77vrvrLoOdXMo2z86BlVlCoVRzafeFK/2mN5wLiqkWUegkZLGy8URNJi70xb8POn+zql42SfTHoParPYQKUhGzVw9bl5CZoTK4+YVOrZt7AGlJCO4qqQBQfZnQcbj9YSL8uvkGC/X7WhDMRx4x3aIREJTZffi2zsxebxZSrx8VjxQbtxCLAZxcdJtAyawCHtUuRail7gCF5s96kvL3RXpBjvL77KWA5mXVTFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbmuGVS3U6k9Br2TvivptcqYdA3Uojt0pLl2MRbKNrY=;
 b=erGm14twn2KIQT63bfTaHrFbaYOyUyoFMSUVk8HDM9oY6sEFuhMhrPLy47V+j1bZwPJO7UYidM66BLu7ZJBadJCvO/zk2z/4QeieScaKfY2GxdcrKSgLcLjtUGkcR2g6addD4O5vK2IabRCP3FD7Wlwk0+ehxfxSgk5I6sWFWSMXeEdV2m7yo8GVgQZNcBr/cAoG7x1xh6/DNT3Mmg/iIgBUuwbAFz5tipy1LRcSRMLvWudO2bKjPQy87CS1MEyY8grFGPYSj1HO4JbKoT4cuRWeM9eV99sowSrfqFSklUsxsSC5BJPGfuNeyazYCZbXOANA6Ksb+/XhQHYZFmDMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbmuGVS3U6k9Br2TvivptcqYdA3Uojt0pLl2MRbKNrY=;
 b=ryPm9ncJdOtTVBMOmmSb7cYHXAOq+EUCbeGQMVj725beP/HpS17LSnLHpoGmCC+Z/1OmQiMUjuEVRhgyKbdo26M7epGedIctugOHTR6wKmdd84CaJW4qR7UHhhPJqLz9Sqcu2+zgRb67yzvJcC6sPTQmIMMIgUo2Fm6EG8q0Mvc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5004.eurprd08.prod.outlook.com (10.255.19.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 07:24:00 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 07:24:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 02/25] hw/core/loader-fit: fix freeing errp in
 fit_load_fdt
Thread-Topic: [PATCH v3 02/25] hw/core/loader-fit: fix freeing errp in
 fit_load_fdt
Thread-Index: AQHVcxQDdiAaxl5+Z0elAgOGbrmRYac7SgeAgAC0NQA=
Date: Wed, 25 Sep 2019 07:24:00 +0000
Message-ID: <5a8a60aa-d394-19eb-a719-9a4068d48a7c@virtuozzo.com>
References: <20190924200902.4703-1-vsementsov@virtuozzo.com>
 <20190924200902.4703-3-vsementsov@virtuozzo.com>
 <1f007fe0-d6bb-db19-835f-9cb4043f9b66@redhat.com>
In-Reply-To: <1f007fe0-d6bb-db19-835f-9cb4043f9b66@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0205.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::29) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925102358281
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d128b6ed-5d60-4ceb-38b3-08d7418955be
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5004; 
x-ms-traffictypediagnostic: DB8PR08MB5004:
x-microsoft-antispam-prvs: <DB8PR08MB50048B72A568FB57A5FB7077C1870@DB8PR08MB5004.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(366004)(39850400004)(376002)(136003)(189003)(199004)(14454004)(81156014)(386003)(305945005)(81166006)(3846002)(6116002)(8676002)(2906002)(6506007)(99286004)(76176011)(53546011)(186003)(26005)(102836004)(6246003)(71190400001)(71200400001)(7736002)(256004)(4326008)(25786009)(6512007)(8936002)(66066001)(446003)(31686004)(476003)(2616005)(66446008)(486006)(11346002)(64756008)(316002)(54906003)(6436002)(229853002)(110136005)(66476007)(66946007)(66556008)(6486002)(5660300002)(2501003)(31696002)(478600001)(52116002)(36756003)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5004;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eLgmtstZ1UZ9y6RS2W1bpybbaubpJjNYf019eCxapYnpHlX6zDG+sEljkq7h/m7eYOPOOZ2FPoXUhNXjYzkCUJTkkbYixUVhyYPrO/HoqfBJFIof45gsxXbo/q+h3i1IRxDGjc6Qeo9ZP/mET5Ly0MMQr+4ZG67mixEPIdJ4Fhr7uAg8DrZYsJn3q2kqJQoJ398An9yQsFC1/PLZohwuGRCe0ONOWsYESz+vrb6HR5bi9k5iSdf8Mchyhw5NvNCB2A7x7cpj0TG956jJRA+9PNJDPcUfuMYfxv5ic+JPbHpIsz9D53ks/M3jxy+ejNyEZANzzgK5aCeeIx7xELh7KWp+Mcq5mEhnNr0sNGkBa8MbBD2L7TmIz+y6BIDn+6mZWh7HlzAdEFWRlPInNqBFPlwf4+k5nqTVsgxle77Ggcc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A47A8662D9FD9244ADC8132865B957D9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d128b6ed-5d60-4ceb-38b3-08d7418955be
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 07:24:00.2850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ajNTQrGGlIYkGANu317Uh4pImeCs8YuK9USGd2dtZa2JYfEjZTLvyar2/om24fQgJUbbsq72eRfxih8sVjBfm0NUYb9s5M0JSUL9iyAqYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5004
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.95
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Paul Burton <pburton@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjQuMDkuMjAxOSAyMzozOCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS8yNC8xOSAzOjA4IFBN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gZml0X2xvYWRfZmR0IGZv
cmdldCB0byB6ZXJvIGVycnAuIEZpeCBpdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1p
ciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiBSZXZp
ZXdlZC1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+ICAgaHcv
Y29yZS9sb2FkZXItZml0LmMgfCAxICsNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2NvcmUvbG9hZGVyLWZpdC5jIGIvaHcvY29yZS9s
b2FkZXItZml0LmMNCj4+IGluZGV4IDk1M2IxNmJjODIuLjExZTRmYWQ1OTUgMTAwNjQ0DQo+PiAt
LS0gYS9ody9jb3JlL2xvYWRlci1maXQuYw0KPj4gKysrIGIvaHcvY29yZS9sb2FkZXItZml0LmMN
Cj4+IEBAIC0yMDEsNiArMjAxLDcgQEAgc3RhdGljIGludCBmaXRfbG9hZF9mZHQoY29uc3Qgc3Ry
dWN0IGZpdF9sb2FkZXIgKmxkciwgY29uc3Qgdm9pZCAqaXRiLA0KPj4gICAgICAgaWYgKGVyciA9
PSAtRU5PRU5UKSB7DQo+PiAgICAgICAgICAgbG9hZF9hZGRyID0gUk9VTkRfVVAoa2VybmVsX2Vu
ZCwgNjQgKiBLaUIpICsgKDEwICogTWlCKTsNCj4+ICAgICAgICAgICBlcnJvcl9mcmVlKCplcnJw
KTsNCj4+ICsgICAgICAgICplcnJwID0gTlVMTDsNCj4gDQo+IEFjdHVhbGx5LCBsZXQncyBkcm9w
IG15IFItYiAtIEkgdGhpbmsgd2UgaGF2ZSBhIGJpZ2dlciBidWcgaGVyZS4gIFdlIGFyZQ0KPiBi
bGluZGx5IGRlcmVmZXJlbmNpbmcgKmVycnAgZXZlbiBpZiB0aGUgY2FsbGVyIHBhc3NlZCBpbiBO
VUxMLiAgVGhlDQo+IGNvcnJlY3Qgd2F5IHRvIHdyaXRlIHRoaXMgZnVuY3Rpb24gcmVxdWlyZXMg
ZWl0aGVyIHRoZSB1c2Ugb2YgbG9jYWxfZXJyDQo+IG9yIHRoZSBhZGRpdGlvbiBvZiBhdXRvLXBy
b3BhZ2F0aW9uLg0KPiANCj4gKEluIHYyLCB5b3Ugc3RpbGwgaGFkIHRoaXMgYnVnIC0geW91ciBh
ZGRpdGlvbiBvZiBlcnJvcl9mcmVlX2VycnAoZXJycCkNCj4gd291bGQgc3RpbGwgYmxpbmRseSBk
ZXJlZmVyZW5jZSAqZXJycCwgdW5sZXNzIHlvdSB0d2VhayB0aGUNCj4gaW1wbGVtZW50YXRpb24g
b2YgZXJyb3JfZnJlZV9lcnJwIHRvIHRvbGVyYXRlIGEgTlVMTCBwb2ludGVyIGlucHV0KQ0KPiAN
Cg0KT29wcywgeW91IGFyZSByaWdodCEgU3RpbGwsIEkgdGhpbmsgaW4gdGhpcyBjYXNlIHdlIGNh
bg0KDQppZiAoZXJycCkgew0KICAgZXJyb3JfZnJlZSgqZXJycCk7DQogICAqZXJycCA9IE5VTEw7
DQp9DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

