Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D002C83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 01:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502A120757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 01:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502A120757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTxtt-0006z5-EL
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 21:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTxt0-0006N6-0u
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 21:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTxsI-0004NI-S8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 21:21:09 -0400
Resent-Date: Wed, 29 Apr 2020 21:21:09 -0400
Resent-Message-Id: <E1jTxsI-0004NI-S8@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTxsH-0004Mv-74
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 21:20:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588209616; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=l/Ur5fBfVrqBQCWeZK/IKSdVrM+73sTZIJf7x8pzhw4cgSdXOPkr8zZk7ZgLrJlmR9RpBHbrVJCXGIYCKtMVQh25ckmU6dcvX/6MI4ao1LFm4rmSWLqss8PA5u1SIRSftRl0dbrxsVMxM535ozV1xGnwB+gnuBnaOx1MNzz9VUc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588209616;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=W4Uy3oaCMWF2v8azlax1xPKx7ooocpdy+/tpwVdkhWU=; 
 b=OC0ZbR0v6/zrYp+4w4AlaxOVoFN/0B0DaxknSNmxxUUD1YDn3Nw1+2atFRpUsykIf9WH+qtXMPzKpjVyMx3g4h1lMJRIRkGJXi1xou2Ii6B/BiLux8ROVzjUUdokDz0m3VJuTkLnmy9wve8r7JB+wkyJ1a2o0C8yA/+7v78iCV0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158820961535676.81794784228498;
 Wed, 29 Apr 2020 18:20:15 -0700 (PDT)
Message-ID: <158820961411.4471.18166306848973407826@45ef0f9c86ae>
In-Reply-To: <20200429200754.18327-1-alex.bennee@linaro.org>
Subject: Re: [RFC PATCH v2] plugins: new lockstep plugin for debugging TCG
 changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Wed, 29 Apr 2020 18:20:15 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 19:37:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.57
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
Cc: mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
 alex.bennee@linaro.org, qemu-devel@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyOTIwMDc1NC4xODMy
Ny0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNDI5MjAwNzU0LjE4MzI3LTEtYWxleC5i
ZW5uZWVAbGluYXJvLm9yZwpTdWJqZWN0OiBbUkZDIFBBVENIIHYyXSBwbHVnaW5zOiBuZXcgbG9j
a3N0ZXAgcGx1Z2luIGZvciBkZWJ1Z2dpbmcgVENHIGNoYW5nZXMKVHlwZTogc2VyaWVzCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9k
ZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNo
ICd0ZXN0JwowZjk4ZWYyIHBsdWdpbnM6IG5ldyBsb2Nrc3RlcCBwbHVnaW4gZm9yIGRlYnVnZ2lu
ZyBUQ0cgY2hhbmdlcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KV0FSTklORzogYWRkZWQsIG1vdmVk
IG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNTQ6
IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMK
IzE3NTogRklMRTogdGVzdHMvcGx1Z2luL2xvY2tzdGVwLmM6MTE3OgorICAgIGdfc3RyaW5nX2Fw
cGVuZF9wcmludGYob3V0LCAiV2UgYXJlICBAICUjMDE2bHggdnMgJSMwMTZseFxuIiwgdXMtPnBj
LCB0aGVtLT5wYyk7CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTc5OiBGSUxF
OiB0ZXN0cy9wbHVnaW4vbG9ja3N0ZXAuYzoxMjE6CisgICAgICAgIGdfc3RyaW5nX2FwcGVuZF9w
cmludGYob3V0LCAiICBwcmV2aW91c2x5IEAgJSMwMTZseC8lbGQgKCVsZCBpbnNuLCAlbGQgYmxv
Y2tzKVxuIiwKCkVSUk9SOiBkbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwojMjU5OiBGSUxFOiB0
ZXN0cy9wbHVnaW4vbG9ja3N0ZXAuYzoyMDE6CisgICAgLy8gc2F2ZSBhIHJlZmVyZW5jZSBzbyB3
ZSBjYW4gZnJlZSBsYXRlcgoKdG90YWw6IDEgZXJyb3JzLCAzIHdhcm5pbmdzLCAzMjIgbGluZXMg
Y2hlY2tlZAoKQ29tbWl0IDBmOThlZjJiNWNlMiAocGx1Z2luczogbmV3IGxvY2tzdGVwIHBsdWdp
biBmb3IgZGVidWdnaW5nIFRDRyBjaGFuZ2VzKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9
PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDQy
OTIwMDc1NC4xODMyNy0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNo
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

