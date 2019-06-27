Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A148C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552C42064A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552C42064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgYAB-0001BT-MC
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 13:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52263)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Mina_Magdy@mentor.com>) id 1hgXUZ-0004zT-LW
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Mina_Magdy@mentor.com>) id 1hgXUY-000362-MI
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:43:23 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:47246)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Mina_Magdy@mentor.com>)
 id 1hgXUY-000320-FQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:43:22 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2]
 helo=SVR-IES-MBX-03.mgc.mentorg.com)
 by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
 id 1hgXUS-0006Nn-Om from Mina_Magdy@mentor.com ;
 Thu, 27 Jun 2019 09:43:16 -0700
Received: from SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) by
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 27 Jun 2019 17:43:13 +0100
Received: from SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17]) by
 SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17%22]) with
 mapi id 15.00.1320.000; Thu, 27 Jun 2019 17:43:13 +0100
From: "Magdy, Mina" <Mina_Magdy@mentor.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: PATCH RISU
Thread-Index: AdUtBw4VrTJzIOT8SVGtMtYnH3BJHg==
Date: Thu, 27 Jun 2019 16:43:12 +0000
Message-ID: <8b827ea614a44810a60e806ddd9c5da5@SVR-IES-MBX-03.mgc.mentorg.com>
Accept-Language: en-US, en-IE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 192.94.38.131
X-Mailman-Approved-At: Thu, 27 Jun 2019 13:24:48 -0400
Subject: [Qemu-devel] PATCH RISU
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGVsbG8gYWxsLA0KDQpJJ20gY3VycmVudGx5IHRyeWluZyB0byB1c2UgUklTVSBmb3IgcHBjNjQg
YXJjaGl0ZWN0dXJlIGJ1dCBzdGlsbCBoYXZpbmcgc29tZSBpc3N1ZXMgZGVzcGl0ZSB1cGRhdGlu
ZyB0aGUgcmVwbyB0byB0aGUgbGF0ZXN0IG9uZSB0aGF0IGluY2x1ZGUgdGhlIGNvbW1pdCB0aGF0
IG1heSBiZSBjYXVzZWQgdGhlIGlzc3VlLiBTbyBJIHRoaW5rIHRoYXQgdGhlcmUncyBzb21ldGhp
bmcgdGhhdCBjYXVzZWQgdGhhdCBlcnJvciByZWxhdGVkIHRvIGEgbWlzc2luZyBoZWFkZXIuDQpT
byBJJ20gd29uZGVyaW5nIGlmIHRoZSBmaXggY291bGQgYmUgZG9uZSBhcyBhIHBhdGNoIGZvciBS
SVNVIHdoaWNoIHdpbGwgYmUgZ3JlYXQuDQoNClJlZ2FyZHMsDQpNaW5hLg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUGV0ZXIgTWF5ZGVsbCBbbWFpbHRvOnBldGVyLm1heWRl
bGxAbGluYXJvLm9yZ10gDQpTZW50OiBTdW5kYXksIEp1bmUgMjMsIDIwMTkgMTI6NDUgUE0NClRv
OiBNYWdkeSwgTWluYSA8TWluYV9NYWdkeUBtZW50b3IuY29tPg0KU3ViamVjdDogUmU6IFBQQyBS
SVNVIENvbXBpbGF0aW9uIGVycm9ycw0KDQpPbiBTdW4sIDIzIEp1biAyMDE5IGF0IDExOjAyLCBN
YWdkeSwgTWluYSA8TWluYV9NYWdkeUBtZW50b3IuY29tPiB3cm90ZToNCj4gSeKAmW0gd3JpdGlu
ZyB0byB5b3UgdG8gYXNrIGZvciBhbiBpc3N1ZXMgdGhhdCBJIGVuY291bnRlcmVkIHdoaWxlIHVz
aW5nIFJJU1UgZm9yIFBQQy4NCj4NCj4gRHVyaW5nIHRoZSBjb25maWd1cmF0aW9uIGZvciBhcmNo
aXRlY3R1cmUgcHBjNjQgYW5kIHVzaW5nIHBvd2VycGMtbGludXgtZ251IHRvb2xjaGFpbiwgSSBm
b3VuZCBzb21lIGlzc3VlcyB0aGF0IHJlbGF0ZWQgdG8gc2V0X3Vjb250ZXh0X3BhcmFtcmVnIGZ1
bmN0aW9uOg0KPiByaXN1X3BwYzY0LmM6IEluIGZ1bmN0aW9uICdzZXRfdWNvbnRleHRfcGFyYW1y
ZWcnOg0KPg0KPiByaXN1X3BwYzY0LmM6Mjc6MjA6IGVycm9yOiAndW5pb24gdWNfcmVnc19wdHIn
IGhhcyBubyBtZW1iZXIgbmFtZWQgJ2dwX3JlZ3MnOyBkaWQgeW91IG1lYW4gJ3VjX3JlZ3MnPw0K
DQpIaSAtLSB0cnkgdXBkYXRpbmcgeW91ciByaXN1IHRvIHRoZSBtb3N0IHJlY2VudCBnaXQgY29t
bWl0IC0tIHRoZSByZWNlbnQgY29tbWl0IDIyNzM1YWJmYzk5MjQwYyBmaXhlZCBhIHBwYzY0IGNv
bXBpbGUgZXJyb3Igd2hpY2ggc291bmRzIGxpa2UgdGhhdCBvbmUuIElmIHlvdSdyZSBzdGlsbCBo
YXZpbmcgYSBwcm9ibGVtIHdpdGggdGhhdCBjb21taXQsIGl0J3MgbGlrZWx5IHNvbWV0aGluZyBk
dWUgdG8gdGhlIHBhcnRpY3VsYXIgc2V0IG9mIGhlYWRlcnMgeW91J3JlIGNvbXBpbGluZyBhZ2Fp
bnN0IC0tIEknbSBoYXBweSB0byB0YWtlIHBhdGNoZXMgdG8gZml4IHRoYXQga2luZCBvZiB0aGlu
ZyAobWFpbCB0aGVtIHRvIHFlbXUtZGV2ZWwsIHdpdGggYSBbUEFUQ0ggUklTVV0gdGFnIGFuZCBj
YyBtZSkuDQoNCnRoYW5rcw0KLS0gUE1NDQo=

