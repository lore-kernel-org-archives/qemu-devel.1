Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63BAC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D3320578
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1FnJBXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D3320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPM2Q-0000mh-Ao
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmt-0008B3-UV
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmq-0007KJ-Da
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:03 -0400
Received: by mail-wm1-x331.google.com with SMTP id f21so2367056wml.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2dRW0974VggKIKxqGHMNH2Z/NUUfZJGSnT5HxJ2UirI=;
 b=A1FnJBXa6mE5Js9Dz2UIBNdaThOTd627f+6O3SeZAZ624pruB/6unsofiWa2Ua5fmJ
 uHcEujp+BeFR0WWmBy98hLc4XCS7RV03V6jr3LVjF1vNP/f53X9k5d3867PhM257k8Mu
 oHRBA425iDzKrBhCllSuluVet9G1GueA4aTyVERVhsjvaqAve4xD6qY4YLXyTbV5D9me
 GTynJG0lzqyzYMRo2HQUz7I97a08fYfXK6VUszuYy7mUH46+DW73LE+usHzKxd+p0ACS
 Phk4ISKA+HB5a8gnhdPpwRmQUUtj3Q8CtbCV8tSNruaJnHjkA6lLeoitYHmck8uNSI7F
 3oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2dRW0974VggKIKxqGHMNH2Z/NUUfZJGSnT5HxJ2UirI=;
 b=HL9MLIS7/0BEmSRNBs2/vTSuuJ0Tkjywix61Iuw7ar9Az1b+iXns9zaT3Z+peJ2JX9
 67XW6kTiyswW93bptuqw5gDNFXWmfGfGCdoqNKveauTfYV2pIanfCBWTyCNjaI+rqlBm
 k954Pg08T9cDxyVPTBYBHMBAAMo0bbnjXDzFaLKEZZUSjcApqwNGdZJRDmKZWcXAMX/2
 4Of2nlIupBpZCT26eEaNwXYdIO1ZC94JgdrFPLPBcrCC/T8XAbdwi3VSBBLjkObe0mF6
 YMmFfEqfOAHUHh0xh3AT429e5t5YT5T9xNcLWqAJHbyZjaxHrsApT2kmu04aok75+0Fd
 mEnA==
X-Gm-Message-State: AOAM532NCoQ3OH2XlVJ3902fKdSCOneMvDXiOPvHncRDCjI1EX4q7HXa
 TIyxXUrfPHZXQzYnIqSVD0HV8fLPFlU=
X-Google-Smtp-Source: ABdhPJywajOLQIYekjUn+bAuUyPK0kJSMweSsny+KpUVPWlnxrPz5GWfu/ZM34XQHPVlUwwLYSFDOA==
X-Received: by 2002:a1c:1905:: with SMTP id 5mr16091053wmz.32.1601886238261;
 Mon, 05 Oct 2020 01:23:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.23.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:23:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/19] default-configs: use TARGET_ARCH key
