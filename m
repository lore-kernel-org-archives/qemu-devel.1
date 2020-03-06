Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB804C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6705D2072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="EvQLS9FB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6705D2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA9kP-0007n3-DS
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 04:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bauerchen@tencent.com>) id 1jA9jc-0007Nr-NL
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bauerchen@tencent.com>) id 1jA9jT-0002pK-8g
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:57:28 -0500
Received: from mail6.tencent.com ([220.249.245.26]:55528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bauerchen@tencent.com>)
 id 1jA9jP-0002GI-KU; Fri, 06 Mar 2020 04:57:27 -0500
Received: from EX-SZ019.tencent.com (unknown [10.28.6.74])
 by mail6.tencent.com (Postfix) with ESMTP id 1FED3CC538;
 Fri,  6 Mar 2020 17:57:45 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
 s=s202002; t=1583488665;
 bh=vXRGqYLfLn+t2valEtnzd7cHE0AuNyj6JvhmbRRLP6s=;
 h=From:To:CC:Subject:Date:References;
 b=EvQLS9FBiYls8vNJNcPG5EZ+GgxvJyhsQ29cjG6yRxBHIwKqNArQ3XOi3LOdGCGWf
 PACkfkgmAmbIFlfpPv9y3UwZQw7GRuiqYTLDDTTYxh9MfhlBff0kIqHAL57Uqpqsw9
 HEJlKmLl/kuuqi6X75qxsT+POrNd3dyIz1GQkAG4=
