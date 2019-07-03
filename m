Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF758C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 05:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3A020989
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 05:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3A020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiXxl-000544-IB
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 01:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39242)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hiXwr-0004c8-0R
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hiXwp-0004Oc-GS
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:36:52 -0400
Resent-Date: Wed, 03 Jul 2019 01:36:52 -0400
Resent-Message-Id: <E1hiXwp-0004Oc-GS@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hiXwp-0004GD-8S
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 01:36:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562132156; cv=none; d=zoho.com; s=zohoarc; 
 b=BfiJi7yZ+hx7ZGi+pLXRSIhtMDkQZJLqy/ZD3yXnR5WfIKksiG+QIqcH5fUpMZuzpWmt1v9AIMyWck6WVV6sKa7BWVPwQOdVzIaU7JuzIEqRZ9jatzoXMaVg1lP7dCERRvi4CXwDMPyZurHZqnxTZBLh/D935fsxl8Npuqgs010=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562132156;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=p5GU+MojqOu2+ODhvSSbJ/DHGAWrHbscU0tjR6Xy2X4=; 
 b=kl2bem1RfLTdXbxQJeunWW6RB2rirowlPR78eHf+Vh/EKuumHcOkkrAUMANf6ppEkZyPEllB0HhElulHnlqzVsUlTh2uN253P8Dlo3HOFTFLX/2dXgEeda7aDTx2tvH8ewU7/48ITYpYYF2g5Xi/V8huAj51cT0F4Aemn3l3EEs=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562132154841395.52399772975264;
 Tue, 2 Jul 2019 22:35:54 -0700 (PDT)
Message-ID: <156213215365.17338.7789996168198186021@c4a48874b076>
In-Reply-To: <20190702150545.1872-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Tue, 2 Jul 2019 22:35:54 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
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
CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVw
ZGF0ZV0gICAgICBwYXRjaGV3LzIwMTkwNzAyMTUwNTQ1LjE4NzItMS1sYXVyZW50QHZpdmllci5l
dSAtPiBwYXRjaGV3LzIwMTkwNzAyMTUwNTQ1LjE4NzItMS1sYXVyZW50QHZpdmllci5ldQpTd2l0
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjZjYTI3Y2QgbGludXgtdXNlcjogbW92ZSBRRU1V
X0lGTEFfQlJfTVVMVElfQk9PTE9QVCB0byB0aGUgZ29vZCBmdW5jdGlvbgoyMWQyNGFlIGxpbnV4
LXVzZXI6IEhhbmRsZSBFWENQX0ZQRSBwcm9wZXJseSBmb3IgTUlQUwo5ZGY1NGRjIGxpbnV4LXVz
ZXI6IEludHJvZHVjZSBUQVJHRVRfSEFWRV9BUkNIX1NUUlVDVF9GTE9DSwpmMGQ4OWY4IGxpbnV4
LXVzZXI6IEZpeCB0YXJnZXRfZmxvY2sgc3RydWN0dXJlIGZvciBNSVBTIE82NCBBQkkKODcwYjYx
MCBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3Igc3RyYWNlIGZvciBzdGF0eCgpIHN5c2NhbGwK
NDI0NGZiMCBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgdHJhbnNsYXRpb24gb2Ygc3RhdHgo
KSBzeXNjYWxsCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzYgQ2hlY2tpbmcgY29tbWl0IDQyNDRm
YjA2YmVkMCAobGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIHRyYW5zbGF0aW9uIG9mIHN0YXR4
KCkgc3lzY2FsbCkKV0FSTklORzogYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGRlZmluZXMgc2hvdWxk
IGJlIGF2b2lkZWQKIzYzOiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGwuYzozMjM6CisjaWYgZGVm
aW5lZChUQVJHRVRfTlJfc3RhdHgpICYmIGRlZmluZWQoX19OUl9zdGF0eCkKCldBUk5JTkc6IGFy
Y2hpdGVjdHVyZSBzcGVjaWZpYyBkZWZpbmVzIHNob3VsZCBiZSBhdm9pZGVkCiM3NTogRklMRTog
bGludXgtdXNlci9zeXNjYWxsLmM6NjUyODoKKyNpZiBkZWZpbmVkKFRBUkdFVF9OUl9zdGF0eCkg
JiYgZGVmaW5lZChfX05SX3N0YXR4KQoKV0FSTklORzogYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGRl
ZmluZXMgc2hvdWxkIGJlIGF2b2lkZWQKIzE0NTogRklMRTogbGludXgtdXNlci9zeXNjYWxsLmM6
MTAyMzg6CisjaWYgZGVmaW5lZChfX05SX3N0YXR4KQoKdG90YWw6IDAgZXJyb3JzLCAzIHdhcm5p
bmdzLCAxODYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS82IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCjIvNiBDaGVja2luZyBjb21taXQgODcwYjYxMDI3ZmViIChsaW51eC11c2VyOiBBZGQgc3Vw
cG9ydCBmb3Igc3RyYWNlIGZvciBzdGF0eCgpIHN5c2NhbGwpCkVSUk9SOiBzdG9yYWdlIGNsYXNz
IHNob3VsZCBiZSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJhdGlvbgojMjk6IEZJTEU6
IGxpbnV4LXVzZXIvc3RyYWNlLmM6OTc5OgorVU5VU0VEIHN0YXRpYyBzdHJ1Y3QgZmxhZ3Mgc3Rh
dHhfZmxhZ3NbXSA9IHsKCkVSUk9SOiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0aGUgYmVn
aW5uaW5nIG9mIHRoZSBkZWNsYXJhdGlvbgojNTE6IEZJTEU6IGxpbnV4LXVzZXIvc3RyYWNlLmM6
MTAwMToKK1VOVVNFRCBzdGF0aWMgc3RydWN0IGZsYWdzIHN0YXR4X21hc2tbXSA9IHsKCnRvdGFs
OiAyIGVycm9ycywgMCB3YXJuaW5ncywgMTA0IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvNiBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy82IENoZWNraW5nIGNvbW1pdCBmMGQ4OWY4NmY1NDQg
KGxpbnV4LXVzZXI6IEZpeCB0YXJnZXRfZmxvY2sgc3RydWN0dXJlIGZvciBNSVBTIE82NCBBQkkp
CjQvNiBDaGVja2luZyBjb21taXQgOWRmNTRkYzI5M2UzIChsaW51eC11c2VyOiBJbnRyb2R1Y2Ug
VEFSR0VUX0hBVkVfQVJDSF9TVFJVQ1RfRkxPQ0spCjUvNiBDaGVja2luZyBjb21taXQgMjFkMjRh
ZTk3ZjNlIChsaW51eC11c2VyOiBIYW5kbGUgRVhDUF9GUEUgcHJvcGVybHkgZm9yIE1JUFMpCjYv
NiBDaGVja2luZyBjb21taXQgNmNhMjdjZGRhNmRmIChsaW51eC11c2VyOiBtb3ZlIFFFTVVfSUZM
QV9CUl9NVUxUSV9CT09MT1BUIHRvIHRoZSBnb29kIGZ1bmN0aW9uKQo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDcwMjE1MDU0NS4xODcyLTEt
bGF1cmVudEB2aXZpZXIuZXUvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t


