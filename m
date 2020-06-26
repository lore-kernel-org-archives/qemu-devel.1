Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597D6C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266F9207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKorKVU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266F9207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqOu-00066d-72
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4T-00034p-2H
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:17 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:43493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4Q-0006dk-CI
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:16 -0400
Received: by mail-wr1-x430.google.com with SMTP id j4so7405633wrp.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1+yw7gLXFotUGKxyde64a0l3p9IplpBYXObf7vT1zi4=;
 b=tKorKVU83T6sHgD7Hh3Bn3J5ucrGIcFELiwZ+k9Ll40i0AtZs61S57T4/lme+F6ciJ
 GA3+1zKMtgrs4ZLBAlgVdZypxodEUDtEUPGEYRZ47TPFlCUIle1IQq8EKlH9gXrgoB4r
 /CEJsXzK5zQA9rlDYbiaoTNWw9L4XqPmJRATRQcn6D+Sjv9+X4di6AYKiqw8CkKQSxKU
 KLIE4PbXYCSMyObb59VS0ltav7jvCO9BA/vaBXcopu6cD/ypeha49fRdnEApM5EMW2aq
 W2cQ5+bj4r471Did5A4lJ7puwYgslgoGgSjcqmdmztx4BpAy3viH6jeHolqZimsK4Qno
 Yi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1+yw7gLXFotUGKxyde64a0l3p9IplpBYXObf7vT1zi4=;
 b=T0jlw/Eykj9oUFkifZANbtbvvdP4P6vXeCVMKNKhirp211FIedkYOZWsBeqGk4qTTh
 ttfxaQmNDMBJufewWoVafOo02XZP0LXBKO5EjKLyeE0rU9VoKetABGBVkb2xV/+/4JON
 E5yUtFm+R9WJmVXI4o7iF/ld7TbLmoLFylrDEMMeaRUrvR4CmTrrH+36LHDB+3/jx5IH
 q27itPDVOM+tqAaXVTpALkPJ3whHj20j2NzrGlTGilcgDGyNDAiSZVO4+K7PcqD4faWi
 Mjjm1+r/eIedoi21dLjRrgwSm5p3OMIE4LAoUJVTYsS+DW/cPjFKUqZz0kc/NoKz4qXP
 J9wQ==
X-Gm-Message-State: AOAM533POeIxzjGSDMLTKbdNKfGqKl9hWX+wYDyQnBZQcB2bN/Bk+lk2
 ntdg5UtY7K8JWNUD0vLXAvC9ZqEe66pKZQ==
X-Google-Smtp-Source: ABdhPJxcJUdKApYurMW05vGnvoGRNQxmBR5dKSkKZ7XtZuiWIqsxrFz1I6L3sRJwNr3+/GuYYNspVA==
X-Received: by 2002:adf:de01:: with SMTP id b1mr4162914wrm.305.1593184511540; 
 Fri, 26 Jun 2020 08:15:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/57] target/arm: Implement helper_mte_checkN
Date: Fri, 26 Jun 2020 16:14:05 +0100
Message-Id: <20200626151424.30117-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Fill out the stub that was added earlier.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-27-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h  |   2 +
 target/arm/mte_helper.c | 165 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 807830cc400..c763a23dfba 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1321,6 +1321,8 @@ FIELD(MTEDESC, TSIZE, 14, 10)  /* mte_checkN only */
 bool mte_probe1(CPUARMState *env, uint32_t desc, uint64_t ptr);
 uint64_t mte_check1(CPUARMState *env, uint32_t desc,
                     uint64_t ptr, uintptr_t ra);
