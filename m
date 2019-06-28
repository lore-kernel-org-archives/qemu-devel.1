Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B400C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32766208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32766208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgndN-0006h7-FQ
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 05:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51329)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hgnag-000515-K3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hgnad-0003Uy-Py
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:54:45 -0400
Resent-Date: Fri, 28 Jun 2019 05:54:45 -0400
Resent-Message-Id: <E1hgnad-0003Uy-Py@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hgnac-0003RD-9P
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:54:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561715665; cv=none; d=zoho.com; s=zohoarc; 
 b=f7wQa/aV7lpWANvRndqF2n4zd4LMGe43bwCgJn/dkoe/owVm7w9vbbhfLzR5UjM85x6bqPcEPqQ+34snbRvpufeZH4JqzKhn/zGpQRKAfc+d6SBhuAO6smU9gRipfJbKG26sPmmk5bjr1dpTQzhQnHqFIMQWiNTuNjy5MnQKwcA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561715665;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=0MSIfsAUXtrxMo1jdlfzCpne4SgBkN479ABm/K3z1go=; 
 b=Qj6idqjxRtfDmnz1bHwJaLyUb3qwgxDUj4+oL/5p+cpQW3eTtRdAg9vjpHPssNMjz7TRW4+gS21cy/rlSaQFgwhh4vkQmVb/FJV7u9/9lFt5vy7apJ0hHb1kGI1Y4K9tARKwoQQU71F1yNleLQ9X6ey4SzqVP+aUhFbW1ttFGMo=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561714757278342.2957946254951;
 Fri, 28 Jun 2019 02:39:17 -0700 (PDT)
Message-ID: <156171475579.6332.4612553471877082379@c4a48874b076>
In-Reply-To: <1561712082-31441-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Fri, 28 Jun 2019 02:39:17 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v15 0/5] linux-user: A set of miscellaneous
 patches
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
Cc: qemu-devel@nongnu.org, amarkovic@wavecomp.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYxNzEyMDgyLTMxNDQxLTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91
dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDE1NjE3MTIwODIt
MzE0NDEtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbQpUeXBl
OiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2MTUgMC81XSBsaW51eC11c2Vy
OiBBIHNldCBvZiBtaXNjZWxsYW5lb3VzIHBhdGNoZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzE1NjE3MTIwODItMzE0NDEtMS1naXQtc2Vu
ZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbSAtPiBwYXRjaGV3LzE1NjE3MTIw
ODItMzE0NDEtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbQpT
d2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjhlMzZiYzggbGludXgtdXNlcjogSGFuZGxl
IEVYQ1BfRlBFIHByb3Blcmx5IGZvciBNSVBTCjhkNTg4ZGUgbGludXgtdXNlcjogSW50cm9kdWNl
IFRBUkdFVF9IQVZFX0FSQ0hfU1RSVUNUX0ZMT0NLCjlmMTJjZTMgbGludXgtdXNlcjogRml4IHRh
cmdldF9mbG9jayBzdHJ1Y3R1cmUgZm9yIE1JUFMgTzY0IEFCSQpjM2FmNGYxIGxpbnV4LXVzZXI6
IEFkZCBzdXBwb3J0IGZvciBzdHJhY2UgZm9yIHN0YXR4KCkgc3lzY2FsbApiMDAxOTliIGxpbnV4
LXVzZXI6IEFkZCBzdXBwb3J0IGZvciB0cmFuc2xhdGlvbiBvZiBzdGF0eCgpIHN5c2NhbGwKCj09
PSBPVVRQVVQgQkVHSU4gPT09CjEvNSBDaGVja2luZyBjb21taXQgYjAwMTk5YjJjNzMwIChsaW51
eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgdHJhbnNsYXRpb24gb2Ygc3RhdHgoKSBzeXNjYWxsKQpX
QVJOSU5HOiBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgZGVmaW5lcyBzaG91bGQgYmUgYXZvaWRlZAoj
NTM6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbC5jOjMyMToKKyNpZiBkZWZpbmVkKFRBUkdFVF9O
Ul9zdGF0eCkgJiYgZGVmaW5lZChfX05SX3N0YXR4KQoKV0FSTklORzogYXJjaGl0ZWN0dXJlIHNw
ZWNpZmljIGRlZmluZXMgc2hvdWxkIGJlIGF2b2lkZWQKIzY1OiBGSUxFOiBsaW51eC11c2VyL3N5
c2NhbGwuYzo2NDc4OgorI2lmIGRlZmluZWQoVEFSR0VUX05SX3N0YXR4KSAmJiBkZWZpbmVkKF9f
TlJfc3RhdHgpCgpXQVJOSU5HOiBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgZGVmaW5lcyBzaG91bGQg
YmUgYXZvaWRlZAojMTM1OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGwuYzoxMDE4ODoKKyNpZiBk
ZWZpbmVkKF9fTlJfc3RhdHgpCgp0b3RhbDogMCBlcnJvcnMsIDMgd2FybmluZ3MsIDE3OSBsaW5l
cyBjaGVja2VkCgpQYXRjaCAxLzUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KMi81IENoZWNr
aW5nIGNvbW1pdCBjM2FmNGYxZjk0MjEgKGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciBzdHJh
Y2UgZm9yIHN0YXR4KCkgc3lzY2FsbCkKRVJST1I6IHN0b3JhZ2UgY2xhc3Mgc2hvdWxkIGJlIGF0
IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uCiMyNzogRklMRTogbGludXgtdXNlci9z
dHJhY2UuYzo5Nzk6CitVTlVTRUQgc3RhdGljIHN0cnVjdCBmbGFncyBzdGF0eF9mbGFnc1tdID0g
ewoKRVJST1I6IHN0b3JhZ2UgY2xhc3Mgc2hvdWxkIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhl
IGRlY2xhcmF0aW9uCiM0OTogRklMRTogbGludXgtdXNlci9zdHJhY2UuYzoxMDAxOgorVU5VU0VE
IHN0YXRpYyBzdHJ1Y3QgZmxhZ3Mgc3RhdHhfbWFza1tdID0gewoKdG90YWw6IDIgZXJyb3JzLCAw
IHdhcm5pbmdzLCAxMDQgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi81IGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCgozLzUgQ2hlY2tpbmcgY29tbWl0IDlmMTJjZTM3MDY5MyAobGludXgtdXNlcjog
Rml4IHRhcmdldF9mbG9jayBzdHJ1Y3R1cmUgZm9yIE1JUFMgTzY0IEFCSSkKNC81IENoZWNraW5n
IGNvbW1pdCA4ZDU4OGRlNmYwOTIgKGxpbnV4LXVzZXI6IEludHJvZHVjZSBUQVJHRVRfSEFWRV9B
UkNIX1NUUlVDVF9GTE9DSykKNS81IENoZWNraW5nIGNvbW1pdCA4ZTM2YmM4NzFhMjggKGxpbnV4
LXVzZXI6IEhhbmRsZSBFWENQX0ZQRSBwcm9wZXJseSBmb3IgTUlQUykKPT09IE9VVFBVVCBFTkQg
PT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU2MTcxMjA4Mi0zMTQ0MS0xLWdp
dC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29tL3Rlc3RpbmcuY2hlY2tw
YXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


