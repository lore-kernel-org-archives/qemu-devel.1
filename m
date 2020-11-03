Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199CEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CCD22280
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CCD22280
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxDa-0001jR-7Y
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kZxCf-0000mk-H3
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:22:29 -0500
Resent-Date: Tue, 03 Nov 2020 09:22:29 -0500
Resent-Message-Id: <E1kZxCf-0000mk-H3@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kZxCc-00022f-Bb
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:22:28 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604413340; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=d5/oCNBOUG6c1v1Ve1ggzTHrBG00UHydFOqqp2ki71re+g66uLd4LDJVqpgxuUbKYp7SOxZq9Pfb0IMzqs/Exmz+Syt/FDV+V5D9P7FKYDcymx/hBFUx/vaNRF1QcO0pJbXPxLt49zJZKbSzZ5stP+IB52iOr37YapRtIfCSopI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1604413340;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=AHybv72+6I/PKVgTWz2zLpYpiyjbJYIbox4DMHx5G0M=; 
 b=jeiphsmtFxBe4FRdu97lCkAIafnvLKIjw69YrODuEhQ5R6f49ek+yTsAfP2NsBGJyj9z0ssYsV2x4OBaYOkpusnYiq7OIpBxTRtrCvoiO1SyVo+lGTiwO2ZkCkU8mXGpp1frzwGlSzoczIChHY0JBuAr3aO/7SfKcFG8g6I9UJo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1604413338512171.49412658070128;
 Tue, 3 Nov 2020 06:22:18 -0800 (PST)
Subject: Re: [PATCH] linux-user: Check copy_from_user() return value in
 vma_dump_size()
Message-ID: <160441333740.30694.4676746815574272642@66eaa9a8a123>
In-Reply-To: <20201103141532.19912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Tue, 3 Nov 2020 06:22:18 -0800 (PST)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 09:22:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTEwMzE0MTUzMi4xOTkx
Mi0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAxMTAzMTQxNTMy
LjE5OTEyLTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnClN1YmplY3Q6IFtQQVRDSF0gbGludXgt
dXNlcjogQ2hlY2sgY29weV9mcm9tX3VzZXIoKSByZXR1cm4gdmFsdWUgaW4gdm1hX2R1bXBfc2l6
ZSgpCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2Ug
YmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
bGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAt
LW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1
YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFu
Y2ggJ3Rlc3QnCjQyMTI2NWMgbGludXgtdXNlcjogQ2hlY2sgY29weV9mcm9tX3VzZXIoKSByZXR1
cm4gdmFsdWUgaW4gdm1hX2R1bXBfc2l6ZSgpCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjog
c3BhY2UgcHJvaGliaXRlZCBiZXR3ZWVuIGZ1bmN0aW9uIG5hbWUgYW5kIG9wZW4gcGFyZW50aGVz
aXMgJygnCiMyNjogRklMRTogbGludXgtdXNlci9lbGZsb2FkLmM6MzQ4NzoKKyAgICAgICAgaWYg
KGNvcHlfZnJvbV91c2VyKHBhZ2UsIHZtYS0+dm1hX3N0YXJ0LCBzaXplb2YgKHBhZ2UpKSkgewoK
dG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMCBsaW5lcyBjaGVja2VkCgpDb21taXQgNDIx
MjY1Yzg0ZGNiIChsaW51eC11c2VyOiBDaGVjayBjb3B5X2Zyb21fdXNlcigpIHJldHVybiB2YWx1
ZSBpbiB2bWFfZHVtcF9zaXplKCkpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAxMTAzMTQxNTMy
LjE5OTEyLTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==

