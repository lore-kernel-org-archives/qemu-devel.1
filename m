Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HEXHASH_WORD,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE80C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60032166E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60032166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38864 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdbYI-00056u-0G
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 10:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55840)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hdbTU-0007U3-NO
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hdbTT-0004QC-Aa
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:22:08 -0400
Resent-Date: Wed, 19 Jun 2019 10:22:08 -0400
Resent-Message-Id: <E1hdbTT-0004QC-Aa@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hdbTT-0004OM-4p
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:22:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560954074; cv=none; d=zoho.com; s=zohoarc; 
 b=ZxrHN1N8RSf8FfR3Q76VKfnmwjGIqlEXxy+zceLCvjn2qApMG+slyk75ilj9ZLYmiYFVG/gh+sQJRyCztZJYOQ6wDR9ZTj/2F+t3VJV865pIIfKfTPVlaIJEbs6UPy1YTrsRjBDjMT08UpAB53oRCeXOiOMpzoRFeuNnjL4dudc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560954074;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=VYvqQ/Z8rxbWdctYkdbr5d4QM5+RU5LxGLMpIqej3X4=; 
 b=E2aYZYPERXmsQ/YYTD+BMgsVN3KOpDHr5oQkkCjM+r20QQof4s3hEmicLHVgzqRPqWz3uAbRVty4s3FVUyESAk4zcTcQ6Sm4Amp1ZJKzbCqFu3VeDaVZklu/7HftO3YqE9/eBXEJrWNscXtuzfHIRLPaWGOuuw13M5xSOCjzOPA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560954072685782.064345915425;
 Wed, 19 Jun 2019 07:21:12 -0700 (PDT)
In-Reply-To: <1560953429-29203-1-git-send-email-aleksandar.markovic@rt-rk.com>
Message-ID: <156095407171.27251.6920570501829734894@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Wed, 19 Jun 2019 07:21:12 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v11 0/5] linux-user: A set of miscellaneous
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYwOTUzNDI5LTI5MjAzLTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91
dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBb
UEFUQ0ggdjExIDAvNV0gbGludXgtdXNlcjogQSBzZXQgb2YgbWlzY2VsbGFuZW91cyBwYXRjaGVz
ClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAxNTYwOTUzNDI5LTI5MjAzLTEtZ2l0LXNlbmQtZW1h
aWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzE1NjA5NTM0MjktMjkyMDMtMS1n
aXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbSAtPiBwYXRjaGV3LzE1
NjA5NTM0MjktMjkyMDMtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJr
LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjJjYjExZGMyNzggbGludXgtdXNl
cjogRml4IGZsb2NrIHN0cnVjdHVyZSBmb3IgTUlQUyBPNjQgQUJJCjliNDZhZDFkNzQgbGludXgt
dXNlcjogQWRkIHN1cHBvcnQgZm9yIHN0cmFjZSBmb3Igc3RhdHgoKSBzeXNjYWxsCmYwN2U3M2M0
ZTggbGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIHRyYW5zbGF0aW9uIG9mIHN0YXR4KCkgc3lz
Y2FsbAo3Y2QwNjU1NmUyIGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciBzZXRzb2Nrb3B0KCkg
b3B0aW9uIFNPTF9BTEcKZmYwMTNmZDIxZSBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3Igc2V0
c29ja29wdCgpIG9wdGlvbnMgSVBWNl88QUREfERST1A+X01FTUJFUlNISVAKCj09PSBPVVRQVVQg
QkVHSU4gPT09CjEvNSBDaGVja2luZyBjb21taXQgZmYwMTNmZDIxZThhIChsaW51eC11c2VyOiBB
ZGQgc3VwcG9ydCBmb3Igc2V0c29ja29wdCgpIG9wdGlvbnMgSVBWNl88QUREfERST1A+X01FTUJF
UlNISVApCjIvNSBDaGVja2luZyBjb21taXQgN2NkMDY1NTZlMmE4IChsaW51eC11c2VyOiBBZGQg
c3VwcG9ydCBmb3Igc2V0c29ja29wdCgpIG9wdGlvbiBTT0xfQUxHKQozLzUgQ2hlY2tpbmcgY29t
bWl0IGYwN2U3M2M0ZTg4NiAobGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIHRyYW5zbGF0aW9u
IG9mIHN0YXR4KCkgc3lzY2FsbCkKV0FSTklORzogYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGRlZmlu
ZXMgc2hvdWxkIGJlIGF2b2lkZWQKIzYwOiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGwuYzozMjM6
CisjaWYgZGVmaW5lZChUQVJHRVRfTlJfc3RhdHgpICYmIGRlZmluZWQoX19OUl9zdGF0eCkKCldB
Uk5JTkc6IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBkZWZpbmVzIHNob3VsZCBiZSBhdm9pZGVkCiM3
MjogRklMRTogbGludXgtdXNlci9zeXNjYWxsLmM6NjUyOToKKyNpZiBkZWZpbmVkKFRBUkdFVF9O
Ul9zdGF0eCkgJiYgZGVmaW5lZChfX05SX3N0YXR4KQoKV0FSTklORzogYXJjaGl0ZWN0dXJlIHNw
ZWNpZmljIGRlZmluZXMgc2hvdWxkIGJlIGF2b2lkZWQKIzE0MjogRklMRTogbGludXgtdXNlci9z
eXNjYWxsLmM6MTAyMzk6CisjaWYgZGVmaW5lZChfX05SX3N0YXR4KQoKdG90YWw6IDAgZXJyb3Jz
LCAzIHdhcm5pbmdzLCAyMDcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy81IGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCjQvNSBDaGVja2luZyBjb21taXQgOWI0NmFkMWQ3NDFlIChsaW51eC11c2Vy
OiBBZGQgc3VwcG9ydCBmb3Igc3RyYWNlIGZvciBzdGF0eCgpIHN5c2NhbGwpCkVSUk9SOiBzdG9y
YWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJhdGlvbgoj
Mjc6IEZJTEU6IGxpbnV4LXVzZXIvc3RyYWNlLmM6OTc5OgorVU5VU0VEIHN0YXRpYyBzdHJ1Y3Qg
ZmxhZ3Mgc3RhdHhfZmxhZ3NbXSA9IHsKCkVSUk9SOiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBh
dCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJhdGlvbgojNDk6IEZJTEU6IGxpbnV4LXVzZXIv
c3RyYWNlLmM6MTAwMToKK1VOVVNFRCBzdGF0aWMgc3RydWN0IGZsYWdzIHN0YXR4X21hc2tbXSA9
IHsKCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgMTA0IGxpbmVzIGNoZWNrZWQKClBhdGNo
IDQvNSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2Ug
ZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIs
IHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNS81IENoZWNraW5nIGNvbW1pdCAyY2Ix
MWRjMjc4ODMgKGxpbnV4LXVzZXI6IEZpeCBmbG9jayBzdHJ1Y3R1cmUgZm9yIE1JUFMgTzY0IEFC
SSkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU2
MDk1MzQyOS0yOTIwMy0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQtcmsu
Y29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


