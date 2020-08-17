Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0208AC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0185205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns15tRZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0185205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gpW-0000PS-05
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHi-0005cH-MU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:50 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHg-0006HE-Ua
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id g8so13425487wmk.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QkSUKaQSRTqap5DCYMIG/XBpbSZg51wHSxqCC8/Qs+8=;
 b=Ns15tRZIMJSFvN6JSndeX0TVvYj8oJnRod3bzN73pq98jYYMLRMLzrm7inKVju7Q4e
 ejGZzmSR64a+XK1X0mVY2gJlioCdIqSFXI1yoBPwCnG7TVJdhTEQAdag0pVcGfIH37bQ
 tie4ktR/x30QSJjAH8sf8WGqjEyBEruZEKpl7Rn7qs2zqcG0CPyDF0hXZBM5NGMj2O8N
 WwZ+/gniNnJFM0d+EtO+EWt04YNfuaqiKHKA2LHT8fcq/fNizdFHL18xQD9QaAa22TnP
 PucWO3i0BC2BTNvUUBrncVN5yd2CWzwhRlb4kveuwFTuJB/MHrrNHPwwoZdV65UvqxEy
 ENFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QkSUKaQSRTqap5DCYMIG/XBpbSZg51wHSxqCC8/Qs+8=;
 b=OjmdM4ZhFVok45dvwYW65FvVkLuH/N/mGP2fiqlQh6U3hLBMsWUedQJQRGrt5KmbpQ
 /5b+FaJCCSty+/ZqKU++iLVbOh7MDx+DidTGb80+Lo+3YD+EETJPy+WkO7ZDapQbGv+j
 M8vga8cso2jqjVdN2crV8G/5H/dxsh9DVGK8AAkXSmSZZqOQAOQ+Z5Cm0noKTdzfMS3v
 JPEmwxg47W/Vz9/KsQfrFfd2AXzDyqbvTGplofkfblQptpbtiqNZZh2Cz+QxhW12Gz0b
 l2NP1Qer680zZLtm+xxWb8sCauoWsxHvxIVpYjda05QYWG8c1T1n4tANuPs3ZWxYW7P4
 wHSw==
X-Gm-Message-State: AOAM530mO9+8Og60p5g0z1vJifBNS2kJ7Hj4M7GpfxT0crvERZVitKoV
 jSALHEKkDpG+hw6QovEKHJCpZKR1NPY=
X-Google-Smtp-Source: ABdhPJxmjQt8Mtz+OdrAdvGIQ+GcVLWDkmtSgWLhkax5qpc11lj08H5E5cTp4dX4NpvT4M0xR63prA==
X-Received: by 2002:a1c:f30f:: with SMTP id q15mr14689214wmq.60.1597675127281; 
 Mon, 17 Aug 2020 07:38:47 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 082/150] meson: convert disas directory to Meson
Date: Mon, 17 Aug 2020 16:36:15 +0200
Message-Id: <20200817143723.343284-83-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs               |  2 --
 disas/Makefile.objs         | 30 ------------------------------
 disas/libvixl/Makefile.objs |  5 -----
 disas/libvixl/meson.build   |  7 +++++++
 disas/meson.build           | 27 +++++++++++++++++++++++++++
 meson.build                 |  1 +
 6 files changed, 35 insertions(+), 37 deletions(-)
 delete mode 100644 disas/Makefile.objs
 delete mode 100644 disas/libvixl/Makefile.objs
 create mode 100644 disas/libvixl/meson.build
 create mode 100644 disas/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 7158031c0c..3b32a4c9bb 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -74,8 +74,6 @@ endif # CONFIG_SOFTMMU
 # Target-independent parts used in system and user emulation
 
 common-obj-y += hw/
-common-obj-y += qom/
-common-obj-y += disas/
 
 ######################################################################
 # Resource file for Windows executables
