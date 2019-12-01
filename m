Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDDCC432C3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 22:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFDA12071F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 22:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mjberubeossiaco.onmicrosoft.com header.i=@mjberubeossiaco.onmicrosoft.com header.b="4AKixB3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDA12071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossiaco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibY3j-0003uy-No
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 17:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Jean-Hugues.Deschenes@ossiaco.com>)
 id 1ibY2Z-0002wx-Tu
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 17:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Jean-Hugues.Deschenes@ossiaco.com>)
 id 1ibY2X-0006ww-Tp
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 17:50:06 -0500
Received: from mail-eopbgr660061.outbound.protection.outlook.com
 ([40.107.66.61]:6464 helo=CAN01-QB1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Jean-Hugues.Deschenes@ossiaco.com>)
 id 1ibY2T-0006uu-Q5; Sun, 01 Dec 2019 17:50:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/l7TtMJbhuHHYP0s0Nepr6zRC0Qu+dniD5ZfuC/NIQdVHMefTjOUHRa26TQGc0ElEyfxMyW6N2EphUBvYea+/NmGdF0Fdpi5+4eaedSmIkwYtsT4nKIkfRhI9UucHEbz8JNW0qmKq2U4Ew0brJuq6LTbIY8kB0uQP05K4NBOdv345JndqwrGcFEwuyWUzhlWMYCWDuqU1qM1RqCOtvzpqr3cV5B7+H/37Qq/zCc1t/T6QinYoZhNg0vxvDrlzI6YioHrfqe0run+3HaLJ/4mB4pzMv3/c+j8T1ZAWNEGi5yebc0mIu1UDRUlsqNOOCqxDSh660txR3wxnJOspnWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VYDqsnhCgKEaqDf9ISnbGSavHMQUlTpY/9rQvAtkNA=;
 b=ekvKAe3kz6djzPymHlku9pdwDS3OEjD0ENaolncXYj+tzpcj3qoDudGB5OFWO2NFOsmvEb5k01zU74VC38i/TegDOT7uG4VziOy21iieWcXoGunC2r6/abGEEPQzoTzUO85AfvxApZK3iKfgigi3yIHT3Ufr3AsxE+wszsuJGEkVnoO1kbpBC2WBfJQfBzgTRjGp5CIqCYPWPu+d8usWgpnMZ+tF8kmAAR6N/fIx0iZAQZFVkAIdJZZ7oUmIe3AEjdP3JFBZxVSqmIPpCrkiQwNtCww8wmBjKR1c4HEaFdKY1T9Xu8b9GA0BxGmneGAgsMYf4vpv1COvMzcgBTaBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ossiaco.com; dmarc=pass action=none header.from=ossiaco.com;
 dkim=pass header.d=ossiaco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mjberubeossiaco.onmicrosoft.com;
 s=selector2-mjberubeossiaco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VYDqsnhCgKEaqDf9ISnbGSavHMQUlTpY/9rQvAtkNA=;
 b=4AKixB3nnLUEqAHEcbHVPd9H+4/Pvas6HzaJHky1fQNucr1ZNoNe/YAIHQ8K6bdW47TozBdmK2T4SlTPzNqi850NkPwa/jfDQoncS6XrfJ7k7GP2k7Q0D/L51Ry/2nyVf2km67JeBvT/Z6jp2v8EYpT4YvahROqO2SHhUDtTT8Y=
Received: from YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM (52.132.79.154) by
 YQXPR0101MB1029.CANPRD01.PROD.OUTLOOK.COM (52.132.77.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Sun, 1 Dec 2019 22:49:59 +0000
Received: from YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c24:2ae:14fe:82cd]) by YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c24:2ae:14fe:82cd%6]) with mapi id 15.20.2495.014; Sun, 1 Dec 2019
 22:49:59 +0000
From: =?utf-8?B?SmVhbi1IdWd1ZXMgRGVzY2jDqm5lcw==?=
 <Jean-Hugues.Deschenes@ossiaco.com>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: RE: [PATCH] target/arm: Allow loading elf from aliased ROM regions
