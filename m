Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62005CA9EAF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 08:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D8720578
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 08:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D8720578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tachyum.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPjbw-0005uA-B9
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 04:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mkysel@tachyum.com>) id 1iPjZI-0004kF-He
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 04:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mkysel@tachyum.com>) id 1iPjZG-0007Lk-AG
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 04:43:03 -0400
Received: from mail.tachyum.com ([66.160.133.170]:44010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mkysel@tachyum.com>) id 1iPjZG-0007E6-3Z
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 04:43:02 -0400
Received: from THQ-IP-EX1.tachyum.com (relayhost.tachyum.com [10.7.1.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.tachyum.com (Postfix) with ESMTPS id 8FC18136;
 Wed, 30 Oct 2019 01:46:06 -0700 (PDT)
Received: from THQ-IP-EX1.tachyum.com (10.7.1.6) by THQ-IP-EX1.tachyum.com
 (10.7.1.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1779.2; Wed, 30
 Oct 2019 01:42:59 -0700
Received: from THQ-IP-EX1.tachyum.com ([::1]) by THQ-IP-EX1.tachyum.com
 ([::1]) with mapi id 15.01.1779.004; Wed, 30 Oct 2019 01:42:59 -0700
From: Matus Kysel <mkysel@tachyum.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Added hardfloat conversion from float32 to float64
Thread-Topic: [PATCH] Added hardfloat conversion from float32 to float64
Thread-Index: AQHVg/P/aCV6Oe4enEaElg3I5ahTc6dd3NkAgBUXB4A=
Date: Wed, 30 Oct 2019 08:42:59 +0000
Message-ID: <507d38e8542842b983d097cf83ff4fc8@tachyum.com>
References: <20191016073240.12473-1-mkysel@tachyum.com>
 <34960708-32a9-53d6-a719-fa98b8be517c@linaro.org>
In-Reply-To: <34960708-32a9-53d6-a719-fa98b8be517c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.7.241.54]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.160.133.170
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGksDQoNCkkgaGF2ZSBzZW5kIHBhdGNoIHYyIHdpdGggcHJvcG9zZWQgY2hhbmdlcywgcGxlYXNl
IGhhdmUgYSBsb29rIGh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1k
ZXZlbC8yMDE5LTEwL21zZzA0MjY0Lmh0bWwNCg0KTWF0dXMNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5h
cm8ub3JnPiANClNlbnQ6IHN0cmVkYSAxNi4gb2t0w7NicmEgMjAxOSAxNzozOA0KVG86IE1hdHVz
IEt5c2VsIDxta3lzZWxAdGFjaHl1bS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCkNjOiBQ
ZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBBbGV4IEJlbm7DqWUgPGFs
ZXguYmVubmVlQGxpbmFyby5vcmc+OyBBdXJlbGllbiBKYXJubyA8YXVyZWxpZW5AYXVyZWwzMi5u
ZXQ+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBBZGRlZCBoYXJkZmxvYXQgY29udmVyc2lvbiBmcm9t
IGZsb2F0MzIgdG8gZmxvYXQ2NA0KDQpPbiAxMC8xNi8xOSAxMjozMiBBTSwgTWF0dXMgS3lzZWwg
d3JvdGU6DQo+ICtmbG9hdDY0IGZsb2F0MzJfdG9fZmxvYXQ2NChmbG9hdDMyIGEsIGZsb2F0X3N0
YXR1cyAqc3RhdHVzKSB7DQo+ICsgICAgaWYgKHVubGlrZWx5KCFmbG9hdDMyX2lzX25vcm1hbChh
KSkpIHsNCj4gKyAgICAgICAgcmV0dXJuIHNvZnRfZmxvYXQzMl90b19mbG9hdDY0KGEsIHN0YXR1
cyk7DQo+ICsgICAgfSBlbHNlIGlmIChmbG9hdDMyX2lzX3plcm8oYSkpIHsNCj4gKyAgICAgICAg
cmV0dXJuIGZsb2F0NjRfc2V0X3NpZ24oZmxvYXQ2NF96ZXJvLCBmbG9hdDMyX2lzX25lZyhhKSk7
DQo+ICsgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgZG91YmxlIHIgPSAqKGZsb2F0ICopJmE7DQo+
ICsgICAgICAgIHJldHVybiAqKGZsb2F0NjQgKikmcjsNCj4gKyAgICB9DQo+ICt9DQoNClRoaXMg
aXMgYSBnb29kIGlkZWEsIHNpbmNlIHRoZXJlIGFyZSBubyBpc3N1ZXMgd2l0aCBpbmV4YWN0IG9y
IHJvdW5kaW5nIHdoZW4gY29udmVydGluZyBpbiB0aGlzIGRpcmVjdGlvbi4NCg0KUGxlYXNlIHVz
ZSB1bmlvbl9mbG9hdHszMiw2NH0gaW5zdGVhZCBvZiBjYXN0aW5nLg0KDQpZb3VyIHNwZWNpYWwg
Y2FzZSBmb3IgMCB3b24ndCBmaXJlLCBzaW5jZSBpdCBpcyBhbHJlYWR5IGZpbHRlcmVkIGJ5ICFm
bG9hdDMyX2lzX25vcm1hbC4NCg0KU28gSSB0aGluayB0aGlzIGNvdWxkIGJlIHdyaXR0ZW4gYXMN
Cg0KICAgIGlmIChsaWtlbHkoZmxvYXQzMl9pc19ub3JtYWwoYSkpKSB7DQogICAgICAgIHVuaW9u
X2Zsb2F0MzIgdWY7DQogICAgICAgIHVuaW9uX2Zsb2F0NjQgdWQ7DQoNCiAgICAgICAgdWYucyA9
IGE7DQogICAgICAgIHVkLmggPSB1Zi5oOw0KICAgICAgICByZXR1cm4gdWQuczsNCiAgICB9IGVs
c2UgaWYgKGZsb2F0MzJfaXNfemVybyhhKSkgew0KICAgICAgICByZXR1cm4gZmxvYXQ2NF9zZXRf
c2lnbihmbG9hdDY0X3plcm8sIGZsb2F0MzJfaXNfbmVnKGEpKTsNCiAgICB9IGVsc2Ugew0KICAg
ICAgICByZXR1cm4gc29mdF9mbG9hdDMyX3RvX2Zsb2F0NjQoYSk7DQogICAgfQ0KDQoNCnJ+DQo=

