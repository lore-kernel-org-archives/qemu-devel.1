Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2394C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 10:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6ED621655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 10:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6ED621655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imxxp-0007rV-TG
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 05:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1imxwi-0006Wq-0X
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1imxwc-0005We-PF
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:43:15 -0500
Resent-Date: Thu, 02 Jan 2020 05:43:15 -0500
Resent-Message-Id: <E1imxwc-0005We-PF@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1imxwc-0005W9-Ga
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:43:10 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1577961783; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Fy3L/9zSZkoNUXItb+6ylr4gQXG4byNT2+jCAD+OYYn+lc113QFpS15WkcnbYOpu9bOtOb5rPbRuWIKT1rXxlx1sjETxlzRW4NehTElxm4rzOEjF26A14g4m1DdTZZ+bAWBeKCs8cmBkYisxNQAf9NI5iYTSKymGAzxWTpQpJVM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1577961783;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=4DLmm48Fq2jToUFx5AS2Zr1oAPPCEi0LHLJkJufvRWg=; 
 b=ksLci/gZ2695dTWVKU/8Ueskafb2o9R2TqYYgJhLVoSEO71bIPS3YhRnMBSJE2FVCXY+bvuHTUlhuMf+EdxINBi3hbpt/07ghzpBi3F9q1zT7f9Li6AkoTt0jNoFtJow3MplnJbAWBxo4Ay7l67y4AuB3X26VStZUTTT8BVMypQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1577961780920191.8496879064312;
 Thu, 2 Jan 2020 02:43:00 -0800 (PST)
In-Reply-To: <20200102103644.233370-1-Jason@zx2c4.com>
Subject: Re: [PATCH] q800: implement mac rom reset function for BIOS-less mode
Message-ID: <157796178042.32423.9573258526031713349@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: Jason@zx2c4.com
Date: Thu, 2 Jan 2020 02:43:00 -0800 (PST)
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
Cc: Jason@zx2c4.com, laurent@vivier.eu, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEwMjEwMzY0NC4yMzMz
NzAtMS1KYXNvbkB6eDJjNC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSF0gcTgwMDogaW1wbGVtZW50IG1hYyByb20gcmVzZXQg
ZnVuY3Rpb24gZm9yIEJJT1MtbGVzcyBtb2RlClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIw
MDEwMjEwMzY0NC4yMzMzNzAtMS1KYXNvbkB6eDJjNC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpmYXRhbDogdW5hYmxlIHRvIHdyaXRlIG5ldyBpbmRleCBmaWxlCndh
cm5pbmc6IENsb25lIHN1Y2NlZWRlZCwgYnV0IGNoZWNrb3V0IGZhaWxlZC4KWW91IGNhbiBpbnNw
ZWN0IHdoYXQgd2FzIGNoZWNrZWQgb3V0IHdpdGggJ2dpdCBzdGF0dXMnCmFuZCByZXRyeSB0aGUg
Y2hlY2tvdXQgd2l0aCAnZ2l0IGNoZWNrb3V0IC1mIEhFQUQnCgpUcmFjZWJhY2sgKG1vc3QgcmVj
ZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAicGF0Y2hldy10ZXN0ZXIyL3NyYy9wYXRjaGV3LWNsaSIs
IGxpbmUgNTMxLCBpbiB0ZXN0X29uZQogICAgZ2l0X2Nsb25lX3JlcG8oY2xvbmUsIHJbInJlcG8i
XSwgclsiaGVhZCJdLCBsb2dmLCBUcnVlKQogIEZpbGUgInBhdGNoZXctdGVzdGVyMi9zcmMvcGF0
Y2hldy1jbGkiLCBsaW5lIDYyLCBpbiBnaXRfY2xvbmVfcmVwbwogICAgc3VicHJvY2Vzcy5jaGVj
a19jYWxsKGNsb25lX2NtZCwgc3RkZXJyPWxvZ2YsIHN0ZG91dD1sb2dmKQogIEZpbGUgIi9vcHQv
cmgvcmgtcHl0aG9uMzYvcm9vdC91c3IvbGliNjQvcHl0aG9uMy42L3N1YnByb2Nlc3MucHkiLCBs
aW5lIDI5MSwgaW4gY2hlY2tfY2FsbAogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snZ2l0Jywg
J2Nsb25lJywgJy1xJywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9wYXRjaGV3LWdpdC1jYWNoZS9o
dHRwc2dpdGh1YmNvbXBhdGNoZXdwcm9qZWN0cWVtdS0zYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1oNGR2bHd6dS9z
cmMnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMTI4LgoKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMTAyMTAzNjQ0LjIz
MzM3MC0xLUphc29uQHp4MmM0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=