diff --git a/disas/Makefile.objs b/disas/Makefile.objs
deleted file mode 100644
index 3c1cdce026..0000000000
--- a/disas/Makefile.objs
+++ /dev/null
@@ -1,30 +0,0 @@
-
-common-obj-$(CONFIG_ALPHA_DIS) += alpha.o
-common-obj-$(CONFIG_ARM_DIS) += arm.o
-common-obj-$(CONFIG_ARM_A64_DIS) += arm-a64.o
-common-obj-$(CONFIG_ARM_A64_DIS) += libvixl/
-libvixldir = $(SRC_PATH)/disas/libvixl
-# The -Wno-sign-compare is needed only for gcc 4.6, which complains about
-# some signed-unsigned equality comparisons in libvixl which later gcc
-# versions do not.
-arm-a64.o-cflags := -I$(libvixldir) -Wno-sign-compare
-common-obj-$(CONFIG_CRIS_DIS) += cris.o
-common-obj-$(CONFIG_HPPA_DIS) += hppa.o
-common-obj-$(CONFIG_I386_DIS) += i386.o
-common-obj-$(CONFIG_M68K_DIS) += m68k.o
-common-obj-$(CONFIG_MICROBLAZE_DIS) += microblaze.o
-common-obj-$(CONFIG_MIPS_DIS) += mips.o
-common-obj-$(CONFIG_NANOMIPS_DIS) += nanomips.o
-common-obj-$(CONFIG_NIOS2_DIS) += nios2.o
-common-obj-$(CONFIG_MOXIE_DIS) += moxie.o
-common-obj-$(CONFIG_PPC_DIS) += ppc.o
-common-obj-$(CONFIG_RISCV_DIS) += riscv.o
-common-obj-$(CONFIG_S390_DIS) += s390.o
-common-obj-$(CONFIG_SH4_DIS) += sh4.o
-common-obj-$(CONFIG_SPARC_DIS) += sparc.o
-common-obj-$(CONFIG_LM32_DIS) += lm32.o
-common-obj-$(CONFIG_XTENSA_DIS) += xtensa.o
-
-# TODO: As long as the TCG interpreter and its generated code depend
-# on the QEMU target, we cannot compile the disassembler here.
-#common-obj-$(CONFIG_TCI_DIS) += tci.o
diff --git a/disas/libvixl/Makefile.objs b/disas/libvixl/Makefile.objs
deleted file mode 100644
index 99a637f6a0..0000000000
--- a/disas/libvixl/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-common-obj-$(CONFIG_ARM_A64_DIS) = vixl/utils.o \
-               vixl/compiler-intrinsics.o \
-               vixl/a64/instructions-a64.o \
-               vixl/a64/decoder-a64.o \
-               vixl/a64/disasm-a64.o
diff --git a/disas/libvixl/meson.build b/disas/libvixl/meson.build
new file mode 100644
index 0000000000..5e2eb33e8e
--- /dev/null
+++ b/disas/libvixl/meson.build
@@ -0,0 +1,7 @@
+libvixl_ss.add(files(
+  'vixl/a64/decoder-a64.cc',
+  'vixl/a64/disasm-a64.cc',
+  'vixl/a64/instructions-a64.cc',
+  'vixl/compiler-intrinsics.cc',
+  'vixl/utils.cc',
+))
diff --git a/disas/meson.build b/disas/meson.build
new file mode 100644
index 0000000000..0527d69128
--- /dev/null
+++ b/disas/meson.build
@@ -0,0 +1,27 @@
+libvixl_ss = ss.source_set()
+subdir('libvixl')
+
+common_ss.add(when: 'CONFIG_ALPHA_DIS', if_true: files('alpha.c'))
+common_ss.add(when: 'CONFIG_ARM_A64_DIS', if_true: files('arm-a64.cc'))
+common_ss.add_all(when: 'CONFIG_ARM_A64_DIS', if_true: libvixl_ss)
+common_ss.add(when: 'CONFIG_ARM_DIS', if_true: files('arm.c'))
+common_ss.add(when: 'CONFIG_CRIS_DIS', if_true: files('cris.c'))
+common_ss.add(when: 'CONFIG_HPPA_DIS', if_true: files('hppa.c'))
+common_ss.add(when: 'CONFIG_I386_DIS', if_true: files('i386.c'))
+common_ss.add(when: 'CONFIG_LM32_DIS', if_true: files('lm32.c'))
+common_ss.add(when: 'CONFIG_M68K_DIS', if_true: files('m68k.c'))
+common_ss.add(when: 'CONFIG_MICROBLAZE_DIS', if_true: files('microblaze.c'))
+common_ss.add(when: 'CONFIG_MIPS_DIS', if_true: files('mips.c'))
+common_ss.add(when: 'CONFIG_MOXIE_DIS', if_true: files('moxie.c'))
+common_ss.add(when: 'CONFIG_NANOMIPS_DIS', if_true: files('nanomips.cpp'))
+common_ss.add(when: 'CONFIG_NIOS2_DIS', if_true: files('nios2.c'))
+common_ss.add(when: 'CONFIG_PPC_DIS', if_true: files('ppc.c'))
+common_ss.add(when: 'CONFIG_RISCV_DIS', if_true: files('riscv.c'))
+common_ss.add(when: 'CONFIG_S390_DIS', if_true: files('s390.c'))
+common_ss.add(when: 'CONFIG_SH4_DIS', if_true: files('sh4.c'))
+common_ss.add(when: 'CONFIG_SPARC_DIS', if_true: files('sparc.c'))
+common_ss.add(when: 'CONFIG_XTENSA_DIS', if_true: files('xtensa.c'))
+
+# TODO: As long as the TCG interpreter and its generated code depend
+# on the QEMU target, we cannot compile the disassembler here.
+#common_ss.add(when: 'CONFIG_TCI_DIS', if_true: files('tci.c'))
diff --git a/meson.build b/meson.build
index dd80401d11..acd730ba92 100644
--- a/meson.build
+++ b/meson.build
@@ -669,6 +669,7 @@ common_ss.add(files('cpus-common.c'))
 
 subdir('softmmu')
 subdir('backends')
+subdir('disas')
 subdir('migration')
 subdir('monitor')
 subdir('net')
-- 
2.26.2



