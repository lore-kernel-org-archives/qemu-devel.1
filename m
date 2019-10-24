Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB457CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9138020659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ron7P1Kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9138020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgo0-0002Cq-9V
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyI-0008HV-Cg
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyG-00012a-0G
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:22 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:44677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfyF-00012K-Pz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:19 -0400
Received: by mail-wr1-x42d.google.com with SMTP id z11so3426426wro.11
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0ZlsAUBDsUyvYREq9UC6PUhIuy2cFHkEmU/zq4fnk1M=;
 b=Ron7P1Kt2i5RKXFToDi+kwl7uGK+AxvNo1pO1MP/jp7ROARYQ795E1kCn1ORVCDvQY
 WsjTpBhdhPYejrnHX2ZYAD8o3iqPLB88xyQy34giOURqftcOCyVwDrmTgI/pEv4a1t0c
 o9cuK4N0qg/XTGh5eLYqoEqPg6uFO/K5z35DaWMpwVjgkSWiky6wgw8azSqGS9cAMIwa
 QATAqevuzY7GTF/aRuSwmWysULHGnUlUQFmvFRTFyiGrY0Veur96TOCpEoRwPoW1ANmt
 0/V07LePZxDzop38LO8d/BeeBmsaYAO1agfHov5YQUhzReawF13cviMdQRfLdEx7ywpJ
 Fg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0ZlsAUBDsUyvYREq9UC6PUhIuy2cFHkEmU/zq4fnk1M=;
 b=BRYfm/Mq9WjUzzsOi6+DaW/5QuWTy0apzk5gxKodWzZw/S1sPPgaIEzHKYfjqSU71U
 fHJ+T6QR4mVBqLHaktzcTHtdxAZa5B0PhaC7nTVmSoMCIPyuHn64s8+JkTeptADhwXVp
 9blorl+kFdkkTVJXqZBhmw3i1ja9pJzgCagbFk2ipyLIN32xQHjjGGpp1fy7Qcdf9x5M
 fLo2VRHjektfjIcTv2KyZ0iBIJ0xtJwVSZS4JTtV7+ld3ohMgfIPihSVnEBQYbpx654J
 I5o2phtFCTBNGstoQ+Qajk1hwpNtBx2j6dy+aK/9tX/5mWFSd1dDfyWWg5NTw5zsa7xZ
 AtbA==
X-Gm-Message-State: APjAAAV8WsLeGf+dCO52ney5VdA706uQdTKwNA7RcyKRUiPvhrKoJ1MG
 d0HMhyNqsbkhxoWdKpkzVsBKQa7gv6M=
X-Google-Smtp-Source: APXvYqxbQ1iX9xkL+ykKQmtdb6votLDk7ltqIa6P2VWxB3TlNt7pVoL5EwTajZbZcJZrgo94OfKR+g==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr4836250wru.196.1571934498255; 
 Thu, 24 Oct 2019 09:28:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/51] target/arm/kvm: scratch vcpu: Preserve input
 kvm_vcpu_init features
Date: Thu, 24 Oct 2019 17:27:14 +0100
Message-Id: <20191024162724.31675-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

From: Andrew Jones <drjones@redhat.com>

kvm_arm_create_scratch_host_vcpu() takes a struct kvm_vcpu_init
parameter. Rather than just using it as an output parameter to
pass back the preferred target, use it also as an input parameter,
allowing a caller to pass a selected target if they wish and to
also pass cpu features. If the caller doesn't want to select a
target they can pass -1 for the target which indicates they want
to use the preferred target and have it passed back like before.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Beata Michalska <beata.michalska@linaro.org>
Message-id: 20191024121808.9612-8-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c   | 20 +++++++++++++++-----
 target/arm/kvm32.c |  6 +++++-
 target/arm/kvm64.c |  6 +++++-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f07332bbda3..5b82cefef60 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -66,7 +66,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
                                       int *fdarray,
                                       struct kvm_vcpu_init *init)
 {
-    int ret, kvmfd = -1, vmfd = -1, cpufd = -1;
+    int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
 
     kvmfd = qemu_open("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
@@ -86,7 +86,14 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
         goto finish;
     }
 
-    ret = ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, init);
+    if (init->target == -1) {
+        struct kvm_vcpu_init preferred;
+
+        ret = ioctl(vmfd, KVM_ARM_PREFERRED_TARGET, &preferred);
+        if (!ret) {
+            init->target = preferred.target;
+        }
+    }
     if (ret >= 0) {
         ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
         if (ret < 0) {
@@ -98,10 +105,12 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
          * creating one kind of guest CPU which is its preferred
          * CPU type.
          */
+        struct kvm_vcpu_init try;
+
         while (*cpus_to_try != QEMU_KVM_ARM_TARGET_NONE) {
-            init->target = *cpus_to_try++;
-            memset(init->features, 0, sizeof(init->features));
-            ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, init);
+            try.target = *cpus_to_try++;
+            memcpy(try.features, init->features, sizeof(init->features));
+            ret = ioctl(cpufd, KVM_ARM_VCPU_INIT, &try);
             if (ret >= 0) {
                 break;
             }
@@ -109,6 +118,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
         if (ret < 0) {
             goto err;
         }
+        init->target = try.target;
     } else {
         /* Treat a NULL cpus_to_try argument the same as an empty
          * list, which means we will fail the call since this must
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 2451a2d4bbe..32bf8d6757c 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -53,7 +53,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         QEMU_KVM_ARM_TARGET_CORTEX_A15,
         QEMU_KVM_ARM_TARGET_NONE
     };
-    struct kvm_vcpu_init init;
+    /*
+     * target = -1 informs kvm_arm_create_scratch_host_vcpu()
+     * to use the preferred target
+     */
+    struct kvm_vcpu_init init = { .target = -1, };
 
     if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
         return false;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 850da1b5e6a..c7ecefbed72 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -502,7 +502,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         KVM_ARM_TARGET_CORTEX_A57,
         QEMU_KVM_ARM_TARGET_NONE
     };
-    struct kvm_vcpu_init init;
+    /*
+     * target = -1 informs kvm_arm_create_scratch_host_vcpu()
+     * to use the preferred target
+     */
+    struct kvm_vcpu_init init = { .target = -1, };
 
     if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
         return false;
-- 
2.20.1


