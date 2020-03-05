Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4F3C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2529C20637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ODxwCdFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2529C20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tdj-0002pv-4K
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPW-00041T-6G
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPU-0002xZ-6v
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:46 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:34736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPT-0002wD-V5
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:44 -0500
Received: by mail-wm1-x330.google.com with SMTP id x3so2309234wmj.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ADlCSkfPf9AlXzjjkTVaVe6/GpzhDc41aeGM7hXo6C0=;
 b=ODxwCdFtrYLH/SruFTRZDerujMVCN882rrXBSvxZNvWsVTJbWzjTIVKgOrXS+rsK+C
 TvRaHjJfisZYomjgJViqrKe68ET1nrGPG/2tDGLt7KWGlc7cjSer7+Rnn+GZX2DZpTJ6
 yYdtEQiFC6vpsCSlIrZjQR2C2J5rc23rWeZbcQ2CVmBmXmwMCA1UXpqyZ8T+CkSj63yj
 Gv9laC5RbGwsm1HciDICqEJH277z61y6l1Akk/uFpANE4mWsifgZWbHi3i3gF6FrVvqV
 NaVWTl1qYLuqf64jci4y6cx9Xe7AmEQfscIfLGjzKTnzdB0baphVNqxbyQ+Nr9AxGUc9
 d+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ADlCSkfPf9AlXzjjkTVaVe6/GpzhDc41aeGM7hXo6C0=;
 b=TBrl//rGl+7gwjGmy1AKBdAiuSddN15rPNbVfX3+gEBdNnz9GQ2PgJxtWpqnfZEeNS
 foxKafWatQgW1CfVCTmFLM++7peqJxQuVNZspZhahhkjE4VIlh552gxJMliMhYhE5uiA
 TG0nI3Tuu8ZqOtrk/bPbCKhuhvbWHK53QpzSQ70xngKMxImdl9F9mEY0g0E+Zq6oW7CZ
 VS5UPzo5MUYdxh3Ae84r3iJpqY529zp60VjhVZPBcr/LGXGFSF1idRwAGrRWM1RLTDSX
 BCWOIeURsFGAGM/F7MjUcw86voY1NzwtBc2912IhEgxP+Mzra5Soh0sgpgwcdW8zNWPA
 lj/g==
X-Gm-Message-State: ANhLgQ3bzbfj1uJNRUgc003qkGhQ7nh1/q7/JZLCvTIZxNFtEDbbbvBT
 E5tixExJIZKAZDplUEzfZ4suMsIw59zZ5w==
X-Google-Smtp-Source: ADFU+vsD7mIA17CvSaG2PBJ9WS9DKzZ8YaYq1nttplYOEM5byPu1RTek0/g+oJXBGZ8ZHdtMLtGRpg==
X-Received: by 2002:a1c:a1c2:: with SMTP id k185mr1543294wme.164.1583425900507; 
 Thu, 05 Mar 2020 08:31:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/37] target/arm: Move helper_dc_zva to helper-a64.c
Date: Thu,  5 Mar 2020 16:30:58 +0000
Message-Id: <20200305163100.22912-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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

From: Richard Henderson <richard.henderson@linaro.org>

This is an aarch64-only function.  Move it out of the shared file.
This patch is code movement only.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200302175829.2183-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.h |  1 +
 target/arm/helper.h     |  1 -
 target/arm/helper-a64.c | 91 ++++++++++++++++++++++++++++++++++++++++
 target/arm/op_helper.c  | 93 -----------------------------------------
 4 files changed, 92 insertions(+), 94 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index a915c1247fe..b1a5935f618 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -90,6 +90,7 @@ DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
 DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
 
 DEF_HELPER_2(exception_return, void, env, i64)
