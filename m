Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CD7C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679112051A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="bz9Oyk0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679112051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBGPS-0004QX-I7
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 07:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bauerchen@tencent.com>) id 1jBGOW-00040E-IA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bauerchen@tencent.com>) id 1jBGOT-00069R-Qb
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:16:22 -0400
Received: from mail6.tencent.com ([220.249.245.26]:54041)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bauerchen@tencent.com>)
 id 1jBGOS-00061Q-O0; Mon, 09 Mar 2020 07:16:21 -0400
Received: from EX-SZ022.tencent.com (unknown [10.28.6.88])
 by mail6.tencent.com (Postfix) with ESMTP id EB027CC647;
 Mon,  9 Mar 2020 19:16:43 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
 s=s202002; t=1583752604;
 bh=dVgQ/jHXCdjVfxBStMRyUUIRUvam3nKJ39G7POagSCU=;
 h=From:To:CC:Subject:Date:References;
 b=bz9Oyk0J2n2g0jKvjXZoTXxALy4QRwmDWQRswd0DzfIvrRHWohEU4NqSsArkDLtrT
 QGtm/sei8GUXdx9F8XlwVwWuUwTAfWFbU2guADGTrMC0Lsr3HXzOCorm0sSRcLd+9w
 bHK/jbAKgDvjocPxBQUnEM6QJxGg1REBWZOqbGI4=
Received: from EX-SZ013.tencent.com (10.28.6.37) by EX-SZ022.tencent.com
 (10.28.6.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 9 Mar 2020
 19:16:12 +0800
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ013.tencent.com
 (10.28.6.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 9 Mar 2020
 19:16:10 +0800
Received: from EX-SZ005.tencent.com ([fe80::a42c:28db:54ef:6adf]) by
 EX-SZ005.tencent.com ([fe80::a42c:28db:54ef:6adf%4]) with mapi id
 15.01.1847.007; Mon, 9 Mar 2020 19:16:10 +0800
From: =?utf-8?B?YmF1ZXJjaGVuKOmZiOiSmeiSmSk=?= <bauerchen@tencent.com>
To: borntraeger <borntraeger@de.ibm.com>, pbonzini <pbonzini@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>
Subject: Re: Re: [PATCH] mem-prealloc: initialize cond and mutex(Internet mail)
Thread-Topic: Re: [PATCH] mem-prealloc: initialize cond and mutex(Internet
 mail)
Thread-Index: AQHV85RZkOhBH6vxAEysUkxz/tkQww==
Date: Mon, 9 Mar 2020 11:16:10 +0000
Message-ID: <4976eaee60934e458e105bebe20d4d18@tencent.com>
References: <20200306085014.120669-1-borntraeger@de.ibm.com>,
 <20200309110331.3ef650a9@redhat.com>,
 <13a05c3e-e374-8411-952d-05f4312ad6c0@redhat.com>,
 <d37b122a-1980-32f3-6c06-89e5ef2a4807@de.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [10.28.2.14]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.249.245.26
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, mhartmay <mhartmay@linux.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhhbmtzLCDCoGluIGZhY3QsZG9fdG91Y2hfcGFnZXMgaXMgY2FsbGVkIGp1c3Qgd2hlbiB2bSBz
dGFydHMgdXAsIGJ1dCB1c2luZyBpbml0IGZsYWcgYW5kIEdvbmNlIG1heWJlIG1vcmUgZWxlZ2Fu
dCAhCmlmIG5lZWRlZCxJIGNhbiBzdWJtaXQgYSBuZXcgcGF0Y2ggISAKdGhhbmtzIHZlcnkgbXVj
aCEKCmJhdWVyY2hlbgrCoApGcm9tOsKgQ2hyaXN0aWFuIEJvcm50cmFlZ2VyCkRhdGU6wqAyMDIw
LTAzLTA5wqAxOTowMQpUbzrCoFBhb2xvIEJvbnppbmk7IElnb3IgTWFtbWVkb3YKQ0M6wqBxZW11
LWRldmVsOyBxZW11LXMzOTB4OyBNYXJjIEhhcnRtYXllcjsgYmF1ZXJjaGVuKOmZiOiSmeiSmSkK
U3ViamVjdDrCoFJlOiBbUEFUQ0hdIG1lbS1wcmVhbGxvYzogaW5pdGlhbGl6ZSBjb25kIGFuZCBt
dXRleChJbnRlcm5ldCBtYWlsKQrCoArCoApPbiAwOS4wMy4yMCAxMTowNSwgUGFvbG8gQm9uemlu
aSB3cm90ZToKPiBPbiAwOS8wMy8yMCAxMTowMywgSWdvciBNYW1tZWRvdiB3cm90ZToKPj4+ICvC
oMKgwqAgcWVtdV9jb25kX2luaXQoJnBhZ2VfY29uZCk7Cj4+PiArwqDCoMKgIHFlbXVfbXV0ZXhf
aW5pdCgmcGFnZV9tdXRleCk7Cj4+IElzIGl0IHBvc3NpYmxlIGZvciB0b3VjaF9hbGxfcGFnZXMg
dG8gYmUgY2FsbGVkIHNldmVyYWwgdGltZXM/Cj4+IElmIGl0J3MgdGhlbiBpdCBwcm9iYWJseSBu
ZWVkcyBhIGd1YXJkIGFnYWluc3QgdGhhdCB0byBtYWtlCj4+IHN1cmUgaXQgd29uJ3QgZXhwbG9k
ZSwgc29tZXRoaW5nIGxpa2U6Cj4+Cj4+IHN0YXRpYyBib29sIHBhZ2VfbXV0ZXhfaW5pdGVkOwo+
Pgo+PiBpZihwYWdlX211dGV4X2luaXRlZCkKPj7CoMKgIHBhZ2VfbXV0ZXhfaW5pdGVkID0gdHJ1
ZQo+PsKgwqAgcWVtdV9tdXRleF9pbml0KCZwYWdlX211dGV4KQo+PsKgwqAgLi4uCj4+Cj4KPiBI
bW0sIGdvb2QgaWRlYSwgaXQgc2hvdWxkIGFsc28gdXNlIEdPbmNlLgrCoApNYXliZSBzdGFydCB3
aXRoIGEgcmV2ZXJ0IGFuZCBsZXQgdGhlIG9yaWdpbmFsIHN1Ym1pdHRlciBzZW5kCmEgZml4ZWQg
dXAgcGF0Y2g/CsKgCsKg