Date: Mon,  5 Oct 2020 10:23:42 +0200
Message-Id: <20201005082349.354095-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the individual TARGET_*=y lines with TARGET_ARCH,
similar to how TARGET_BASE_ARCH is handled already.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/targets/aarch64-linux-user.mak      | 2 +-
 default-configs/targets/aarch64-softmmu.mak         | 2 +-
 default-configs/targets/aarch64_be-linux-user.mak   | 2 +-
 default-configs/targets/alpha-linux-user.mak        | 2 +-
 default-configs/targets/alpha-softmmu.mak           | 2 +-
 default-configs/targets/arm-linux-user.mak          | 2 +-
 default-configs/targets/arm-softmmu.mak             | 2 +-
 default-configs/targets/armeb-linux-user.mak        | 2 +-
 default-configs/targets/avr-softmmu.mak             | 2 +-
 default-configs/targets/cris-linux-user.mak         | 2 +-
 default-configs/targets/cris-softmmu.mak            | 2 +-
 default-configs/targets/hppa-linux-user.mak         | 2 +-
 default-configs/targets/hppa-softmmu.mak            | 2 +-
 default-configs/targets/i386-bsd-user.mak           | 2 +-
 default-configs/targets/i386-linux-user.mak         | 2 +-
 default-configs/targets/i386-softmmu.mak            | 2 +-
 default-configs/targets/lm32-softmmu.mak            | 2 +-
 default-configs/targets/m68k-linux-user.mak         | 2 +-
 default-configs/targets/m68k-softmmu.mak            | 2 +-
 default-configs/targets/microblaze-linux-user.mak   | 2 +-
 default-configs/targets/microblaze-softmmu.mak      | 2 +-
 default-configs/targets/microblazeel-linux-user.mak | 2 +-
 default-configs/targets/microblazeel-softmmu.mak    | 2 +-
 default-configs/targets/mips-linux-user.mak         | 2 +-
 default-configs/targets/mips-softmmu.mak            | 2 +-
 default-configs/targets/mips64-linux-user.mak       | 2 +-
 default-configs/targets/mips64-softmmu.mak          | 2 +-
 default-configs/targets/mips64el-linux-user.mak     | 2 +-
 default-configs/targets/mips64el-softmmu.mak        | 2 +-
 default-configs/targets/mipsel-linux-user.mak       | 2 +-
 default-configs/targets/mipsel-softmmu.mak          | 2 +-
 default-configs/targets/mipsn32-linux-user.mak      | 2 +-
 default-configs/targets/mipsn32el-linux-user.mak    | 2 +-
 default-configs/targets/moxie-softmmu.mak           | 2 +-
 default-configs/targets/nios2-linux-user.mak        | 2 +-
 default-configs/targets/nios2-softmmu.mak           | 2 +-
 default-configs/targets/or1k-linux-user.mak         | 2 +-
 default-configs/targets/or1k-softmmu.mak            | 2 +-
 default-configs/targets/ppc-linux-user.mak          | 2 +-
 default-configs/targets/ppc-softmmu.mak             | 2 +-
 default-configs/targets/ppc64-linux-user.mak        | 2 +-
 default-configs/targets/ppc64-softmmu.mak           | 2 +-
 default-configs/targets/ppc64abi32-linux-user.mak   | 2 +-
 default-configs/targets/ppc64le-linux-user.mak      | 2 +-
 default-configs/targets/riscv32-linux-user.mak      | 2 +-
 default-configs/targets/riscv32-softmmu.mak         | 2 +-
 default-configs/targets/riscv64-linux-user.mak      | 2 +-
 default-configs/targets/riscv64-softmmu.mak         | 2 +-
 default-configs/targets/rx-softmmu.mak              | 2 +-
 default-configs/targets/s390x-linux-user.mak        | 2 +-
 default-configs/targets/s390x-softmmu.mak           | 2 +-
 default-configs/targets/sh4-linux-user.mak          | 2 +-
 default-configs/targets/sh4-softmmu.mak             | 2 +-
 default-configs/targets/sh4eb-linux-user.mak        | 2 +-
 default-configs/targets/sh4eb-softmmu.mak           | 2 +-
 default-configs/targets/sparc-bsd-user.mak          | 2 +-
 default-configs/targets/sparc-linux-user.mak        | 2 +-
 default-configs/targets/sparc-softmmu.mak           | 2 +-
 default-configs/targets/sparc32plus-linux-user.mak  | 2 +-
 default-configs/targets/sparc64-bsd-user.mak        | 2 +-
 default-configs/targets/sparc64-linux-user.mak      | 2 +-
 default-configs/targets/sparc64-softmmu.mak         | 2 +-
 default-configs/targets/tilegx-linux-user.mak       | 2 +-
 default-configs/targets/tricore-softmmu.mak         | 2 +-
 default-configs/targets/unicore32-softmmu.mak       | 2 +-
 default-configs/targets/x86_64-bsd-user.mak         | 2 +-
 default-configs/targets/x86_64-linux-user.mak       | 2 +-
 default-configs/targets/x86_64-softmmu.mak          | 2 +-
 default-configs/targets/xtensa-linux-user.mak       | 2 +-
 default-configs/targets/xtensa-softmmu.mak          | 2 +-
 default-configs/targets/xtensaeb-linux-user.mak     | 2 +-
 default-configs/targets/xtensaeb-softmmu.mak        | 2 +-
 meson.build                                         | 5 ++++-
 73 files changed, 76 insertions(+), 73 deletions(-)

diff --git a/default-configs/targets/aarch64-linux-user.mak b/default-configs/targets/aarch64-linux-user.mak
index 4495e86509..d6c4a35c39 100644
--- a/default-configs/targets/aarch64-linux-user.mak
+++ b/default-configs/targets/aarch64-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_AARCH64=y
+TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_ABI_DIR=aarch64
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
diff --git a/default-configs/targets/aarch64-softmmu.mak b/default-configs/targets/aarch64-softmmu.mak
index 4eff428074..a8c0174fc3 100644
--- a/default-configs/targets/aarch64-softmmu.mak
+++ b/default-configs/targets/aarch64-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_AARCH64=y
+TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
diff --git a/default-configs/targets/aarch64_be-linux-user.mak b/default-configs/targets/aarch64_be-linux-user.mak
index da13693d3d..5e2d615c11 100644
--- a/default-configs/targets/aarch64_be-linux-user.mak
+++ b/default-configs/targets/aarch64_be-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_AARCH64=y
+TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_ABI_DIR=aarch64
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/alpha-linux-user.mak b/default-configs/targets/alpha-linux-user.mak
index 5ff89f5d48..e21f7cdefd 100644
--- a/default-configs/targets/alpha-linux-user.mak
+++ b/default-configs/targets/alpha-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_ALPHA=y
+TARGET_ARCH=alpha
 TARGET_BASE_ARCH=alpha
 TARGET_ABI_DIR=alpha
 TARGET_SYSTBL_ABI=common
diff --git a/default-configs/targets/alpha-softmmu.mak b/default-configs/targets/alpha-softmmu.mak
index 8a484c9775..8ba1b4e403 100644
--- a/default-configs/targets/alpha-softmmu.mak
+++ b/default-configs/targets/alpha-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_ALPHA=y
+TARGET_ARCH=alpha
 TARGET_BASE_ARCH=alpha
 TARGET_ALIGNED_ONLY=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/arm-linux-user.mak b/default-configs/targets/arm-linux-user.mak
