Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2651C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D80B2084E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="auPqbB7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D80B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9eg8-0004tB-Mq
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 19:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasper.lowell@bt.com>) id 1j9efP-0004PO-J4
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasper.lowell@bt.com>) id 1j9efO-000092-9G
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:47:11 -0500
Received: from smtpe1.intersmtp.com ([213.121.35.73]:59208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasper.lowell@bt.com>)
 id 1j9efN-0008T7-MD
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:47:10 -0500
Received: from tpw09926dag08f.domain1.systemhost.net (10.9.202.39) by
 BWP09926078.bt.com (10.36.82.109) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Thu, 5 Mar
 2020 00:47:06 +0000
Received: from tpw09926dag04f.domain1.systemhost.net (10.9.202.23) by
 tpw09926dag08f.domain1.systemhost.net (10.9.202.39) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Thu, 5 Mar 2020 00:47:05 +0000
Received: from bwp09926077.bt.com (10.36.82.108) by
 tpw09926dag04f.domain1.systemhost.net (10.9.202.23) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Thu, 5 Mar 2020 00:47:05
 +0000
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (104.47.20.51) by
 smtpe1.intersmtp.com (10.36.82.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1713.5; Thu, 5 Mar 2020 00:47:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckubQT346+N/rKBP4NOmySzFX/BYQtjU4Ov3fV28benbDBddzqON6gADQ09bH/27MCHGH3nRvu80zT5NuCC2gHZ8JEcMgDo6ttXpUlWn3uKvL8ylHqETDmIvjZyp5bUcvjOjiLEJfpNqYek0vCPDArPqZ7Md//TJqjWevpeGfcsZvYP2fgMPZD4JZcdIJ8lR9MkY7s3NYyOHyHHEnxgiV3sNBNlXqohQoowAQp/fucdi6xIm8GHfIpxb2OE9bOGaF+CJ/4MMXfbxFpnYtwM7CzVPDqohX4iYtzotc2z4+Jom5vpMZOhz1/cDNsdwNdq6SeBbcwVc8qkBhixpQjArfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cc7XoJ9IW5N9SdVcw/5/q/+nrUKp5cbF29i+hiYr6Qc=;
 b=KidEJL6JUfotdLV1YwqRXnyDvKiqhnD9rzecEPFymlXMg1GfQMoIi/y5xYFmTTJNjeXEbnfZ3NAfyncG8uHad25sZL11bNUQ71h/9yOQ1POfuazpgEO3orNTKqvXRh2G18cXi5hrJSSwpdCcFYlcY0GrYFHgL0CLBZ1rzJxmJgRhMMkopOTPHe0qMNeVgOl8DveoOlxAR2oERdDIKgHpeMMEn1SkgTxsmZPLDxPaurBpzq9COMtoj2dq6HkWgUQSCHNsFOgukuDJslVtNDFSLhiGDrZA3yqabyGTpBIUcozq8pALQtsWgXNhV7oSsmFMivVUoa7XcX3ztnMp/N4xNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cc7XoJ9IW5N9SdVcw/5/q/+nrUKp5cbF29i+hiYr6Qc=;
 b=auPqbB7b57S4T2zvOwUWJu6IuTdXUIdCq7Ul6hWW9DbCR3v+8KPVKpEq8desG0HpEDyE71ZjNKgj87pR2+a65jNiMi19CUvGFpG2L7VKrlSz5OO8Xe3gY6n9FsA9ZftuaSLfnP5WC+WXPQ+6m5XedwxsqGzsjBCkHdSkXEIcYu0=
Received: from LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM (20.176.154.209) by
 LO2P123MB2174.GBRP123.PROD.OUTLOOK.COM (20.176.158.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Thu, 5 Mar 2020 00:47:05 +0000
Received: from LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM
 ([fe80::312f:184d:74b1:28c5]) by LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM
 ([fe80::312f:184d:74b1:28c5%4]) with mapi id 15.20.2793.013; Thu, 5 Mar 2020
 00:47:05 +0000
From: <jasper.lowell@bt.com>
To: <balaton@eik.bme.hu>, <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
Thread-Topic: [PATCH] hw/ide: Remove status register read side effect
Thread-Index: AQHV6IMztk0nS91QXUSAhbuFxp1TiagnnJkAgAADjoCAAAXGgIAAvUiAgACESgCAAmZZAIAAvBaAgADuooCABx1uAIADvlaAgAEsV4CAAD2JgA==
Date: Thu, 5 Mar 2020 00:47:05 +0000
Message-ID: <a3eda55a557ea121f7859c3457e64fa92d85de55.camel@bt.com>
References: <20200221065015.337915-1-jasper.lowell@bt.com>
 <f432a118-f6be-d6ff-fe37-35b6244f3b97@ilande.co.uk>
 <alpine.LMD.2.03.2002222042370.1577@eik.bme.hu>
 <alpine.LMD.2.03.2002222101580.1577@eik.bme.hu>
 <5f336bc8838b5bfebfcc5829a3fae0a34a2ebac0.camel@bt.com>
 <alpine.BSF.2.22.395.2002231522530.69746@zero.eik.bme.hu>
 <5ca992b3a358610c897d923009fe9f7a8febc17f.camel@bt.com>
 <alpine.BSF.2.22.395.2002251515290.22173@zero.eik.bme.hu>
 <2e972e94627a39cf45504ed244828d065d743910.camel@bt.com>
 <alpine.BSF.2.22.395.2003011847220.28669@zero.eik.bme.hu>
 <06be591e667c6b72c78ae3a33e3092ab323fdb8b.camel@bt.com>
 <614b7a97-84c2-1861-75d3-51921ae1e4fa@ilande.co.uk>
In-Reply-To: <614b7a97-84c2-1861-75d3-51921ae1e4fa@ilande.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jasper.lowell@bt.com; 
x-originating-ip: [61.68.11.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2050a92d-aef6-4d98-3ccf-08d7c09eb9db
x-ms-traffictypediagnostic: LO2P123MB2174:
x-microsoft-antispam-prvs: <LO2P123MB21745F429853CA757CEAAEFE83E20@LO2P123MB2174.GBRP123.PROD.OUTLOOK.COM>
x-antispam-2: 1
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(199004)(189003)(2906002)(76116006)(66946007)(6486002)(2616005)(91956017)(36756003)(53546011)(186003)(6506007)(81166006)(478600001)(6512007)(4326008)(316002)(86362001)(8936002)(5660300002)(71200400001)(81156014)(66446008)(26005)(64756008)(54906003)(110136005)(8676002)(66476007)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:LO2P123MB2174;
 H:LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bt.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K+8ysIYQLIVnQPNKPOP4SmQr5rln8GREqfDZyz9C3Cpy+5G2iswViU6qKPVJB/kLf4gh5fA7rhwiyHgCT6Ne1WVRy0Hq07PnraPVigHuSrLIG/Fyr5rAvgryMfCiMX5FJLqECxr5RytfHbiOve+NSduPDDJ1ufggZOG+eEXbWfFGQFWd2zoPd5VmTaoyKES2obPzbBEh6UN98nHzUXTqC2qbM7Gbvqfgk5BVkvMPmF8S0VEZVfTBe3GftNWU/KXiKxZjBdw3uAT7e+OaEnrCLYHRsakXZxrrmNpUMiRSVCO47ZvmoxKoPoYd/j8TRUzNbD57a+J64fbIxQicsCW5TlcsiNbXOFO5c3L1KzKJ+K/3W5TbcA1RDFjhICzj86wAeKse6yogWNc7msAEoFCov37rYyOxzuf+XCAPArgaIMKufBmcPa4fm3L6gq/Ug/VV
x-ms-exchange-antispam-messagedata: UpOVI1nEt5WjaackMV2MKRLEOH1v/dHXJ+bbMgG3rHhzsCU6fkjV/olIq8zMbJHD2fVnw8m2McVOlAbNibVatJGOJL1vMJ6BhIufJ47uazMEkmxFdkR5nhHtiT7n1BprQ5BwlNL7l6F694IKtF0eNA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECC77D8F0E547846930A84C9B7856E6A@GBRP123.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2050a92d-aef6-4d98-3ccf-08d7c09eb9db
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 00:47:05.0813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R0pDjCxItIw8AZ2iLwmxH4e/9roeTee2srHWdD2Q3HxXE6IBKYb3NZh5XUHyRWQIHhh3lb5U3+MPlXHBUZPWLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB2174
X-OriginatorOrg: bt.com
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.73
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBZZXMsIHRoYXQncyBjb3JyZWN0LiBIb3dldmVyIEknbSBxdWl0ZSBjb25maWRlbnQgZnJvbSBi
b290aW5nIG90aGVyDQo+IG5vbi1Tb2xhcmlzIE9Tcw0KPiB1bmRlciBxZW11LXN5c3RlbS1zcGFy
YzY0IHRoYXQgUENJIG5hdGl2ZSBtb2RlIGlzIGJlaW5nIHVzZWQsDQo+IHBhcnRpY3VsYXJseSBh
cyBpdCBpcw0KPiBwb3NzaWJsZSB0byBzZWUgdGhlIHJlbGF0ZWQgUENJIHNhYnJlIElSUSByb3V0
aW5nIGNvbmZpZ3VyYXRpb24NCj4gY2hhbmdlcy4NCg0KQ29uc2lkZXJpbmcgdGhhdCBTb2xhcmlz
IDEwIGlzIGFjY2Vzc2luZyBDRlIgYW5kIEFSVFRJTTIzIEkgZG9uJ3QgdGhpbmsNCnRoZXJlIGlz
IGFueSBkb3VidCB0aGF0IGl0IGlzIHVzaW5nIHRoZSBjaGlwIGluIFBDSSBuYXRpdmUgbW9kZS4g
SQ0KZG9uJ3QgdGhpbmsgU29sYXJpcyAxMCBldmVuIGhhcyBzdXBwb3J0IGZvciBsZWdhY3kgbW9k
ZS4NCg0KVGhhbmtzLA0KSmFzcGVyIExvd2VsbC4NCg0KT24gV2VkLCAyMDIwLTAzLTA0IGF0IDIx
OjA3ICswMDAwLCBNYXJrIENhdmUtQXlsYW5kIHdyb3RlOg0KPiBPbiAwNC8wMy8yMDIwIDAzOjEx
LCBqYXNwZXIubG93ZWxsQGJ0LmNvbSB3cm90ZToNCj4gDQo+ID4gPiBjbWQ2NDZfdXBkYXRlX2ly
cSgpIG9ubHkgc2VlbXMgdG8gcmFpc2UgUENJIGludGVycnVwdCwgc2hvdWxkIGl0DQo+ID4gPiBh
bHNvDQo+ID4gPiBoYXZlIA0KPiA+ID4gYW4gb3B0aW9uIHRvIHVzZSBJTlQgMTQgYW5kIDE1IGlu
IGxlZ2FjeSBtb2RlIHNpbWlsYXIgdG8gd2hhdCBteQ0KPiA+ID4gcGF0Y2ggDQo+ID4gPiBkb2Vz
IGZvciB2aWEtaWRlPw0KPiA+IA0KPiA+IExvb2tpbmcgdGhyb3VnaCAvcWVtdS9ody9pZGUvY21k
NjQ2LmMgaXQgZG9lc24ndCBsb29rIGxpa2UgUUVNVSBoYXMNCj4gPiBzdXBwb3J0IGZvciBsZWdh
Y3kgbW9kZS4gQXQgdGhlIHZlcnkgbGVhc3QsIGl0IGxvb2tzIGxpa2Ugd2UNCj4gPiBkZWZhdWx0
IHRvDQo+ID4gUENJIG5hdGl2ZSBtb2RlOg0KPiA+IA0KPiA+IHN0YXRpYyB2b2lkIHBjaV9jbWQ2
NDZfaWRlX3JlYWxpemUoUENJRGV2aWNlICpkZXYsIEVycm9yICoqZXJycCkNCj4gPiAJLi4uDQo+
ID4gCXBjaV9jb25mW1BDSV9DTEFTU19QUk9HXSA9IDB4OGY7DQo+ID4gCS4uLg0KPiA+IA0KPiA+
IFRvIGFkZCBzdXBwb3J0IGZvciBsZWdhY3kgbW9kZSBpdCB3b3VsZCByZXF1aXJlIGNoYW5naW5n
DQo+ID4gY21kNjQ2X3VwZGF0ZV9pcnEoKSBhbmQgbWF5YmUgY21kNjQ2X3NldF9pcnEoKSBzbyB0
aGF0IGludGVycnVwdHMNCj4gPiBhcmUNCj4gPiBjb25kaXRpb25hbGx5IHJhaXNlZCBvbiBJUlEx
NCBhbmQvb3IgSVJRMTUgd2hlbiB0aGUgcG9ydHMgYXJlIGluDQo+ID4gbGVnYWN5DQo+ID4gbW9k
ZS4NCj4gDQo+IFllcywgdGhhdCdzIGNvcnJlY3QuIEhvd2V2ZXIgSSdtIHF1aXRlIGNvbmZpZGVu
dCBmcm9tIGJvb3Rpbmcgb3RoZXINCj4gbm9uLVNvbGFyaXMgT1NzDQo+IHVuZGVyIHFlbXUtc3lz
dGVtLXNwYXJjNjQgdGhhdCBQQ0kgbmF0aXZlIG1vZGUgaXMgYmVpbmcgdXNlZCwNCj4gcGFydGlj
dWxhcmx5IGFzIGl0IGlzDQo+IHBvc3NpYmxlIHRvIHNlZSB0aGUgcmVsYXRlZCBQQ0kgc2FicmUg
SVJRIHJvdXRpbmcgY29uZmlndXJhdGlvbg0KPiBjaGFuZ2VzLg0KPiANCj4gDQo+IEFUQiwNCj4g
DQo+IE1hcmsuDQo=

