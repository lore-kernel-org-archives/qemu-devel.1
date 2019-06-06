Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0184C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3973020866
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3973020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYrpT-0003Hb-RW
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 08:49:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.de>) id 1hYmnc-0005oh-Tz
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 03:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.de>) id 1hYmnb-0007Gt-Rq
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 03:27:00 -0400
Received: from mailin4.audi.de ([143.164.102.18]:36479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.de>)
	id 1hYmnb-0007Dt-J0
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 03:26:59 -0400
From: "Brenken, David (EFS-GH2)" <david.brenken@efs-auto.de>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, David Brenken
	<david.brenken@efs-auto.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 3/5] tricore: fix RRPW_INSERT instruction
Thread-Index: AQHVG2WRrcO1I/WiUEGKEn72YVvZnKaM/1iAgAE42kA=
Date: Thu, 6 Jun 2019 07:26:53 +0000
Message-ID: <34F764F04E859040BBA6C4FF41AB17D93B2DA4@AUDIINSX0410.audi.vwg>
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
	<20190605061126.10244-4-david.brenken@efs-auto.org>
	<ffb4ba2c-318e-6b08-c206-a90b000074d2@mail.uni-paderborn.de>
In-Reply-To: <ffb4ba2c-318e-6b08-c206-a90b000074d2@mail.uni-paderborn.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.134.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 143.164.102.18
X-Mailman-Approved-At: Thu, 06 Jun 2019 08:47:51 -0400
Subject: Re: [Qemu-devel] [PATCH 3/5] tricore: fix RRPW_INSERT instruction
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Konopik, Andreas \(EFS-GH2\)" <andreas.konopik@efs-auto.de>, "Rasche,
	Robert \(EFS-GH2\)" <robert.rasche@efs-auto.de>, "Hofstetter, 
	Georg \(EFS-GH2\)" <Georg.Hofstetter@efs-auto.de>, "Biermanski,
	Lars \(EFS-GH3\)" <lars.biermanski@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgQmFzdGlhbiwNCg0KPiBIaSBEYXZpZCwNCj4gDQo+IE9uIDYvNS8xOSA4OjExIEFNLCBEYXZp