+uint64_t mte_checkN(CPUARMState *env, uint32_t desc,
+                    uint64_t ptr, uintptr_t ra);
 
 static inline int allocation_tag_from_addr(uint64_t ptr)
 {
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index c8a5e7c0edd..abe6af6b795 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -500,7 +500,170 @@ uint64_t HELPER(mte_check1)(CPUARMState *env, uint32_t desc, uint64_t ptr)
 /*
  * Perform an MTE checked access for multiple logical accesses.
  */
+
+/**
+ * checkN:
+ * @tag: tag memory to test
+ * @odd: true to begin testing at tags at odd nibble
+ * @cmp: the tag to compare against
+ * @count: number of tags to test
+ *
+ * Return the number of successful tests.
+ * Thus a return value < @count indicates a failure.
+ *
+ * A note about sizes: count is expected to be small.
+ *
+ * The most common use will be LDP/STP of two integer registers,
+ * which means 16 bytes of memory touching at most 2 tags, but
+ * often the access is aligned and thus just 1 tag.
+ *
+ * Using AdvSIMD LD/ST (multiple), one can access 64 bytes of memory,
+ * touching at most 5 tags.  SVE LDR/STR (vector) with the default
+ * vector length is also 64 bytes; the maximum architectural length
+ * is 256 bytes touching at most 9 tags.
+ *
+ * The loop below uses 7 logical operations and 1 memory operation
+ * per tag pair.  An implementation that loads an aligned word and
+ * uses masking to ignore adjacent tags requires 18 logical operations
+ * and thus does not begin to pay off until 6 tags.
+ * Which, according to the survey above, is unlikely to be common.
+ */
+static int checkN(uint8_t *mem, int odd, int cmp, int count)
+{
+    int n = 0, diff;
+
+    /* Replicate the test tag and compare.  */
+    cmp *= 0x11;
+    diff = *mem++ ^ cmp;
+
+    if (odd) {
+        goto start_odd;
+    }
+
+    while (1) {
+        /* Test even tag. */
+        if (unlikely((diff) & 0x0f)) {
+            break;
+        }
+        if (++n == count) {
+            break;
+        }
+
+    start_odd:
+        /* Test odd tag. */
+        if (unlikely((diff) & 0xf0)) {
+            break;
+        }
+        if (++n == count) {
+            break;
+        }
+
+        diff = *mem++ ^ cmp;
+    }
+    return n;
+}
+
+uint64_t mte_checkN(CPUARMState *env, uint32_t desc,
+                    uint64_t ptr, uintptr_t ra)
+{
+    int mmu_idx, ptr_tag, bit55;
+    uint64_t ptr_last, ptr_end, prev_page, next_page;
+    uint64_t tag_first, tag_end;
+    uint64_t tag_byte_first, tag_byte_end;
+    uint32_t esize, total, tag_count, tag_size, n, c;
+    uint8_t *mem1, *mem2;
+    MMUAccessType type;
+
+    bit55 = extract64(ptr, 55, 1);
+
+    /* If TBI is disabled, the access is unchecked, and ptr is not dirty. */
+    if (unlikely(!tbi_check(desc, bit55))) {
+        return ptr;
+    }
+
+    ptr_tag = allocation_tag_from_addr(ptr);
+
+    if (tcma_check(desc, bit55, ptr_tag)) {
+        goto done;
+    }
+
+    mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
+    type = FIELD_EX32(desc, MTEDESC, WRITE) ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    esize = FIELD_EX32(desc, MTEDESC, ESIZE);
+    total = FIELD_EX32(desc, MTEDESC, TSIZE);
+
+    /* Find the addr of the end of the access, and of the last element. */
+    ptr_end = ptr + total;
+    ptr_last = ptr_end - esize;
+
+    /* Round the bounds to the tag granule, and compute the number of tags. */
+    tag_first = QEMU_ALIGN_DOWN(ptr, TAG_GRANULE);
+    tag_end = QEMU_ALIGN_UP(ptr_last, TAG_GRANULE);
+    tag_count = (tag_end - tag_first) / TAG_GRANULE;
+
+    /* Round the bounds to twice the tag granule, and compute the bytes. */
+    tag_byte_first = QEMU_ALIGN_DOWN(ptr, 2 * TAG_GRANULE);
+    tag_byte_end = QEMU_ALIGN_UP(ptr_last, 2 * TAG_GRANULE);
+
+    /* Locate the page boundaries. */
+    prev_page = ptr & TARGET_PAGE_MASK;
+    next_page = prev_page + TARGET_PAGE_SIZE;
+
+    if (likely(tag_end - prev_page <= TARGET_PAGE_SIZE)) {
+        /* Memory access stays on one page. */
+        tag_size = (tag_byte_end - tag_byte_first) / (2 * TAG_GRANULE);
+        mem1 = allocation_tag_mem(env, mmu_idx, ptr, type, total,
+                                  MMU_DATA_LOAD, tag_size, ra);
+        if (!mem1) {
+            goto done;
+        }
+        /* Perform all of the comparisons. */
+        n = checkN(mem1, ptr & TAG_GRANULE, ptr_tag, tag_count);
+    } else {
+        /* Memory access crosses to next page. */
+        tag_size = (next_page - tag_byte_first) / (2 * TAG_GRANULE);
+        mem1 = allocation_tag_mem(env, mmu_idx, ptr, type, next_page - ptr,
+                                  MMU_DATA_LOAD, tag_size, ra);
+
+        tag_size = (tag_byte_end - next_page) / (2 * TAG_GRANULE);
+        mem2 = allocation_tag_mem(env, mmu_idx, next_page, type,
+                                  ptr_end - next_page,
+                                  MMU_DATA_LOAD, tag_size, ra);
+
+        /*
+         * Perform all of the comparisons.
+         * Note the possible but unlikely case of the operation spanning
+         * two pages that do not both have tagging enabled.
+         */
+        n = c = (next_page - tag_first) / TAG_GRANULE;
+        if (mem1) {
+            n = checkN(mem1, ptr & TAG_GRANULE, ptr_tag, c);
+        }
+        if (n == c) {
+            if (!mem2) {
+                goto done;
+            }
+            n += checkN(mem2, 0, ptr_tag, tag_count - c);
+        }
+    }
+
+    /*
+     * If we failed, we know which granule.  Compute the element that
+     * is first in that granule, and signal failure on that element.
+     */
+    if (unlikely(n < tag_count)) {
+        uint64_t fail_ofs;
+
+        fail_ofs = tag_first + n * TAG_GRANULE - ptr;
+        fail_ofs = ROUND_UP(fail_ofs, esize);
+        mte_check_fail(env, mmu_idx, ptr + fail_ofs, ra);
+    }
+
+ done:
+    return useronly_clean_ptr(ptr);
+}
+
 uint64_t HELPER(mte_checkN)(CPUARMState *env, uint32_t desc, uint64_t ptr)
 {
-    return ptr;
+    return mte_checkN(env, desc, ptr, GETPC());
 }
-- 
2.20.1


