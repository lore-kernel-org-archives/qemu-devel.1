Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C294BC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C60215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C60215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEwqg-00086G-G5
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 10:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iEwoe-0006ab-6a
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iEwob-0000t1-Hm
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:38:18 -0400
Resent-Date: Mon, 30 Sep 2019 10:38:18 -0400
Resent-Message-Id: <E1iEwob-0000t1-Hm@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iEwob-0000sP-AG
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:38:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569854284; cv=none; d=zoho.com; s=zohoarc; 
 b=K+p2UIrqswsb6KkriLG84+jaWX3H+R0L7pNyhM+jt1yskLAVVUl+k7zCITgyhRTgYcIIGDQXg/CPCIhitWHZm7XMLyDG2rc/R07aNL4kgSESL2XyjBXNAL/NOaNQe6HHUkf7UVLfwkX0gpYiVBnYqORKgXBUNvmceKmkZ8uCJdc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569854284;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=BPFZBjOHkGslI9/1JCXnDu0hlxvwYTsgxqW43tPY/Vw=; 
 b=fOGa1dNHO0ine8zajwmihcOAFMjGHclUssAV+b3GfqQvg1aljLs/N3eIJ4nIGG8BhPMrIf477Og85Xw6Ct50H7MVwweeqVY2ptKlJvUD2vQAc+Fvo4ysLEcDunciC/6oUSGngq00GjuI6cagkngnR4ccVjX0q8l5LpBt3KC9w7g=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569854282471340.68206473363693;
 Mon, 30 Sep 2019 07:38:02 -0700 (PDT)
Subject: Re: [PATCH 0/5] TriCore fixes and gdbstub
In-Reply-To: <20190930124643.179695-1-kbastian@mail.uni-paderborn.de>
Message-ID: <156985428146.27524.7695022923813487373@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kbastian@mail.uni-paderborn.de
Date: Mon, 30 Sep 2019 07:38:02 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.58
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
Cc: david.brenken@efs-auto.de, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkzMDEyNDY0My4xNzk2
OTUtMS1rYmFzdGlhbkBtYWlsLnVuaS1wYWRlcmJvcm4uZGUvCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDkz
MDEyNDY0My4xNzk2OTUtMS1rYmFzdGlhbkBtYWlsLnVuaS1wYWRlcmJvcm4uZGUKU3ViamVjdDog
W1BBVENIIDAvNV0gVHJpQ29yZSBmaXhlcyBhbmQgZ2Ric3R1YgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhp
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBo
aXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZTBhYjM1
OSB0YXJnZXQvdHJpY29yZTogSW1wbGVtZW50IGdkYnN0dWIKYWY5MDZkNiB0YXJnZXQvdHJpY29y
ZTogSW1wbGVtZW50IHRyaWNvcmVfY3B1X2dldF9waHlzX3BhZ2VfZGVidWcKNDIxYWM4MiB0YXJn
ZXQvdHJpY29yZTogUmFpc2UgRVhDUF9ERUJVRyBpbiBnZW5fZ290b190YigpIGZvciBzaW5nbGVz
dGVwCjVhNmM4NDUgdGFyZ2V0L3RyaWNvcmU6IE1vdmUgdHJhbnNsYXRlIGZlYXR1cmUgY2hlY2sg
dG8gY3R4CjY5ZjEwYjQgdGFyZ2V0L3RyaWNvcmU6IERvbid0IHNhdmUgcGMgaW4gZ2VuZXJhdGVf
cWVtdV9leGNwCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzUgQ2hlY2tpbmcgY29tbWl0IDY5ZjEw
YjRhNGQzOSAodGFyZ2V0L3RyaWNvcmU6IERvbid0IHNhdmUgcGMgaW4gZ2VuZXJhdGVfcWVtdV9l
eGNwKQoyLzUgQ2hlY2tpbmcgY29tbWl0IDVhNmM4NDU0NWY1NiAodGFyZ2V0L3RyaWNvcmU6IE1v
dmUgdHJhbnNsYXRlIGZlYXR1cmUgY2hlY2sgdG8gY3R4KQozLzUgQ2hlY2tpbmcgY29tbWl0IDQy
MWFjODI3MDU0OCAodGFyZ2V0L3RyaWNvcmU6IFJhaXNlIEVYQ1BfREVCVUcgaW4gZ2VuX2dvdG9f
dGIoKSBmb3Igc2luZ2xlc3RlcCkKNC81IENoZWNraW5nIGNvbW1pdCBhZjkwNmQ2NDM3Y2QgKHRh
cmdldC90cmljb3JlOiBJbXBsZW1lbnQgdHJpY29yZV9jcHVfZ2V0X3BoeXNfcGFnZV9kZWJ1ZykK
NS81IENoZWNraW5nIGNvbW1pdCBlMGFiMzU5YTZjOTYgKHRhcmdldC90cmljb3JlOiBJbXBsZW1l
bnQgZ2Ric3R1YikKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9l
cyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNTk6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoK
V0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzEzMzogRklMRTogdGFyZ2V0L3RyaWNv
cmUvZ2Ric3R1Yi5jOjcwOgorc3RhdGljIHZvaWQgdHJpY29yZV9jcHVfZ2RiX3dyaXRlX2NzZnIo
Q1BVVHJpQ29yZVN0YXRlICplbnYsIGludCBuLCB1aW50MzJfdCB2YWwpCgpFUlJPUjogc3BhY2Vz
IHJlcXVpcmVkIGFyb3VuZCB0aGF0ICctJyAoY3R4OlZ4VikKIzE3ODogRklMRTogdGFyZ2V0L3Ry
aWNvcmUvZ2Ric3R1Yi5jOjExNToKKyAgICAgICAgcmV0dXJuIGdkYl9nZXRfcmVnMzIobWVtX2J1
ZiwgZW52LT5ncHJfYVtuLTE2XSk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJy0n
IChjdHg6VnhWKQojMTk2OiBGSUxFOiB0YXJnZXQvdHJpY29yZS9nZGJzdHViLmM6MTMzOgorICAg
ICAgICBlbnYtPmdwcl9kW24tMTZdID0gdG1wOwogICAgICAgICAgICAgICAgICAgICBeCgp0b3Rh
bDogMiBlcnJvcnMsIDIgd2FybmluZ3MsIDE3MCBsaW5lcyBjaGVja2VkCgpQYXRjaCA1LzUgaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5k
IGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTMwMTI0NjQzLjE3OTY5NS0xLWtiYXN0aWFuQG1haWwu
dW5pLXBhZGVyYm9ybi5kZS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=


