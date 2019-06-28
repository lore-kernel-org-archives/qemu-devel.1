Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC256C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED142083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED142083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrQ7-0006Ag-So
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51266)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hgqkM-0002yL-OI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hgqkI-000512-0Q
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:16:58 -0400
Resent-Date: Fri, 28 Jun 2019 09:16:55 -0400
Resent-Message-Id: <E1hgqkI-000512-0Q@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21591)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hgqk7-0004sd-BK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:16:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561721450; cv=none; d=zoho.com; s=zohoarc; 
 b=KtByWEOrKQmusu3XxGx72MdvqPepM+dUT3DjfA+v8TT10jLEiK1qmDyMO3Vdntz9dMDBx8BAg1HLF+OOptVGR0IWDMdVaak2QGe/p84z3XOTnZI5atXK0fT9phqbilgIyxSKyZqno3vdmIVLQxmpwJysVgU8so4UzoLvL5dajyo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561721450;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=lFSqcWmy3rIBia41qzkfsDW2IHKv2Szq84EwK4WP+S4=; 
 b=iebljpksQ3DuGoJCH7ntw3BrWIax44qSOJmwiQza3TKGbEUZot0BPranXij09m0lsyfNygLf9Zw5U4V5eei/fWSWOjgnikYxXOqG7xe04dHUFRyjXX2Go7uxZrmqFOeR90W2yep9kSgyE80yQE04L+bhxijnS5g25H+mU2WcZjM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561721443321859.1070352950009;
 Fri, 28 Jun 2019 04:30:43 -0700 (PDT)
Message-ID: <156172144211.6332.11649071950907806769@c4a48874b076>
In-Reply-To: <1561718618-20218-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Fri, 28 Jun 2019 04:30:43 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v16 0/5] linux-user: A set of miscellaneous
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYxNzE4NjE4LTIwMjE4LTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91
dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDE1NjE3MTg2MTgt
MjAyMTgtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbQpTdWJq
ZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYxNiAwLzVdIGxpbnV4LXVzZXI6IEEgc2V0IG9mIG1p
c2NlbGxhbmVvdXMgcGF0Y2hlcwpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4
NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtu
ZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMTU2MTcxODYxOC0yMDIxOC0xLWdpdC1zZW5kLWVtYWls
LWFsZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29tIC0+IHBhdGNoZXcvMTU2MTcxODYxOC0yMDIx
OC0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29tClN3aXRjaGVk
IHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNDg4OGNkZCBsaW51eC11c2VyOiBIYW5kbGUgRVhDUF9G
UEUgcHJvcGVybHkgZm9yIE1JUFMKNTVkNzg1YyBsaW51eC11c2VyOiBJbnRyb2R1Y2UgVEFSR0VU
X0hBVkVfQVJDSF9TVFJVQ1RfRkxPQ0sKNTNkM2U0OCBsaW51eC11c2VyOiBGaXggdGFyZ2V0X2Zs
b2NrIHN0cnVjdHVyZSBmb3IgTUlQUyBPNjQgQUJJCmUwMGQ4OTEgbGludXgtdXNlcjogQWRkIHN1
cHBvcnQgZm9yIHN0cmFjZSBmb3Igc3RhdHgoKSBzeXNjYWxsCjRhMjNjMDIgbGludXgtdXNlcjog
QWRkIHN1cHBvcnQgZm9yIHRyYW5zbGF0aW9uIG9mIHN0YXR4KCkgc3lzY2FsbAoKPT09IE9VVFBV
VCBCRUdJTiA9PT0KMS81IENoZWNraW5nIGNvbW1pdCA0YTIzYzAyY2QyODggKGxpbnV4LXVzZXI6
IEFkZCBzdXBwb3J0IGZvciB0cmFuc2xhdGlvbiBvZiBzdGF0eCgpIHN5c2NhbGwpCldBUk5JTkc6
IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBkZWZpbmVzIHNob3VsZCBiZSBhdm9pZGVkCiM2MTogRklM
RTogbGludXgtdXNlci9zeXNjYWxsLmM6MzIyOgorI2lmIGRlZmluZWQoVEFSR0VUX05SX3N0YXR4
KSAmJiBkZWZpbmVkKF9fTlJfc3RhdHgpCgpXQVJOSU5HOiBhcmNoaXRlY3R1cmUgc3BlY2lmaWMg
ZGVmaW5lcyBzaG91bGQgYmUgYXZvaWRlZAojNzM6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbC5j
OjY0Nzk6CisjaWYgZGVmaW5lZChUQVJHRVRfTlJfc3RhdHgpICYmIGRlZmluZWQoX19OUl9zdGF0
eCkKCldBUk5JTkc6IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBkZWZpbmVzIHNob3VsZCBiZSBhdm9p
ZGVkCiMxNDM6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbC5jOjEwMTg5OgorI2lmIGRlZmluZWQo
X19OUl9zdGF0eCkKCnRvdGFsOiAwIGVycm9ycywgMyB3YXJuaW5ncywgMTg2IGxpbmVzIGNoZWNr
ZWQKClBhdGNoIDEvNSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoyLzUgQ2hlY2tpbmcgY29t
bWl0IGUwMGQ4OTEwMDE5YyAobGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIHN0cmFjZSBmb3Ig
c3RhdHgoKSBzeXNjYWxsKQpFUlJPUjogc3RvcmFnZSBjbGFzcyBzaG91bGQgYmUgYXQgdGhlIGJl
Z2lubmluZyBvZiB0aGUgZGVjbGFyYXRpb24KIzI3OiBGSUxFOiBsaW51eC11c2VyL3N0cmFjZS5j
Ojk3OToKK1VOVVNFRCBzdGF0aWMgc3RydWN0IGZsYWdzIHN0YXR4X2ZsYWdzW10gPSB7CgpFUlJP
Ujogc3RvcmFnZSBjbGFzcyBzaG91bGQgYmUgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgZGVjbGFy
YXRpb24KIzQ5OiBGSUxFOiBsaW51eC11c2VyL3N0cmFjZS5jOjEwMDE6CitVTlVTRUQgc3RhdGlj
IHN0cnVjdCBmbGFncyBzdGF0eF9tYXNrW10gPSB7Cgp0b3RhbDogMiBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDEwNCBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KCjMvNSBDaGVja2luZyBjb21taXQgNTNkM2U0ODNlOTFkIChsaW51eC11c2VyOiBGaXggdGFy
Z2V0X2Zsb2NrIHN0cnVjdHVyZSBmb3IgTUlQUyBPNjQgQUJJKQo0LzUgQ2hlY2tpbmcgY29tbWl0
IDU1ZDc4NWNmNzg2ZCAobGludXgtdXNlcjogSW50cm9kdWNlIFRBUkdFVF9IQVZFX0FSQ0hfU1RS
VUNUX0ZMT0NLKQo1LzUgQ2hlY2tpbmcgY29tbWl0IDQ4ODhjZGQ5M2ZkZCAobGludXgtdXNlcjog
SGFuZGxlIEVYQ1BfRlBFIHByb3Blcmx5IGZvciBNSVBTKQo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTYxNzE4NjE4LTIwMjE4LTEtZ2l0LXNlbmQt
ZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t


