Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC92AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3436C2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xx33lHJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3436C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYIp9-00065D-Bd
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 21:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIc0-0004L9-7t
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:48 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbv-0001ri-Tr
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:47 -0400
Received: by mail-pg1-x543.google.com with SMTP id i26so3751033pgl.5
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z2KaP1xs6rRO9cwUUOTb/ugn+4CyHbulGJfJyCgsn04=;
 b=xx33lHJBzp23BGBvF1qD0vsRKsTSd2golyL79BF+ezblp2OuSSEvG2eoPCkdqUsebS
 BE6zIEL2kcsy4iCH/LbU5JLZI+JVnlQ2CSkzchye8ln66nKhPZnu3mK4jxcJK4kbL1Gx
 eYqMVR8Pk0GxhD3QstDMVGj7Hrr6Ye32YHjV7EVz5uCAA7o5zOURa0GNG2rJhpBbH01f
 hcDDyNG0mQWUJBx2V0xqJwZh4Bp2l5VEB6nw29n05Wid5XzLoadrfBZCkwj7PpZkRpHM
 geRZthL+tPxiyaLbagpV6+nuazmBJtQANQtWvsC2Mchq0m9ugmJUp5TFJ6IOX3znvZV4
 Lwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z2KaP1xs6rRO9cwUUOTb/ugn+4CyHbulGJfJyCgsn04=;
 b=j30M7h/p9VBjs0foEp9Ouxf/UqQ9JtR/gNuZKAEEnysjOxZcfbS3CKxgDMb37XWosq
 7DqI+xzgQRvKCIbj0fRCv/I+ljri4ZYaDeqlihU+p59JR3xvwgX2T0EcxdS+gT/TAnLa
 HAnu4qqRrekuA2Qc8xCz1APqoqTH+vXNdKu9VV7CK7Esoh0VwXW/fEc1di6yJaNc2eyP
 8FcvoNN2Bto3/EBeKwYlY0bihv7lpn1X7FPWWKN/OreCYJwgwF7TbGfxRdcHoSjxVS4H
 4Cik0WkcC3ywvqSZ33pL8jTjr3TyqEBXgy/8lRyiOg6FpIEUZ6kgilGlyJYTTb220LVh
 +eqw==
X-Gm-Message-State: AOAM5310lt8O3nmzpDjyxWzndkYBvShaWYKElaFjsi3grLRLHU99wIGZ
 0/zWHFsh5r0rDq/pLkgFTH33jzVmLQrWmQ==
X-Google-Smtp-Source: ABdhPJwummvSf5QzF5URwHX1p7LEfKV6GeR6dMekG2urAv9+ph955YF6bnVR0wzdNIJ5/oX5o0ytcw==
X-Received: by 2002:a17:90a:1690:: with SMTP id
 o16mr1964360pja.148.1604018982218; 
 Thu, 29 Oct 2020 17:49:42 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/19] RFC: accel/tcg: Support split-rwx for darwin/iOS
 with vm_remap
Date: Thu, 29 Oct 2020 17:49:16 -0700
Message-Id: <20201030004921.721096-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: pbonzini@redhat.com, j@getutm.app, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cribbed from code posted by Joelle van Dyne <j@getutm.app>,
and rearranged to a cleaner structure.  Completely untested.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 68 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 3e69ebd1d3..bf8263fdb4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1093,6 +1093,11 @@ static bool alloc_code_gen_buffer_anon(size_t size, int prot, Error **errp)
     int flags = MAP_PRIVATE | MAP_ANONYMOUS;
     void *buf;
 
+#ifdef CONFIG_DARWIN
+    /* Applicable to both iOS and macOS (Apple Silicon). */
+    flags |= MAP_JIT;
+#endif
+
     buf = mmap(NULL, size, prot, flags, -1, 0);
     if (buf == MAP_FAILED) {
         error_setg_errno(errp, errno,
@@ -1182,13 +1187,74 @@ static bool alloc_code_gen_buffer_mirror_memfd(size_t size, Error **errp)
     qemu_madvise(buf_rx, size, QEMU_MADV_HUGEPAGE);
     return true;
 }
-#endif
+#endif /* CONFIG_LINUX */
+
+#ifdef CONFIG_DARWIN
+#include <mach/mach.h>
+
+extern kern_return_t mach_vm_remap(vm_map_t target_task,
+                                   mach_vm_address_t *target_address,
+                                   mach_vm_size_t size,
+                                   mach_vm_offset_t mask,
+                                   int flags,
+                                   vm_map_t src_task,
+                                   mach_vm_address_t src_address,
+                                   boolean_t copy,
+                                   vm_prot_t *cur_protection,
+                                   vm_prot_t *max_protection,
+                                   vm_inherit_t inheritance);
+
+static bool alloc_code_gen_buffer_mirror_vmremap(size_t size, Error **errp)
+{
+    kern_return_t ret;
+    mach_vm_address_t buf_rw, buf_rx;
+    vm_prot_t cur_prot, max_prot;
+
+    /* Map the read-write portion via normal anon memory. */
+    if (!alloc_code_gen_buffer_anon(size, PROT_READ | PROT_WRITE, errp)) {
+        return false;
+    }
+
+    buf_rw = tcg_ctx->code_gen_buffer;
+    buf_rx = 0;
+    ret = mach_vm_remap(mach_task_self(),
+                        &buf_rx,
+                        size,
+                        0,
+                        VM_FLAGS_ANYWHERE | VM_FLAGS_RANDOM_ADDR,
+                        mach_task_self(),
+                        buf_rw,
+                        false,
+                        &cur_prot,
+                        &max_prot,
+                        VM_INHERIT_NONE);
+    if (ret != KERN_SUCCESS) {
+        /* TODO: Convert "ret" to a human readable error message. */
+        error_setg(errp, "vm_remap for jit mirror failed");
+        munmap((void *)buf_rw, size);
+        return false;
+    }
+
+    if (mprotect((void *)buf_rx, size, PROT_READ | PROT_EXEC) != 0) {
+        error_setg_errno(errp, errno, "mprotect for jit mirror");
+        munmap((void *)buf_rx, size);
+        munmap((void *)buf_rw, size);
+        return false;
+    }
+
+    tcg_rx_mirror_diff = buf_rx - buf_rw;
+    return true;
+}
+#endif /* CONFIG_DARWIN */
 
 static bool alloc_code_gen_buffer_mirror(size_t size, Error **errp)
 {
     if (TCG_TARGET_SUPPORT_MIRROR) {
 #ifdef CONFIG_LINUX
         return alloc_code_gen_buffer_mirror_memfd(size, errp);
+#endif
+#ifdef CONFIG_DARWIN
+        return alloc_code_gen_buffer_mirror_vmremap(size, errp);
 #endif
     }
     error_setg(errp, "jit split-rwx not supported");
-- 
2.25.1