index 7c54c3c2a2..1b9bac9d3a 100644
--- a/default-configs/targets/arm-linux-user.mak
+++ b/default-configs/targets/arm-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_ARM=y
+TARGET_ARCH=arm
 TARGET_BASE_ARCH=arm
 TARGET_ABI_DIR=arm
 TARGET_SYSTBL_ABI=common,oabi
diff --git a/default-configs/targets/arm-softmmu.mak b/default-configs/targets/arm-softmmu.mak
index 5923f9b203..8af1d3ee1d 100644
--- a/default-configs/targets/arm-softmmu.mak
+++ b/default-configs/targets/arm-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_ARM=y
+TARGET_ARCH=arm
 TARGET_BASE_ARCH=arm
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
diff --git a/default-configs/targets/armeb-linux-user.mak b/default-configs/targets/armeb-linux-user.mak
index 1882aa472d..d2b0d9e26e 100644
--- a/default-configs/targets/armeb-linux-user.mak
+++ b/default-configs/targets/armeb-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_ARM=y
+TARGET_ARCH=arm
 TARGET_BASE_ARCH=arm
 TARGET_ABI_DIR=arm
 TARGET_SYSTBL_ABI=common,oabi
diff --git a/default-configs/targets/avr-softmmu.mak b/default-configs/targets/avr-softmmu.mak
index 46b6da717c..547c2986b6 100644
--- a/default-configs/targets/avr-softmmu.mak
+++ b/default-configs/targets/avr-softmmu.mak
@@ -1,3 +1,3 @@
-TARGET_AVR=y
+TARGET_ARCH=avr
 TARGET_BASE_ARCH=avr
 TARGET_XML_FILES= gdb-xml/avr-cpu.xml
diff --git a/default-configs/targets/cris-linux-user.mak b/default-configs/targets/cris-linux-user.mak
index ba61135172..7d3f6eb36d 100644
--- a/default-configs/targets/cris-linux-user.mak
+++ b/default-configs/targets/cris-linux-user.mak
@@ -1,3 +1,3 @@
-TARGET_CRIS=y
+TARGET_ARCH=cris
 TARGET_BASE_ARCH=cris
 TARGET_ABI_DIR=cris
diff --git a/default-configs/targets/cris-softmmu.mak b/default-configs/targets/cris-softmmu.mak
index 1f7b44114b..a132cec8d9 100644
--- a/default-configs/targets/cris-softmmu.mak
+++ b/default-configs/targets/cris-softmmu.mak
@@ -1,2 +1,2 @@
-TARGET_CRIS=y
+TARGET_ARCH=cris
 TARGET_BASE_ARCH=cris
diff --git a/default-configs/targets/hppa-linux-user.mak b/default-configs/targets/hppa-linux-user.mak
index 94222e8fc6..05ef4568ad 100644
--- a/default-configs/targets/hppa-linux-user.mak
+++ b/default-configs/targets/hppa-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_HPPA=y
+TARGET_ARCH=hppa
 TARGET_BASE_ARCH=hppa
 TARGET_ABI_DIR=hppa
 TARGET_SYSTBL_ABI=common,32
diff --git a/default-configs/targets/hppa-softmmu.mak b/default-configs/targets/hppa-softmmu.mak
index c4ee4e6c51..bd7eaaf9a5 100644
--- a/default-configs/targets/hppa-softmmu.mak
+++ b/default-configs/targets/hppa-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_HPPA=y
+TARGET_ARCH=hppa
 TARGET_BASE_ARCH=hppa
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/i386-bsd-user.mak b/default-configs/targets/i386-bsd-user.mak
index c58db819ae..aa4d8c55e1 100644
--- a/default-configs/targets/i386-bsd-user.mak
+++ b/default-configs/targets/i386-bsd-user.mak
@@ -1,4 +1,4 @@
-TARGET_I386=y
+TARGET_ARCH=i386
 TARGET_BASE_ARCH=i386
 TARGET_ABI_DIR=i386
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/default-configs/targets/i386-linux-user.mak b/default-configs/targets/i386-linux-user.mak
index 34b52e9ee2..5117f59222 100644
--- a/default-configs/targets/i386-linux-user.mak
+++ b/default-configs/targets/i386-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_I386=y
+TARGET_ARCH=i386
 TARGET_BASE_ARCH=i386
 TARGET_ABI_DIR=i386
 TARGET_SYSTBL_ABI=i386
diff --git a/default-configs/targets/i386-softmmu.mak b/default-configs/targets/i386-softmmu.mak
index 4e2eb9f369..7371e87982 100644
--- a/default-configs/targets/i386-softmmu.mak
+++ b/default-configs/targets/i386-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_I386=y
+TARGET_ARCH=i386
 TARGET_BASE_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/default-configs/targets/lm32-softmmu.mak b/default-configs/targets/lm32-softmmu.mak
index 2c4b8eab79..6e55873788 100644
--- a/default-configs/targets/lm32-softmmu.mak
+++ b/default-configs/targets/lm32-softmmu.mak
@@ -1,3 +1,3 @@
-TARGET_LM32=y
+TARGET_ARCH=lm32
 TARGET_BASE_ARCH=lm32
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/m68k-linux-user.mak b/default-configs/targets/m68k-linux-user.mak
index e7c0af5881..186d1117cf 100644
--- a/default-configs/targets/m68k-linux-user.mak
+++ b/default-configs/targets/m68k-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_M68K=y
+TARGET_ARCH=m68k
 TARGET_BASE_ARCH=m68k
 TARGET_ABI_DIR=m68k
 TARGET_SYSTBL_ABI=common
