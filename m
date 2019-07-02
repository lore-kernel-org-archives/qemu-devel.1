Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA7FC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 21:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D12218BE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 21:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D12218BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiQjw-0005Pw-Ba
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 17:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53896)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hiQi8-0004jI-U9
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hiQi5-0006CO-TA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:53:12 -0400
Resent-Date: Tue, 02 Jul 2019 17:53:12 -0400
Resent-Message-Id: <E1hiQi5-0006CO-TA@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hiQi5-00069V-8h
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:53:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562104348; cv=none; d=zoho.com; s=zohoarc; 
 b=e1GqrBPXj5YWO7GcjmoPkbF44xKGpoHyoV6eemzQJkcvkceIbbkElbIl0cbNdcWP1BPtmbUwpwDxujI1lmj3ZRhnR8cO7ujUe7KDmJbSZi1ZLPkGix+ufq+VzBsyi56u3IoyCLGAN2AlHxAeyNNzqcRzOs4BjyID4fZ29ri2jHc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562104348;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=/1Fxcx/5yGcn/5D15AH+HxrwwtTWLGuKq4hckisE0X0=; 
 b=Q+ckQGR8pmUg4tU0mbks+8nYv1sOgs6XT5JISZRl5t7Ihm+rwLM4Rqq/6isctW4MLrdEMIjb63hKuhworFGlgv323D2thCDkjqMazPWdPrP5XUTEabAnfomcnBuvCrOk/kGMQl7WFgWOitgYxb9ix8ndHtHUYMDEdMSQ2uY8LeU=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562104347192572.1834036474929;
 Tue, 2 Jul 2019 14:52:27 -0700 (PDT)
Message-ID: <156210434600.16064.7264890899532630488@c4a48874b076>
In-Reply-To: <20190702150545.1872-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Tue, 2 Jul 2019 14:52:27 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PULL 0/6] Linux user for 4.1 patches
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
Cc: arikalo@wavecomp.com, riku.voipio@iki.fi, qemu-devel@nongnu.org,
 laurent@vivier.eu, amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwMjE1MDU0NS4xODcy
LTEtbGF1cmVudEB2aXZpZXIuZXUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClR5cGU6IHNlcmllcwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BVTEwgMC82XSBM
aW51eCB1c2VyIGZvciA0LjEgcGF0Y2hlcwpNZXNzYWdlLWlkOiAyMDE5MDcwMjE1MDU0NS4xODcy
LTEtbGF1cmVudEB2aXZpZXIuZXUKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jh
c2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMg
VHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0
cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09
CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjk0NGQ1NWMgbGludXgtdXNlcjogbW92
ZSBRRU1VX0lGTEFfQlJfTVVMVElfQk9PTE9QVCB0byB0aGUgZ29vZCBmdW5jdGlvbgpmNDdlMDZl
IGxpbnV4LXVzZXI6IEhhbmRsZSBFWENQX0ZQRSBwcm9wZXJseSBmb3IgTUlQUwo2ZjA4ZDAyIGxp
bnV4LXVzZXI6IEludHJvZHVjZSBUQVJHRVRfSEFWRV9BUkNIX1NUUlVDVF9GTE9DSwpkMGRjZDhl
IGxpbnV4LXVzZXI6IEZpeCB0YXJnZXRfZmxvY2sgc3RydWN0dXJlIGZvciBNSVBTIE82NCBBQkkK
YWE3ZDY0ZSBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3Igc3RyYWNlIGZvciBzdGF0eCgpIHN5
c2NhbGwKOTM5YjUyNiBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgdHJhbnNsYXRpb24gb2Yg
c3RhdHgoKSBzeXNjYWxsCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzYgQ2hlY2tpbmcgY29tbWl0
IDkzOWI1MjZhMTI0YiAobGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIHRyYW5zbGF0aW9uIG9m
IHN0YXR4KCkgc3lzY2FsbCkKV0FSTklORzogYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGRlZmluZXMg
c2hvdWxkIGJlIGF2b2lkZWQKIzYzOiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGwuYzozMjM6Cisj
aWYgZGVmaW5lZChUQVJHRVRfTlJfc3RhdHgpICYmIGRlZmluZWQoX19OUl9zdGF0eCkKCldBUk5J
Tkc6IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBkZWZpbmVzIHNob3VsZCBiZSBhdm9pZGVkCiM3NTog
RklMRTogbGludXgtdXNlci9zeXNjYWxsLmM6NjUyODoKKyNpZiBkZWZpbmVkKFRBUkdFVF9OUl9z
dGF0eCkgJiYgZGVmaW5lZChfX05SX3N0YXR4KQoKV0FSTklORzogYXJjaGl0ZWN0dXJlIHNwZWNp
ZmljIGRlZmluZXMgc2hvdWxkIGJlIGF2b2lkZWQKIzE0NTogRklMRTogbGludXgtdXNlci9zeXNj
YWxsLmM6MTAyMzg6CisjaWYgZGVmaW5lZChfX05SX3N0YXR4KQoKdG90YWw6IDAgZXJyb3JzLCAz
IHdhcm5pbmdzLCAxODYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS82IGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCjIvNiBDaGVja2luZyBjb21taXQgYWE3ZDY0ZTEzNjE5IChsaW51eC11c2VyOiBB
ZGQgc3VwcG9ydCBmb3Igc3RyYWNlIGZvciBzdGF0eCgpIHN5c2NhbGwpCkVSUk9SOiBzdG9yYWdl
IGNsYXNzIHNob3VsZCBiZSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJhdGlvbgojMjk6
IEZJTEU6IGxpbnV4LXVzZXIvc3RyYWNlLmM6OTc5OgorVU5VU0VEIHN0YXRpYyBzdHJ1Y3QgZmxh
Z3Mgc3RhdHhfZmxhZ3NbXSA9IHsKCkVSUk9SOiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0
aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJhdGlvbgojNTE6IEZJTEU6IGxpbnV4LXVzZXIvc3Ry
YWNlLmM6MTAwMToKK1VOVVNFRCBzdGF0aWMgc3RydWN0IGZsYWdzIHN0YXR4X21hc2tbXSA9IHsK
CnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgMTA0IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIv
NiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy82IENoZWNraW5nIGNvbW1pdCBkMGRjZDhl
MjEzNWYgKGxpbnV4LXVzZXI6IEZpeCB0YXJnZXRfZmxvY2sgc3RydWN0dXJlIGZvciBNSVBTIE82
NCBBQkkpCjQvNiBDaGVja2luZyBjb21taXQgNmYwOGQwMjIxNDhlIChsaW51eC11c2VyOiBJbnRy
b2R1Y2UgVEFSR0VUX0hBVkVfQVJDSF9TVFJVQ1RfRkxPQ0spCjUvNiBDaGVja2luZyBjb21taXQg
ZjQ3ZTA2ZTc5ODJiIChsaW51eC11c2VyOiBIYW5kbGUgRVhDUF9GUEUgcHJvcGVybHkgZm9yIE1J
UFMpCjYvNiBDaGVja2luZyBjb21taXQgOTQ0ZDU1Y2FlYmNiIChsaW51eC11c2VyOiBtb3ZlIFFF
TVVfSUZMQV9CUl9NVUxUSV9CT09MT1BUIHRvIHRoZSBnb29kIGZ1bmN0aW9uKQo9PT0gT1VUUFVU
IEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDcwMjE1MDU0NS4x
ODcyLTEtbGF1cmVudEB2aXZpZXIuZXUvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t


