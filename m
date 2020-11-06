Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177B4C55179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2943B20729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FeoFaiUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2943B20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasXv-0004lr-3t
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRe-0004qJ-St
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:46 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRc-0006wq-GG
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:46 -0500
Received: by mail-pf1-x441.google.com with SMTP id o129so63187pfb.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5S5FVYwmKp9iGdEx0YkNjwJAvfyyQ5CRcf+gaFezy/Y=;
 b=FeoFaiUZMXk40Cc0c6BmXWGCm0RpP42O4v/Fb/x+gH+Gfmdv5CkeVL7js5F2KtD7iv
 XjA4o17kGDsBH1RBeP4sUk3T+2+hCD59NCQ95/1Y/chbpTv1XQ3O2Z3pZOaDEf5JdXj5
 PapdRYzXyfdeCdZbqhV8BbSFgwwVTsvGwTomK2qTBkAbLbs1t6MgYms501qTtVxgq9Te
 37EDgPD/I8sAF5Ni9cuRiweBw45EhdSoqRQUWdB+KbsHMt17REGL9Tt7yf/+/IOej4mA
 VlBi7V4yaVIqu1tsFX2KGCxmzKz0ul/cTfk2R/Valgxtbm2xgtqpUc+rm2w4DPvDR7nb
 KtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5S5FVYwmKp9iGdEx0YkNjwJAvfyyQ5CRcf+gaFezy/Y=;
 b=Ciw1GuHDAQ7Q3uxEDh3LWCWMx5x+DZ5Gc0fpTPQQqK4w+A53tQrGVnxADnbKK3WR98
 QpMLJrZQWJl3QGjRJxKRUaerYp4ZHjFogoNY/+XJzDWHiYva8zHtZyugQXNbYIHlhQWY
 ccb5vwhC7iYIfTpjXsenKCEW7FMjnBmMJ3Vrv08sQw70aP7rDSrehbNRg68IH7FUpvyl
 ZR3hc3StHgll+4WYSKaxjUTUkkNUzddI/wufe+uAQ8ZknKMDxUdDHLCDKqQ+p4Ey+SrQ
 rHIDpkA/SZZDykGUeAg2i9zQ4tXc91+9hDAjGJLIcHz54S03gJYWiUkJla4CIiooeX7c
 +whg==
X-Gm-Message-State: AOAM532X7KVvaeYwO+ybaHv0gGuDqPJsFMfPw8BnDUnqToVNUN5brIzc
 fYvDZXreXSuRtPVzhzxAc0DNlQV+jtqkgw==
X-Google-Smtp-Source: ABdhPJxng/MS4TeF2Q3bO6gJpp2n8oJutCpAcAZrFPpqxuRcPmo9H5MEaiNSY4206OBGWG+Ob0bGYA==
X-Received: by 2002:a17:90b:3314:: with SMTP id
 kf20mr178672pjb.156.1604633381341; 
 Thu, 05 Nov 2020 19:29:41 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/41] tcg: Add --accel tcg,split-wx property
Date: Thu,  5 Nov 2020 19:28:54 -0800
Message-Id: <20201106032921.600200-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Plumb the value through to alloc_code_gen_buffer.  This is not
supported by any os or tcg backend, so for now enabling it will
result in an error.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/sysemu/tcg.h      |  3 ++-
 tcg/aarch64/tcg-target.h  |  1 +
 tcg/arm/tcg-target.h      |  1 +
 tcg/i386/tcg-target.h     |  1 +
 tcg/mips/tcg-target.h     |  1 +
 tcg/ppc/tcg-target.h      |  1 +
 tcg/riscv/tcg-target.h    |  1 +
 tcg/s390/tcg-target.h     |  1 +
 tcg/sparc/tcg-target.h    |  1 +
 tcg/tci/tcg-target.h      |  1 +
 accel/tcg/tcg-all.c       | 26 +++++++++++++++++++++++++-
 accel/tcg/translate-all.c | 35 +++++++++++++++++++++++++++--------
 bsd-user/main.c           |  2 +-
 linux-user/main.c         |  2 +-
 14 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/include/sysemu/tcg.h b/include/sysemu/tcg.h
index d9d3ca8559..00349fb18a 100644
--- a/include/sysemu/tcg.h
+++ b/include/sysemu/tcg.h
@@ -8,7 +8,8 @@
 #ifndef SYSEMU_TCG_H
 #define SYSEMU_TCG_H
 