diff --git a/default-configs/targets/m68k-softmmu.mak b/default-configs/targets/m68k-softmmu.mak
index 991e626677..fd8975978c 100644
--- a/default-configs/targets/m68k-softmmu.mak
+++ b/default-configs/targets/m68k-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_M68K=y
+TARGET_ARCH=m68k
 TARGET_BASE_ARCH=m68k
 TARGET_WORDS_BIGENDIAN=y
 TARGET_XML_FILES= gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
diff --git a/default-configs/targets/microblaze-linux-user.mak b/default-configs/targets/microblaze-linux-user.mak
index 809819424d..249a22295a 100644
--- a/default-configs/targets/microblaze-linux-user.mak
+++ b/default-configs/targets/microblaze-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_MICROBLAZE=y
+TARGET_ARCH=microblaze
 TARGET_BASE_ARCH=microblaze
 TARGET_ABI_DIR=microblaze
 TARGET_SYSTBL_ABI=common
diff --git a/default-configs/targets/microblaze-softmmu.mak b/default-configs/targets/microblaze-softmmu.mak
index 24594862bf..8e5126f0f1 100644
--- a/default-configs/targets/microblaze-softmmu.mak
+++ b/default-configs/targets/microblaze-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_MICROBLAZE=y
+TARGET_ARCH=microblaze
 TARGET_BASE_ARCH=microblaze
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/microblazeel-linux-user.mak b/default-configs/targets/microblazeel-linux-user.mak
index 416b42eeb6..f59156c63b 100644
--- a/default-configs/targets/microblazeel-linux-user.mak
+++ b/default-configs/targets/microblazeel-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_MICROBLAZE=y
+TARGET_ARCH=microblaze
 TARGET_BASE_ARCH=microblaze
 TARGET_ABI_DIR=microblaze
 TARGET_SYSTBL_ABI=common
diff --git a/default-configs/targets/microblazeel-softmmu.mak b/default-configs/targets/microblazeel-softmmu.mak
index 5817a63755..2d465cf6b4 100644
--- a/default-configs/targets/microblazeel-softmmu.mak
+++ b/default-configs/targets/microblazeel-softmmu.mak
@@ -1,3 +1,3 @@
-TARGET_MICROBLAZE=y
+TARGET_ARCH=microblaze
 TARGET_BASE_ARCH=microblaze
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/mips-linux-user.mak b/default-configs/targets/mips-linux-user.mak
index bcfff16a7b..5b8000dfb0 100644
--- a/default-configs/targets/mips-linux-user.mak
+++ b/default-configs/targets/mips-linux-user.mak
@@ -1,5 +1,5 @@
+TARGET_ARCH=mips
 TARGET_ABI_MIPSO32=y
-TARGET_MIPS=y
 TARGET_BASE_ARCH=mips
 TARGET_ABI_DIR=mips
 TARGET_SYSTBL_ABI=o32
diff --git a/default-configs/targets/mips-softmmu.mak b/default-configs/targets/mips-softmmu.mak
index 1b4bba6e3b..e391801a0e 100644
--- a/default-configs/targets/mips-softmmu.mak
+++ b/default-configs/targets/mips-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_MIPS=y
+TARGET_ARCH=mips
 TARGET_BASE_ARCH=mips
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/mips64-linux-user.mak b/default-configs/targets/mips64-linux-user.mak
index c02c5460a7..811df35427 100644
--- a/default-configs/targets/mips64-linux-user.mak
+++ b/default-configs/targets/mips64-linux-user.mak
@@ -1,5 +1,5 @@
+TARGET_ARCH=mips64
 TARGET_ABI_MIPSN64=y
-TARGET_MIPS64=y
 TARGET_BASE_ARCH=mips
 TARGET_ABI_DIR=mips64
 TARGET_SYSTBL_ABI=n64
diff --git a/default-configs/targets/mips64-softmmu.mak b/default-configs/targets/mips64-softmmu.mak
index 736586f01b..ece25b9624 100644
--- a/default-configs/targets/mips64-softmmu.mak
+++ b/default-configs/targets/mips64-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_MIPS64=y
+TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/mips64el-linux-user.mak b/default-configs/targets/mips64el-linux-user.mak
index 8cbbc38e78..f9de5d7857 100644
--- a/default-configs/targets/mips64el-linux-user.mak
+++ b/default-configs/targets/mips64el-linux-user.mak
@@ -1,5 +1,5 @@
+TARGET_ARCH=mips64
 TARGET_ABI_MIPSN64=y
-TARGET_MIPS64=y
 TARGET_BASE_ARCH=mips
 TARGET_ABI_DIR=mips64
 TARGET_SYSTBL_ABI=n64