+DEF_HELPER_2(dc_zva, void, env, i64)
 
 DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(pacib, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index fcbf5041213..72eb9e6a1a5 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -559,7 +559,6 @@ DEF_HELPER_FLAGS_3(crypto_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
-DEF_HELPER_2(dc_zva, void, env, i64)
 
 DEF_HELPER_FLAGS_5(gvec_qrdmlah_s16, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 123ce50e7a8..bc0649a44aa 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
@@ -1109,4 +1110,94 @@ uint32_t HELPER(sqrt_f16)(uint32_t a, void *fpstp)
     return float16_sqrt(a, s);
 }
 
+void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
+{
+    /*
+     * Implement DC ZVA, which zeroes a fixed-length block of memory.
+     * Note that we do not implement the (architecturally mandated)
+     * alignment fault for attempts to use this on Device memory
+     * (which matches the usual QEMU behaviour of not implementing either
+     * alignment faults or any memory attribute handling).
+     */
 
+    ARMCPU *cpu = env_archcpu(env);
+    uint64_t blocklen = 4 << cpu->dcz_blocksize;
+    uint64_t vaddr = vaddr_in & ~(blocklen - 1);
+
+#ifndef CONFIG_USER_ONLY
+    {
+        /*
+         * Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
+         * the block size so we might have to do more than one TLB lookup.
+         * We know that in fact for any v8 CPU the page size is at least 4K
+         * and the block size must be 2K or less, but TARGET_PAGE_SIZE is only
+         * 1K as an artefact of legacy v5 subpage support being present in the
+         * same QEMU executable. So in practice the hostaddr[] array has
+         * two entries, given the current setting of TARGET_PAGE_BITS_MIN.
+         */
+        int maxidx = DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
+        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)];
+        int try, i;
+        unsigned mmu_idx = cpu_mmu_index(env, false);
+        TCGMemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
+
+        assert(maxidx <= ARRAY_SIZE(hostaddr));
+
+        for (try = 0; try < 2; try++) {
+
+            for (i = 0; i < maxidx; i++) {
+                hostaddr[i] = tlb_vaddr_to_host(env,
+                                                vaddr + TARGET_PAGE_SIZE * i,
+                                                1, mmu_idx);
+                if (!hostaddr[i]) {
+                    break;
+                }
+            }
+            if (i == maxidx) {
+                /*
+                 * If it's all in the TLB it's fair game for just writing to;
+                 * we know we don't need to update dirty status, etc.
+                 */
+                for (i = 0; i < maxidx - 1; i++) {
+                    memset(hostaddr[i], 0, TARGET_PAGE_SIZE);
+                }
+                memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE));
+                return;
+            }
+            /*
+             * OK, try a store and see if we can populate the tlb. This
+             * might cause an exception if the memory isn't writable,
+             * in which case we will longjmp out of here. We must for
+             * this purpose use the actual register value passed to us
+             * so that we get the fault address right.
+             */
+            helper_ret_stb_mmu(env, vaddr_in, 0, oi, GETPC());
+            /* Now we can populate the other TLB entries, if any */
+            for (i = 0; i < maxidx; i++) {
+                uint64_t va = vaddr + TARGET_PAGE_SIZE * i;
+                if (va != (vaddr_in & TARGET_PAGE_MASK)) {
+                    helper_ret_stb_mmu(env, va, 0, oi, GETPC());
+                }
+            }
+        }
+
+        /*
+         * Slow path (probably attempt to do this to an I/O device or
+         * similar, or clearing of a block of code we have translations
+         * cached for). Just do a series of byte writes as the architecture
+         * demands. It's not worth trying to use a cpu_physical_memory_map(),
+         * memset(), unmap() sequence here because:
+         *  + we'd need to account for the blocksize being larger than a page
+         *  + the direct-RAM access case is almost always going to be dealt
+         *    with in the fastpath code above, so there's no speed benefit
+         *  + we would have to deal with the map returning NULL because the
+         *    bounce buffer was in use
+         */
+        for (i = 0; i < blocklen; i++) {
+            helper_ret_stb_mmu(env, vaddr + i, 0, oi, GETPC());
+        }
+    }
+#else
+    memset(g2h(vaddr), 0, blocklen);
+#endif
+}
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index af3020b78f8..eb0de080f11 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -17,7 +17,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu/units.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
@@ -936,95 +935,3 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
         return ((uint32_t)x >> shift) | (x << (32 - shift));
     }
 }