-void tcg_exec_init(unsigned long tb_size);
+void tcg_exec_init(unsigned long tb_size, int splitwx);
+
 #ifdef CONFIG_TCG
 extern bool tcg_allowed;
 #define tcg_enabled() (tcg_allowed)
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 91313d93be..fa64058d43 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -164,5 +164,6 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
+#define TCG_TARGET_SUPPORT_MIRROR       0
 
 #endif /* AARCH64_TCG_TARGET_H */
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index b21a2fb6a1..e355d6a4b2 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -150,5 +150,6 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
+#define TCG_TARGET_SUPPORT_MIRROR       0
 
 #endif
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index f52ba0ffec..1b9d41bd56 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -236,5 +236,6 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
+#define TCG_TARGET_SUPPORT_MIRROR       0
 
 #endif
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index cd548dacec..d231522dc9 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -206,6 +206,7 @@ extern bool use_mips32r2_instructions;
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
+#define TCG_TARGET_SUPPORT_MIRROR       0
 
 /* Flush the dcache at RW, and the icache at RX, as necessary. */
 static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 8f3e4c924a..78d6a5e96f 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -185,5 +185,6 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
+#define TCG_TARGET_SUPPORT_MIRROR       0
 
 #endif
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index e03fd17427..3c2e8305b0 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -179,5 +179,6 @@ void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 #define TCG_TARGET_NEED_POOL_LABELS
 
 #define TCG_TARGET_HAS_MEMORY_BSWAP 0
+#define TCG_TARGET_SUPPORT_MIRROR   0
 
 #endif
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index c5a749e425..8324197127 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -163,5 +163,6 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
 #define TCG_TARGET_NEED_LDST_LABELS
 #endif
 #define TCG_TARGET_NEED_POOL_LABELS
+#define TCG_TARGET_SUPPORT_MIRROR       0
 
 #endif
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index 87e2be61e6..517840705f 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -181,5 +181,6 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 
 #define TCG_TARGET_NEED_POOL_LABELS
+#define TCG_TARGET_SUPPORT_MIRROR       0
 
 #endif
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index a19a6b06e5..3653fef947 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -200,6 +200,7 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 #define TCG_TARGET_DEFAULT_MO  (0)
 
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
+#define TCG_TARGET_SUPPORT_MIRROR       0
 
 static inline void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_rx,
                                             uintptr_t jmp_rw, uintptr_t addr)
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index fa1208158f..5f07ab09a9 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -38,6 +38,7 @@ struct TCGState {
     AccelState parent_obj;
 
     bool mttcg_enabled;
+    int splitwx_enabled;
     unsigned long tb_size;
 };
 typedef struct TCGState TCGState;
@@ -94,6 +95,13 @@ static void tcg_accel_instance_init(Object *obj)
     TCGState *s = TCG_STATE(obj);
 
     s->mttcg_enabled = default_mttcg_enabled();
+
+    /* If debugging enabled, default "auto on", otherwise off. */
+#ifdef CONFIG_DEBUG_TCG
+    s->splitwx_enabled = -1;
+#else
+    s->splitwx_enabled = 0;
+#endif
 }
 
 bool mttcg_enabled;
@@ -102,7 +110,7 @@ static int tcg_init(MachineState *ms)
 {
     TCGState *s = TCG_STATE(current_accel());
 
-    tcg_exec_init(s->tb_size * 1024 * 1024);
+    tcg_exec_init(s->tb_size * 1024 * 1024, s->splitwx_enabled);
     mttcg_enabled = s->mttcg_enabled;
     cpus_register_accel(&tcg_cpus);
 
@@ -168,6 +176,18 @@ static void tcg_set_tb_size(Object *obj, Visitor *v,
     s->tb_size = value;
 }
 
+static bool tcg_get_splitwx(Object *obj, Error **errp)
+{
+    TCGState *s = TCG_STATE(obj);
+    return s->splitwx_enabled;
+}
+
+static void tcg_set_splitwx(Object *obj, bool value, Error **errp)
+{
+    TCGState *s = TCG_STATE(obj);
+    s->splitwx_enabled = value;
+}
+
 static void tcg_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -185,6 +205,10 @@ static void tcg_accel_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "tb-size",
         "TCG translation block cache size");
 
