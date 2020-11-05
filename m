Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D247CC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C5D2065E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sKuBjdxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C5D2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajV6-0000fK-9w
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajR2-0004UL-Ic
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:32 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQy-0004st-Up
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:32 -0500
Received: by mail-wr1-x441.google.com with SMTP id w1so2798164wrm.4
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PWX79l8aK71+AYI8WeJL1C20BLKUbqb3b0w9LAzwhV8=;
 b=sKuBjdxgzO5u9D8pgwF/tGU3Jl9e9kVQLXkjUZin+MoLsmfLdqrVeqhqiki4zrHNmt
 5hy7oStzIxiY+o16gdITJ6d17aQlrLazLaOKd1So+BBwfe/FRh1q20LBPkyH1CYBKIBc
 89BFyfERsJdvAKbEqLP1/bDRte++Si1BFXcV5wA53Yg3P8t5AiT8ptxNXg/9K4dFdUJ5
 sPXa8twvD5cGmJ5dvqqFdwnTja/ybh6DzAOswcsvh1WULOZk8Tif6W1wiM9fUjihlpqK
 kiMe6f4QE/wGEOHChHWXznLNi+6OKoDNmYdzcJDS8aOMnUWcpxcWrDD/Hk5hUq8sEImR
 ikkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PWX79l8aK71+AYI8WeJL1C20BLKUbqb3b0w9LAzwhV8=;
 b=A/LcD2V+bK45xnG7YhEl59JyogGaz4aBbqvkLv4ATTviGVIdxzFiEc2P86CcuyU39F
 HFeDnHuXLxBoho1x/atjHyxVJx9moMWHUHFbvmX90jjp8cK4SDvNa8sU05RJJGlbB6Qk
 nE/eJ0NspY2lLT6IBIuZ2KXm9ZGf7My47qp5isZT/DyPiuCUaRoEyWSbv+QS+qP9yN9I
 g+hx9QU/Z/me4kP9VjQG21vhz00Qy1dZnFAgM0eVIk4LhmuQH2ok1lVSIPyqRWEh+kmF
 wMV4GbWhEa1hvQEwb9vycAJN4VnRWPDGtKBmOfmlSCazpA1CoiB/4ZZN/9W+y/m85Cv5
 sjBg==
X-Gm-Message-State: AOAM5315rQaTFrvG/vhdQvLH7C5/5kHO7G5nvfoZfyHksuKjDchk66R9
 ZFmCV5ULrwAvYwLVbSedg133Eg==
X-Google-Smtp-Source: ABdhPJykPmP1sXUte37eZYccOK8QD1oW46dCne80dIEM79/5lUgUNgxRnHI2ok44wyDkI60skFiMrA==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr4588066wrn.73.1604598746349; 
 Thu, 05 Nov 2020 09:52:26 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a185sm3323029wmf.24.2020.11.05.09.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:52:15 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 154F51FF9D;
 Thu,  5 Nov 2020 17:51:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  14/15] xen: only build HVM support under CONFIG_XEN_HVM
Date: Thu,  5 Nov 2020 17:51:52 +0000
Message-Id: <20201105175153.30489-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105175153.30489-1-alex.bennee@linaro.org>
References: <20201105175153.30489-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, julien@xen.org,
 Eduardo Habkost <ehabkost@redhat.com>, masami.hiramatsu@linaro.org,
 Paul Durrant <paul@xen.org>, andre.przywara@arm.com,
 Richard Henderson <rth@twiddle.net>, stefano.stabellini@linaro.org,
 takahiro.akashi@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running on non-x86 systems there is no point building HVM support
because we will never see such things. To achieve this we need to
shuffle a little bit of the inline and other stubs about.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/sysemu/xen-mapcache.h |  2 +-
 include/sysemu/xen.h          |  9 +++++----
 accel/stubs/xen-all-stub.c    | 11 +++++++++++
 accel/stubs/xen-stub.c        |  2 --
 accel/stubs/meson.build       |  3 ++-
 hw/i386/xen/meson.build       |  2 +-
 6 files changed, 20 insertions(+), 9 deletions(-)
 create mode 100644 accel/stubs/xen-all-stub.c

diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index c8e7c2f6cf..4bba764745 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -13,7 +13,7 @@
 
 typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
                                          ram_addr_t size);
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_HVM
 
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 0ca25697e4..43d2314441 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -24,7 +24,7 @@ extern bool xen_allowed;
 
 #define xen_enabled()           (xen_allowed)
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_XEN_HVM
 void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
@@ -33,7 +33,10 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
 #else /* !CONFIG_XEN_IS_POSSIBLE */
 
 #define xen_enabled() 0
-#ifndef CONFIG_USER_ONLY
+
+#endif /* CONFIG_XEN_IS_POSSIBLE */
+
+#if !defined(CONFIG_XEN_HVM) && !defined(CONFIG_USER_ONLY)
 static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 {
     /* nothing */
@@ -45,6 +48,4 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
 }
 #endif
 
-#endif /* CONFIG_XEN_IS_POSSIBLE */
-
 #endif
diff --git a/accel/stubs/xen-all-stub.c b/accel/stubs/xen-all-stub.c
new file mode 100644
index 0000000000..597c5789cc
--- /dev/null
+++ b/accel/stubs/xen-all-stub.c
@@ -0,0 +1,11 @@
+/*
+ * Copyright (C) 2014       Citrix Systems UK Ltd.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/xen.h"
+
+bool xen_allowed;
diff --git a/accel/stubs/xen-stub.c b/accel/stubs/xen-stub.c
index 7054965c48..6bc9906239 100644
--- a/accel/stubs/xen-stub.c
+++ b/accel/stubs/xen-stub.c
@@ -9,8 +9,6 @@
 #include "sysemu/xen.h"
 #include "qapi/qapi-commands-migration.h"
 
-bool xen_allowed;
-
 void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
 {
 }
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index d65cb6a5e1..dca468c82a 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -1,7 +1,8 @@
 softmmu_stub_ss = ss.source_set()
 
 softmmu_stub_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
-softmmu_stub_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
+softmmu_stub_ss.add(when: 'CONFIG_XEN', if_false: files('xen-all-stub.c'))
+softmmu_stub_ss.add(when: 'CONFIG_XEN_HVM', if_false: files('xen-stub.c'))
 softmmu_stub_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 softmmu_stub_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
 
diff --git a/hw/i386/xen/meson.build b/hw/i386/xen/meson.build
index be84130300..576e2cc5dc 100644
--- a/hw/i386/xen/meson.build
+++ b/hw/i386/xen/meson.build
@@ -1,4 +1,4 @@
-i386_ss.add(when: 'CONFIG_XEN', if_true: files(
+i386_ss.add(when: 'CONFIG_XEN_HVM', if_true: files(
   'xen-hvm.c',
   'xen-mapcache.c',
   'xen_apic.c',
-- 
2.20.1