diff --git a/default-configs/targets/mips64el-softmmu.mak b/default-configs/targets/mips64el-softmmu.mak
index aed4fe89b0..b751ae1bcf 100644
--- a/default-configs/targets/mips64el-softmmu.mak
+++ b/default-configs/targets/mips64el-softmmu.mak
@@ -1,3 +1,3 @@
-TARGET_MIPS64=y
+TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mipsel-linux-user.mak b/default-configs/targets/mipsel-linux-user.mak
index 26aa9c8279..11c3556665 100644
--- a/default-configs/targets/mipsel-linux-user.mak
+++ b/default-configs/targets/mipsel-linux-user.mak
@@ -1,5 +1,5 @@
+TARGET_ARCH=mips
 TARGET_ABI_MIPSO32=y
-TARGET_MIPS=y
 TARGET_BASE_ARCH=mips
 TARGET_ABI_DIR=mips
 TARGET_SYSTBL_ABI=o32
diff --git a/default-configs/targets/mipsel-softmmu.mak b/default-configs/targets/mipsel-softmmu.mak
index ca95b39d29..a9fc3b2647 100644
--- a/default-configs/targets/mipsel-softmmu.mak
+++ b/default-configs/targets/mipsel-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_MIPS=y
+TARGET_ARCH=mips
 TARGET_BASE_ARCH=mips
 TARGET_ALIGNED_ONLY=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/mipsn32-linux-user.mak b/default-configs/targets/mipsn32-linux-user.mak
index 81d548e699..040022ce87 100644
--- a/default-configs/targets/mipsn32-linux-user.mak
+++ b/default-configs/targets/mipsn32-linux-user.mak
@@ -1,6 +1,6 @@
+TARGET_ARCH=mips64
 TARGET_ABI_MIPSN32=y
 TARGET_ABI32=y
-TARGET_MIPS64=y
 TARGET_BASE_ARCH=mips
 TARGET_ABI_DIR=mips64
 TARGET_SYSTBL_ABI=n32
diff --git a/default-configs/targets/mipsn32el-linux-user.mak b/default-configs/targets/mipsn32el-linux-user.mak
index 6de47f2a79..faeca7752e 100644
--- a/default-configs/targets/mipsn32el-linux-user.mak
+++ b/default-configs/targets/mipsn32el-linux-user.mak
@@ -1,6 +1,6 @@
+TARGET_ARCH=mips64
 TARGET_ABI_MIPSN32=y
 TARGET_ABI32=y
-TARGET_MIPS64=y
 TARGET_BASE_ARCH=mips
 TARGET_ABI_DIR=mips64
 TARGET_SYSTBL_ABI=n32
diff --git a/default-configs/targets/moxie-softmmu.mak b/default-configs/targets/moxie-softmmu.mak
index ada92a6b5b..b9d8d97031 100644
--- a/default-configs/targets/moxie-softmmu.mak
+++ b/default-configs/targets/moxie-softmmu.mak
@@ -1,3 +1,3 @@
-TARGET_MOXIE=y
+TARGET_ARCH=moxie
 TARGET_BASE_ARCH=moxie
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/nios2-linux-user.mak b/default-configs/targets/nios2-linux-user.mak
index a2308a16aa..57ddc32838 100644
--- a/default-configs/targets/nios2-linux-user.mak
+++ b/default-configs/targets/nios2-linux-user.mak
@@ -1,3 +1,3 @@
-TARGET_NIOS2=y
+TARGET_ARCH=nios2
 TARGET_BASE_ARCH=nios2
 TARGET_ABI_DIR=nios2
diff --git a/default-configs/targets/nios2-softmmu.mak b/default-configs/targets/nios2-softmmu.mak
index f10f08d0ca..787d1d1be1 100644
--- a/default-configs/targets/nios2-softmmu.mak
+++ b/default-configs/targets/nios2-softmmu.mak
@@ -1,2 +1,2 @@
-TARGET_NIOS2=y
+TARGET_ARCH=nios2
 TARGET_BASE_ARCH=nios2
diff --git a/default-configs/targets/or1k-linux-user.mak b/default-configs/targets/or1k-linux-user.mak
index 2f5ff844df..88175f039b 100644
--- a/default-configs/targets/or1k-linux-user.mak
+++ b/default-configs/targets/or1k-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_OPENRISC=y
+TARGET_ARCH=openrisc
 TARGET_BASE_ARCH=openrisc
 TARGET_ABI_DIR=openrisc
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/or1k-softmmu.mak b/default-configs/targets/or1k-softmmu.mak
index a922266a98..4c0c4165aa 100644
--- a/default-configs/targets/or1k-softmmu.mak
+++ b/default-configs/targets/or1k-softmmu.mak
@@ -1,3 +1,3 @@
-TARGET_OPENRISC=y
+TARGET_ARCH=openrisc
 TARGET_BASE_ARCH=openrisc
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/ppc-linux-user.mak b/default-configs/targets/ppc-linux-user.mak
index c4d912bfb1..dda377508b 100644
--- a/default-configs/targets/ppc-linux-user.mak
+++ b/default-configs/targets/ppc-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_PPC=y
+TARGET_ARCH=ppc
 TARGET_BASE_ARCH=ppc
 TARGET_ABI_DIR=ppc
 TARGET_SYSTBL_ABI=common,nospu,32