Received: from EX-SZ008.tencent.com (10.28.6.32) by EX-SZ019.tencent.com
 (10.28.6.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 6 Mar 2020
 17:57:14 +0800
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ008.tencent.com
 (10.28.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 6 Mar 2020
 17:57:14 +0800
Received: from EX-SZ005.tencent.com ([fe80::ed4f:20ce:ec0d:e637]) by
 EX-SZ005.tencent.com ([fe80::ed4f:20ce:ec0d:e637%4]) with mapi id
 15.01.1713.004; Fri, 6 Mar 2020 17:57:14 +0800
From: =?utf-8?B?YmF1ZXJjaGVuKOmZiOiSmeiSmSk=?= <bauerchen@tencent.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel
 <qemu-devel@nongnu.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG1lbS1wcmVhbGxvYzogaW5pdGlhbGl6ZSBjb25k?=
 =?utf-8?Q?_and_mutex(Internet_mail)?=
Thread-Topic: [PATCH] mem-prealloc: initialize cond and mutex(Internet mail)
Thread-Index: AQHV85RZkOhBH6vxAEysUkxz/tkQww==
Date: Fri, 6 Mar 2020 09:57:13 +0000
Message-ID: <cd400f3194624bc6905384ba7cbb4a9e@tencent.com>
References: <20200306085014.120669-1-borntraeger@de.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.120]
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 pbonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VmVyeSBzb3JyeSBmb3IgbXkgZmF1bHQsIGluIGZhY3QsSSB0ZXN0IMKgaW4gYSBvbGQgcWVtdSB2
ZXJzaW9uICxhbmQgcGF0Y2ggZ2VuZXJhdGVkIGJhc2VkIGEgbmV3IG9uZSA7wqAKQWxsIGluIGFs
bO+8jGl0cyBteSBmYXVsdCwgYW5kIEkgd2lsbCBjaGVjayBhbmQgdGVzdCBwYXRjaCBjYXJlZnVs
bHkgSW4gdGhlIGZ1dHVyZQpJZiBJIMKgbmVlZCB0byDCoHN1Ym1pdCB0aGUgcGF0Y2ggYWdhaW4g
PwoKwqAKCsKgCuWPkeS7tuS6uu+8msKgQ2hyaXN0aWFuIEJvcm50cmFlZ2VyCuWPkemAgeaXtumX
tO+8msKgMjAyMC0wMy0wNsKgMTY6NTAK5pS25Lu25Lq677yawqBxZW11LWRldmVsCuaKhOmAge+8
msKgcWVtdS1zMzkweDsgQ2hyaXN0aWFuIEJvcm50cmFlZ2VyOyBiYXVlcmNoZW4o6ZmI6JKZ6JKZ
KTsgUGFvbG8gQm9uemluaTsgTWFyYyBIYXJ0bWF5ZXIK5Li76aKY77yawqBbUEFUQ0hdIG1lbS1w
cmVhbGxvYzogaW5pdGlhbGl6ZSBjb25kIGFuZCBtdXRleChJbnRlcm5ldCBtYWlsKQpHdWVzdHMg
d2l0aCBtZW0tcHJlYWxsb2MgZG8gZmFpbCB3aXRoCnFlbXUtc3lzdGVtLXMzOTB4OiAvaG9tZS9j
Ym9ybnRyYS9SRVBPUy9xZW11L3V0aWwvcWVtdS10aHJlYWQtcG9zaXguYzo3NjogcWVtdV9tdXRl
eF9sb2NrX2ltcGw6IEFzc2VydGlvbiBgbXV0ZXgtPmluaXRpYWxpemVkJyBmYWlsZWQuCnFlbXUt
c3lzdGVtLXMzOTB4OiAvaG9tZS9jYm9ybnRyYS9SRVBPUy9xZW11L3V0aWwvcWVtdS10aHJlYWQt
cG9zaXguYzoxNjE6IHFlbXVfY29uZF9icm9hZGNhc3Q6IEFzc2VydGlvbiBgY29uZC0+aW5pdGlh
bGl6ZWQnIGZhaWxlZC4KwqAKTGV0IHVzIGluaXRpYWxpemUgY29uZCBhbmQgbXV0ZXguCsKgCkNj
OiBiYXVlcmNoZW4gPGJhdWVyY2hlbkB0ZW5jZW50LmNvbT4KQ2M6IFBhb2xvIEJvbnppbmkgPHBi
b256aW5pQHJlZGhhdC5jb20+ClJlcG9ydGVkLWJ5OiBNYXJjIEhhcnRtYXllciA8bWhhcnRtYXlA
bGludXguaWJtLmNvbT4KRml4ZXM6IDAzN2ZiNWViMzk0MSAoIm1lbS1wcmVhbGxvYzogb3B0aW1p
emUgbGFyZ2UgZ3Vlc3Qgc3RhcnR1cCIpClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBCb3JudHJh
ZWdlciA8Ym9ybnRyYWVnZXJAZGUuaWJtLmNvbT4KLS0tCnV0aWwvb3NsaWItcG9zaXguYyB8IDIg
KysKMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQrCoApkaWZmIC0tZ2l0IGEvdXRpbC9v
c2xpYi1wb3NpeC5jIGIvdXRpbC9vc2xpYi1wb3NpeC5jCmluZGV4IDg5N2U4ZjNiYTYuLjUyNjUw
MTgzZDMgMTAwNjQ0Ci0tLSBhL3V0aWwvb3NsaWItcG9zaXguYworKysgYi91dGlsL29zbGliLXBv
c2l4LmMKQEAgLTQ3MCw2ICs0NzAsOCBAQCBzdGF0aWMgYm9vbCB0b3VjaF9hbGxfcGFnZXMoY2hh
ciAqYXJlYSwgc2l6ZV90IGhwYWdlc2l6ZSwgc2l6ZV90IG51bXBhZ2VzLArCoMKgwqDCoCBjaGFy
ICphZGRyID0gYXJlYTsKwqDCoMKgwqAgaW50IGkgPSAwOworwqDCoMKgIHFlbXVfY29uZF9pbml0
KCZwYWdlX2NvbmQpOworwqDCoMKgIHFlbXVfbXV0ZXhfaW5pdCgmcGFnZV9tdXRleCk7CsKgwqDC
oMKgIG1lbXNldF90aHJlYWRfZmFpbGVkID0gZmFsc2U7CsKgwqDCoMKgIHRocmVhZHNfY3JlYXRl
ZF9mbGFnID0gZmFsc2U7CsKgwqDCoMKgIG1lbXNldF9udW1fdGhyZWFkcyA9IGdldF9tZW1zZXRf
bnVtX3RocmVhZHMoc21wX2NwdXMpOwotLQoyLjI1LjAKwqAKwqA=

