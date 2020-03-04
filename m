Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A3AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785E120870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785E120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9VaC-0006jc-JC
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 10:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j9VZV-0006JY-4d
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j9VZT-00044h-DB
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:04:28 -0500
Resent-Date: Wed, 04 Mar 2020 10:04:28 -0500
Resent-Message-Id: <E1j9VZT-00044h-DB@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j9VZS-00040r-FR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:04:26 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1583334251; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZgDbl0lWkuIkEr/XrXCfPKZSkaaXX7vC1o/BS03V2hcKid3eesZWrT022J1yNn20Fxyr85xLSaSXh6P0vZJ3rNlyd5MIYjgFmS3QUI2ncncWJ07NkqeL/WDYVXy2W/8eMqvtpjepBV/17w1ViRq/afr9StjgRygJcjFubR5ydto=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583334251;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=N86vLXN82zMWz0o5cH5pLQz9EmGlZJXYwR60eKXnGFU=; 
 b=UwqyaPe+iFaFn2F/+Ey8utwjLB/+h369I5uX5nk4EJm4Ii0xz7ozyutfYcrUTu/cm/QxFVSZV4sFQ9sg+++dobBz2QVMmENUUugpxgq0ZuMkjQa+TYy5DLVqDTqmYNqBj6HZv5SkZktCv3rKwcRki7ZnyYnY9KYjcJ68sR71WR8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583334247572164.4891805943339;
 Wed, 4 Mar 2020 07:04:07 -0800 (PST)
In-Reply-To: <20200304145003.GB15649@humpty.home.comstyle.com>
Subject: Re: [PATCH] audio: Add sndio backend
Message-ID: <158333424649.21741.12510392429749383012@abdcc9e1aa82>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: brad@comstyle.com
Date: Wed, 4 Mar 2020 07:04:07 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMwNDE0NTAwMy5HQjE1
NjQ5QGh1bXB0eS5ob21lLmNvbXN0eWxlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSBhdWRpbzogQWRkIHNuZGlvIGJhY2tl
bmQKTWVzc2FnZS1pZDogMjAyMDAzMDQxNDUwMDMuR0IxNTY0OUBodW1wdHkuaG9tZS5jb21zdHls
ZS5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
RnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWdd
ICAgICAgICAgcGF0Y2hldy8yMDIwMDMwNDE0NTAwMy5HQjE1NjQ5QGh1bXB0eS5ob21lLmNvbXN0
eWxlLmNvbSAtPiBwYXRjaGV3LzIwMjAwMzA0MTQ1MDAzLkdCMTU2NDlAaHVtcHR5LmhvbWUuY29t
c3R5bGUuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNDIxYWI2MiBhdWRpbzog
QWRkIHNuZGlvIGJhY2tlbmQKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBzcGFjZSBwcm9o
aWJpdGVkIGJlZm9yZSB0aGF0IGNsb3NlIHBhcmVudGhlc2lzICcpJwojNDE6IEZJTEU6IGF1ZGlv
L2F1ZGlvLmM6MTk3NzoKKyAgICAgICAgQ0FTRShTTkRJTywgc25kaW8sICk7CgpXQVJOSU5HOiBh
ZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBk
YXRpbmc/CiM1OTogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogZ19mcmVlKE5VTEwpIGlz
IHNhZmUgdGhpcyBjaGVjayBpcyBwcm9iYWJseSBub3QgcmVxdWlyZWQKIzM4MTogRklMRTogYXVk
aW8vc25kaW9hdWRpby5jOjMxODoKKyAgICBpZiAoc2VsZi0+cGZkcykgeworICAgICAgICBnX2Zy
ZWUoc2VsZi0+cGZkcyk7CgpFUlJPUjogZ19mcmVlKE5VTEwpIGlzIHNhZmUgdGhpcyBjaGVjayBp
cyBwcm9iYWJseSBub3QgcmVxdWlyZWQKIzM4NjogRklMRTogYXVkaW8vc25kaW9hdWRpby5jOjMy
MzoKKyAgICBpZiAoc2VsZi0+cGluZGV4ZXMpIHsKKyAgICAgICAgZ19mcmVlKHNlbGYtPnBpbmRl
eGVzKTsKCkVSUk9SOiBnX2ZyZWUoTlVMTCkgaXMgc2FmZSB0aGlzIGNoZWNrIGlzIHByb2JhYmx5
IG5vdCByZXF1aXJlZAojMzkxOiBGSUxFOiBhdWRpby9zbmRpb2F1ZGlvLmM6MzI4OgorICAgIGlm
IChzZWxmLT5idWYpIHsKKyAgICAgICAgZ19mcmVlKHNlbGYtPmJ1Zik7Cgp0b3RhbDogNCBlcnJv
cnMsIDEgd2FybmluZ3MsIDc4MCBsaW5lcyBjaGVja2VkCgpDb21taXQgNDIxYWI2MmMxNjliIChh
dWRpbzogQWRkIHNuZGlvIGJhY2tlbmQpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmll
dy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhl
bSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMzA0MTQ1
MDAzLkdCMTU2NDlAaHVtcHR5LmhvbWUuY29tc3R5bGUuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