diff --git a/default-configs/targets/ppc-softmmu.mak b/default-configs/targets/ppc-softmmu.mak
index 1b6d091cfb..b02f1fe51a 100644
--- a/default-configs/targets/ppc-softmmu.mak
+++ b/default-configs/targets/ppc-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_PPC=y
+TARGET_ARCH=ppc
 TARGET_BASE_ARCH=ppc
 TARGET_WORDS_BIGENDIAN=y
 TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
diff --git a/default-configs/targets/ppc64-linux-user.mak b/default-configs/targets/ppc64-linux-user.mak
index 7f96ab7e9d..3133346676 100644
--- a/default-configs/targets/ppc64-linux-user.mak
+++ b/default-configs/targets/ppc64-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_PPC64=y
+TARGET_ARCH=ppc64
 TARGET_BASE_ARCH=ppc
 TARGET_ABI_DIR=ppc
 TARGET_SYSTBL_ABI=common,nospu,64
diff --git a/default-configs/targets/ppc64-softmmu.mak b/default-configs/targets/ppc64-softmmu.mak
index e431feffeb..0fde2d02b9 100644
--- a/default-configs/targets/ppc64-softmmu.mak
+++ b/default-configs/targets/ppc64-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_PPC64=y
+TARGET_ARCH=ppc64
 TARGET_BASE_ARCH=ppc
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/ppc64abi32-linux-user.mak b/default-configs/targets/ppc64abi32-linux-user.mak
index 13a02700aa..0945451081 100644
--- a/default-configs/targets/ppc64abi32-linux-user.mak
+++ b/default-configs/targets/ppc64abi32-linux-user.mak
@@ -1,5 +1,5 @@
+TARGET_ARCH=ppc64
 TARGET_ABI32=y
-TARGET_PPC64=y
 TARGET_BASE_ARCH=ppc
 TARGET_ABI_DIR=ppc
 TARGET_SYSTBL_ABI=common,nospu,32
diff --git a/default-configs/targets/ppc64le-linux-user.mak b/default-configs/targets/ppc64le-linux-user.mak
index 3dd54b894c..426d5a28d6 100644
--- a/default-configs/targets/ppc64le-linux-user.mak
+++ b/default-configs/targets/ppc64le-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_PPC64=y
+TARGET_ARCH=ppc64
 TARGET_BASE_ARCH=ppc
 TARGET_ABI_DIR=ppc
 TARGET_SYSTBL_ABI=common,nospu,64
diff --git a/default-configs/targets/riscv32-linux-user.mak b/default-configs/targets/riscv32-linux-user.mak
index 91d72a46b0..dfb259e8aa 100644
--- a/default-configs/targets/riscv32-linux-user.mak
+++ b/default-configs/targets/riscv32-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_RISCV32=y
+TARGET_ARCH=riscv32
 TARGET_BASE_ARCH=riscv
 TARGET_ABI_DIR=riscv
 TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-csr.xml gdb-xml/riscv-32bit-virtual.xml
diff --git a/default-configs/targets/riscv32-softmmu.mak b/default-configs/targets/riscv32-softmmu.mak
index caa5829af8..4544e1ae9a 100644
--- a/default-configs/targets/riscv32-softmmu.mak
+++ b/default-configs/targets/riscv32-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_RISCV32=y
+TARGET_ARCH=riscv32
 TARGET_BASE_ARCH=riscv
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-csr.xml gdb-xml/riscv-32bit-virtual.xml
diff --git a/default-configs/targets/riscv64-linux-user.mak b/default-configs/targets/riscv64-linux-user.mak
index 9e53193cdb..b13895f3b0 100644
--- a/default-configs/targets/riscv64-linux-user.mak
+++ b/default-configs/targets/riscv64-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_RISCV64=y
+TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
 TARGET_ABI_DIR=riscv
 TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-csr.xml gdb-xml/riscv-64bit-virtual.xml
diff --git a/default-configs/targets/riscv64-softmmu.mak b/default-configs/targets/riscv64-softmmu.mak
index e190c0363b..6ce0b283cf 100644
--- a/default-configs/targets/riscv64-softmmu.mak
+++ b/default-configs/targets/riscv64-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_RISCV64=y
+TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-csr.xml gdb-xml/riscv-64bit-virtual.xml
diff --git a/default-configs/targets/rx-softmmu.mak b/default-configs/targets/rx-softmmu.mak
index 37b365475f..07abc5cd55 100644
--- a/default-configs/targets/rx-softmmu.mak
+++ b/default-configs/targets/rx-softmmu.mak
@@ -1,3 +1,3 @@
-TARGET_RX=y
+TARGET_ARCH=rx
 TARGET_BASE_ARCH=rx
 TARGET_XML_FILES= gdb-xml/rx-core.xml
diff --git a/default-configs/targets/s390x-linux-user.mak b/default-configs/targets/s390x-linux-user.mak
index 77ebec769f..f7e4244f43 100644
--- a/default-configs/targets/s390x-linux-user.mak
+++ b/default-configs/targets/s390x-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_S390X=y
+TARGET_ARCH=s390x
 TARGET_BASE_ARCH=s390x
 TARGET_ABI_DIR=s390x
 TARGET_SYSTBL_ABI=common,64
