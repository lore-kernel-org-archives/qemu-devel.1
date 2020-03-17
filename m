Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A5BC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D42020674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbAMvCsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D42020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE58B-0000s7-ED
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 01:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jE57H-00083l-T9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jE57G-0004RN-Mz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:50:15 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45480)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jE57E-0004CD-8F; Tue, 17 Mar 2020 01:50:12 -0400
Received: by mail-pl1-x644.google.com with SMTP id b22so9119570pls.12;
 Mon, 16 Mar 2020 22:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RpIYMi98ERdqGF80xj54e/sTeGl4eeAe2USIP3ZNd7Y=;
 b=fbAMvCsSn4u/n2d+RNS8uAP3/OemUPdCNzf8LZv/AoKlY8KD42DcUln82nEGp5yair
 3y9ejONIB3XLoYPUvLYv08PPJ3mopXKIYnfspvf+1n8dsQ+LMTWIwgtuVCHX34xBJsbW
 GDgV8h1Nf9gg/bkXZ7HS+vOGFeBySt1PlBuUif42tEGc2cv6efv2sxCEruEitWLXiGex
 QgPT7J7heqweC+a06GjuDVMLlTaypCl57cGu2132Vad/+RWkOndQhH50YiaCxTruhdHe
 qJlrRca2dsNNmU+NZ+aaMtW89eeZafrMBoDDWo4zPVcxjfbQLGZjC4diZCPy0BWy9BUc
 Hr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RpIYMi98ERdqGF80xj54e/sTeGl4eeAe2USIP3ZNd7Y=;
 b=pqZjlo8APXqYH9ON/BTOyDGe8SntWI5fD7iE4LUaMEioMP6GE38aZlRaLaNqN0YBX9
 tSfqpJDSy4Yym3B4AAeHwiOBz/Q9z9qfGUiUKCqrv35jxlfgRkn29qmO13ZHJzck4FNR
 rNIKCep7smHmmufjJ/KRodXq/olIZtuvR/nbBZWQkp054TeiSg92VIxKVl99Ab4xjQ5n
 fscpJ/Lqp9IzMu6vrbtleOX3XBau45/DN64rxa8fBBffI8vd3gt/XOLTTAWjvuy7S346
 CIE8EINdidQGH566oMYwRN4czcfhBleP60ioYEixN0gcceMV7kFqbYYkTDXo9Lh3ibyf
 FkRQ==
X-Gm-Message-State: ANhLgQ1+bC5blvuc3886duBxCAkGZeXfIP34iwD0bVCtjgniTC3NC5/E
 Y/vS4JCxwqFdtOBLtBkapypdh2Xh1Rw=
X-Google-Smtp-Source: ADFU+vsqrdcfc9VzdFKTD8gYizVpKT5bTYQbMDOA1CE7+Z6keixIessDOwKGCqfN2jpgvzvKMyR+4g==
X-Received: by 2002:a17:902:34f:: with SMTP id 73mr2671593pld.50.1584424210881; 
 Mon, 16 Mar 2020 22:50:10 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (14-202-190-183.tpgi.com.au.
 [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id s206sm1599735pfs.100.2020.03.16.22.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 22:50:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v3 1/2] target/ppc: Improve syscall exception logging
Date: Tue, 17 Mar 2020 15:49:17 +1000
Message-Id: <20200317054918.199161-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

system calls (at least in Linux) use registers r3-r8 for inputs, so
include those registers in the dump.

This also adds a mode for PAPR hcalls, which have a different calling
convention.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v2:
- Rebased on top of FWNMI series

 target/ppc/excp_helper.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 08bc885ca6..81ee19ebae 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -57,12 +57,29 @@ static void ppc_hw_interrupt(CPUPPCState *env)
 #else /* defined(CONFIG_USER_ONLY) */
 static inline void dump_syscall(CPUPPCState *env)
 {
-    qemu_log_mask(CPU_LOG_INT, "syscall r0=%016" PRIx64 " r3=%016" PRIx64
-                  " r4=%016" PRIx64 " r5=%016" PRIx64 " r6=%016" PRIx64
+    qemu_log_mask(CPU_LOG_INT, "syscall r0=%016" PRIx64
+                  " r3=%016" PRIx64 " r4=%016" PRIx64 " r5=%016" PRIx64
+                  " r6=%016" PRIx64 " r7=%016" PRIx64 " r8=%016" PRIx64
                   " nip=" TARGET_FMT_lx "\n",
                   ppc_dump_gpr(env, 0), ppc_dump_gpr(env, 3),
                   ppc_dump_gpr(env, 4), ppc_dump_gpr(env, 5),
-                  ppc_dump_gpr(env, 6), env->nip);
+                  ppc_dump_gpr(env, 6), ppc_dump_gpr(env, 7),
+                  ppc_dump_gpr(env, 8), env->nip);
+}
+
+static inline void dump_hcall(CPUPPCState *env)
+{
+    qemu_log_mask(CPU_LOG_INT, "hypercall r3=%016" PRIx64
+		  " r4=%016" PRIx64 " r5=%016" PRIx64 " r6=%016" PRIx64
+		  " r7=%016" PRIx64 " r8=%016" PRIx64 " r9=%016" PRIx64
+		  " r10=%016" PRIx64 " r11=%016" PRIx64 " r12=%016" PRIx64
+                  " nip=" TARGET_FMT_lx "\n",
+                  ppc_dump_gpr(env, 3), ppc_dump_gpr(env, 4),
+		  ppc_dump_gpr(env, 5), ppc_dump_gpr(env, 6),
+		  ppc_dump_gpr(env, 7), ppc_dump_gpr(env, 8),
+		  ppc_dump_gpr(env, 9), ppc_dump_gpr(env, 10),
+		  ppc_dump_gpr(env, 11), ppc_dump_gpr(env, 12),
+		  env->nip);
 }
 
 static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
@@ -379,9 +396,14 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
         }
         break;
     case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
-        dump_syscall(env);
         lev = env->error_code;
 
+        if ((lev == 1) && cpu->vhyp) {
+            dump_hcall(env);
+        } else {
+            dump_syscall(env);
+        }
+
         /*
          * We need to correct the NIP which in this case is supposed
          * to point to the next instruction
-- 
2.23.0


