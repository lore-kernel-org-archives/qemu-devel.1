Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDDDC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF07920760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erWuw/tT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF07920760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhfu-00087L-RY
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ9-0002a5-A7
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:01 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:34803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ7-0001PF-Ix
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:00 -0400
Received: by mail-wr1-x42e.google.com with SMTP id t10so12238520wrv.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9PshzEAxmiySI9dhZtBtR355rxrVnXQvCn9xhLCKJkQ=;
 b=erWuw/tTrQOciYA3Lcrl2WoB16Tdz86cx/DocAcFkleWpI+PCVV8L0BdrCjfWmyb4V
 oeVB1ez7OrxeZ86SoojM75st1Z3FllW7RKSH7VEiz6AzkB/2j2w3Wqh8ROGukkfsxFiR
 bvO5k1vcvKsIizySpuysRnaDn7n3aGRB/wuDrOIrUUFGPyMRNOSOiaNK2yrnv2AQQIP/
 QKfHN8TFituJvDGZqJHooivdKGH2fSlV5MI2Opbuklz44pT90bCDgxaT0AVXPijfAbVj
 b8YpBm0me4am0WmszDxf4Nx30e7UE30Hc4JvhwuF+5tje1OJKm/jaXwKBCe6bwQINiWY
 7Y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9PshzEAxmiySI9dhZtBtR355rxrVnXQvCn9xhLCKJkQ=;
 b=qiV39+n6AvNvyYqBPR4UMvge3IX4q+jQij4/wwQE3fWqBUUJehQ3uF3VlW/b1BQ/IR
 L0jE5yVvm4JR6VgrTat8HUuyp5SLn/wERivIh/7JNqD3HyWFdKaRVeRGW28+BLelkQ/+
 Y7ODxbdUIkiTdGrXiok+vIPJyjOC9PS7R/OzD5J3k7M2lHSXq99G5VkZoNkKZ0RTqM1N
 VjXaJJxNKo9gBCnw3kyK4W8zD2NOhN1DJUdl6DjPnQOvmPPafIxcptwaoX+BacRiN8Pm
 IBXQpt/B4HwrWFTHs0ih8dbrXZa6lvEukm7yySv+2EyKJYyRVkpoTmIGrsh0m7kW3eCV
 JpRA==
X-Gm-Message-State: AOAM531/AhH3RgRLUKFyAnBA/LX3NPW2bYH4NdLjCIlbnTvzmdh6CR6V
 WBweSzk+aM2Y6qtdoDLHdklxUgrgIvc=
X-Google-Smtp-Source: ABdhPJwgTEK6MiFUpJIMB6EYM26uvEshkTm8TD9FUxDEIPCwWitk55xdKMrd6c/u4itL4GgGglaZgg==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr3241648wrm.355.1601969398048; 
 Tue, 06 Oct 2020 00:29:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:29:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/37] hvf: remove hvf specific functions from global includes
Date: Tue,  6 Oct 2020 09:29:23 +0200
Message-Id: <20201006072947.487729-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/stubs/hvf-stub.c     | 30 ------------------------------
 accel/stubs/meson.build    |  1 -
 include/sysemu/hvf.h       |  8 --------
 target/i386/hvf/hvf-cpus.h |  8 ++++++++
 target/i386/hvf/x86hvf.c   |  2 ++
 target/i386/hvf/x86hvf.h   |  1 -
 6 files changed, 10 insertions(+), 40 deletions(-)
 delete mode 100644 accel/stubs/hvf-stub.c

diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
deleted file mode 100644
index e81dfe888c..0000000000
--- a/accel/stubs/hvf-stub.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * QEMU HVF support
- *
- * Copyright 2017 Red Hat, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2 or later, as published by the Free Software Foundation,
- * and may be copied, distributed, and modified under those terms.
- *
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "sysemu/hvf.h"
-
-int hvf_init_vcpu(CPUState *cpu)
-{
-    return -ENOSYS;
-}
-
-int hvf_vcpu_exec(CPUState *cpu)
-{
-    return -ENOSYS;
-}
-
-void hvf_vcpu_destroy(CPUState *cpu)
-{
-}
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 314e3cfff4..3fbe34e5bb 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -1,6 +1,5 @@
 specific_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
 specific_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
-specific_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
 specific_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 specific_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
 specific_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 1398679458..f893768df9 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -26,14 +26,6 @@ extern bool hvf_allowed;
 #define hvf_get_supported_cpuid(func, idx, reg) 0
 #endif /* !CONFIG_HVF */
 
-int hvf_init_vcpu(CPUState *);
-int hvf_vcpu_exec(CPUState *);
-void hvf_cpu_synchronize_state(CPUState *);
-void hvf_cpu_synchronize_post_reset(CPUState *);
-void hvf_cpu_synchronize_post_init(CPUState *);
-void hvf_cpu_synchronize_pre_loadvm(CPUState *);
-void hvf_vcpu_destroy(CPUState *);
-
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
 typedef struct HVFState HVFState;
diff --git a/target/i386/hvf/hvf-cpus.h b/target/i386/hvf/hvf-cpus.h
index 262e449fd6..ced31b82c0 100644
--- a/target/i386/hvf/hvf-cpus.h
+++ b/target/i386/hvf/hvf-cpus.h
@@ -14,4 +14,12 @@
 
 extern const CpusAccel hvf_cpus;
 
+int hvf_init_vcpu(CPUState *);
+int hvf_vcpu_exec(CPUState *);
+void hvf_cpu_synchronize_state(CPUState *);
+void hvf_cpu_synchronize_post_reset(CPUState *);
+void hvf_cpu_synchronize_post_init(CPUState *);
+void hvf_cpu_synchronize_pre_loadvm(CPUState *);
+void hvf_vcpu_destroy(CPUState *);
+
 #endif /* HVF_CPUS_H */
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 5cbcb32ab6..b986213c0f 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -32,6 +32,8 @@
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
 
+#include "hvf-cpus.h"
+
 void hvf_set_segment(struct CPUState *cpu, struct vmx_segment *vmx_seg,
                      SegmentCache *qseg, bool is_tr)
 {
diff --git a/target/i386/hvf/x86hvf.h b/target/i386/hvf/x86hvf.h
index 79539f7282..4fabc6d582 100644
--- a/target/i386/hvf/x86hvf.h
+++ b/target/i386/hvf/x86hvf.h
@@ -35,5 +35,4 @@ void hvf_get_msrs(CPUState *cpu_state);
 void vmx_clear_int_window_exiting(CPUState *cpu);
 void hvf_get_segments(CPUState *cpu_state);
 void vmx_update_tpr(CPUState *cpu);
-void hvf_cpu_synchronize_state(CPUState *cpu_state);
 #endif
-- 
2.26.2