Thread-Topic: [PATCH] target/arm: Allow loading elf from aliased ROM regions
Thread-Index: AQHVo42dAgdlcFdTL0aHTFeU06w+BKelwF+AgAAmowCAAAP0QA==
Date: Sun, 1 Dec 2019 22:49:58 +0000
Message-ID: <YQXPR0101MB1142ACF7B4629FB56926BDF1A0400@YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM>
References: <20191125124055.19286-1-jean-hugues.deschenes@ossiaco.com>
 <3e2857fd-aa5e-acc5-edd6-359715a636a6@linaro.org>
 <CAFEAcA90u0GsZZTX6EB0AzrS+A-ErTEGE2XVeJH8wvSmfF80tQ@mail.gmail.com>
In-Reply-To: <CAFEAcA90u0GsZZTX6EB0AzrS+A-ErTEGE2XVeJH8wvSmfF80tQ@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jean-Hugues.Deschenes@ossiaco.com; 
x-originating-ip: [107.159.35.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88927b9e-f8f1-4f37-96d2-08d776b0cb36
x-ms-traffictypediagnostic: YQXPR0101MB1029:
x-microsoft-antispam-prvs: <YQXPR0101MB1029007ED1C8819BC5F47AA6A0400@YQXPR0101MB1029.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0238AEEDB0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39830400003)(346002)(366004)(396003)(376002)(189003)(199004)(7696005)(110136005)(256004)(54906003)(66066001)(9686003)(2906002)(229853002)(6246003)(55016002)(3846002)(6116002)(66946007)(66476007)(66556008)(64756008)(66446008)(76176011)(85202003)(76116006)(4326008)(86362001)(316002)(25786009)(33656002)(508600001)(99286004)(446003)(6436002)(8936002)(186003)(81166006)(305945005)(7736002)(85182001)(81156014)(11346002)(5660300002)(26005)(102836004)(52536014)(14454004)(71200400001)(6506007)(8676002)(71190400001)(74316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:YQXPR0101MB1029;
 H:YQXPR0101MB1142.CANPRD01.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: ossiaco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WOlwvLkBoxfD9QrurmXuiCaCSehRJ1uKwrPbkaxLD0EU1d4KbZCLkU3f12W71+xCk6M5YMQub68sgIXjYrdWK7LIIjgFTrvC5gcvESPSvt9EfD/hae1K7+jxl5kQi9PXjjM/4y8VyMNo3670VSzZUBQ5qMLrEanN95vJHy80Bjt55ctrYMP8z5NVKcisGrEnXkciUdTAzG04XttPCDvpEr6MDv3bqcEzbNFECTBXIEX5hQKi1AdZtFgbXHeKpEO4/107VMERimxvlEdEq7wehvZYpGMTaRAHqltdumNUZHwTDjm5AYoua7tCUr1dwrD4RQXgIzG7yGrtr2AnqFpp0FgCHzV89G2ST3hCg1rk4NCcm8b/ihgFkJVkLt4xnvBAMVX7KpMjjshxeUbGrBzcM8BrF7Vq+ANJfRFIZXY/PeA9PSFp1WXIEQiXW4vRMXJ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ossiaco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88927b9e-f8f1-4f37-96d2-08d776b0cb36
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2019 22:49:59.0259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7b948053-cc61-434b-af8e-9de586f466aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwChhXdcUhbPO0YidU346usjS0iSgz9RjS4d/ULCGmdNGHcw3ciTBKmATmijQ6CL6YZdIZLf76k6Gpit31bXB69ebhlGewcrTHI4ChOz6mIPHX3ioAvRcytF/3ny79Qr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB1029
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.66.61
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "martin.galvan@tallertechnologies.com" <martin.galvan@tallertechnologies.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBOby4gVGhpcyBpcyBhIHJlc2V0IG9yZGVyaW5nIHByb2JsZW0uIFRoZSBDUFUgcmVzZXQgaGFw
cGVucyBiZWZvcmUgdGhlIA0KPiAncm9tIGJsb2IgbG9hZGVyJyByZXNldCwgc28gYXQgdGhpcyBw
b2ludCB0aGUgcm9tIGRhdGEgKHVzdWFsbHkgYW4gRUxGIGZpbGUNCj4gc2VnbWVudCkgaGFzIG5v
dCBiZWVuIHdyaXR0ZW4gaW50byByYW0sIGFuZCBkb2luZyBhbiANCj4gYWRkcmVzc19zcGFjZV9y
ZWFkKCkgd2lsbCBqdXN0IHJlYWQgemVyb2VzLiBUaGlzIGlzIGFsc28gd2h5IHRoZSBhbGlhc2lu
Zw0KPiBpc3N1ZSBoYXBwZW5zIGF0IGFsbCAtLSB0aGUgcm9tIGJsb2IgaXMgYXQgYSBwYXJ0aWN1
bGFyIGFkZHJlc3MsIGJ1dCBpZiB0aGUNCj4gYWRkcmVzcyB3ZSB1c2UgaGVyZSB0byB0cnkgdG8g
cmVhZCB0aGUgZGF0YSBpcyBhbiBhbGlhc2VkIHZhcmlhbnQgb2YgaXQNCj4gdGhlbiByb21fcHRy
KCkgZG9lcyB0aGUgd3JvbmcgdGhpbmcuDQo+DQo+IE15IHByZWZlcmVuY2UgZm9yIGZpeGluZyB0
aGlzIHByb3Blcmx5IGlzOg0KPiAgKiBnZXQgRGFtaWVuJ3MgdGhyZWUtcGhhc2UtcmVzZXQgcGF0
Y2hzZXQgaW50byBtYXN0ZXINCj4gICogbWFrZSB0aGUgUk9NIGJsb2IgbG9hZGVyIHdyaXRlIGl0
cyBkYXRhIGludG8gcmFtDQo+ICAgIGluIHBoYXNlIDIgKCdob2xkJykNCj4gKiBtYWtlIHRoZSBh
cm0gQ1BVIHJlc2V0IHJlYWQgdGhlIGRhdGEgaW4gcGhhc2UgMyAoJ2V4aXQnKQ0KPg0KPiBUaGlz
IGxhc3QgbWF0Y2hlcyBiZXR0ZXIgd2hhdCB0aGUgaGFyZHdhcmUgZG9lcyAtLSB0aGUgTS1wcm9m
aWxlIENQVQ0KPiByZWFkcyB0aGUgdmVjdG9yIHRhYmxlIGluIHRoZSBmaXJzdCBjb3VwbGUgb2Yg
Y2xvY2sgY3ljbGVzIHdoZW4gaXQgKmxlYXZlcyoNCj4gcmVzZXQsIG5vdCB3aGlsZSB0aGUgQ1BV
IGlzIGJlaW5nICpoZWxkKiBpbiByZXNldC4gVGhpcyBraW5kIG9mIHRoaW5nIGlzDQo+IGFsd2F5
cyBhd2t3YXJkIHRvIG1vZGVsIGluIGFuIGVtdWxhdG9yLCBlc3BlY2lhbGx5IGlmIHlvdSB3ZXJl
IGhvcGluZw0KPiB0byBhbHNvIGhhbmRsZSBhbGxvd2luZyB0aGUgUEMgdG8gYmUgc2V0IGZyb20g
YW4gRUxGIGZpbGUgZW50cnlwb2ludCBvcg0KPiBieSB0aGUgdXNlciBpbiB0aGUgZ2Ric3R1YiBv
biBzdGFydHVwLi4uDQoNCk1ha2VzIHBlcmZlY3Qgc2Vuc2UuIEZlZWwgZnJlZSB0byBkcm9wIHRo
ZSBwYXRjaC4NCg0KVGhhbmtzLA0KDQpKaA0K

