Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FC2C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F6920718
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F6920718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibqMK-0002qi-3k
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ibqLG-0001nk-B1
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ibqLE-0006rU-OA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:22:37 -0500
Resent-Date: Mon, 02 Dec 2019 13:22:37 -0500
Resent-Message-Id: <E1ibqLE-0006rU-OA@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ibqLE-0006pz-GF
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:22:36 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575310952; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UEGSv3dhtte2zEm0W77ZXLZHNPxqqvsu6ShKZ5zhhj3R9J0OueZHqTm6PNPw1QNRe5tfF0AozW/1flpjuNFyZKYsxNZggIZJdZ0EDB30vsqYDRIx/fP7viFhIwMLqyhrXaXrydrtMXg7W0Qur5xUAvW2cB15PaTQAkVnvtVXBg0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575310952;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=CWP0cIfWI/AE17V8wNcsH48rzdhVq6LIa7txQjYrTJE=; 
 b=Rcd5l0svpfMX6+GI9v+Id5Cp2AfzU8skIBcAu/Nt3ha/oQgvFwDorjwUYHLbXMmQrheEKjmaZmsszRntkzUCt1bQv2bF7acUzpPw9Gik7r1ZKWCbqmC2FOuG+vw1qhS6JTFu1OBr+8VVMpzSFTCgtYIQJrUXPEijSrW1dTgD4NI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575310949751765.8117299806026;
 Mon, 2 Dec 2019 10:22:29 -0800 (PST)
In-Reply-To: <20191202152746.32292-1-armbru@redhat.com>
Subject: Re: [PULL for-4.2 0/3] Error reporting patches for 2019-12-02
Message-ID: <157531094882.11577.6287471121319964887@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Mon, 2 Dec 2019 10:22:29 -0800 (PST)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTIwMjE1Mjc0Ni4zMjI5
Mi0xLWFybWJydUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUFVMTCBmb3ItNC4yIDAvM10gRXJyb3IgcmVwb3J0aW5nIHBh
dGNoZXMgZm9yIDIwMTktMTItMDIKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkxMjAyMTUy
NzQ2LjMyMjkyLTEtYXJtYnJ1QHJlZGhhdC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFt
Ci4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQ
VCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQog
ICBmYjIyNDY4Li4zOTAzMjk4ICBtYXN0ZXIgICAgIC0+IG1hc3RlcgpGcm9tIGh0dHBzOi8vZ2l0
aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3
LzIwMTkxMjAyMTUyNzQ2LjMyMjkyLTEtYXJtYnJ1QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5
MTIwMjE1Mjc0Ni4zMjI5Mi0xLWFybWJydUByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJy
YW5jaCAndGVzdCcKCj09PSBPVVRQVVQgQkVHSU4gPT09CmNoZWNrcGF0Y2gucGw6IG5vIHJldmlz
aW9ucyByZXR1cm5lZCBmb3IgcmV2bGlzdCAnMScKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMjU1CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTIwMjE1Mjc0Ni4zMjI5Mi0xLWFybWJydUBy
ZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


