Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0223C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A467214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR4Q9798"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A467214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izkgo-0005Ky-IL
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1izkfa-00041l-VA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:10:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1izkfZ-0001Fi-V4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:10:26 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1izkfZ-00012Z-Nr
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:10:25 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so8147116wru.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jjnCZXZi3hUirJrFffysm+Ox+oJ10wc0HIp1OeZZuEY=;
 b=bR4Q9798eIFtn8fyzdrW+7OfX4DTyVQZYA93shTvUuuUVZys/rXRJYdJE4MDurylSj
 Gw5rFUCnXkRXzA0TCz4c+nqGHFEIvJRzOcmEBR3sI6WwUzwGUl2peXfg946p98sOd09P
 cetE7SRDnZo6U7DQfZ6Aha9y9qhbMZTWNDHTybkG8lqCsTx1FnwL9lDqqzhwoPQdnIVb
 PqnrX6LA0zkcKoCe8iAnpUoBKbEaN8RnSyzx+VJToX3L0OFMJlxQDtnlksWXR6sNYsAd
 NbmKokPa6GZwb0PUAnSJF6Ak97gmbNutnBd5W+qQOhTvxXsVxX3POYU7+oGlre+hqZUX
 nJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=jjnCZXZi3hUirJrFffysm+Ox+oJ10wc0HIp1OeZZuEY=;
 b=D0mbhxk1PsWSjnxVPL4xtKtYBmWOJFDWI7pj9K6OeE1G8TYslWZmBFJFRPIjhrj2Le
 haiirUrmEn6ri75F+TgrQVir3nT1so2dHWaLnT6RKWcASFTvHYyrPKMwNDcAAlzTYwtk
 tylHVobAseticoXg8DVhfGM2SKjIgkAArj8bdipZ4zsOWMaCskx4x11XS7sR5PVvZVVF
 qQp7jqMVL5AwixHwmxJTJsmJUopLhGlobsbUtHFk2iC3lIoizx2K+V+xwkz6Hyv1A+0G
 Fr4vE7koeSiJD2YjpeOiw8l3pPNBm0Xt2+XpLeF68/qnlcaXcRZcvC5JT8HZXJfdhHs6
 pazQ==
X-Gm-Message-State: APjAAAX+rREWy0XiWdQxE6GQpOeIBLiU4GmcBbms0cuHTRfMasj7DHsN
 uYeGSCZYGwgSlsdzK/QdAWTjNDEb
X-Google-Smtp-Source: APXvYqzhrFohSuys/tm+Sn18j0EfJQdq6+DBH0p1AtJjyfqQGSsPQZLmTaiyd/7uMA/TqSeuxNiMCw==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr5098633wrx.153.1581009024091; 
 Thu, 06 Feb 2020 09:10:24 -0800 (PST)
Received: from donizetti.redhat.com (nat-pool-mxp-u.redhat.com.
 [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id k16sm5241246wru.0.2020.02.06.09.10.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:10:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: fix TCG UCODE_REV access
Date: Thu,  6 Feb 2020 18:10:22 +0100
Message-Id: <20200206171022.9289-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This was a very interesting semantic conflict that caused git to move
the MSR_IA32_UCODE_REV read to helper_wrmsr.  Not a big deal, but
still should be fixed...

Fixes: 4e45aff398 ("target/i386: add a ucode-rev property", 2020-01-24)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/misc_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index aed16fe3f0..7d61221024 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -229,7 +229,6 @@ void helper_rdmsr(CPUX86State *env)
 #else
 void helper_wrmsr(CPUX86State *env)
 {
-    X86CPU *x86_cpu = env_archcpu(env);
     uint64_t val;
 
     cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, GETPC());
@@ -372,9 +371,6 @@ void helper_wrmsr(CPUX86State *env)
         env->msr_bndcfgs = val;
         cpu_sync_bndcs_hflags(env);
         break;
-     case MSR_IA32_UCODE_REV:
-        val = x86_cpu->ucode_rev;
-        break;
     default:
         if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
             && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
@@ -393,6 +389,7 @@ void helper_wrmsr(CPUX86State *env)
 
 void helper_rdmsr(CPUX86State *env)
 {
+    X86CPU *x86_cpu = env_archcpu(env);
     uint64_t val;
 
     cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 0, GETPC());
@@ -526,6 +523,9 @@ void helper_rdmsr(CPUX86State *env)
     case MSR_IA32_BNDCFGS:
         val = env->msr_bndcfgs;
         break;
+     case MSR_IA32_UCODE_REV:
+        val = x86_cpu->ucode_rev;
+        break;
     default:
         if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
             && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
-- 
2.21.0


