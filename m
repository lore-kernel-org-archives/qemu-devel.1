Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578E9C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258C42737D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzzzAgx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258C42737D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38411 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqfl-0007wI-93
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:23:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUL-0007GC-Nq
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUK-0004MD-4c
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:13 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:39501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUJ-0003qB-Qm
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:12 -0400
Received: by mail-wr1-x432.google.com with SMTP id x4so12920847wrt.6
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=vc64i+V8AvVjruMmRgyWsqB0XBi6fzlLO4mu9/lTb9I=;
	b=PzzzAgx5geEqL8awZmMUpoTyTtKnnFqtCOGU4l1QQb+4HTbjdSK8AYJLMd76aMmrL5
	aTR3Xi3drLb5mLi2+49YFPd8ejGnxTumeOUZjRnfo6wUp3QNZGSKu5ujg80ACHRvS4+c
	DkaK0lBdP0tN5gr1m3S8yB22ZBEG91U8/VpsdCYTmMdPIFbRW6CAv9NiNhg2BsoTbXXB
	AUfekDCoB50Q5DHjDQH59mDPaOjYMWqj7Mhnqw7+V8zOY5rwrK3RP1lYuo6uq9MzuELI
	wvsF1RXW3f5BU/dhNyaatqWn2b2GBe2mUZO+DPcH1kjVfbw/y/i0GO4nzfWTOQGrbGRS
	IrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=vc64i+V8AvVjruMmRgyWsqB0XBi6fzlLO4mu9/lTb9I=;
	b=Ki2SFdThwXgOqrdFuMHFhLpobeNgY/RqfVbkXZ2slYMynl0/ifbOqQL1fvHYXmRVJO
	FQkCd39k99RqOtPBo63WzzSXK93cqsQwPWec83HKoDyImWHg5Xm2UE6w8BBelrBqWEqw
	5ot9NkPxo2FnvhHEQEZVqMTilSNMHo56QPi5JADQ4A+t6CbugCYmYVp3UjaAEI5a/dCg
	n3kgu/72ZNRJVf1QnWPWu3HbjF4L8HViSskDEp7aWf+9QWVPJxA5CjBEHB53NX5RxvPU
	9kVJk5bWpo84hzn7+pyEWDsmQk188GUcUtSpzgnaq8dBF5e5AHgZgLMZUqHRyNTKo+Lt
	mJNw==
X-Gm-Message-State: APjAAAXhX3MHkZOOU6pFf/ZLgTs7erXDelL+PsYElupHdAqts4F2ggzl
	cH3G9T/A50KSThigsaKKatASu3h/
X-Google-Smtp-Source: APXvYqw/2lE4qoWpI5XfDU6oOZbt0ePSUIxB0xAcZah1hZ/7siNaj1Y4YEtnQ10190L9UhtOVS3fYQ==
X-Received: by 2002:adf:e311:: with SMTP id b17mr17283846wrj.11.1559581851740; 
	Mon, 03 Jun 2019 10:10:51 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:24 +0200
Message-Id: <1559581843-3968-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 05/24] i386: Enable IA32_MISC_ENABLE MWAIT bit
 when exposing mwait/monitor
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Wanpeng Li <wanpengli@tencent.com>, Eduardo Habkost <ehabkost@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wanpeng Li <wanpengli@tencent.com>

The CPUID.01H:ECX[bit 3] ought to mirror the value of the MSR
IA32_MISC_ENABLE MWAIT bit and as userspace has control of them
both, it is userspace's job to configure both bits to match on
the initial setup.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Message-Id: <1557813999-9175-1-git-send-email-wanpengli@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 3 +++
 target/i386/cpu.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 536d7d1..c1ab86d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4730,6 +4730,9 @@ static void x86_cpu_reset(CPUState *s)
 
     env->pat = 0x0007040600070406ULL;
     env->msr_ia32_misc_enable = MSR_IA32_MISC_ENABLE_DEFAULT;
+    if (env->features[FEAT_1_ECX] & CPUID_EXT_MONITOR) {
+        env->msr_ia32_misc_enable |= MSR_IA32_MISC_ENABLE_MWAIT;
+    }
 
     memset(env->dr, 0, sizeof(env->dr));
     env->dr[6] = DR6_FIXED_1;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fce6660..bd06523 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -387,6 +387,7 @@ typedef enum X86Seg {
 #define MSR_IA32_MISC_ENABLE            0x1a0
 /* Indicates good rep/movs microcode on some processors: */
 #define MSR_IA32_MISC_ENABLE_DEFAULT    1
+#define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
 
 #define MSR_MTRRphysBase(reg)           (0x200 + 2 * (reg))
 #define MSR_MTRRphysMask(reg)           (0x200 + 2 * (reg) + 1)
-- 
1.8.3.1



