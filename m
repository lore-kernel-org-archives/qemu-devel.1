Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0133AC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B082085B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B082085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWzC-0006EG-VG
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTWtE-000530-IH
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTWtC-0007jC-JS
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:31:36 -0400
Resent-Date: Tue, 28 Apr 2020 16:31:36 -0400
Resent-Message-Id: <E1jTWtC-0007jC-JS@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTWtB-0007i9-Tr
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:31:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588105887; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=chh1RoOHyABUZje194L8qA/R5FE9hvXtORaKdGOsDm5Ibq5m/VHWlWSY655u+sDfv5EMj2m4SOXLYdsfkoV9I9bGWjA5gxtYBN2AXHkVbn1ONT3mgvLzWLOBlKlSso+nMmoH956cJRB/OuBCql1O+lEgcr1sZBbdIMZASVecj4w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588105887;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=/vDuGNjBUrd80FXJyXRjIoX6Tyb7tJRV8GlIByU9zC0=; 
 b=GwXaGVCWD8W+8Ogspgwaq4FjEEuXsx+hqzOgvQ7SjwPeecEv62M9dv6DHuN+t1R2a/+pAf9zqhu5F/5OPUltcSYi/kYz08g78rYjY6//vy9H2ulmpm2MxUE01PBOn51rvW3PaXbKPnBy0uweTTNsALmEroKziLyEKbcfkzKXjPw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588105886449968.2622602978125;
 Tue, 28 Apr 2020 13:31:26 -0700 (PDT)
In-Reply-To: <20200428171633.17487-1-alex.bennee@linaro.org>
Subject: Re: [RFC PATCH] plugins: new lockstep plugin for debugging TCG changes
Message-ID: <158810588518.2837.10235303350554397297@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Tue, 28 Apr 2020 13:31:26 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 16:31:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
 alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyODE3MTYzMy4xNzQ4
Ny0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtSRkMgUEFUQ0hdIHBsdWdpbnM6IG5ldyBsb2Nrc3Rl
cCBwbHVnaW4gZm9yIGRlYnVnZ2luZyBUQ0cgY2hhbmdlcwpNZXNzYWdlLWlkOiAyMDIwMDQyODE3
MTYzMy4xNzQ4Ny0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcKVHlwZTogc2VyaWVzCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYv
bnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
YWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJh
c2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0
ZXN0Jwo2MDhmZGQzIHBsdWdpbnM6IG5ldyBsb2Nrc3RlcCBwbHVnaW4gZm9yIGRlYnVnZ2luZyBU
Q0cgY2hhbmdlcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KV0FSTklORzogYWRkZWQsIG1vdmVkIG9y
IGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMzY6IApu
ZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzCiMx
NjI6IEZJTEU6IHRlc3RzL3BsdWdpbi9sb2Nrc3RlcC5jOjEyMjoKKyAgICAvLyBjb21wYXJlIGFu
ZCBiYWlsCgpFUlJPUjogZG8gbm90IHVzZSBDOTkgLy8gY29tbWVudHMKIzE2ODogRklMRTogdGVz
dHMvcGx1Z2luL2xvY2tzdGVwLmM6MTI4OgorICAgIC8vIG1hcmsgdGhlIGV4ZWN1dGlvbiBhcyBj
b21wbGV0ZQoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnLScgKGN0eDpWeFYp
CiMyMDM6IEZJTEU6IHRlc3RzL3BsdWdpbi9sb2Nrc3RlcC5jOjE2MzoKKyAgICBnX3N0cmxjcHko
c29ja2FkZHIuc3VuX3BhdGgsIHBhdGgsIHNpemVvZihzb2NrYWRkci5zdW5fcGF0aCktMSk7CiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnLScgKGN0eDpWeFYp
CiMyNDI6IEZJTEU6IHRlc3RzL3BsdWdpbi9sb2Nrc3RlcC5jOjIwMjoKKyAgICBnX3N0cmxjcHko
c29ja2FkZHIuc3VuX3BhdGgsIHBhdGgsIHNpemVvZihzb2NrYWRkci5zdW5fcGF0aCktMSk7CiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXgoKdG90YWw6IDQgZXJyb3JzLCAxIHdhcm5pbmdzLCAyNTEgbGluZXMgY2hlY2tlZAoK
Q29tbWl0IDYwOGZkZDNhN2Q3YSAocGx1Z2luczogbmV3IGxvY2tzdGVwIHBsdWdpbiBmb3IgZGVi
dWdnaW5nIFRDRyBjaGFuZ2VzKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVU
IEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDQyODE3MTYzMy4x
NzQ4Ny0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
czovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t

