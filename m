Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2298C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9206C206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mK9bkm87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9206C206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8kc-0006vS-Ph
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zy-0002Zu-7P
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:53716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zx-0007Dq-3S
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id k12so18030732wmj.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FKycni8NPHvHNWeB849RmEyB5xFRLf+3CRF6YKP5BZ0=;
 b=mK9bkm87iSNjS1dFx2KMRjLsZShdvyR4I5N7joi+c3QCdrhC9IriArJTkKIbFTfgga
 ju3VXRtVRFt+PAxuPA053ZF9nEkHM9bnIRiwIFkz06EVNQkaFDypyi9mSuSzzqudSQ4d
 OkWJNgXY5cto9J9xetFOb4TdmIT5O2Ttz4vDMpC/mTqQ8D+FnpLSWGzF6+f3Azp21HF0
 OLU7H/8RZd8ZeGAxMkNk+/HG3xXb1AtRFfq/Jf8k4IbZE2CtQXxpO/BJXWV5TDw5nKNI
 txsE/ZZ/msGvIg3NLLY4HHyHNnWYyR9N1s4bhdMcwkZpylXH/Ckjlrh4GrOk7xNZ45Cf
 lyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FKycni8NPHvHNWeB849RmEyB5xFRLf+3CRF6YKP5BZ0=;
 b=ADbbKjghtYBkY2s5d8+mSRXgX5sku+zA2K4lrND8lssfw4vm5tlPW5GlBoQ3drBO2f
 lC/bKYwbsiNz3E/TklyLGzbZCWx9ktFnnUuEUEmHOP+XkunI08Iw8ozNE8TQhwykIzaQ
 mIgbTAJqxN0jwHwK5xRFdl+igXHaCHA5o7yLYI1BL/VruXzqO+zzPKB6wA6dmw0elsxT
 AY9wL2oAYuk5Ni9YWmhIK0uz9B1+ToHF0q+mEnl7SXLne+5JyUGEmXwGpXFRH/cZKwWZ
 EEblUQm2IRVkLjFSZ9m1IJjP0LfkSGSR+aG7g9KSYQLsBSt4teO21EZfW0SAZD/HnY/L
 fugw==
X-Gm-Message-State: AGi0PuZGksAjbbjsG7piQCNRBB5fHzkP4e9uXgAgsw8JYuilHsqZ0CWz
 P6j7Yi/MFDI5H1ZbRnRBcluDTwAt7Q4qxA==
X-Google-Smtp-Source: APiQypLbZHHmBEeirjr3ioj6RA7TZe0km4nek/XX5jVogA6y9Dwy7kpFcd8QLP18PJUB4t3bVdtHNg==
X-Received: by 2002:a1c:bbc4:: with SMTP id
 l187mr12225429wmf.183.1589204083196; 
 Mon, 11 May 2020 06:34:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/34] target/arm: Make set_feature() available for other files
Date: Mon, 11 May 2020 14:33:59 +0100
Message-Id: <20200511133405.5275-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Thomas Huth <thuth@redhat.com>

Move the common set_feature() and unset_feature() functions
from cpu.c and cpu64.c to cpu.h.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200504172448.9402-3-philmd@redhat.com
Message-ID: <20190921150420.30743-2-thuth@redhat.com>
[PMD: Split Thomas's patch in two: set_feature, cpu_register]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h   | 10 ++++++++++
 target/arm/cpu.c   | 10 ----------
 target/arm/cpu64.c | 10 ----------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8608da6b6fc..676f216b67c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -696,6 +696,16 @@ typedef struct CPUARMState {
     void *gicv3state;
 } CPUARMState;
 
+static inline void set_feature(CPUARMState *env, int feature)
+{
+    env->features |= 1ULL << feature;
+}
+
+static inline void unset_feature(CPUARMState *env, int feature)
+{
+    env->features &= ~(1ULL << feature);
+}
+
 /**
  * ARMELChangeHookFn:
  * type of a function which can be registered via arm_register_el_change_hook()
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5d64adfe76e..13959cb6435 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -725,16 +725,6 @@ static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
 
 #endif
 
-static inline void set_feature(CPUARMState *env, int feature)
-{
-    env->features |= 1ULL << feature;
-}
-
-static inline void unset_feature(CPUARMState *env, int feature)
-{
-    env->features &= ~(1ULL << feature);
-}
-
 static int
 print_insn_thumb1(bfd_vma pc, disassemble_info *info)
 {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9bdf75b1abb..cbaa5ed2287 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -29,16 +29,6 @@
 #include "kvm_arm.h"
 #include "qapi/visitor.h"
 
-static inline void set_feature(CPUARMState *env, int feature)
-{
-    env->features |= 1ULL << feature;
-}
-
-static inline void unset_feature(CPUARMState *env, int feature)
-{
-    env->features &= ~(1ULL << feature);
-}
-
 #ifndef CONFIG_USER_ONLY
 static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-- 
2.20.1


