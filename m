Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26702C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DA3208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DA3208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgYft-0005HI-UR
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 13:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40755)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hgYf4-0004q3-2c
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hgYf2-00038q-4f
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:58:17 -0400
Resent-Date: Thu, 27 Jun 2019 13:58:17 -0400
Resent-Message-Id: <E1hgYf2-00038q-4f@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hgYf1-0002zI-2V
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:58:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561658252; cv=none; d=zoho.com; s=zohoarc; 
 b=Kk9U8OIzylS70lqFQdjxBc9N4ZgXby35edNXuxIUEW3HIDko1XWXEiSODsENJ+0XAR53S/rsrLBdypBOoSjthghNKl9lun5NwpYZjx1envDbGKYa3fm1WbUeEzjS8XwsuaSvBD0LXNnfPGBj9ajyhgBv6Ai5pwQGeJ0SlbyYR5I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561658252;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=U+RWuUopwuFBFwir+1e8QokxxyT8I+vXXsDsLiKWhD0=; 
 b=B/GZ2t/5PVgRJVnIDmjXZTPssi5SKbAf4kxB9SAXW1MKFGoWHlyHKMzQip2CJumZhZyFGJ3nMQ4pLyq2Mltvde9svDHZOV2MkCY3sFWpNg09Uf+V+p5z1zKfcnrg95Led23/LT4Km2P2GkHP7y52wVJIy+K/obWLRKwohXw/0rA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561658244830326.01963618591674;
 Thu, 27 Jun 2019 10:57:24 -0700 (PDT)
Message-ID: <156165824263.6332.8341680505632281487@c4a48874b076>
In-Reply-To: <1561649510-21183-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Thu, 27 Jun 2019 10:57:24 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v14 0/5] linux-user: A set of miscellaneous
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYxNjQ5NTEwLTIxMTgzLTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91
dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDE1NjE2NDk1MTAt
MjExODMtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbQpUeXBl
OiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2MTQgMC81XSBsaW51eC11c2Vy
OiBBIHNldCBvZiBtaXNjZWxsYW5lb3VzIHBhdGNoZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzE1NjE2NDk1MTAtMjExODMtMS1n
aXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbSAtPiBwYXRjaGV3LzE1
NjE2NDk1MTAtMjExODMtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJr
LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmY5YjJiM2M2ZjEgbGludXgtdXNl
cjogSGFuZGxlIEVYQ1BfRlBFIHByb3Blcmx5IGZvciBNSVBTCjg5YjQyNzVjODkgbGludXgtdXNl
cjogSW50cm9kdWNlIFRBUkdFVF9IQVZFX0FSQ0hfU1RSVUNUX0ZMT0NLCjY0NmEwOTZkMGYgbGlu
dXgtdXNlcjogRml4IGZsb2NrIHN0cnVjdHVyZSBmb3IgTUlQUyBPNjQgQUJJCjFkZGQzMmI2N2Mg
bGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIHN0cmFjZSBmb3Igc3RhdHgoKSBzeXNjYWxsCjg2
OWUyYTRmNzUgbGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIHRyYW5zbGF0aW9uIG9mIHN0YXR4
KCkgc3lzY2FsbAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS81IENoZWNraW5nIGNvbW1pdCA4Njll
MmE0Zjc1YzAgKGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciB0cmFuc2xhdGlvbiBvZiBzdGF0
eCgpIHN5c2NhbGwpCldBUk5JTkc6IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBkZWZpbmVzIHNob3Vs
ZCBiZSBhdm9pZGVkCiM2MDogRklMRTogbGludXgtdXNlci9zeXNjYWxsLmM6MzIyOgorI2lmIGRl
ZmluZWQoVEFSR0VUX05SX3N0YXR4KSAmJiBkZWZpbmVkKF9fTlJfc3RhdHgpCgpXQVJOSU5HOiBh
cmNoaXRlY3R1cmUgc3BlY2lmaWMgZGVmaW5lcyBzaG91bGQgYmUgYXZvaWRlZAojNzI6IEZJTEU6
IGxpbnV4LXVzZXIvc3lzY2FsbC5jOjY0Nzk6CisjaWYgZGVmaW5lZChUQVJHRVRfTlJfc3RhdHgp
ICYmIGRlZmluZWQoX19OUl9zdGF0eCkKCldBUk5JTkc6IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBk
ZWZpbmVzIHNob3VsZCBiZSBhdm9pZGVkCiMxNDI6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbC5j
OjEwMTg5OgorI2lmIGRlZmluZWQoX19OUl9zdGF0eCkKCnRvdGFsOiAwIGVycm9ycywgMyB3YXJu
aW5ncywgMTg2IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvNSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgoyLzUgQ2hlY2tpbmcgY29tbWl0IDFkZGQzMmI2N2M4MCAobGludXgtdXNlcjogQWRkIHN1
cHBvcnQgZm9yIHN0cmFjZSBmb3Igc3RhdHgoKSBzeXNjYWxsKQpFUlJPUjogc3RvcmFnZSBjbGFz
cyBzaG91bGQgYmUgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgZGVjbGFyYXRpb24KIzI3OiBGSUxF
OiBsaW51eC11c2VyL3N0cmFjZS5jOjk3OToKK1VOVVNFRCBzdGF0aWMgc3RydWN0IGZsYWdzIHN0
YXR4X2ZsYWdzW10gPSB7CgpFUlJPUjogc3RvcmFnZSBjbGFzcyBzaG91bGQgYmUgYXQgdGhlIGJl
Z2lubmluZyBvZiB0aGUgZGVjbGFyYXRpb24KIzQ5OiBGSUxFOiBsaW51eC11c2VyL3N0cmFjZS5j
OjEwMDE6CitVTlVTRUQgc3RhdGljIHN0cnVjdCBmbGFncyBzdGF0eF9tYXNrW10gPSB7Cgp0b3Rh
bDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDEwNCBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzUgaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjMvNSBDaGVja2luZyBjb21taXQgNjQ2YTA5NmQwZjA2
IChsaW51eC11c2VyOiBGaXggZmxvY2sgc3RydWN0dXJlIGZvciBNSVBTIE82NCBBQkkpCjQvNSBD
aGVja2luZyBjb21taXQgODliNDI3NWM4OTNmIChsaW51eC11c2VyOiBJbnRyb2R1Y2UgVEFSR0VU
X0hBVkVfQVJDSF9TVFJVQ1RfRkxPQ0spCjUvNSBDaGVja2luZyBjb21taXQgZjliMmIzYzZmMWYw
IChsaW51eC11c2VyOiBIYW5kbGUgRVhDUF9GUEUgcHJvcGVybHkgZm9yIE1JUFMpCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1NjE2NDk1MTAtMjEx
ODMtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS90ZXN0aW5n
LmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