+    object_class_property_add_bool(oc, "split-wx",
+        tcg_get_splitwx, tcg_set_splitwx);
+    object_class_property_set_description(oc, "split-wx",
+        "Map jit pages into separate RW and RX regions");
 }
 
 static const TypeInfo tcg_accel_type = {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2824b3e387..a29cb4a42e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1015,13 +1015,19 @@ static inline void *split_cross_256mb(void *buf1, size_t size1)
 static uint8_t static_code_gen_buffer[DEFAULT_CODE_GEN_BUFFER_SIZE]
     __attribute__((aligned(CODE_GEN_ALIGN)));
 
-static bool alloc_code_gen_buffer(size_t tb_size, Error **errp)
+static bool alloc_code_gen_buffer(size_t tb_size, int splitwx, Error **errp)
 {
-    void *buf = static_code_gen_buffer;
-    void *end = static_code_gen_buffer + sizeof(static_code_gen_buffer);
+    void *buf, *end;
     size_t size;
 
+    if (splitwx > 0) {
+        error_setg(errp, "jit split-wx not supported");
+        return false;
+    }
+
     /* page-align the beginning and end of the buffer */
+    buf = static_code_gen_buffer;
+    end = static_code_gen_buffer + sizeof(static_code_gen_buffer);
     buf = QEMU_ALIGN_PTR_UP(buf, qemu_real_host_page_size);
     end = QEMU_ALIGN_PTR_DOWN(end, qemu_real_host_page_size);
 
@@ -1050,9 +1056,16 @@ static bool alloc_code_gen_buffer(size_t tb_size, Error **errp)
     return true;
 }
 #elif defined(_WIN32)
-static bool alloc_code_gen_buffer(size_t size, Error **errp)
+static bool alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
 {
-    void *buf = VirtualAlloc(NULL, size, MEM_RESERVE | MEM_COMMIT,
+    void *buf;
+
+    if (splitwx > 0) {
+        error_setg(errp, "jit split-wx not supported");
+        return false;
+    }
+
+    buf = VirtualAlloc(NULL, size, MEM_RESERVE | MEM_COMMIT,
                              PAGE_EXECUTE_READWRITE);
     if (buf == NULL) {
         error_setg_win32(errp, GetLastError(),
@@ -1065,12 +1078,17 @@ static bool alloc_code_gen_buffer(size_t size, Error **errp)
     return true;
 }
 #else
-static bool alloc_code_gen_buffer(size_t size, Error **errp)
+static bool alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
 {
     int prot = PROT_WRITE | PROT_READ | PROT_EXEC;
     int flags = MAP_PRIVATE | MAP_ANONYMOUS;
     void *buf;
 
+    if (splitwx > 0) {
+        error_setg(errp, "jit split-wx not supported");
+        return false;
+    }
+
     buf = mmap(NULL, size, prot, flags, -1, 0);
     if (buf == MAP_FAILED) {
         error_setg_errno(errp, errno,
@@ -1145,7 +1163,7 @@ static void tb_htable_init(void)
 /* Must be called before using the QEMU cpus. 'tb_size' is the size
    (in bytes) allocated to the translation buffer. Zero means default
    size. */
-void tcg_exec_init(unsigned long tb_size)
+void tcg_exec_init(unsigned long tb_size, int splitwx)
 {
     bool ok;
 
@@ -1154,7 +1172,8 @@ void tcg_exec_init(unsigned long tb_size)
     page_init();
     tb_htable_init();
 
-    ok = alloc_code_gen_buffer(size_code_gen_buffer(tb_size), &error_fatal);
+    ok = alloc_code_gen_buffer(size_code_gen_buffer(tb_size),
+                               splitwx, &error_fatal);
     assert(ok);
 
 #if defined(CONFIG_SOFTMMU)
diff --git a/bsd-user/main.c b/bsd-user/main.c
index ac40d79bfa..ffd4888a26 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -910,7 +910,7 @@ int main(int argc, char **argv)
     }
 
     /* init tcg before creating CPUs and to get qemu_host_page_size */
-    tcg_exec_init(0);
+    tcg_exec_init(0, false);
 
     cpu_type = parse_cpu_option(cpu_model);
     cpu = cpu_create(cpu_type);
diff --git a/linux-user/main.c b/linux-user/main.c
index 75c9785157..3856b2611d 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -705,7 +705,7 @@ int main(int argc, char **argv, char **envp)
     cpu_type = parse_cpu_option(cpu_model);
 
     /* init tcg before creating CPUs and to get qemu_host_page_size */
-    tcg_exec_init(0);
+    tcg_exec_init(0, false);
 
     cpu = cpu_create(cpu_type);
     env = cpu->env_ptr;
-- 
2.25.1


