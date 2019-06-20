Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D2EC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8A62082C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8A62082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdwRb-0004bC-SD
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 08:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33657)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hdw37-0001Vc-QU
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hdvn1-00021l-Su
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:05:31 -0400
Resent-Date: Thu, 20 Jun 2019 08:05:26 -0400
Resent-Message-Id: <E1hdvn1-00021l-Su@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hdvn1-00020g-9v
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:03:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561031291; cv=none; d=zoho.com; s=zohoarc; 
 b=l9UuArZBcbpqwTK1yeBM5SHNCPMe6xtuaTNo4ZpM/l1zAIdieHa1rAJYophWK0ymycT25DHsPsgpwAdDSjJ58xsAHWv90lrxBCjRU6Q7YH4IWrOWliMID0rPDHgAF5Yyxx7BzKFRNOn/1YlYTBp6KjYgG+f9tqk4VsPihFUtgq8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561031291;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=9dJCUKucPIlgIjLoRxlvJZp0QYuPYFhD4IrJU2TvAcU=; 
 b=PeIitu7F/vrk29e1R1D693bETH2IO90zeSftZ9T4Jz3Jnodj084ctOzfyC51r+m64NVOdygohmj+/xftR7cUtbNg4RgfLReBVQLAnjv1Rg1ESIJqWXpH66c9r89azz0yGWWQMTgHm9PfotUPRwcJABePKMGw7AEQwshsrsLfDew=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561031290082234.56799315419744;
 Thu, 20 Jun 2019 04:48:10 -0700 (PDT)
