Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F385C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 02:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0845920787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 02:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="i4uH93Ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0845920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaVxz-0001jp-48
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 22:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jaVxQ-0001Ks-K9
 for qemu-devel@nongnu.org; Sun, 17 May 2020 22:56:48 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.74]:10398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jaVxO-0005Ur-8e
 for qemu-devel@nongnu.org; Sun, 17 May 2020 22:56:47 -0400
Received: from tpw09926dag08g.domain1.systemhost.net (10.9.202.43) by
 BWP09926079.bt.com (10.36.82.110) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Mon, 18
 May 2020 03:56:19 +0100
Received: from tpw09926dag05g.domain1.systemhost.net (10.9.202.28) by
 tpw09926dag08g.domain1.systemhost.net (10.9.202.43) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Mon, 18 May 2020 03:56:43 +0100
Received: from RDW083A010ED66.bt.com (10.187.98.36) by
 tpw09926dag05g.domain1.systemhost.net (10.9.202.28) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Mon, 18 May 2020 03:56:43
 +0100
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (104.47.20.56) by
 smtpe1.intersmtp.com (62.239.224.237) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 18 May 2020 03:55:11 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxkFeITjDByCW30NOORz5I2FRkOCQbSgMcP0pSaWHy+2yw9wmc8M/WOTTzHgH7be1RSKDQntRrgAY2wFMO8YHg0vTzAc16vx2HWLDMt1t41HOB2k4p0e2WfKn5i0xmbZ2D0MqwWpBXxe1oBkJ3sgDvbFHbG75Pn+Eb73XBGAzuuXTYOpaC1wTk7U2Q7f2CklX3U1/i0JjJE9M5byVeI1QreBIz0WVpZqNCdNRg/B0LCYFs06FZUCo+iAUHCYkUANs5ykxWS7dXMsvM8H7Kz3kq/tnnGlu6mZFXbCshAAm66bnlkV9LIR1PibGNCtFgOhw8FdBj8nwWYDyKmX/0JN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLBNr226hc3MUUb1qRhbUL8kVJqR3B6OnPAW9ldsLxk=;
 b=nL8g+LM8T3VczAIzZR2zMZ5T9LKvkft3+lRC6J9gtrQWVb91Sb10syz6HFiVhOU52P1XeHgiZYtJxUb1BKjg4rud+bHeuv1Lx/mAguAhnNFjon0BZBVMLZSz8b16f2bKwBX6NyEUf2nNN2PA19lxFvFQYGN7Q5fjKbgxJIzJe/NADIhKt+kAJRWdhSN1ed0VAQgAvQyKXk2kZCGrmwAd+Vcen7G8N9V9MsrHKpK+rHAjQEYocEkBgNkdVuo6KjvW2fmNITOmeHRRA8qY6F2xblv4wUijf5U4hVN8JWYniJivWPpwjHZUgorZ+PNCLNwkSQ8oh96fOVJJcueWUwoCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLBNr226hc3MUUb1qRhbUL8kVJqR3B6OnPAW9ldsLxk=;
 b=i4uH93CiIAaQlU/YSBx/qdvTWQ02JVUn3AMP04h+QEtF4cLMa54QmA63YucOgblE0h4ZJP3wpJs4c4TEYK0JQ75UAv3GeqA7fQXaP/vVEZS8wGHISoJ04gJvhGDG4E/D/Ag9tAODsnKmAijx4+6tq7tCvEC9rOIAdNy2IDb2dpU=
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:7b::18)
 by CWXP123MB2695.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Mon, 18 May
 2020 02:56:40 +0000
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f132:e811:f232:2bdf]) by CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f132:e811:f232:2bdf%7]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 02:56:40 +0000
From: <jasper.lowell@bt.com>
To: <atar4qemu@gmail.com>
Subject: Re: Emulating Solaris 10 on SPARC64 sun4u
Thread-Topic: Emulating Solaris 10 on SPARC64 sun4u
Thread-Index: AdXb7aKPCyPc5BgLRMag+zXZgy3FKQDThhmAEVAOwAAAASBWgAAYKG4AAA0xpYAACkUqgABNi1OAAA3dmwABXQ4+gAAJxqYAAB4B/4A=
Date: Mon, 18 May 2020 02:56:40 +0000
Message-ID: <be68b7ad559ec17c69439217c1378c23e30745c9.camel@bt.com>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <f0f00ecd-1989-9bc1-02e0-8a9b4819f051@ilande.co.uk>
 <f833edcfed7dd58a6bb27269de66acfed0e550eb.camel@bt.com>
 <CACXAS8D9CAo3oGKHdA0qvxs9g9rTJMdYKtJrhw7QqHA6jvtYYg@mail.gmail.com>
 <81bfbfd669c652657421f66a30d144d02d8fa79d.camel@bt.com>
 <CAEgYsbHejSdBiL0o-AOLURhcMw+BHyFeZskmAV4w1cN6V46N3A@mail.gmail.com>
 <CACXAS8D5YLs2BMHBR39h_XEsMZ4n7XpDE+FSdKBLDgxFGpwzbQ@mail.gmail.com>
 <3926d33de12c70af150c9e9e2d75bda69e971546.camel@bt.com>
 <34b47695-c61e-360a-ffc4-6171e25a7c0a@ilande.co.uk>
 <feaccbcfcd5a36d1024e91e40bef6eb6f359a628.camel@bt.com>
 <CACXAS8DqO8CSkkSbD5aivGxL8xVB-FS5Bm0TL3ad+OLsvzcuxg@mail.gmail.com>
