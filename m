Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D48C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA9E2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA9E2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnL3d-0001E4-Kw
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 06:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55335)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hnL3S-0000oV-FX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hnL3R-0006Xs-8s
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:51:30 -0400
Resent-Date: Tue, 16 Jul 2019 06:51:30 -0400
Resent-Message-Id: <E1hnL3R-0006Xs-8s@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hnL3R-0006TM-0i; Tue, 16 Jul 2019 06:51:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563274273; cv=none; d=zoho.com; s=zohoarc; 
 b=ktC6XGE5A3CKwJO8EIFKmrrctiDw9G0DGQ6uerNqXj/ROStsewCjI87DXRv90BAiTvCyJRC11GNqU7Em7qaYB8mzRyVsLGdpIh1yHW8r4t94KcscZIxy8T7fClypLFcNOo9eQs/iIyks+WXsonpVWWxfGumF5LGQF1SPctHpLgM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1563274273;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=qlF8OI/G5DIuUscA9IDvT8i0dF594GVXtsPsxW5XHS4=; 
 b=WAVbYuFjOcWHD3pvZ9jTB6tYG4cqBdx+apTxPdmxqwSOEBmh1D8ScfghfXqIVp1XWV53kMcqNLW3Hkyd7uUBgmyhzgrfP7CkbgMEpXBB3YWCo84fgzxSstKy6xEfWNmSt4EKTqwivnNaX/VJn1d4rw28oaQ0ycTUSd6YySbRUvY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1563274271673576.6774481441985;
 Tue, 16 Jul 2019 03:51:11 -0700 (PDT)
Message-ID: <156327427033.3080.4007866092680967266@c4a48874b076>
In-Reply-To: <20190715142304.215018-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: borntraeger@de.ibm.com
Date: Tue, 16 Jul 2019 03:51:11 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH 0/3] s390x/cpumodel fixes for 4.1
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
Cc: david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxNTE0MjMwNC4yMTUw
MTgtMS1ib3JudHJhZWdlckBkZS5pYm0uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDE5MDcxNTE0MjMwNC4yMTUwMTgtMS1ib3Ju
dHJhZWdlckBkZS5pYm0uY29tClR5cGU6IHNlcmllcwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BB
VENIIDAvM10gczM5MHgvY3B1bW9kZWwgZml4ZXMgZm9yIDQuMQoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhp
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBo
aXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVj
dC9xZW11CiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA3MTUxNDIzMDQu
MjE1MDE4LTEtYm9ybnRyYWVnZXJAZGUuaWJtLmNvbSAtPiBwYXRjaGV3LzIwMTkwNzE1MTQyMzA0
LjIxNTAxOC0xLWJvcm50cmFlZ2VyQGRlLmlibS5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNo
ICd0ZXN0Jwo3YmM0MzZkM2VkIHMzOTB4L2NwdW1vZGVsOiBjaGFuZ2UgaW50ZXJuYWwgbmFtZSBv
ZiB2eHAgdG8gbWFrZSBkZXNjcmlwdGlvbgo2YjA0NzRiYmIzIHMzOTB4L2NwdW1vZGVsOiBhbHNv
IGNoYW5nZSBuYW1lIG9mIHZ4YmVoCjJhMzQ0NTU1NWEgczM5MHgvY3B1bW9kZWw6IHJlbW92ZSBl
c29ydCBmcm9tIHRoZSBkZWZhdWx0IG1vZGVsCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzMgQ2hl
Y2tpbmcgY29tbWl0IDJhMzQ0NTU1NWE1NSAoczM5MHgvY3B1bW9kZWw6IHJlbW92ZSBlc29ydCBm
cm9tIHRoZSBkZWZhdWx0IG1vZGVsKQoyLzMgQ2hlY2tpbmcgY29tbWl0IDZiMDQ3NGJiYjNlYyAo
czM5MHgvY3B1bW9kZWw6IGFsc28gY2hhbmdlIG5hbWUgb2YgdnhiZWgpCldBUk5JTkc6IGxpbmUg
b3ZlciA4MCBjaGFyYWN0ZXJzCiMyOTogRklMRTogdGFyZ2V0L3MzOTB4L2NwdV9mZWF0dXJlc19k
ZWYuaW5jLmg6MTA3OgorREVGX0ZFQVQoVkVDVE9SX0JDRF9FTkgsICJ2eHAiLCBTVEZMLCAxNTIs
ICJWZWN0b3ItUGFja2VkLURlY2ltYWwtRW5oYW5jZW1lbnQgRmFjaWxpdHkiKQoKdG90YWw6IDAg
ZXJyb3JzLCAxIHdhcm5pbmdzLCA4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvMyBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgozLzMgQ2hlY2tpbmcgY29tbWl0IDdiYzQzNmQzZWRhNCAoczM5MHgv
Y3B1bW9kZWw6IGNoYW5nZSBpbnRlcm5hbCBuYW1lIG9mIHZ4cCB0byBtYWtlIGRlc2NyaXB0aW9u
KQpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzIyOiBGSUxFOiB0YXJnZXQvczM5MHgv
Y3B1X2ZlYXR1cmVzX2RlZi5pbmMuaDoxMDc6CitERUZfRkVBVChWRUNUT1JfUEFDS0VEX0RFQ0lN
QUxfRU5ILCAidnhwIiwgU1RGTCwgMTUyLCAiVmVjdG9yLVBhY2tlZC1EZWNpbWFsLUVuaGFuY2Vt
ZW50IEZhY2lsaXR5IikKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMjQgbGluZXMgY2hl
Y2tlZAoKUGF0Y2ggMy8zIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVO
RCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDcxNTE0MjMwNC4yMTUw
MTgtMS1ib3JudHJhZWdlckBkZS5pYm0uY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==


