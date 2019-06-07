Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6409C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DCBD20657
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCBD20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49148 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHNI-0004Bb-ME
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60847)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andreas.konopik@efs-auto.de>) id 1hZAQd-00066I-1P
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andreas.konopik@efs-auto.de>) id 1hZAQb-0006vK-Fm
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:40:50 -0400
Received: from mailin4.audi.de ([143.164.102.18]:44610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andreas.konopik@efs-auto.de>)
 id 1hZAQb-0006VJ-3T
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:40:49 -0400
From: "Konopik, Andreas (EFS-GH2)" <andreas.konopik@efs-auto.de>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 4/5] tricore: add QSEED instruction
Thread-Index: AQHVG2WPXjGEeP6bXEumMYkWdbcFpKaNB4kAgALS7FA=
Date: Fri, 7 Jun 2019 08:40:28 +0000
Message-ID: <F5B10EA5F04CF44F81B685A0E28157872022B0@AUDIINSX0385.audi.vwg>
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
 <20190605061126.10244-5-david.brenken@efs-auto.org>
 <9baa6207-17a2-7218-9ad2-9627de232304@mail.uni-paderborn.de>
In-Reply-To: <9baa6207-17a2-7218-9ad2-9627de232304@mail.uni-paderborn.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.246.77.120]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 143.164.102.18
X-Mailman-Approved-At: Fri, 07 Jun 2019 11:13:35 -0400
Subject: Re: [Qemu-devel] [PATCH 4/5] tricore: add QSEED instruction
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
Cc: "Brenken, David \(EFS-GH2\)" <david.brenken@efs-auto.de>, "Rasche,
 Robert \(EFS-GH2\)" <robert.rasche@efs-auto.de>, "Hofstetter, 
 Georg \(EFS-GH2\)" <Georg.Hofstetter@efs-auto.de>, "Biermanski,
 Lars \(EFS-GH3\)" <lars.biermanski@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgQmFzdGlhbiwNCg0KPiBIaSwNCj4gDQo+IE9uIDYvNS8xOSA4OjExIEFNLCBEYXZpZCBCcmVu
