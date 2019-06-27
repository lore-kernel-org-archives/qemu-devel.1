Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF33C48BE4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 18:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE0C205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 18:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE0C205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgZCd-0004wG-Mp
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 14:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47536)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hgZAu-0004T0-SN
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 14:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hgZAs-0007RM-SU
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 14:31:12 -0400
Resent-Date: Thu, 27 Jun 2019 14:31:12 -0400
Resent-Message-Id: <E1hgZAs-0007RM-SU@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21573)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hgZAr-00074N-AM
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 14:31:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561660234; cv=none; d=zoho.com; s=zohoarc; 
 b=egH4UnW3RYs+YhFYj9PrFvvIa/8T/P3kLi9Nkz5JPuga0dnQHNkW4UleO3CfJpjpeHrA4IN1Y/EmXuCbYiWzVoQc+IIeHcSE5MyGfpVBYpaiLOhvXDbsEyk8ygBIHmeZdnxjm1WCgH/bcAiOSJbAffKV9Ggpa+HgAWUKEL/TvpA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561660234;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=BGATH2xt74+Hss+VYxqpZlLS1AvnXd9Tkc9d1oa0EZg=; 
 b=hT75wRxKSZig3alkdsnmbWVQmWrV9qa0pDXRTtyCTlh77/zUOk3EtQ2CEG81F4oEPrid12aJ8aKETSgksReZVYG7fH4OqKDkDwFC3Nceqv6AF7q39nIg1S4aTPu5Pj5A3HDkiBW3SCYIt93+p3PNNt1azW/n41LsCbF0a/2EPgY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561660227592607.8397703082163;
 Thu, 27 Jun 2019 11:30:27 -0700 (PDT)
Message-ID: <156166022640.6332.17115757325327321505@c4a48874b076>
In-Reply-To: <1561648298-18100-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Thu, 27 Jun 2019 11:30:27 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v13 0/5] linux-user: A set of miscellaneous
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYxNjQ4Mjk4LTE4MTAwLTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91
dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBb
UEFUQ0ggdjEzIDAvNV0gbGludXgtdXNlcjogQSBzZXQgb2YgbWlzY2VsbGFuZW91cyBwYXRjaGVz
Ck1lc3NhZ2UtaWQ6IDE1NjE2NDgyOTgtMTgxMDAtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFy
Lm1hcmtvdmljQHJ0LXJrLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4
NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZjA5MmUxZCBsaW51eC11c2Vy
OiBIYW5kbGUgRVhDUF9GUEUgcHJvcGVybHkgZm9yIE1JUFMKMjdlOWJkZCBsaW51eC11c2VyOiBJ
bnRyb2R1Y2UgVEFSR0VUX0hBVkVfQVJDSF9TVFJVQ1RfRkxPQ0sKNDc1ZDYxYyBsaW51eC11c2Vy
OiBGaXggZmxvY2sgc3RydWN0dXJlIGZvciBNSVBTIE82NCBBQkkKYWU3ZGJiNCBsaW51eC11c2Vy
OiBBZGQgc3VwcG9ydCBmb3Igc3RyYWNlIGZvciBzdGF0eCgpIHN5c2NhbGwKMzk1NjMzOSBsaW51
eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgdHJhbnNsYXRpb24gb2Ygc3RhdHgoKSBzeXNjYWxsCgo9
PT0gT1VUUFVUIEJFR0lOID09PQoxLzUgQ2hlY2tpbmcgY29tbWl0IDM5NTYzMzkwZDJkOSAobGlu
dXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIHRyYW5zbGF0aW9uIG9mIHN0YXR4KCkgc3lzY2FsbCkK
V0FSTklORzogYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGRlZmluZXMgc2hvdWxkIGJlIGF2b2lkZWQK
IzYwOiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGwuYzozMjI6CisjaWYgZGVmaW5lZChUQVJHRVRf
TlJfc3RhdHgpICYmIGRlZmluZWQoX19OUl9zdGF0eCkKCldBUk5JTkc6IGFyY2hpdGVjdHVyZSBz
cGVjaWZpYyBkZWZpbmVzIHNob3VsZCBiZSBhdm9pZGVkCiM3MjogRklMRTogbGludXgtdXNlci9z
eXNjYWxsLmM6NjQ3OToKKyNpZiBkZWZpbmVkKFRBUkdFVF9OUl9zdGF0eCkgJiYgZGVmaW5lZChf
X05SX3N0YXR4KQoKV0FSTklORzogYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGRlZmluZXMgc2hvdWxk
IGJlIGF2b2lkZWQKIzE0MjogRklMRTogbGludXgtdXNlci9zeXNjYWxsLmM6MTAxODk6CisjaWYg
ZGVmaW5lZChfX05SX3N0YXR4KQoKdG90YWw6IDAgZXJyb3JzLCAzIHdhcm5pbmdzLCAxODYgbGlu
ZXMgY2hlY2tlZAoKUGF0Y2ggMS81IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjIvNSBDaGVj
a2luZyBjb21taXQgYWU3ZGJiNGMyMWJmIChsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3Igc3Ry
YWNlIGZvciBzdGF0eCgpIHN5c2NhbGwpCkVSUk9SOiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBh
dCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJhdGlvbgojMjc6IEZJTEU6IGxpbnV4LXVzZXIv
c3RyYWNlLmM6OTc5OgorVU5VU0VEIHN0YXRpYyBzdHJ1Y3QgZmxhZ3Mgc3RhdHhfZmxhZ3NbXSA9
IHsKCkVSUk9SOiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRo
ZSBkZWNsYXJhdGlvbgojNDk6IEZJTEU6IGxpbnV4LXVzZXIvc3RyYWNlLmM6MTAwMToKK1VOVVNF
RCBzdGF0aWMgc3RydWN0IGZsYWdzIHN0YXR4X21hc2tbXSA9IHsKCnRvdGFsOiAyIGVycm9ycywg
MCB3YXJuaW5ncywgMTA0IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvNSBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKMy81IENoZWNraW5nIGNvbW1pdCA0NzVkNjFjYmRiODkgKGxpbnV4LXVzZXI6
IEZpeCBmbG9jayBzdHJ1Y3R1cmUgZm9yIE1JUFMgTzY0IEFCSSkKNC81IENoZWNraW5nIGNvbW1p
dCAyN2U5YmRkMWU5NDkgKGxpbnV4LXVzZXI6IEludHJvZHVjZSBUQVJHRVRfSEFWRV9BUkNIX1NU
UlVDVF9GTE9DSykKNS81IENoZWNraW5nIGNvbW1pdCBmMDkyZTFkOTAzMjIgKGxpbnV4LXVzZXI6
IEhhbmRsZSBFWENQX0ZQRSBwcm9wZXJseSBmb3IgTUlQUykKPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU2MTY0ODI5OC0xODEwMC0xLWdpdC1zZW5k
LWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