In-Reply-To: <CACXAS8DqO8CSkkSbD5aivGxL8xVB-FS5Bm0TL3ad+OLsvzcuxg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=bt.com;
x-originating-ip: [217.138.204.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f827b5e7-6601-4d08-19a5-08d7fad7170a
x-ms-traffictypediagnostic: CWXP123MB2695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWXP123MB2695E315AC37AC1C4DC7E69A83B80@CWXP123MB2695.GBRP123.PROD.OUTLOOK.COM>
x-antispam-2: 1
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dRqLSrGaahDErzNZIjfyy+mydg2YlPCZ6hK5Tv1LXTl1M3Qws5WNDVxchwAbgYB6wS5xgXzhQJt1aNqSz4TabHM+lWNMgB7tXmQecEFeNjDd9LnHJYbA/mqEwhGOKv7ms/euf8nq0Cb/HbOFkH4+3GViUv3wuyVxTejkmIlFTLkt4RbQoTDpIuck2TlUvUk0tULjrEwWKMYmVoxPiFYY/HcxSnquFRFgPgaLz+d096exC4l5QAd8Mhq3SKaQdt5HJ61NiRPFuBeDyF8WlKMr4j30wKJDbPI3dpvRwoB0pvGa+PHUGtiOnJsSyLohcR1Htq2t0KIH6A2nyTZHbEYJgQGUlY88ahQthwbmU1Vr1yLn1TZ52GUEQe0jZolD3gBdkXd9JTBS/ukK4mtmYCqTZgljpKEg3p2bqMSxLxifmEFQ7EdSYLegEfjtSJFW/1TMyAxsVrb8wYbh67+xH6zIsb3MqpkOqZKJmTUR9cUuHpN7a5RumzVPvu6Y2i2y9bQg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(26005)(6512007)(36756003)(8676002)(86362001)(66946007)(76116006)(91956017)(66476007)(64756008)(66556008)(8936002)(53546011)(5660300002)(316002)(478600001)(66446008)(6486002)(6506007)(2616005)(54906003)(186003)(2906002)(4326008)(71200400001)(6916009)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: e+0y46aVa/rKbU6yZe5KEy0OTbpz9hd+mITFy5nMsNgetiFKxAPuPEnJROQvwuUnI+0Ww5xkFtaBypTxtknfvuW/idTIWWDWoxqDjSeUABVCMD5gaPha5NBHhhS9qMSc5EEqUdMex3Vaj6GjXLfmSRL/O9AeeCQsh6ti561YUXeYjE21AAEsckwpelOSIJANjoMK3cgUFy9BoWKC98lRc9ZMdBZPiQmSzY3pJSUIUGSQrFwcWUBubjH1kJ9jf9TsTwIcKB+1EwmdYMSiX/yl4VClqQPwz92Fu7V8zlqQNSpw5EjtLRixcrF399gjo+XrJO6zWP4DKclZMiLyvq4VxYAqU6nGuJ8ZpYyHePp8OC53821ItixyVHVzoVGZeAhne9BBMbrHcXYm234efW1hGDfGo19pn19v6aRCNsLf9lrO2gP8j/blM+8kktwSB/3YpQ8cLOAQ5RR98m95jzonBMuse+sHFpbZtnfdLCUGNfF1Ud7VnbtWb0TgvBsBI3sK
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DC1BE7F1C185242B1C1D614DF95C1BC@GBRP123.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f827b5e7-6601-4d08-19a5-08d7fad7170a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 02:56:40.6635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HeLTbyM9QeoXng0MQhUhoeYdbetEG0pmBoVBUUnIIUvziP1DB1T3duEslBRGHg48eixex3jiYUH5EMP38tfjnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB2695
X-OriginatorOrg: bt.com
Received-SPF: pass client-ip=213.121.35.74; envelope-from=jasper.lowell@bt.com;
 helo=smtpe1.intersmtp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:56:44
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: tony.nguyen@bt.com, peter.tribble@gmail.com, mark.cave-ayland@ilande.co.uk,
 dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBHcmVhdCBwcm9ncmVzcyEgQXJlIHlvdSBwbGFubmluZyB0byBjb250cmlidXRlIHlvdXIgZXNj
YzIgdG8gdGhlDQo+IHVwc3RyZWFtPw0KDQpJIHdvdWxkIGxpa2UgdG8uIFdoaWxlIGl0IGRpZG4n
dCBzb2x2ZSB0aGUgY29uc29sZSBkaWZmaWN1bHRpZXMgb24NCk9wZW5Tb2xhcmlzIHZhcmlhbnRz
LCBpdCdzIHByb2JhYmx5IHN0aWxsIGEgZ29vZCBpZGVhIHRvIGluY3JlbWVudA0KU3VuNHUgZW11
bGF0aW9uIHRvd2FyZHMgYmVpbmcgbW9yZSBmYWl0aGZ1bCB0byBoYXJkd2FyZS4gSXQgd2lsbCB0
YWtlDQptZSBhIGZldyB3ZWVrcyB0byBjbGVhbiB1cCBhbmQgdGVzdCBidXQgSSdsbCBtYWtlIGFu
IFJGQyBvbmNlIEkgaGF2ZSBhDQpwYXRjaCB0byBkaXNjdXNzLiBJdCdzIHVubGlrZWx5IHRoYXQg
dGhlIHBhdGNoIHdpbGwgYmUgZmVhdHVyZSBjb21wbGV0ZQ0KYnV0IEknbGwgYWltIGZvciBpdCB0
byBiZSBlbm91Z2ggdG8gc2F0aXNmeSB0aGUgTGludXgvT3BlbkJTRCBkcml2ZXJzLg0KDQo+IFdl
IGNhbiB1c2UgdGhlIHN0cmF0ZWd5IEkgdXNlZCAxMCB5ZWFycyBiYWNrIGZvciBzdW40bTogYm9v
dCB0aGUNCj4gcHJvcHJpZXRhcnkgZmlybXdhcmUgZmlyc3QgdG8gcmVkdWNlIHRoZSBudW1iZXIg
b2YgcG9zc2libGUgZW11bGF0aW9uDQo+IGJ1Z3MuIFRoZSBwcm9wcmlldGFyeSBmaXJtd2FyZSBp
cyBrbm93biB0byBib290IFNvbGFyaXMuDQoNClVzaW5nIHRoZSBwcm9wcmlldGFyeSBmaXJtd2Fy
ZSBmb3IgdGhpcyB3b3VsZCBiZSBpZGVhbC4gSXQgd291bGQgYWxzbw0KcHJvdmlkZSByZWxpYWJs
ZSBhY2Nlc3MgdG8gdGhlIGtlcm5lbCBkZWJ1Z2dlciB3aGljaCB3b3VsZCBiZSBleHRyZW1lbHkN
CmhlbHBmdWwgZm9yIGRpYWdub3Npbmcgd2hhdCdzIGdvaW5nIHdyb25nIHdpdGggdGhlIGNvbnNv
bGUuIEknbSBub3QNCnN1cmUgaG93IEkgd291bGQgZ28gYWJvdXQgbWFraW5nIHByb2dyZXNzIG9u
IHRoaXMgdGhvdWdoLiBJIGtub3cgdGhlcmUNCmFyZSBiaW5hcmllcyBvZiB0aGUgQklPUyBmb3Ig
U3VuNG0gbWFjaGluZXMgZmxvYXRpbmcgYXJvdW5kIGJ1dCBJJ20gbm90DQphd2FyZSBvZiBhbnkg
Zm9yIFN1bjR1IG1hY2hpbmVzLg0KDQpUaGFua3MsDQpKYXNwZXIgTG93ZWxsLg0KDQpPbiBTdW4s
IDIwMjAtMDUtMTcgYXQgMTQ6MzcgKzAyMDAsIEFydHlvbSBUYXJhc2Vua28gd3JvdGU6DQo+IE9u
IFN1biwgTWF5IDE3LCAyMDIwIGF0IDk6NTcgQU0gPGphc3Blci5sb3dlbGxAYnQuY29tPiB3cm90
ZToNCj4gPiBJJ3ZlIHdyaXR0ZW4gdXAgYSBiYXNpYyBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgU0FC
IDgyNTMyIEVTQ0MyDQo+ID4gZGV2aWNlDQo+ID4gYW5kIGhhdmUgd3JpdHRlbiBhIHBhdGNoIGZv
ciBPcGVuQklPUyB0byBhZGQgaXQgdG8gdGhlIGRldmljZSB0cmVlLg0KPiA+IEkNCj4gPiBzdGls
bCBoYXZlIHRoZSAxNjU1MEEgVUFSVCBhY3RpbmcgYXMgdHR5YSB0byBhdm9pZCBoYXZpbmcgdG8g
d3JpdGUNCj4gPiBhbg0KPiA+IE9wZW5CSU9TIGRldmljZSBkcml2ZXIuDQo+IA0KPiBHcmVhdCBw
cm9ncmVzcyEgQXJlIHlvdSBwbGFubmluZyB0byBjb250cmlidXRlIHlvdXIgZXNjYzIgdG8gdGhl
DQo+IHVwc3RyZWFtPw0KPiANCj4gPiBPcGVuQlNEIGFuZCBTb2xhcmlzIGJvdGggaWRlbnRpZnkg
dGhlIGRldmljZSBjb3JyZWN0bHkgYW5kIGF0dGFjaA0KPiA+IGl0Lg0KPiA+IA0KPiA+IEludGVy
ZXN0aW5nbHksIGl0IGxvb2tzIGxpa2UgU29sYXJpcyBlbnRlcmVkIGFuIGludGVycnVwdCBoYW5k
bGVyDQo+ID4gdG8NCj4gPiBkZWFsIHdpdGggYW4gZXZlbnQgZm9yIHRoZSBTQUIgODI1MzIgYW5k
IGl0IHByb2JlZCBhIGZldyBzdGF0dXMNCj4gPiByZWdpc3RlcnMuIEdpdmVuIHRoYXQgSSBjb3Vs
ZG4ndCBlbmNvdXJhZ2UgU29sYXJpcyB0byBkbyBhbnl0aGluZw0KPiA+IG91dHNpZGUgb2YgYXR0
YWNoIHRoZSBkZXZpY2UgZm9yIHRoZSAxNjU1MEEsIEkgd2FzIHRoaW5raW5nIHRoaXMNCj4gPiBt
aWdodA0KPiA+IGJlIGEgZ29vZCBzaWduLg0KPiA+IA0KPiA+IFRoZXJlIHJlYWxseSBzaG91bGRu
J3QgYmUgYW4gaW50ZXJydXB0IHRob3VnaCBhcyB0aGUgcmVzZXQgc3RhdGUgb2YNCj4gPiB0aGUN
Cj4gPiBTQUIgODI1MzIgaXMgdG8gaGF2ZSBhbGwgaW50ZXJydXB0cyBtYXNrZWQuIFNvbGFyaXMg
cHJvYmVzIHRoZXNlDQo+ID4gaW50ZXJydXB0IHN0YXR1cyByZWdpc3RlcnMgd2hpbGUgImNvbmZp
Z3VyaW5nIiB0aGUgc3VuaG1lIGRldmljZS4NCj4gPiANCj4gPiBBdHRlbXB0aW5nIHRvIGNvbmZp
Z3VyZSBpbnRlcmZhY2UgaG1lMC4uLg0KPiA+IDE0MDA3MEAxNTg5Njk4NjAzLjI2ODk0Mjplc2Nj
Ml9tZW1fcmVhZCBjaGFubmVsIGEgYWRkciAweDM4IHZhbHVlDQo+ID4gMHg0DQo+ID4gMTQwMDcw
QDE1ODk2OTg2MDMuMjY5MDExOmVzY2MyX2lycV91cGRhdGUgdmFsdWUgMHgwDQo+ID4gMTQwMDcw
QDE1ODk2OTg2MDMuMjY5MDE1OmVzY2MyX21lbV9yZWFkIGNoYW5uZWwgYSBhZGRyIDB4M2EgdmFs
dWUNCj4gPiAweDgwDQo+ID4gMTQwMDcwQDE1ODk2OTg2MDMuMjY5MDE3OmVzY2MyX2lycV91cGRh
dGUgdmFsdWUgMHgwDQo+ID4gMTQwMDcwQDE1ODk2OTg2MDMuMjY5MDE4OmVzY2MyX21lbV9yZWFk
IGNoYW5uZWwgYSBhZGRyIDB4M2IgdmFsdWUNCj4gPiAweDANCj4gPiAxNDAwNzBAMTU4OTY5ODYw
My4yNjkwNzY6ZXNjYzJfbWVtX3JlYWQgY2hhbm5lbCBhIGFkZHIgMHgzOCB2YWx1ZQ0KPiA+IDB4
MA0KPiA+IFdBUk5JTkc6IFBvd2VyIG9mZiByZXF1ZXN0ZWQgZnJvbSBwb3dlciBidXR0b24gb3Ig
U0MsIHBvd2VyaW5nIGRvd24NCj4gPiB0aGUNCj4gPiBzeXN0ZW0hDQo+ID4gMTQwMDcwQDE1ODk2
OTg2MTEuMjcwODQ1OmVzY2MyX21lbV9yZWFkIGNoYW5uZWwgYSBhZGRyIDB4MzggdmFsdWUNCj4g
PiAweDANCj4gPiAxNDAwNzBAMTU4OTY5ODYxOS4yNzE3NTg6ZXNjYzJfbWVtX3JlYWQgY2hhbm5l
bCBhIGFkZHIgMHgzOCB2YWx1ZQ0KPiA+IDB4MA0KPiA+IA0KPiA+IEkndmUgbm90aWNlZCB0aGF0
IHJlbW92aW5nIHRoZSBzdW5obWUgY29kZSBmb3Igc3VuNHUuYyBpbiBRRU1VDQo+ID4gcHJldmVu
dHMNCj4gPiB0aGUgc3B1cmlvdXMgaW50ZXJydXB0IGZyb20gaGFwcGVuaW5nIGZvciB0aGUgc2Vy
aWFsIGRldmljZSBhbG9uZw0KPiA+IHdpdGgNCj4gPiBwcmV2ZW50IHRoZSB1bmV4cGVjdGVkIHBv
d2VyIG9mZiByZXF1ZXN0ICh0aGUgcG93ZXIgb2ZmIHJlcXVlc3Qgd2FzDQo+ID4gbm90DQo+ID4g
aW50cm9kdWNlZCBieSBteSBjb2RlKS4gSSBoYXZlbid0IGludmVzdGlnYXRlZCB3aHkgdGhlIHBy
ZXNlbmNlIG9mDQo+ID4gc3VuaG1lIGNhdXNlcyB0aGVzZSBldmVudHMuDQo+ID4gDQo+ID4gSSBt
b2RpZmllZCBPcGVuQklPUyB0byB1c2UgdHR5YiBmb3Igc3RkaW4vc3Rkb3V0IGFuZCBhc3NpZ25l
ZCB0aGF0DQo+ID4gdG8NCj4gPiB0aGUgMTY1NTBBIHNvIHRoYXQgdHR5YSBjb3VsZCBiZSBhbGlh
c2VkIHRvIHRoZSBTQUIgODI1MzIuIE91dHNpZGUNCj4gPiBvZg0KPiA+IHRoZSBzcHVyaW91cyBp
bnRlcnJ1cHQgaGFuZGxlciBiZWluZyBjYWxsZWQsIEknbSBnZXR0aW5nIHRoZSBzYW1lDQo+ID4g
YmVoYXZpb3VyIHdoZXJlIFNvbGFyaXMgaWRlbnRpZmllcywgYXR0YWNoZXMsIGFuZCB0aGVuIGln
bm9yZXMgdGhlDQo+ID4gZGV2aWNlLiBEb2Vzbid0IGxvb2sgbGlrZSBteSBndWVzcyB3YXMgb24g
dGhlIG1hcmsuDQo+ID4gDQo+ID4gSSdsbCBiZSBsb29raW5nIGF0IGdldHRpbmcgYW4gT3BlblNv
bGFyaXMtbGlrZSBrZXJuZWwgYnVpbHQgd2l0aA0KPiA+IHByb20NCj4gPiBkZWJ1Z2dpbmcgb3V0
cHV0IGZvciBjb25zb2xlL3R0eSByZWxhdGVkIGZpbGVzIGxpa2UNCj4gPiB1c3Ivc3JjL3V0cy9j
b21tb24vaW8vY29uc2NvbmZpZ19kYWNmLmMuIFRoZSBpbGx1bW9zIGtlcm5lbCBpcw0KPiA+IHBy
b2JhYmx5DQo+ID4gc3VpdGFibGUgZm9yIHRoaXMgYmVjYXVzZSBpdCdzIHN0aWxsIG1haW50YWlu
ZWQgYW5kIGFwcGVhcnMgdG8gYmUNCj4gPiBzdWZmZXJpbmcgZnJvbSB0aGUgc2FtZSBjb25zb2xl
IHByb2JsZW1zLiBJIGRvbid0IGhhdmUgYSBTUEFSQzY0DQo+ID4gbWFjaGluZSBpbW1lZGlhdGVs
eSBhdmFpbGFibGUgYW5kIEknbSB1bmZhbWlsaWFyIHdpdGggdGhlIGJ1aWxkDQo+ID4gc3lzdGVt
DQo+ID4gYmVoaW5kIHRoZXNlIGRpc3RyaWJ1dGlvbnMsIHNvIGl0IG1pZ2h0IGJlIGEgd2hpbGUg
YmVmb3JlIHRoaXMNCj4gPiBoYXBwZW5zLg0KPiA+IA0KPiA+IEknbSBvdXQgb2YgaWRlYXMuDQo+
IA0KPiBXZSBjYW4gdXNlIHRoZSBzdHJhdGVneSBJIHVzZWQgMTAgeWVhcnMgYmFjayBmb3Igc3Vu
NG06IGJvb3QgdGhlDQo+IHByb3ByaWV0YXJ5IGZpcm13YXJlIGZpcnN0IHRvIHJlZHVjZSB0aGUg
bnVtYmVyIG9mIHBvc3NpYmxlIGVtdWxhdGlvbg0KPiBidWdzLiBUaGUgcHJvcHJpZXRhcnkgZmly
bXdhcmUgaXMga25vd24gdG8gYm9vdCBTb2xhcmlzLg0KPiANCj4gUmVnYXJkcywNCj4gQXJ0eW9t
DQo=

