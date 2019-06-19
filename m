Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8236EC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 12:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510D4214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 12:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510D4214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38006 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdZwP-0005Z4-HN
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 08:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57755)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david.brenken@efs-auto.de>) id 1hdZuC-000443-31
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.brenken@efs-auto.de>) id 1hdZuA-0004th-LS
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:41:35 -0400
Received: from mailin4.audi.de ([143.164.102.18]:41904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.brenken@efs-auto.de>)
 id 1hdZuA-0004ra-FP
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:41:34 -0400
From: "Brenken, David (EFS-GH2)" <david.brenken@efs-auto.de>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, David Brenken
 <david.brenken@efs-auto.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 5/5] tricore: reset DisasContext before
 generating code
Thread-Index: AQHVJnSXmnGkMgwHhUOzhJYdW9yiwaaixdQAgAAlY2A=
Date: Wed, 19 Jun 2019 12:41:28 +0000
Message-ID: <34F764F04E859040BBA6C4FF41AB17D93C00E2@AUDIINSX0410.audi.vwg>
References: <20190619075643.10048-1-david.brenken@efs-auto.org>
 <20190619075643.10048-6-david.brenken@efs-auto.org>
 <caa5aca5-a41e-4d58-33f8-acba5062a46e@mail.uni-paderborn.de>
In-Reply-To: <caa5aca5-a41e-4d58-33f8-acba5062a46e@mail.uni-paderborn.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.134.50]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 143.164.102.18
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tricore: reset DisasContext before
 generating code
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
Cc: "Konopik, Andreas \(EFS-GH2\)" <andreas.konopik@efs-auto.de>, "Rasche,
 Robert \(EFS-GH2\)" <robert.rasche@efs-auto.de>, "Hofstetter, 
 Georg \(EFS-GH2\)" <Georg.Hofstetter@efs-auto.de>, "Biermanski,
 Lars \(EFS-GH3\)" <lars.biermanski@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWguIFlvdSBhcmUgcmlnaHQuIA0KSSB3aWxsIGZpeCB0aGlzIG9uZSB3aXRoaW4gdGhlIHRoaXJk
IHZlcnNpb24uDQoNCkJlc3QgcmVnYXJkcw0KDQpEYXZpZA0KDQotLS0tLVVyc3Byw7xuZ2xpY2hl
IE5hY2hyaWNodC0tLS0tDQpWb246IEJhc3RpYW4gS29wcGVsbWFubiBbbWFpbHRvOmtiYXN0aWFu
QG1haWwudW5pLXBhZGVyYm9ybi5kZV0gDQpHZXNlbmRldDogTWl0dHdvY2gsIDE5LiBKdW5pIDIw
MTkgMTQ6MjYNCkFuOiBEYXZpZCBCcmVua2VuIDxkYXZpZC5icmVua2VuQGVmcy1hdXRvLm9yZz47
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KQ2M6IEJpZXJtYW5za2ksIExhcnMgKEVGUy1HSDMpIDxs
YXJzLmJpZXJtYW5za2lAZWZzLWF1dG8uZGU+OyBIb2ZzdGV0dGVyLCBHZW9yZyAoRUZTLUdIMikg
PEdlb3JnLkhvZnN0ZXR0ZXJAZWZzLWF1dG8uZGU+OyBCcmVua2VuLCBEYXZpZCAoRUZTLUdIMikg
PGRhdmlkLmJyZW5rZW5AZWZzLWF1dG8uZGU+OyBSYXNjaGUsIFJvYmVydCAoRUZTLUdIMikgPHJv
YmVydC5yYXNjaGVAZWZzLWF1dG8uZGU+OyBLb25vcGlrLCBBbmRyZWFzIChFRlMtR0gyKSA8YW5k
cmVhcy5rb25vcGlrQGVmcy1hdXRvLmRlPg0KQmV0cmVmZjogUmU6IFtRZW11LWRldmVsXSBbUEFU
Q0ggdjIgNS81XSB0cmljb3JlOiByZXNldCBEaXNhc0NvbnRleHQgYmVmb3JlIGdlbmVyYXRpbmcg
Y29kZQ0KDQoNCk9uIDYvMTkvMTkgOTo1NiBBTSwgRGF2aWQgQnJlbmtlbiB3cm90ZToNCj4gRnJv
bTogR2VvcmcgSG9mc3RldHRlciA8Z2VvcmcuaG9mc3RldHRlckBlZnMtYXV0by5kZT4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogQW5kcmVhcyBLb25vcGlrIDxhbmRyZWFzLmtvbm9waWtAZWZzLWF1dG8u
ZGU+DQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEJyZW5rZW4gPGRhdmlkLmJyZW5rZW5AZWZzLWF1
dG8uZGU+DQo+IFNpZ25lZC1vZmYtYnk6IEdlb3JnIEhvZnN0ZXR0ZXIgPGdlb3JnLmhvZnN0ZXR0
ZXJAZWZzLWF1dG8uZGU+DQo+IFNpZ25lZC1vZmYtYnk6IFJvYmVydCBSYXNjaGUgPHJvYmVydC5y
YXNjaGVAZWZzLWF1dG8uZGU+DQo+IFNpZ25lZC1vZmYtYnk6IExhcnMgQmllcm1hbnNraSA8bGFy
cy5iaWVybWFuc2tpQGVmcy1hdXRvLmRlPg0KPiAtLS0NCj4gICB0YXJnZXQvdHJpY29yZS90cmFu
c2xhdGUuYyB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvdGFyZ2V0L3RyaWNvcmUvdHJhbnNsYXRlLmMgYi90YXJnZXQvdHJpY29yZS90
cmFuc2xhdGUuYyANCj4gaW5kZXggYjNiZmIzY2E1MS4uOGY5MGM3NmQzNSAxMDA2NDQNCj4gLS0t
IGEvdGFyZ2V0L3RyaWNvcmUvdHJhbnNsYXRlLmMNCj4gKysrIGIvdGFyZ2V0L3RyaWNvcmUvdHJh
bnNsYXRlLmMNCj4gQEAgLTg4MDYsNiArODgwNiw3IEBAIHZvaWQgZ2VuX2ludGVybWVkaWF0ZV9j
b2RlKENQVVN0YXRlICpjcywgVHJhbnNsYXRpb25CbG9jayAqdGIsIGludCBtYXhfaW5zbnMpDQo+
ICAgICAgIHRhcmdldF91bG9uZyBwY19zdGFydDsNCj4gICAgICAgaW50IG51bV9pbnNucyA9IDA7
DQo+ICAgDQo+ICsgICAgbWVtc2V0KCZjdHgsIDB4MDAsIHNpemVvZihEaXNhc0NvbnRleHQpKTsN
Cj4gICAgICAgcGNfc3RhcnQgPSB0Yi0+cGM7DQo+ICAgICAgIGN0eC5wYyA9IHBjX3N0YXJ0Ow0K
PiAgICAgICBjdHguc2F2ZWRfcGMgPSAtMTsNCg0KU3RpbGwgdGhlIG9sZCBwYXRjaC4gRGlkIHlv
dSBtYWtlIGEgcmViYXNlIG1pc3Rha2U/IDopDQoNCkNoZWVycywNCg0KQmFzdGlhbg0KDQo=

