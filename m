Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486E7C11D00
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 23:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1FC20801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 23:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1FC20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4vIz-0006QW-8h
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 18:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j4vIH-0005yb-Hr
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 18:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j4vIF-0002xM-J3
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 18:31:45 -0500
Resent-Date: Thu, 20 Feb 2020 18:31:45 -0500
Resent-Message-Id: <E1j4vIF-0002xM-J3@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j4vIF-0002wE-Bi; Thu, 20 Feb 2020 18:31:43 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1582241493; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IBZx4vvC2CcPSCDpcoKEeD7raB91ny277podRleZjP0/CBDymKleG7HRi9hfmjrIMLh7hGAJgv38MEX+I9UKmXK55lk9k0TPtpj1WEQygDFS4ZUcjiGFVufWfi5Hc3aXx6R0V/NJjF7uT3Bs+crWZzPISJeXN06+TkTdIVdtQQw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1582241493;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=DybI+LTU4t5xk9booofuIZWmeqXuhmJDgSjNIXyx85I=; 
 b=iQ3w8lJQLWZG6tRYd9JYn+cBa7ao7cohSiA8xH9wotSRnR3WMlS0jAxe9xRR5L5OfCms6egelx6DMwWT8o9j5v+/4Hqmyh6LQtYo0JCpsqGUiSkVvrR36hOeWX3/DDES68MpyeO9hM1gp3XH78vUaJXJ4KjNtPciUStwHAaAnEk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1582241491341404.01756982908;
 Thu, 20 Feb 2020 15:31:31 -0800 (PST)
In-Reply-To: <cover.1582240656.git.alistair.francis@wdc.com>
Subject: Re: [PATCH v1 0/2]  linux-user: generate syscall_nr.sh for RISC-V
Message-ID: <158224149003.31180.5954402657995887989@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alistair.francis@wdc.com
Date: Thu, 20 Feb 2020 15:31:31 -0800 (PST)
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, laurent@vivier.eu,
 alistair.francis@wdc.com, alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTgyMjQwNjU2Lmdp
dC5hbGlzdGFpci5mcmFuY2lzQHdkYy5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2MSAwLzJdICBsaW51eC11c2VyOiBnZW5l
cmF0ZSBzeXNjYWxsX25yLnNoIGZvciBSSVNDLVYKTWVzc2FnZS1pZDogY292ZXIuMTU4MjI0MDY1
Ni5naXQuYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwg
fHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29y
aXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4K
PT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFk
ZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0
L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy9jb3Zlci4xNTgyMjQwNjU2LmdpdC5h
bGlzdGFpci5mcmFuY2lzQHdkYy5jb20gLT4gcGF0Y2hldy9jb3Zlci4xNTgyMjQwNjU2LmdpdC5h
bGlzdGFpci5mcmFuY2lzQHdkYy5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwph
OGY5NWZmIGxpbnV4LXVzZXIvcmlzY3Y6IFVwZGF0ZSB0aGUgc3lzY2FsbF9ucidzIHRvIHRoZSA1
LjUga2VybmVsCjhmMzE5ZmUgbGludXgtdXNlcjogUHJvdGVjdCBtb3JlIHN5c2NhbGxzCgo9PT0g
T1VUUFVUIEJFR0lOID09PQoxLzIgQ2hlY2tpbmcgY29tbWl0IDhmMzE5ZmU0MDQ0ZiAobGludXgt
dXNlcjogUHJvdGVjdCBtb3JlIHN5c2NhbGxzKQpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZXR3
ZWVuIGZ1bmN0aW9uIG5hbWUgYW5kIG9wZW4gcGFyZW50aGVzaXMgJygnCiM3NTogRklMRTogbGlu
dXgtdXNlci9zeXNjYWxsLmM6MTA4ODoKKyNpZiBkZWZpbmVkKFRBUkdFVF9OUl9nZXRybGltaXQp
IHx8IGRlZmluZWQgKFRBUkdFVF9OUl91Z2V0cmxpbWl0KQoKdG90YWw6IDEgZXJyb3JzLCAwIHdh
cm5pbmdzLCAxMjEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS8yIGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgoyLzIgQ2hlY2tpbmcgY29tbWl0IGE4Zjk1ZmY3OGQyMCAobGludXgtdXNlci9yaXNj
djogVXBkYXRlIHRoZSBzeXNjYWxsX25yJ3MgdG8gdGhlIDUuNSBrZXJuZWwpCldBUk5JTkc6IEJs
b2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiMzNzc6IEZJ
TEU6IGxpbnV4LXVzZXIvcmlzY3Yvc3lzY2FsbF9uci5oOjQ0MjoKKy8qIEFsaWFzIHNvbWUgb2Yg
dGhlIG9sZGVyIHByZSA2NC1iaXQgdGltZV90IHN5c2NhbGxzIHRvIHRoZSA2NC1iaXQKCldBUk5J
Tkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIHRyYWlsaW5nICovIG9uIGEgc2VwYXJhdGUgbGluZQoj
Mzc4OiBGSUxFOiBsaW51eC11c2VyL3Jpc2N2L3N5c2NhbGxfbnIuaDo0NDM6CisgKiBvbmVzIGZv
ciBSVjMyLiBUaGlzIGlzIGJhc2VkIG9uIHRoZSBsaXN0IHVzZWQgYnkgZ2xpYmMuICovCgp0b3Rh
bDogMCBlcnJvcnMsIDIgd2FybmluZ3MsIDM3MCBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzIgaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQg
ZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvY292ZXIuMTU4MjI0MDY1Ni5naXQuYWxpc3RhaXIuZnJhbmNpc0B3
ZGMuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

