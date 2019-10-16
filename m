Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F7DECE588
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCA821835
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCA821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKfOB-0003OL-Up
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 05:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iKfN3-0002o0-Sr
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iKfN2-00036G-HY
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:13:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iKfMv-00034O-Ua; Wed, 16 Oct 2019 05:13:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 97D2610CBC4B;
 Wed, 16 Oct 2019 09:13:20 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F3555D9CD;
 Wed, 16 Oct 2019 09:13:16 +0000 (UTC)
Date: Wed, 16 Oct 2019 11:13:14 +0200
From: Andrew Jones <drjones@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] target/arm/arch_dump: Add SVE notes
Message-ID: <20191016091314.cu76t3ovwofsfart@kamzik.brq.redhat.com>
References: <20191004120313.5347-1-drjones@redhat.com>
 <f23153f2-35be-f74d-ad7b-d9c324cba1cf@linaro.org>
 <20191010061600.pwhos4huazbsv6kn@kamzik.brq.redhat.com>
 <6451070f-9488-cc8f-2f4b-a7577e11f447@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6451070f-9488-cc8f-2f4b-a7577e11f447@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Wed, 16 Oct 2019 09:13:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 qemu-arm@nongnu.org, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 10, 2019 at 01:33:02PM -0400, Richard Henderson wrote:
> On 10/10/19 2:16 AM, Andrew Jones wrote:
> >> It might be best to avoid the ifdef altogether:
> >>
> >>     for (i = 0; i < 32; ++i) {
> >>         uint64_t *d = (uint64_t *)&buf[sve_zreg_offset(vq, i)];
> >>         for (j = 0; j < vq * 2; ++j) {
> >>             d[j] = cpu_to_le64(env->vfp.zregs[i].d[j]);
> >>         }
> >>     }
> >>
> >> The compiler may well transform the inner loop to memcpy for little-endian
> >> host, but even if it doesn't core dumping is hardly performance sensitive.
> > 
> > True. I even had something like the above at first, but then
> > overcomplicated it with the #ifdef-ing.
> 
> Ah, I wonder if you changed things around with the ifdefs due to the pregs.
> There's no trivial solution for those.  It'd be nice to share the bswapping
> subroutine that you add in the SVE KVM patch set, and size the temporary array
> using ARM_MAX_VQ.

How about something like this squashed in?

Thanks,
drew

diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index b02e398430b9..7c7fd23f4d94 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -182,6 +182,7 @@ static int aarch64_write_elf64_sve(WriteCoreDumpFunction f,
     struct aarch64_note *note;
     ARMCPU *cpu = env_archcpu(env);
     uint32_t vq = sve_current_vq(env);
+    uint64_t tmp[ARM_MAX_VQ * 2], *r;
     uint32_t fpr;
     uint8_t *buf;
     int ret, i;
@@ -198,31 +199,14 @@ static int aarch64_write_elf64_sve(WriteCoreDumpFunction f,
     note->sve.flags = cpu_to_dump16(s, 1);
 
     for (i = 0; i < 32; ++i) {
-#ifdef HOST_WORDS_BIGENDIAN
-        uint64_t d[vq * 2];
-        int j;
-
-        for (j = 0; j < vq * 2; ++j) {
-            d[j] = bswap64(env->vfp.zregs[i].d[j]);
-        }
-#else
-        uint64_t *d = &env->vfp.zregs[i].d[0];
-#endif
-        memcpy(&buf[sve_zreg_offset(vq, i)], &d[0], vq * 16);
+        r = sve_bswap64(tmp, &env->vfp.zregs[i].d[0], vq * 2);
+        memcpy(&buf[sve_zreg_offset(vq, i)], r, vq * 16);
     }
 
     for (i = 0; i < 17; ++i) {
-#ifdef HOST_WORDS_BIGENDIAN
-        uint64_t d[DIV_ROUND_UP(vq * 2, 8)];
-        int j;
-
-        for (j = 0; j < DIV_ROUND_UP(vq * 2, 8); ++j) {
-            d[j] = bswap64(env->vfp.pregs[i].p[j]);
-        }
-#else
-        uint64_t *d = &env->vfp.pregs[i].p[0];
-#endif
-        memcpy(&buf[sve_preg_offset(vq, i)], &d[0], vq * 16 / 8);
+        r = sve_bswap64(tmp, r = &env->vfp.pregs[i].p[0],
+                        DIV_ROUND_UP(vq * 2, 8));
+        memcpy(&buf[sve_preg_offset(vq, i)], r, vq * 16 / 8);
     }
 
     fpr = cpu_to_dump32(s, vfp_get_fpsr(env));
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5b9c3e4cd73d..b3092e5213e6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -975,6 +975,31 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
                            int new_el, bool el0_a64);
 void aarch64_add_sve_properties(Object *obj);
+
+/*
+ * SVE registers are encoded in KVM's memory in an endianness-invariant format.
+ * The byte at offset i from the start of the in-memory representation contains
+ * the bits [(7 + 8 * i) : (8 * i)] of the register value. As this means the
+ * lowest offsets are stored in the lowest memory addresses, then that nearly
+ * matches QEMU's representation, which is to use an array of host-endian
+ * uint64_t's, where the lower offsets are at the lower indices. To complete
+ * the translation we just need to byte swap the uint64_t's on big-endian hosts.
+ */
+static inline uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
+{
+#ifdef HOST_WORDS_BIGENDIAN
+    int i;
+
+    for (i = 0; i < nr; ++i) {
+        dst[i] = bswap64(src[i]);
+    }
+
+    return dst;
+#else
+    return src;
+#endif
+}
+
 #else
 static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { }
 static inline void aarch64_sve_change_el(CPUARMState *env, int o,
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 876184b8fe4d..e2da756e65ed 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -876,30 +876,6 @@ static int kvm_arch_put_fpsimd(CPUState *cs)
     return 0;
 }
 
-/*
- * SVE registers are encoded in KVM's memory in an endianness-invariant format.
- * The byte at offset i from the start of the in-memory representation contains
- * the bits [(7 + 8 * i) : (8 * i)] of the register value. As this means the
- * lowest offsets are stored in the lowest memory addresses, then that nearly
- * matches QEMU's representation, which is to use an array of host-endian
- * uint64_t's, where the lower offsets are at the lower indices. To complete
- * the translation we just need to byte swap the uint64_t's on big-endian hosts.
- */
-static uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
-{
-#ifdef HOST_WORDS_BIGENDIAN
-    int i;
-
-    for (i = 0; i < nr; ++i) {
-        dst[i] = bswap64(src[i]);
-    }
-
-    return dst;
-#else
-    return src;
-#endif
-}
-
 /*
  * KVM SVE registers come in slices where ZREGs have a slice size of 2048 bits
  * and PREGS and the FFR have a slice size of 256 bits. However we simply hard