In-Reply-To: <1561024929-26004-1-git-send-email-aleksandar.markovic@rt-rk.com>
Message-ID: <156103128907.29212.16492157818835353028@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Thu, 20 Jun 2019 04:48:10 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v3 0/4] target/mips: Misc fixes and
 maintenance for 4.1
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
Cc: arikalo@wavecomp.com, qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYxMDI0OTI5LTI2MDA0LTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91
dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBb
UEFUQ0ggdjMgMC80XSB0YXJnZXQvbWlwczogTWlzYyBmaXhlcyBhbmQgbWFpbnRlbmFuY2UgZm9y
IDQuMQpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMTU2MTAyNDkyOS0yNjAwNC0xLWdpdC1zZW5k
LWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0
L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8xNTYxMDI0OTI5LTI2MDA0
LTEtZ2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20gLT4gcGF0Y2hl
dy8xNTYxMDI0OTI5LTI2MDA0LTEtZ2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0By
dC1yay5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwozMTdmNDQ5MTZjIHRhcmdl
dC9taXBzOiBGaXggaWYtZWxzZS1zd2l0Y2gtY2FzZSBhcm1zIGNoZWNrcGF0Y2ggZXJyb3JzIGlu
IHRyYW5zbGF0ZS5jCjYyZDg0ZGU2MDMgdGFyZ2V0L21pcHM6IEZpeCBzb21lIHNwYWNlIGNoZWNr
cGF0Y2ggZXJyb3JzIGluIHRyYW5zbGF0ZS5jCjVmOTBlYTA2ZDUgTUFJTlRBSU5FUlM6IENvbnNv
bGlkYXRlIE1JUFMgZGlzYXNzZW1ibGVyLXJlbGF0ZWQgaXRlbXMKZmIyYTcyZDRjZiBNQUlOVEFJ
TkVSUzogVXBkYXRlIGZpbGUgaXRlbXMgZm9yIE1JUFMgTWFsdGEgYm9hcmQKCj09PSBPVVRQVVQg
QkVHSU4gPT09CjEvNCBDaGVja2luZyBjb21taXQgZmIyYTcyZDRjZmZkIChNQUlOVEFJTkVSUzog
VXBkYXRlIGZpbGUgaXRlbXMgZm9yIE1JUFMgTWFsdGEgYm9hcmQpCjIvNCBDaGVja2luZyBjb21t
aXQgNWY5MGVhMDZkNWRhIChNQUlOVEFJTkVSUzogQ29uc29saWRhdGUgTUlQUyBkaXNhc3NlbWJs
ZXItcmVsYXRlZCBpdGVtcykKMy80IENoZWNraW5nIGNvbW1pdCA2MmQ4NGRlNjAzZGQgKHRhcmdl
dC9taXBzOiBGaXggc29tZSBzcGFjZSBjaGVja3BhdGNoIGVycm9ycyBpbiB0cmFuc2xhdGUuYykK
NC80IENoZWNraW5nIGNvbW1pdCAzMTdmNDQ5MTZjNDcgKHRhcmdldC9taXBzOiBGaXggaWYtZWxz
ZS1zd2l0Y2gtY2FzZSBhcm1zIGNoZWNrcGF0Y2ggZXJyb3JzIGluIHRyYW5zbGF0ZS5jKQpFUlJP
Ujogc3BhY2UgcHJvaGliaXRlZCBhZnRlciB0aGF0IG9wZW4gcGFyZW50aGVzaXMgJygnCiMxMzk6
IEZJTEU6IHRhcmdldC9taXBzL3RyYW5zbGF0ZS5jOjMxMzg6CisgICAgaWYgKHVubGlrZWx5KCAo
Y3R4LT5DUDBfQ29uZmlnNSAmICgxIDw8IENQMEM1X05NUykpICYmCgpFUlJPUjogc3BhY2UgcHJv
aGliaXRlZCBiZWZvcmUgdGhhdCBjbG9zZSBwYXJlbnRoZXNpcyAnKScKIzE0MDogRklMRTogdGFy
Z2V0L21pcHMvdHJhbnNsYXRlLmM6MzEzOToKKyAgICAgICAgICAgICAgICAgIShjdHgtPkNQMF9D
b25maWcxICYgKDEgPDwgQ1AwQzFfREwgKSkgJiYKCkVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGJl
Zm9yZSB0aGF0IGNsb3NlIHBhcmVudGhlc2lzICcpJwojMTQxOiBGSUxFOiB0YXJnZXQvbWlwcy90
cmFuc2xhdGUuYzozMTQwOgorICAgICAgICAgICAgICAgICAhKGN0eC0+Q1AwX0NvbmZpZzEgJiAo
MSA8PCBDUDBDMV9JTCApKSAmJgoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYmVmb3JlIHRoYXQg
Y2xvc2UgcGFyZW50aGVzaXMgJyknCiMxNDI6IEZJTEU6IHRhcmdldC9taXBzL3RyYW5zbGF0ZS5j
OjMxNDE6CisgICAgICAgICAgICAgICAgICEoY3R4LT5DUDBfQ29uZmlnMiAmICgxIDw8IENQMEMy
X1NMICkpICYmCgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZWZvcmUgdGhhdCBjbG9zZSBwYXJl
bnRoZXNpcyAnKScKIzE0MzogRklMRTogdGFyZ2V0L21pcHMvdHJhbnNsYXRlLmM6MzE0MjoKKyAg
ICAgICAgICAgICAgICAgIShjdHgtPkNQMF9Db25maWcyICYgKDEgPDwgQ1AwQzJfVEwgKSkgJiYK
CkVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGJlZm9yZSB0aGF0IGNsb3NlIHBhcmVudGhlc2lzICcp
JwojMTQ0OiBGSUxFOiB0YXJnZXQvbWlwcy90cmFuc2xhdGUuYzozMTQzOgorICAgICAgICAgICAg
ICAgICAhKGN0eC0+Q1AwX0NvbmZpZzUgJiAoMSA8PCBDUDBDNV9MMkMpKSAgICAgKSApIHsKCnRv
dGFsOiA2IGVycm9ycywgMCB3YXJuaW5ncywgNDMyIGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvNCBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1h
bmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU2MTAyNDkyOS0yNjAwNC0xLWdpdC1zZW5kLWVtYWlsLWFs
ZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==


