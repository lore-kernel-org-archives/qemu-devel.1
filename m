Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F854C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C862089C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C862089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhsWf-0006YL-OG
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 05:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47730)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hhsWA-00069q-1o
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hhsW8-0000tO-Ie
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:22:33 -0400
Resent-Date: Mon, 01 Jul 2019 05:22:33 -0400
Resent-Message-Id: <E1hhsW8-0000tO-Ie@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hhsW8-0000eM-Aj
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:22:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561972886; cv=none; d=zoho.com; s=zohoarc; 
 b=Y46+STPViBJt5YmhELOXhPJVQvefZaACX25hmY3pc8NUfA03CCtGqFHlm38hwDSl+ZqDskadsAMmNz2/Y67SNi6wu6bKbCqKL+4URdQ6iqgCNeAQtjJCAECoSPYywn8ZFOS+QYEo40DBNziaQk1vnPuoK45CjqwDyRn145R1sAU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561972886;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=kYwGsMedm1Qitv4a2XIstWgdzWDnbpCJ0B9lsSfNRgg=; 
 b=mfzdupNCyKgMiSgYE+LuNgyW+RV475u+r6B0nwOdrd1DjGJnOZ+9ilb141YlD5q14++oTx6bCnEAJyqiFRvXJg/aXRxjAXBwih05AIf2ZUvNoPEuihnBJuEkB8AEiGzvuBjdyoacjAWZa+IvOMFcqFgBqv2QIEwoBCwqnGKpO/Y=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156197288430632.38996398839288;
 Mon, 1 Jul 2019 02:21:24 -0700 (PDT)
Message-ID: <156197288308.9213.13337163072290764145@c4a48874b076>
In-Reply-To: <20190701090904.31312-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ppandit@redhat.com
Date: Mon, 1 Jul 2019 02:21:24 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v2 0/3] restrict bridge interface name to
 IFNAMSIZ
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
Reply-To: qemu-devel@nongnu.org
Cc: rschiron@redhat.com, berrange@redhat.com, pjp@fedoraproject.org,
 jasowang@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwMTA5MDkwNC4zMTMx
Mi0xLXBwYW5kaXRAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA3MDEwOTA5MDQuMzEzMTItMS1wcGFuZGl0QHJl
ZGhhdC5jb20KVHlwZTogc2VyaWVzClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjIgMC8z
XSByZXN0cmljdCBicmlkZ2UgaW50ZXJmYWNlIG5hbWUgdG8gSUZOQU1TSVoKCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxs
IHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdv
cml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4u
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3
LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMTkwNzAxMDkwOTA0
LjMxMzEyLTEtcHBhbmRpdEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAxOTA3MDEwOTA5MDQuMzEz
MTItMS1wcGFuZGl0QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwoz
ZWY5ODgzIG5ldDogdGFwOiByZXN0cmljdCBicmlkZ2UgbmFtZSB0byBJRk5BTVNJWgo2ODFiMjNi
IHFlbXUtYnJpZGdlLWhlbHBlcjogbW92ZSByZXBlYXRpbmcgY29kZSBpbiBwYXJzZV9hY2xfZmls
ZQoxMjkzZThjIHFlbXUtYnJpZGdlLWhlbHBlcjogcmVzdHJpY3QgaW50ZXJmYWNlIG5hbWUgdG8g
SUZOQU1TSVoKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMyBDaGVja2luZyBjb21taXQgMTI5M2U4
Yzc3ZjBkIChxZW11LWJyaWRnZS1oZWxwZXI6IHJlc3RyaWN0IGludGVyZmFjZSBuYW1lIHRvIElG
TkFNU0laKQoyLzMgQ2hlY2tpbmcgY29tbWl0IDY4MWIyM2IzN2U3MyAocWVtdS1icmlkZ2UtaGVs
cGVyOiBtb3ZlIHJlcGVhdGluZyBjb2RlIGluIHBhcnNlX2FjbF9maWxlKQozLzMgQ2hlY2tpbmcg
Y29tbWl0IDNlZjk4ODMxNzFhZSAobmV0OiB0YXA6IHJlc3RyaWN0IGJyaWRnZSBuYW1lIHRvIElG
TkFNU0laKQpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcrJyAoY3R4OlZ4VikK
IzI3OiBGSUxFOiBuZXQvdGFwLmM6NTAyOgorICAgICAgICBjaGFyIGJyX2J1Zls1K0lGTkFNU0la
XSA9IHswfTsKICAgICAgICAgICAgICAgICAgICAgIF4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJu
aW5ncywgOCBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MTkwNzAxMDkwOTA0LjMxMzEyLTEtcHBhbmRpdEByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRj
aC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