diff --git a/default-configs/targets/s390x-softmmu.mak b/default-configs/targets/s390x-softmmu.mak
index f08d25d3c3..080682f07b 100644
--- a/default-configs/targets/s390x-softmmu.mak
+++ b/default-configs/targets/s390x-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_S390X=y
+TARGET_ARCH=s390x
 TARGET_BASE_ARCH=s390x
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/sh4-linux-user.mak b/default-configs/targets/sh4-linux-user.mak
index 4292dd6128..db395a4886 100644
--- a/default-configs/targets/sh4-linux-user.mak
+++ b/default-configs/targets/sh4-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_SH4=y
+TARGET_ARCH=sh4
 TARGET_BASE_ARCH=sh4
 TARGET_ABI_DIR=sh4
 TARGET_SYSTBL_ABI=common
diff --git a/default-configs/targets/sh4-softmmu.mak b/default-configs/targets/sh4-softmmu.mak
index 8c7e9eaa7b..037cdac1d2 100644
--- a/default-configs/targets/sh4-softmmu.mak
+++ b/default-configs/targets/sh4-softmmu.mak
@@ -1,3 +1,3 @@
-TARGET_SH4=y
+TARGET_ARCH=sh4
 TARGET_BASE_ARCH=sh4
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/sh4eb-linux-user.mak b/default-configs/targets/sh4eb-linux-user.mak
index cf9178f4ea..b498e99ac2 100644
--- a/default-configs/targets/sh4eb-linux-user.mak
+++ b/default-configs/targets/sh4eb-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_SH4=y
+TARGET_ARCH=sh4
 TARGET_BASE_ARCH=sh4
 TARGET_ABI_DIR=sh4
 TARGET_SYSTBL_ABI=common
diff --git a/default-configs/targets/sh4eb-softmmu.mak b/default-configs/targets/sh4eb-softmmu.mak
index f1848b89b6..e0fc9715e0 100644
--- a/default-configs/targets/sh4eb-softmmu.mak
+++ b/default-configs/targets/sh4eb-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_SH4=y
+TARGET_ARCH=sh4
 TARGET_BASE_ARCH=sh4
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc-bsd-user.mak b/default-configs/targets/sparc-bsd-user.mak
index f478255591..bb83a268b6 100644
--- a/default-configs/targets/sparc-bsd-user.mak
+++ b/default-configs/targets/sparc-bsd-user.mak
@@ -1,4 +1,4 @@
-TARGET_SPARC=y
+TARGET_ARCH=sparc
 TARGET_BASE_ARCH=sparc
 TARGET_ABI_DIR=sparc
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/sparc-linux-user.mak b/default-configs/targets/sparc-linux-user.mak
index 7f2fcba978..72a4a90219 100644
--- a/default-configs/targets/sparc-linux-user.mak
+++ b/default-configs/targets/sparc-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_SPARC=y
+TARGET_ARCH=sparc
 TARGET_BASE_ARCH=sparc
 TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,32
diff --git a/default-configs/targets/sparc-softmmu.mak b/default-configs/targets/sparc-softmmu.mak
index fb3dbb0d61..dab69263bb 100644
--- a/default-configs/targets/sparc-softmmu.mak
+++ b/default-configs/targets/sparc-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_SPARC=y
+TARGET_ARCH=sparc
 TARGET_BASE_ARCH=sparc
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc32plus-linux-user.mak b/default-configs/targets/sparc32plus-linux-user.mak
index f5fcb7879e..e4c51df3dc 100644
--- a/default-configs/targets/sparc32plus-linux-user.mak
+++ b/default-configs/targets/sparc32plus-linux-user.mak
@@ -1,5 +1,5 @@
+TARGET_ARCH=sparc64
 TARGET_ABI32=y
-TARGET_SPARC64=y
 TARGET_BASE_ARCH=sparc
 TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,32
diff --git a/default-configs/targets/sparc64-bsd-user.mak b/default-configs/targets/sparc64-bsd-user.mak
index 0ae8ea5420..3202825dc3 100644
--- a/default-configs/targets/sparc64-bsd-user.mak
+++ b/default-configs/targets/sparc64-bsd-user.mak
@@ -1,4 +1,4 @@
-TARGET_SPARC64=y
+TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_ABI_DIR=sparc64
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/sparc64-linux-user.mak b/default-configs/targets/sparc64-linux-user.mak
index 817529e587..87d880032e 100644
--- a/default-configs/targets/sparc64-linux-user.mak
+++ b/default-configs/targets/sparc64-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_SPARC64=y
+TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_ABI_DIR=sparc64
 TARGET_SYSTBL_ABI=common,64
diff --git a/default-configs/targets/sparc64-softmmu.mak b/default-configs/targets/sparc64-softmmu.mak
index bc07bfdb0a..8dd3217800 100644
--- a/default-configs/targets/sparc64-softmmu.mak
+++ b/default-configs/targets/sparc64-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_SPARC64=y
+TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/tilegx-linux-user.mak b/default-configs/targets/tilegx-linux-user.mak
index 064d3320d7..dfa00f4327 100644
--- a/default-configs/targets/tilegx-linux-user.mak
+++ b/default-configs/targets/tilegx-linux-user.mak
@@ -1,3 +1,3 @@
-TARGET_TILEGX=y
+TARGET_ARCH=tilegx
 TARGET_BASE_ARCH=tilegx
 TARGET_ABI_DIR=tilegx