a2VuIHdyb3RlOg0KPiA+ICsvKg0KPiA+ICsgKiBUYXJnZXQgVHJpQ29yZSBRU0VFRC5GIHNpZ25p
ZmljYW5kIExvb2t1cCBUYWJsZQ0KPiA+ICsgKg0KPiA+ICsgKiBUaGUgUVNFRUQuRiBvdXRwdXQg
c2lnbmlmaWNhbmQgZGVwZW5kcyBvbiB0aGUgbGVhc3Qtc2lnbmlmaWNhbnQNCj4gPiArICogZXhw
b25lbnQgYml0IGFuZCB0aGUgNiBtb3N0LXNpZ25pZmljYW50IHNpZ25pZmljYW5kIGJpdHMuDQo+
ID4gKyAqDQo+ID4gKyAqIElFRUUgNzU0IGZsb2F0IGRhdGF0eXBlDQo+ID4gKyAqIHBhcnRpdGlv
bmVkIGludG8gU2lnbiAoUyksIEV4cG9uZW50IChFKSBhbmQgU2lnbmlmaWNhbmQgKE0pOg0KPiA+
ICsgKg0KPiA+ICsgKiBTICAgRSBFIEUgRSBFIEUgRSBFICAgTSBNIE0gTSBNIE0gLi4uDQo+ID4g
KyAqICAgIHwgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIHwNCj4gPiArICogICAgKy0tLS0t
LSstLS0tLS0rLS0tLS0tLSstLS0tLS0tKw0KPiA+ICsgKiAgICAgICAgICAgfCAgICAgICAgICAg
ICAgfA0KPiA+ICsgKiAgICAgICAgICBmb3IgICAgICAgIGxvb2t1cCB0YWJsZQ0KPiA+ICsgKiAg
ICAgIGNhbGN1bGF0aW5nICAgICBpbmRleCBmb3INCj4gPiArICogICAgICAgIG91dHB1dCBFICAg
ICAgIG91dHB1dCBNDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgY29uc3QgdWludDhfdCB0YXJnZXRf
cXNlZWRfc2lnbmlmaWNhbmRfdGFibGVbMTI4XSA9IHsNCj4gPiArICAgIDI1MywgMjUyLCAyNDUs
IDI0NCwgMjM5LCAyMzgsIDIzMSwgMjMwLCAyMjUsIDIyNCwgMjE3LCAyMTYsDQo+ID4gKyAgICAy
MTEsIDIxMCwgMjA1LCAyMDQsIDIwMSwgMjAwLCAxOTUsIDE5NCwgMTg5LCAxODgsIDE4NSwgMTg0
LA0KPiA+ICsgICAgMTc5LCAxNzgsIDE3NSwgMTc0LCAxNjksIDE2OCwgMTY1LCAxNjQsIDE2MSwg
MTYwLCAxNTcsIDE1NiwNCj4gPiArICAgIDE1MywgMTUyLCAxNDksIDE0OCwgMTQ1LCAxNDQsIDE0
MSwgMTQwLCAxMzcsIDEzNiwgMTMzLCAxMzIsDQo+ID4gKyAgICAxMzEsIDEzMCwgMTI3LCAxMjYs
IDEyMywgMTIyLCAxMjEsIDEyMCwgMTE3LCAxMTYsIDExNSwgMTE0LA0KPiA+ICsgICAgMTExLCAx
MTAsIDEwOSwgMTA4LCAxMDMsIDEwMiwgOTksIDk4LCA5MywgOTIsIDg5LCA4OCwgODMsDQo+ID4g
KyAgICA4MiwgNzksIDc4LCA3NSwgNzQsIDcxLCA3MCwgNjcsIDY2LCA2MywgNjIsIDU5LCA1OCwg
NTUsDQo+ID4gKyAgICA1NCwgNTMsIDUyLCA0OSwgNDgsIDQ1LCA0NCwgNDMsIDQyLCAzOSwgMzgs
IDM3LCAzNiwgMzMsDQo+ID4gKyAgICAzMiwgMzEsIDMwLCAyNywgMjYsIDI1LCAyNCwgMjMsIDIy
LCAxOSwgMTgsIDE3LCAxNiwgMTUsDQo+ID4gKyAgICAxNCwgMTMsIDEyLCAxMSwgMTAsIDksIDgs
IDcsIDYsIDUsIDQsIDMsIDIgfTsNCj4gDQo+IA0KPiBDYW4geW91IGV4cGxhaW4gaW4gYSBjb21t
ZW50IGhvdyB5b3UgYXJyaXZlZCBhdCB0aGlzIGxvb2t1cCB0YWJsZT8NCg0KV2UgZXh0cmFjdGVk
IHRoaXMgbG9va3VwIHRhYmxlIGZyb20gcmVhbCBoYXJkd2FyZSByZXN1bHRzLg0KV2UgYWxzbyB2
YWxpZGF0ZWQgUUVNVSBvdXRwdXQgdmFsdWVzIGJ5IGNvbXBhcmluZyBhZ2FpbiB3aXRoIHRoZSBy
ZWFsDQpoYXJkd2FyZSBxc2VlZCBvdXRwdXQuDQpUZXN0aW5nIHdhcyBub3QgbWFkZSBmb3IgYWxs
IDJeMzIgcG9zc2libGUgaW5wdXQgdmFsdWVzLGJ1dCBmb3IgYWxsDQpwb3NpdGl2ZSBmbG9hdHMg
dGhhdCB5aWVsZCBkaWZmZXJlbnQgb3V0cHV0cyAod2l0aCBhIGJpZyBzdHJpZGUpLg0KDQpXZSB3
aWxsIGFkZCBhIHNob3J0ZXIgY29tbWVudCB0byB0aGUgc2Vjb25kIHZlcnNpb24gb2YgdGhlIHBh
dGNoc2V0DQoNCj4gPiArICAgIH0gZWxzZSBpZiAoZmxvYXQzMl9pc19uZWcoYXJnMSkpIHsNCj4g
PiArICAgICAgICByZXN1bHQgPSBmbG9hdDMyX3NxcnRfbmFuOw0KPiA+ICsgICAgICAgIGVudi0+
RlBVX0ZJID0gMTsNCj4gWy4uLl0NCj4gPiArDQo+ID4gKyAgICBmbGFncyA9IGZfZ2V0X2V4Y3Bf
ZmxhZ3MoZW52KTsNCj4gPiArICAgIGlmIChmbGFncykgew0KPiA+ICsgICAgICAgIGlmIChmbGFn
cyAmIGZsb2F0X2ZsYWdfaW52YWxpZCkgew0KPiA+ICsgICAgICAgICAgICBmX3VwZGF0ZV9wc3df
ZmxhZ3MoZW52LCBmbGFncyk7DQo+ID4gKyAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAg
ICAgZW52LT5GUFVfRlMgPSAwOw0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0gZWxzZSB7DQo+
ID4gKyAgICAgICAgZW52LT5GUFVfRlMgPSAwOw0KPiANCj4gWW91IGFyZSBzZXR0aW5nIEZQVV9G
UyB0byAwLCBldmVuIHRob3VnaCBGUFVfRkkgbWlnaHQgaGF2ZSBiZWVuIHNldCBpbiBjYXNlIG9m
DQo+IGEgTmFOLiBJIHRoaW5rIGl0J3MgYmVzdCB0byByZW1vdmUgdGhlIHdob2xlIHNvZnRmbG9h
dCBjaGVjaywgYXMgbm9uZSBvZiB0aGUNCj4gc29mdGZsb2F0IGZ1bmN0aW9ucyB5b3UgY2FsbCwg
Y2FuIHJhaXNlIGFueSBmbGFncy4NCg0KSSB3aWxsIG1ha2UgdGhlIFBTVyB1cGRhdGUgb25seSBk
ZXBlbmRlbnQgb24gaXNfTmFOKGlucHV0KSBhbmQgaXNfU1FSVF9OYU4ob3V0cHV0KS4NCg0KQmVz
dCByZWdhcmRzLA0KDQpBbmRyZWFzDQo=