ZCBCcmVua2VuIHdyb3RlOg0KPiA+IEZyb206IERhdmlkIEJyZW5rZW4gPGRhdmlkLmJyZW5rZW5A
ZWZzLWF1dG8uZGU+DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWFzIEtvbm9waWsgPGFu
ZHJlYXMua29ub3Bpa0BlZnMtYXV0by5kZT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBCcmVu
a2VuIDxkYXZpZC5icmVua2VuQGVmcy1hdXRvLmRlPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEdlb3Jn
IEhvZnN0ZXR0ZXIgPGdlb3JnLmhvZnN0ZXR0ZXJAZWZzLWF1dG8uZGU+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogUm9iZXJ0IFJhc2NoZSA8cm9iZXJ0LnJhc2NoZUBlZnMtYXV0by5kZT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBMYXJzIEJpZXJtYW5za2kgPGxhcnMuYmllcm1hbnNraUBlZnMtYXV0by5kZT4N
Cj4gPg0KPiA+IC0tLQ0KPiA+ICAgdGFyZ2V0L3RyaWNvcmUvdHJhbnNsYXRlLmMgfCAxMSArKysr
KysrKy0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90YXJnZXQvdHJpY29yZS90cmFuc2xhdGUuYyBi
L3RhcmdldC90cmljb3JlL3RyYW5zbGF0ZS5jDQo+ID4gaW5kZXggYThiNGRlNjQ3YS4uMTlkOGRi
N2E0NiAxMDA2NDQNCj4gPiAtLS0gYS90YXJnZXQvdHJpY29yZS90cmFuc2xhdGUuYw0KPiA+ICsr
KyBiL3RhcmdldC90cmljb3JlL3RyYW5zbGF0ZS5jDQo+ID4gQEAgLTcwMDQsNiArNzAwNCw3IEBA
IHN0YXRpYyB2b2lkDQo+IGRlY29kZV9ycnB3X2V4dHJhY3RfaW5zZXJ0KENQVVRyaUNvcmVTdGF0
ZSAqZW52LCBEaXNhc0NvbnRleHQgKmN0eCkNCj4gPiAgICAgICB1aW50MzJfdCBvcDI7DQo+ID4g
ICAgICAgaW50IHIxLCByMiwgcjM7DQo+ID4gICAgICAgaW50MzJfdCBwb3MsIHdpZHRoOw0KPiA+
ICsgICAgVENHdiB0ZW1wMSwgdGVtcDI7DQo+ID4NCj4gPiAgICAgICBvcDIgPSBNQVNLX09QX1JS
UFdfT1AyKGN0eC0+b3Bjb2RlKTsNCj4gPiAgICAgICByMSA9IE1BU0tfT1BfUlJQV19TMShjdHgt
Pm9wY29kZSk7DQo+ID4gQEAgLTcwNDIsOSArNzA0MywxMyBAQCBzdGF0aWMgdm9pZA0KPiBkZWNv
ZGVfcnJwd19leHRyYWN0X2luc2VydChDUFVUcmlDb3JlU3RhdGUgKmVudiwgRGlzYXNDb250ZXh0
ICpjdHgpDQo+ID4gICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAg
Y2FzZSBPUEMyXzMyX1JSUFdfSU5TRVJUOg0KPiA+IC0gICAgICAgIGlmIChwb3MgKyB3aWR0aCA8
PSAzMSkgew0KPiA+IC0gICAgICAgICAgICB0Y2dfZ2VuX2RlcG9zaXRfdGwoY3B1X2dwcl9kW3Iz
XSwgY3B1X2dwcl9kW3IxXSwgY3B1X2dwcl9kW3IyXSwNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHdpZHRoLCBwb3MpOw0KPiBDYW4geW91IGV4cGxhaW4gdGhlIHByb2JsZW0g
Y2F1c2luZyB0aGUgYnVnPyBEZXBvc2l0IGxvb2tzIGZpbmUgdG8gbWUuDQo+IEFmdGVyIHJlYWRp
bmcgdGhlIHNwZWNzIGFnYWluLCBJIGFncmVlIHRoYXQgdGhlIGNoZWNrIG5lZWRzIHRvIGJlIDw9
IDMyLg0KVGhlIGJ1ZyB3YXMgcmVjb2duaXplZCBiZWNhdXNlIG9mIGRpZmZlcmVudCBiZWhhdmlv
ciBiZXR3ZWVuIGFjdHVhbCBoYXJkd2FyZSBhbmQgUUVNVS4NCkp1c3QgZnJvbSBsb29raW5nIGF0
IGl0IEkgd291bGQgc2F5IHRoYXQgZGVwb3NpdCBtYXNrcyBhbmQgdGhlbiBzaGlmdHMgdGhlIGFy
ZzIgKERbYl0pIHdoaWxlIHRoZSANCm1hbnVhbCBzdGF0ZXMgdG8gZmlyc3Qgc2hpZnQgRFtiXSBh
bmQgdGhlbiBtYXNrIGl0LiBJIHJlbWVtYmVyIHRoYXQgaXQgd2FzIGEgY29ybmVyIGNhc2UgKGUu
Zy4gDQp3aWR0aCArIHBvcyA9IDMxIG9yIDMyKS4gDQpJIGFsc28gdGhvdWdodCB0aGF0IHVzaW5n
IHRoZSBkaXJlY3QgaW5zZXJ0IGluc3RydWN0aW9uIGlzIG1vcmUgY29udmVuaWVudCBzaW5jZSBp
dCB3YXMgcHJlc2VudCBhbnl3YXkuDQoNCj4gDQo+IA0KPiA+ICsgICAgICAgIGlmIChwb3MgKyB3
aWR0aCA8PSAzMikgew0KPiA+ICsgICAgICAgICAgICB0ZW1wMSA9IHRjZ19jb25zdF9pMzIocG9z
KTsgICAvKiBwb3MgKi8NCj4gPiArICAgICAgICAgICAgdGVtcDIgPSB0Y2dfY29uc3RfaTMyKHdp
ZHRoKTsgLyogd2lkdGggKi8NCj4gVXNlbGVzcyBjb21tZW50cy4NCkkgd2lsbCByZW1vdmUgdGhl
bSBpbiBhIHNlY29uZCB2ZXJzaW9uIG9mIHRoZSBwYXRjaHNldC4NCj4gDQo+IA0KPiBDaGVlcnMs
DQo+IA0KPiBCYXN0aWFuDQpCZXN0IHJlZ2FyZHMNCg0KRGF2aWQNCg0K

