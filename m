Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EF4C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40672222C7
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFLDkUpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40672222C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWuo-0004my-T4
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcE-0002fX-Q3
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWc9-0004ki-1J
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWc8-0004ht-Md
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id z12so1826259pgp.9
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Lvd4eeuinUqzweCiCcYtM7YlQdV39v/YpVBNYDRC1E4=;
 b=UFLDkUpThBi+7GVzuQ58gcWc/uCuf/Vn1gf14ukOsguCx7F2/eeuxQC4k6GVOPrH/d
 ClB+F52WO9OK9Zaho8MGS86h0KxQe4jVdzItOrwusIU/H+m10/CA6IKQpV5MANonvKQk
 AlBnMsfsizO9CcU6440GQ4/wxd8SDE58YmMIJDYbK+mLzTVw8u6EdIS/CNBwYxC5zNcc
 vndbQeui10MYagqXkbaSzK05kwL8YtEjjtTIY+KdvE7ktAPfYDMwNIrrGji3xTFj4uk4
 lbnCQRlPRKdYG9npLjei9T9LQCw9pp4upu/ctPY5Heso2s5sHqxVUMBJmZEMnc3NIqCB
 KNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Lvd4eeuinUqzweCiCcYtM7YlQdV39v/YpVBNYDRC1E4=;
 b=nD6f8HbqHwRB0lmXFAGtybwV2WLReUZiFY10Z3wwKx+fVrzuZp4v18+Q5+bp56QduN
 exDbOTND6norH+ZGCq+dsWZoyNeU39UoSi9EWEtRAxA4dsVL8O4sHsTG7jImxTygKkyz
 XMP4G4qoqUcOyKSfBBw+g/fwiZbpX/YRKx6ttGrq6j13jmMPa4HO69i3IP2P9w+X53GK
 V2261h0NV6Cj1B0xkuYIqsvK/JQjsVt1NI0c4OjUA/oywYT9gPilEWda6wvUKmzDEGeu
 q2igrXxqt/+VBjt94JoGnb0K2DvF3TfdpjlN0wiuf1wC/5injthUPDWVKgoe9Ue5EfqX
 ZnCA==
X-Gm-Message-State: APjAAAXwX8th/82pf2aVM0v5C90rDMj4Jw9em6zn6J87ERoxPygvtXrn
 6oX0tRZMd8xxndFgMIvt8N+WmSVVw1Y=
X-Google-Smtp-Source: APXvYqz5m1jDRqLo5aZW9YsMgn1rlI6t9Yha17bnTpp+8yFlKUqrD43BhiQEDymzpr03M7z7cscNhw==
X-Received: by 2002:a65:62cd:: with SMTP id m13mr4186640pgv.437.1569515189399; 
 Thu, 26 Sep 2019 09:26:29 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/18] target/s390: Return exception from mmu_translate_real
Date: Thu, 26 Sep 2019 09:26:05 -0700
Message-Id: <20190926162615.31168-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not raise the exception directly within mmu_translate_real,
but pass it back so that caller may do so.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/internal.h    | 2 +-
 target/s390x/excp_helper.c | 4 ++--
 target/s390x/mmu_helper.c  | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index c243fa725b..c4388aaf23 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -362,7 +362,7 @@ void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
 int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
                   target_ulong *raddr, int *flags, bool exc);
 int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
-                       target_ulong *addr, int *flags);
+                       target_ulong *addr, int *flags, uint64_t *tec);
 
 
 /* misc_helper.c */
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index ab2ed47fef..906b87c071 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -147,8 +147,8 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         if (!(env->psw.mask & PSW_MASK_64)) {
             vaddr &= 0x7fffffff;
         }
-        fail = mmu_translate_real(env, vaddr, access_type, &raddr, &prot);
-        excp = 0; /* exception already raised */
+        excp = mmu_translate_real(env, vaddr, access_type, &raddr, &prot, &tec);
+        fail = excp;
     } else {
         g_assert_not_reached();
     }
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 3ef40a37a7..b783c62bd7 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -523,10 +523,10 @@ void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra)
  * @param rw     0 = read, 1 = write, 2 = code fetch
  * @param addr   the translated address is stored to this pointer
  * @param flags  the PAGE_READ/WRITE/EXEC flags are stored to this pointer
- * @return       0 if the translation was successful, < 0 if a fault occurred
+ * @return       0 = success, != 0, the exception to raise
  */
 int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
-                       target_ulong *addr, int *flags)
+                       target_ulong *addr, int *flags, uint64_t *tec)
 {
     const bool lowprot_enabled = env->cregs[0] & CR0_LOWPROT;
 
@@ -535,8 +535,8 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
         /* see comment in mmu_translate() how this works */
         *flags |= PAGE_WRITE_INV;
         if (is_low_address(raddr) && rw == MMU_DATA_STORE) {
-            trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, 0);
-            return -EACCES;
+            *tec = 0;
+            return PGM_PROTECTION;
         }
     }
 
-- 
2.17.1


