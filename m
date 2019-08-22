Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.9 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8122BC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD3E22CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ONok0O94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD3E22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kOe-0001OA-FI
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1i0kGU-0001Is-M6
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1i0kGT-0000JB-0s
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:24:22 -0400
Received: from smtpbg519.qq.com ([203.205.250.45]:52437 helo=smtpbg.qq.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1i0kGR-0000F1-PU
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1566469451;
 bh=N5iDD9U69KkciRhRHq7CpzA8EKo05z6b744Md+cAcTo=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=ONok0O94gOFQC+2lNbi6u606/LUS7Zr/3Eg7xg710VnYvvKg9vTNwbk6tm1CoLOXD
 FU/sqvxaH/1X6piGwXrAdvg7BIQ8WILu0V95fESkLbRaFdiOwqLNmml5emvj9KDabz
 6NmRmIHfNFQAvBITABMrBNh75U+KF0uBW8qQeUPE=
X-QQ-SSF: 000100000000005000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 124.200.70.7
In-Reply-To: <CAL1e-=jUNzu19BBhFq0M_hjxi6BSgfmZUgQMygszTTonORVNmg@mail.gmail.com>
References: <tencent_A4D270EBF3CC4134E8EB55BB9B541724780A@qq.com>
 <CAL1e-=jUNzu19BBhFq0M_hjxi6BSgfmZUgQMygszTTonORVNmg@mail.gmail.com>
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1566469449t845771
From: "=?gb18030?B?waI=?=" <zhlb29@foxmail.com>
To: "=?gb18030?B?QWxla3NhbmRhciBNYXJrb3ZpYw==?=" <aleksandar.m.mail@gmail.com>
Mime-Version: 1.0
Date: Thu, 22 Aug 2019 18:24:09 +0800
X-Priority: 3
Message-ID: <tencent_6386EC2F24D7A13D2B753FCF@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 401260763
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Thu, 22 Aug 2019 18:24:09 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgweb:bgweb5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.205.250.45
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
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
Cc: =?gb18030?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgQWxla3NhbmRhciwNCg0KDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHBhdGll
bnQgZXhwbGFuYXRpb24gaW4gdGhlIHByZXZpb3VzIHBvc3QuIEFuZCB0aGFuayB5b3UgZm9y
IGNoZWNraW5nLg0KWW91ciBhbmQgUGV0ZXIncyByZXBsaWVzIGluIHRoZSBwcmV2aW91cyBw
b3N0IGNlcnRhaW5seSBoZWxwZWQgYSBsb3QuIEkgYW0gbm93IGxvb2tpbmcgYXQgYSBnaXQg
Y29tbWl0IDcgeWVhcnMgYWdvIChiZDI3N2ZhMTk2NmJjNDAwZjFiNDExZjg2OGYzOTEyNWNk
YTBjNDAzKSwgaXQgd2FzIGEgTG9vbmdzb24gTXVsdGltZWRpYSBJbnN0cnVjdGlvbiBpbXBs
ZW1lbnRhdGlvbiBkb25lIG15IFJpY2hhcmQgSGVuZGVyc29uLiBJIHRoaW5rIHdoYXQgaGUg
ZGlkIGlzIGV4YWN0bHkgd2hhdCBJIHdhbnQgdG8gZG8gbm93LiBJIGdvdCBhIHZhZ3VlIHZp
ZXcgb2YgdGhlIGJpZyBwaWN0dXJlLCBidXQgSSBuZWVkIG1vcmUgdGltZSB0byBmaWd1cmUg
b3V0IHRoZSBkZXRhaWxzLiBJIHdpbGwgY2VydGFpbmx5IGFzayBtb3JlIHF1ZXN0aW9ucyBh
Ym91dCB0aGlzIGxhdGVyLCBidXQgYmVmb3JlIHRoYXQgSSBuZWVkIHRvIGxvb2sgYXQgc29t
ZSBvdGhlciBwYXJ0cyBvZiB0aGUgc291cmNlIGNvZGU6KSBBZ2FpbiB0aGFuayB5b3UgZm9y
IGNoZWNraW5nIQ0KDQoNCg0KQ2hlZXJzLA0KTGlibw0KDQoNCg0KDQoNCi0tLS0tLS0tLS0t
LS0tLS0tLSBPcmlnaW5hbCBtZXNzYWdlIC0tLS0tLS0tLS0tLS0tLS0tLQ0KRnJvbTogIkFs
ZWtzYW5kYXIgTWFya292aWMiOyANClNlbmR0aW1lOiBUaHVyc2RheSwgQXVnIDIyLCAyMDE5
IDQ6MjMgUE0NClRvOiAiwaIiOyANCkNjOiAicWVtdS1kZXZlbCI7IA0KU3ViamVjdDogUmU6
IFtRZW11LWRldmVsXSBRRU1VIGFzIElTUyAoSW5zdHJ1Y3Rpb24gU2V0IFNpbXVsYXRvcikN
Cg0KDQoNCk9uIFR1ZSwgQXVnIDIwLCAyMDE5IGF0IDEyOjEyIFBNIMGiIDx6aGxiMjlAZm94
bWFpbC5jb20+IHdyb3RlOg0KDQo+IEkgYW0gd29ya2luZyBvbiBhIHByb2plY3QgdGhhdCBy
ZXF1aXJlcyBtZSB0byBtb2RpZnkgdGhlIElTQSBvZiB0aGUgTUlQUw0KPiB0YXJnZXQuDQoN
Cg0KTC4sDQoNCkhvdyBpcyBpdCBnb2luZz8NCg0KQWxla3NhbmRhcg0KDQoNCg0KPiBJIGhh
dmUgYmVlbiBzdGFyaW5nIGF0IHRoZSBzb3VyY2UgY29kZSBmb3IgYWJvdXQgYSB3ZWVrLCBi
dXQgZm91bmQgaXQNCj4gcmVhbGx5IGRpZmZpY3VsdCBkdWUgdG8gbWUgYmVpbmcgYSB5b3Vu
ZyByb29raWUgYW5kIHRoZSBzcGFyc2UgY29tbWVudHMuDQo+IFNwZWNpZmljYWxseSwgSSBu
ZWVkIHRvIGV4dGVuZCBNSVBTLCBieSBhZGRpbmcgc29tZSBuZXcgaW5zdHJ1Y3Rpb25zIGFu
ZA0KPiBuZXcgQ1BVIHJlZ2lzdGVycyB0byB0aGUgY3VycmVudCBhcmNoaXRlY3R1cmUsIGFu
ZCB0aGF0IHNvdW5kcyByZWFsbHkgZWFzeS4NCj4gSSB0aGluayB0aGUgcGxhY2UgZm9yIG1l
IHRvIGxvb2sgYXQgc2hvdWxkIGJlIGF0IHRoZSBkaXJlY3RvcnkNCj4gJHtxZW11X3Jvb3R9
L3RhcmdldC9taXBzLy4gV2l0aCBhIE1JUFMgSW5zdHJ1Y3Rpb24gU2V0IE1hbnVhbCBSZWxl
YXNlIDYNCj4gaGFuZHksIEkgaGF2ZSBkaWZmaWN1bHR5IGZpbmRpbmcgdGhlIHNvdXJjZSBj
b2RlIHdoZXJlIHRoZSBJU0EgcmVzaWRlcy4gSXMNCj4gaXQgaW4gb3BfaGVscGVyLmM/IE9y
IHRyYW5zbGF0ZS5jPyBBbnkgZ3VpZGFuY2Ugd291bGQgYmUgcmVhbGx5DQo+IGFwcHJlY2lh
dGVkLiBUaGFuayB5b3UgdmVyeSBtdWNoIGluIGFkdmFuY2UuDQo+DQo+DQo+IENoZWVycywN
Cj4gTC4=
