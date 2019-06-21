Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D57CC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2778B21530
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2778B21530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59328 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heHNM-0007s9-8x
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andreas.konopik@efs-auto.de>) id 1heHMS-0007Ki-ED
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andreas.konopik@efs-auto.de>) id 1heHMP-0005Hg-Br
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:05:40 -0400
Received: from mailin3.audi.de ([143.164.102.17]:58034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andreas.konopik@efs-auto.de>)
 id 1heHMP-0003gk-5i
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:05:37 -0400
From: "Konopik, Andreas (EFS-GH2)" <andreas.konopik@efs-auto.de>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, David Brenken
 <david.brenken@efs-auto.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 4/5] tricore: add QSEED instruction
Thread-Index: AQHVJnSahp6nxEePnkqPadw3nWiQ6KaixacAgAMsbRA=
Date: Fri, 21 Jun 2019 10:55:55 +0000
Message-ID: <F5B10EA5F04CF44F81B685A0E281578720CA35@AUDIINSX0385.audi.vwg>
References: <20190619075643.10048-1-david.brenken@efs-auto.org>
 <20190619075643.10048-5-david.brenken@efs-auto.org>
 <cd1adeb4-6006-fcc8-4301-0604623f3991@mail.uni-paderborn.de>
In-Reply-To: <cd1adeb4-6006-fcc8-4301-0604623f3991@mail.uni-paderborn.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.246.66.213]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 143.164.102.17
Subject: Re: [Qemu-devel] [PATCH v2 4/5] tricore: add QSEED instruction
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

SGkgQmFzdGlhbiwNCg0KYWxscmlnaHQgdGhhbmsgeW91LiBBIGZpeCBpcyBhbHJlYWR5IG9uIHRo
ZSB3YXkuDQoNCkJlc3QgcmVnYXJkcywNCg0KQW5kcmVhcyANCg0KPiAtLS0tLVVyc3Byw7xuZ2xp
Y2hlIE5hY2hyaWNodC0tLS0tDQo+IFZvbjogQmFzdGlhbiBLb3BwZWxtYW5uIDxrYmFzdGlhbkBt
YWlsLnVuaS1wYWRlcmJvcm4uZGU+DQo+IEdlc2VuZGV0OiBNaXR0d29jaCwgMTkuIEp1bmkgMjAx
OSAxNDoyNQ0KPiBBbjogRGF2aWQgQnJlbmtlbiA8ZGF2aWQuYnJlbmtlbkBlZnMtYXV0by5vcmc+
OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IEJpZXJtYW5za2ksIExhcnMgKEVGUy1HSDMp
IDxsYXJzLmJpZXJtYW5za2lAZWZzLWF1dG8uZGU+OyBIb2ZzdGV0dGVyLA0KPiBHZW9yZyAoRUZT
LUdIMikgPEdlb3JnLkhvZnN0ZXR0ZXJAZWZzLWF1dG8uZGU+OyBCcmVua2VuLCBEYXZpZCAoRUZT
LUdIMikNCj4gPGRhdmlkLmJyZW5rZW5AZWZzLWF1dG8uZGU+OyBSYXNjaGUsIFJvYmVydCAoRUZT
LUdIMikgPHJvYmVydC5yYXNjaGVAZWZzLQ0KPiBhdXRvLmRlPjsgS29ub3BpaywgQW5kcmVhcyAo
RUZTLUdIMikgPGFuZHJlYXMua29ub3Bpa0BlZnMtYXV0by5kZT4NCj4gQmV0cmVmZjogUmU6IFtR
ZW11LWRldmVsXSBbUEFUQ0ggdjIgNC81XSB0cmljb3JlOiBhZGQgUVNFRUQgaW5zdHJ1Y3Rpb24N
Cj4gDQo+IA0KPiBPbiA2LzE5LzE5IDk6NTYgQU0sIERhdmlkIEJyZW5rZW4gd3JvdGU6DQo+ID4g
Kw0KPiA+ICsgICAgICAgIHJlc3VsdCA9IDA7DQo+ID4gKyAgICAgICAgcmVzdWx0ID0gZGVwb3Np
dDMyKHJlc3VsdCwgMzEsIDEsIG5ld19TKTsNCj4gPiArICAgICAgICByZXN1bHQgPSBkZXBvc2l0
MzIocmVzdWx0LCAyMywgOCwgbmV3X0UpOw0KPiA+ICsgICAgICAgIHJlc3VsdCA9IGRlcG9zaXQz
MihyZXN1bHQsIDE1LCA4LCBuZXdfTSk7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgaWYg
KGZsb2F0MzJfaXNfYW55X25hbihhcmcxKSB8fCByZXN1bHQgPT0gZmxvYXQzMl9zcXJ0X25hbikg
ew0KPiANCj4gDQo+IFlvdSBuZWVkIGZsb2F0MzJfaXNfc2lnbmFsaW5nX25hbiwgc2luY2Ugb25s
eSBzaWduYWxpbmcgbmFuIHJhaXNlcyB0aGUgaW52YWxpZA0KPiBmbGFnLg0KPiANCj4gDQo+ID4g
KyAgICAgICAgZW52LT5GUFVfRkkgPSAxOw0KPiANCj4gZW52LT5GUFVfRkkgPSAxIDw8IDMxOw0K
PiANCj4gU2VlIGZfdXBkYXRlX3Bzd19mbGFncygpLiBGUFVfRknCoCBhbmQgUFNXX1YgYXJlIHRo
ZSBzYW1lIGFuZCB3ZSBkZWZpbmVkDQo+IGJpdCAzMSBhcyB0aGUgViBiaXQgZm9yIG9wdGltaXph
dGlvbiBwdXJwb3Nlcy4NCj4gDQo+IENoZWVycywNCj4gDQo+IEJhc3RpYW4NCg0K