diff --git a/default-configs/targets/tricore-softmmu.mak b/default-configs/targets/tricore-softmmu.mak
index a29aa2d6dd..6f4193717f 100644
--- a/default-configs/targets/tricore-softmmu.mak
+++ b/default-configs/targets/tricore-softmmu.mak
@@ -1,2 +1,2 @@
-TARGET_TRICORE=y
+TARGET_ARCH=tricore
 TARGET_BASE_ARCH=tricore
diff --git a/default-configs/targets/unicore32-softmmu.mak b/default-configs/targets/unicore32-softmmu.mak
index 85f37dc88f..23d02da953 100644
--- a/default-configs/targets/unicore32-softmmu.mak
+++ b/default-configs/targets/unicore32-softmmu.mak
@@ -1,2 +1,2 @@
-TARGET_UNICORE32=y
+TARGET_ARCH=unicore32
 TARGET_BASE_ARCH=unicore32
diff --git a/default-configs/targets/x86_64-bsd-user.mak b/default-configs/targets/x86_64-bsd-user.mak
index 935b10e22c..83ac877606 100644
--- a/default-configs/targets/x86_64-bsd-user.mak
+++ b/default-configs/targets/x86_64-bsd-user.mak
@@ -1,4 +1,4 @@
-TARGET_X86_64=y
+TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_ABI_DIR=x86_64
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/default-configs/targets/x86_64-linux-user.mak b/default-configs/targets/x86_64-linux-user.mak
index 6a9418f9ff..6ccc10597b 100644
--- a/default-configs/targets/x86_64-linux-user.mak
+++ b/default-configs/targets/x86_64-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_X86_64=y
+TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_ABI_DIR=x86_64
 TARGET_SYSTBL_ABI=common,64
diff --git a/default-configs/targets/x86_64-softmmu.mak b/default-configs/targets/x86_64-softmmu.mak
index 377c63e823..75e42bc840 100644
--- a/default-configs/targets/x86_64-softmmu.mak
+++ b/default-configs/targets/x86_64-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_X86_64=y
+TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/default-configs/targets/xtensa-linux-user.mak b/default-configs/targets/xtensa-linux-user.mak
index 63d9cff69f..83ac59dbc9 100644
--- a/default-configs/targets/xtensa-linux-user.mak
+++ b/default-configs/targets/xtensa-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_XTENSA=y
+TARGET_ARCH=xtensa
 TARGET_BASE_ARCH=xtensa
 TARGET_ABI_DIR=xtensa
 TARGET_SYSTBL_ABI=common
diff --git a/default-configs/targets/xtensa-softmmu.mak b/default-configs/targets/xtensa-softmmu.mak
index 96f892c4a8..7ea404f8be 100644
--- a/default-configs/targets/xtensa-softmmu.mak
+++ b/default-configs/targets/xtensa-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_XTENSA=y
+TARGET_ARCH=xtensa
 TARGET_BASE_ARCH=xtensa
 TARGET_ALIGNED_ONLY=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/xtensaeb-linux-user.mak b/default-configs/targets/xtensaeb-linux-user.mak
index e66b7dd0e3..954e798fbe 100644
--- a/default-configs/targets/xtensaeb-linux-user.mak
+++ b/default-configs/targets/xtensaeb-linux-user.mak
@@ -1,4 +1,4 @@
-TARGET_XTENSA=y
+TARGET_ARCH=xtensa
 TARGET_BASE_ARCH=xtensa
 TARGET_ABI_DIR=xtensa
 TARGET_SYSTBL_ABI=common
diff --git a/default-configs/targets/xtensaeb-softmmu.mak b/default-configs/targets/xtensaeb-softmmu.mak
index e6f53a1272..c22832d236 100644
--- a/default-configs/targets/xtensaeb-softmmu.mak
+++ b/default-configs/targets/xtensaeb-softmmu.mak
@@ -1,4 +1,4 @@
-TARGET_XTENSA=y
+TARGET_ARCH=xtensa
 TARGET_BASE_ARCH=xtensa
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/meson.build b/meson.build
index 60ecd03fbd..5f5d916364 100644
--- a/meson.build
+++ b/meson.build
@@ -727,7 +727,7 @@ kconfig_external_symbols = [
   'CONFIG_LINUX',
   'CONFIG_PVRDMA',
 ]
-ignored = ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
+ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
 
 default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
 actual_target_dirs = []
@@ -780,6 +780,7 @@ foreach target : target_dirs
 
   actual_target_dirs += target
   config_target += keyval.load('default-configs/targets' / target + '.mak')
+  config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
 
   foreach k, v: disassemblers
     if config_host['ARCH'].startswith(k) or config_target['TARGET_BASE_ARCH'].startswith(k)
@@ -797,6 +798,8 @@ foreach target : target_dirs
     elif ignored.contains(k)
       # do nothing
     elif k == 'TARGET_BASE_ARCH'
+      # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
+      # not used to select files from sourcesets.
       config_target_data.set('TARGET_' + v.to_upper(), 1)
     elif k == 'TARGET_NAME' or k == 'CONFIG_QEMU_INTERP_PREFIX'
       config_target_data.set_quoted(k, v)
-- 
2.26.2