-
-void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
-{
-    /*
-     * Implement DC ZVA, which zeroes a fixed-length block of memory.
-     * Note that we do not implement the (architecturally mandated)
-     * alignment fault for attempts to use this on Device memory
-     * (which matches the usual QEMU behaviour of not implementing either
-     * alignment faults or any memory attribute handling).
-     */
-
-    ARMCPU *cpu = env_archcpu(env);
-    uint64_t blocklen = 4 << cpu->dcz_blocksize;
-    uint64_t vaddr = vaddr_in & ~(blocklen - 1);
-
-#ifndef CONFIG_USER_ONLY
-    {
-        /*
-         * Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
-         * the block size so we might have to do more than one TLB lookup.
-         * We know that in fact for any v8 CPU the page size is at least 4K
-         * and the block size must be 2K or less, but TARGET_PAGE_SIZE is only
-         * 1K as an artefact of legacy v5 subpage support being present in the
-         * same QEMU executable. So in practice the hostaddr[] array has
-         * two entries, given the current setting of TARGET_PAGE_BITS_MIN.
-         */
-        int maxidx = DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
-        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)];
-        int try, i;
-        unsigned mmu_idx = cpu_mmu_index(env, false);
-        TCGMemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
-
-        assert(maxidx <= ARRAY_SIZE(hostaddr));
-
-        for (try = 0; try < 2; try++) {
-
-            for (i = 0; i < maxidx; i++) {
-                hostaddr[i] = tlb_vaddr_to_host(env,
-                                                vaddr + TARGET_PAGE_SIZE * i,
-                                                1, mmu_idx);
-                if (!hostaddr[i]) {
-                    break;
-                }
-            }
-            if (i == maxidx) {
-                /*
-                 * If it's all in the TLB it's fair game for just writing to;
-                 * we know we don't need to update dirty status, etc.
-                 */
-                for (i = 0; i < maxidx - 1; i++) {
-                    memset(hostaddr[i], 0, TARGET_PAGE_SIZE);
-                }
-                memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE));
-                return;
-            }
-            /*
-             * OK, try a store and see if we can populate the tlb. This
-             * might cause an exception if the memory isn't writable,
-             * in which case we will longjmp out of here. We must for
-             * this purpose use the actual register value passed to us
-             * so that we get the fault address right.
-             */
-            helper_ret_stb_mmu(env, vaddr_in, 0, oi, GETPC());
-            /* Now we can populate the other TLB entries, if any */
-            for (i = 0; i < maxidx; i++) {
-                uint64_t va = vaddr + TARGET_PAGE_SIZE * i;
-                if (va != (vaddr_in & TARGET_PAGE_MASK)) {
-                    helper_ret_stb_mmu(env, va, 0, oi, GETPC());
-                }
-            }
-        }
-
-        /*
-         * Slow path (probably attempt to do this to an I/O device or
-         * similar, or clearing of a block of code we have translations
-         * cached for). Just do a series of byte writes as the architecture
-         * demands. It's not worth trying to use a cpu_physical_memory_map(),
-         * memset(), unmap() sequence here because:
-         *  + we'd need to account for the blocksize being larger than a page
-         *  + the direct-RAM access case is almost always going to be dealt
-         *    with in the fastpath code above, so there's no speed benefit
-         *  + we would have to deal with the map returning NULL because the
-         *    bounce buffer was in use
-         */
-        for (i = 0; i < blocklen; i++) {
-            helper_ret_stb_mmu(env, vaddr + i, 0, oi, GETPC());
-        }
-    }
-#else
-    memset(g2h(vaddr), 0, blocklen);
-#endif
-}
-- 
2.20.1


