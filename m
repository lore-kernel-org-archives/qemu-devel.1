Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1E4C47095
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9C820776
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oh5vPMJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9C820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLqp-00044R-Ku
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmu-0008Ca-GR
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:04 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmr-0007KU-Ej
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:04 -0400
Received: by mail-wm1-x341.google.com with SMTP id y15so7826181wmi.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1g9VuHLi8A5b1a5exAFedNus2vU2AytC6R92SQi8h7E=;
 b=oh5vPMJxmmWjg5ANcQh6QmWMSTd5oWq7WbMgoh+dLDeZziOZ7p3mluILtKU1/aAXBz
 RpgLXK8D30WxElJoI6EYbjVapvW5fFLeS+tOL03qacNVTKdiKLRmQBN4+eYxKLSe9Mrl
 9RoPsZfHAEAnd6VIEGdZsm7Auy1+HXV0+k2XYdks3Gk0wQRrIlhPObOzDM7dXSgsPptp
 kkKqJg9petulCVsaCQX/vRT22TUDSThgWUcUd+WtBJh4Lu5E1JnLvobMOVHXUCjmCNUt
 SaatLA7LAUW0Sgvuf1k9wThU29rBqpYxZ/Grpk6Vj0MBTuretzFtC35ikC/hY5D67YUZ
 G5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1g9VuHLi8A5b1a5exAFedNus2vU2AytC6R92SQi8h7E=;
 b=UIpb1mBtKrB10xVkrTvRiBJvfUZVhROLOYQmD+4ORyKuNsE3qUqXfwg4sDq0GleeWu
 /5kITnPuSmm2We0PAXW4YR39Kp8J7qtIsfBuCPz4A2wjm++DiVlFbyYSydSrdLJ7syLn
 m3UF+4GMMgxVJHYLT3s9AXQYzrEM/YC0a1fQ2qqTBiTdQZYe8egjQFgtzY9KnzhINrVh
 pobvjHlJJ3ko+6hpRcLqv4Qp8SrDI6sAP3LFONTYswpLW9RLKLJUcIf0hBm90ykOMqKg
 XdAvrYrBRfwq64qgOW9pPZhraZ7Xe4Qx+7LSZLIiga6Kuc09SgfqrfNHN7YHxXCGYWNG
 s6vA==
X-Gm-Message-State: AOAM533rQY/H8mS2llV4qV/QhCKiQsJbvYx3q4kQOvUJhi4ryp+CjVUM
 OZ/rY10ASLJZ8QfsTp1DAYDg5dpjcwg=
X-Google-Smtp-Source: ABdhPJwNgRRRRy7huOYkZsY3+36VKzQrCfEFdyTkLSYgMK1TE801LF8vqEb1N+TiOXn7hesCvvT1Mg==
X-Received: by 2002:a1c:ded7:: with SMTP id
 v206mr11399041wmg.183.1601886239193; 
 Mon, 05 Oct 2020 01:23:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.23.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:23:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/19] default-configs: remove redundant keys
Date: Mon,  5 Oct 2020 10:23:43 +0200
Message-Id: <20201005082349.354095-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x341.google.com
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

TARGET_BASE_ARCH and TARGET_ABI_DIR are 99% of the time the same
as TARGET_ARCH, remove them if so.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/targets/aarch64-linux-user.mak      | 1 -
 default-configs/targets/aarch64_be-linux-user.mak   | 1 -
 default-configs/targets/alpha-linux-user.mak        | 2 --
 default-configs/targets/alpha-softmmu.mak           | 1 -
 default-configs/targets/arm-linux-user.mak          | 2 --
 default-configs/targets/arm-softmmu.mak             | 1 -
 default-configs/targets/armeb-linux-user.mak        | 2 --
 default-configs/targets/avr-softmmu.mak             | 1 -
 default-configs/targets/cris-linux-user.mak         | 2 --
 default-configs/targets/cris-softmmu.mak            | 1 -
 default-configs/targets/hppa-linux-user.mak         | 2 --
 default-configs/targets/hppa-softmmu.mak            | 1 -
 default-configs/targets/i386-bsd-user.mak           | 2 --
 default-configs/targets/i386-linux-user.mak         | 2 --
 default-configs/targets/i386-softmmu.mak            | 1 -
 default-configs/targets/lm32-softmmu.mak            | 1 -
 default-configs/targets/m68k-linux-user.mak         | 2 --
 default-configs/targets/m68k-softmmu.mak            | 1 -
 default-configs/targets/microblaze-linux-user.mak   | 2 --
 default-configs/targets/microblaze-softmmu.mak      | 1 -
 default-configs/targets/microblazeel-linux-user.mak | 2 --
 default-configs/targets/microblazeel-softmmu.mak    | 1 -
 default-configs/targets/mips-linux-user.mak         | 2 --
 default-configs/targets/mips-softmmu.mak            | 1 -
 default-configs/targets/mips64-linux-user.mak       | 1 -
 default-configs/targets/mips64el-linux-user.mak     | 1 -
 default-configs/targets/mipsel-linux-user.mak       | 2 --
 default-configs/targets/mipsel-softmmu.mak          | 1 -
 default-configs/targets/mipsn32-linux-user.mak      | 1 -
 default-configs/targets/mipsn32el-linux-user.mak    | 1 -
 default-configs/targets/moxie-softmmu.mak           | 1 -
 default-configs/targets/nios2-linux-user.mak        | 2 --
 default-configs/targets/nios2-softmmu.mak           | 1 -
 default-configs/targets/or1k-linux-user.mak         | 2 --
 default-configs/targets/or1k-softmmu.mak            | 1 -
 default-configs/targets/ppc-linux-user.mak          | 2 --
 default-configs/targets/ppc-softmmu.mak             | 1 -
 default-configs/targets/rx-softmmu.mak              | 1 -
 default-configs/targets/s390x-linux-user.mak        | 2 --
 default-configs/targets/s390x-softmmu.mak           | 1 -
 default-configs/targets/sh4-linux-user.mak          | 2 --
 default-configs/targets/sh4-softmmu.mak             | 1 -
 default-configs/targets/sh4eb-linux-user.mak        | 2 --
 default-configs/targets/sh4eb-softmmu.mak           | 1 -
 default-configs/targets/sparc-bsd-user.mak          | 2 --
 default-configs/targets/sparc-linux-user.mak        | 2 --
 default-configs/targets/sparc-softmmu.mak           | 1 -
 default-configs/targets/sparc64-bsd-user.mak        | 1 -
 default-configs/targets/sparc64-linux-user.mak      | 1 -
 default-configs/targets/tilegx-linux-user.mak       | 2 --
 default-configs/targets/tricore-softmmu.mak         | 1 -
 default-configs/targets/unicore32-softmmu.mak       | 1 -
 default-configs/targets/x86_64-bsd-user.mak         | 1 -
 default-configs/targets/x86_64-linux-user.mak       | 1 -
 default-configs/targets/xtensa-linux-user.mak       | 2 --
 default-configs/targets/xtensa-softmmu.mak          | 1 -
 default-configs/targets/xtensaeb-linux-user.mak     | 2 --
 default-configs/targets/xtensaeb-softmmu.mak        | 1 -
 meson.build                                         | 8 ++++++++
 59 files changed, 8 insertions(+), 81 deletions(-)

diff --git a/default-configs/targets/aarch64-linux-user.mak b/default-configs/targets/aarch64-linux-user.mak
index d6c4a35c39..163c9209f4 100644
--- a/default-configs/targets/aarch64-linux-user.mak
+++ b/default-configs/targets/aarch64-linux-user.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_ABI_DIR=aarch64
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
 TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/aarch64_be-linux-user.mak b/default-configs/targets/aarch64_be-linux-user.mak
index 5e2d615c11..4c953cf8c5 100644
--- a/default-configs/targets/aarch64_be-linux-user.mak
+++ b/default-configs/targets/aarch64_be-linux-user.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_ABI_DIR=aarch64
 TARGET_WORDS_BIGENDIAN=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
 TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/alpha-linux-user.mak b/default-configs/targets/alpha-linux-user.mak
index e21f7cdefd..7e62fd796a 100644
--- a/default-configs/targets/alpha-linux-user.mak
+++ b/default-configs/targets/alpha-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=alpha
-TARGET_BASE_ARCH=alpha
-TARGET_ABI_DIR=alpha
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/alpha-softmmu.mak b/default-configs/targets/alpha-softmmu.mak
index 8ba1b4e403..e4b874a19e 100644
--- a/default-configs/targets/alpha-softmmu.mak
+++ b/default-configs/targets/alpha-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=alpha
-TARGET_BASE_ARCH=alpha
 TARGET_ALIGNED_ONLY=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/arm-linux-user.mak b/default-configs/targets/arm-linux-user.mak
index 1b9bac9d3a..c7cd872e86 100644
--- a/default-configs/targets/arm-linux-user.mak
+++ b/default-configs/targets/arm-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=arm
-TARGET_BASE_ARCH=arm
-TARGET_ABI_DIR=arm
 TARGET_SYSTBL_ABI=common,oabi
 TARGET_SYSTBL=syscall.tbl
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
diff --git a/default-configs/targets/arm-softmmu.mak b/default-configs/targets/arm-softmmu.mak
index 8af1d3ee1d..9b1a7f37c6 100644
--- a/default-configs/targets/arm-softmmu.mak
+++ b/default-configs/targets/arm-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=arm
-TARGET_BASE_ARCH=arm
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
diff --git a/default-configs/targets/armeb-linux-user.mak b/default-configs/targets/armeb-linux-user.mak
index d2b0d9e26e..79bf10e99b 100644
--- a/default-configs/targets/armeb-linux-user.mak
+++ b/default-configs/targets/armeb-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=arm
-TARGET_BASE_ARCH=arm
-TARGET_ABI_DIR=arm
 TARGET_SYSTBL_ABI=common,oabi
 TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/avr-softmmu.mak b/default-configs/targets/avr-softmmu.mak
index 547c2986b6..e3f921c019 100644
--- a/default-configs/targets/avr-softmmu.mak
+++ b/default-configs/targets/avr-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=avr
-TARGET_BASE_ARCH=avr
 TARGET_XML_FILES= gdb-xml/avr-cpu.xml
diff --git a/default-configs/targets/cris-linux-user.mak b/default-configs/targets/cris-linux-user.mak
index 7d3f6eb36d..e483c42066 100644
--- a/default-configs/targets/cris-linux-user.mak
+++ b/default-configs/targets/cris-linux-user.mak
@@ -1,3 +1 @@
 TARGET_ARCH=cris
-TARGET_BASE_ARCH=cris
-TARGET_ABI_DIR=cris
diff --git a/default-configs/targets/cris-softmmu.mak b/default-configs/targets/cris-softmmu.mak
index a132cec8d9..e483c42066 100644
--- a/default-configs/targets/cris-softmmu.mak
+++ b/default-configs/targets/cris-softmmu.mak
@@ -1,2 +1 @@
 TARGET_ARCH=cris
-TARGET_BASE_ARCH=cris
diff --git a/default-configs/targets/hppa-linux-user.mak b/default-configs/targets/hppa-linux-user.mak
index 05ef4568ad..f01e0a7b9e 100644
--- a/default-configs/targets/hppa-linux-user.mak
+++ b/default-configs/targets/hppa-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=hppa
-TARGET_BASE_ARCH=hppa
-TARGET_ABI_DIR=hppa
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/hppa-softmmu.mak b/default-configs/targets/hppa-softmmu.mak
index bd7eaaf9a5..e3e71eb21b 100644
--- a/default-configs/targets/hppa-softmmu.mak
+++ b/default-configs/targets/hppa-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=hppa
-TARGET_BASE_ARCH=hppa
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/i386-bsd-user.mak b/default-configs/targets/i386-bsd-user.mak
index aa4d8c55e1..0283bb62a0 100644
--- a/default-configs/targets/i386-bsd-user.mak
+++ b/default-configs/targets/i386-bsd-user.mak
@@ -1,4 +1,2 @@
 TARGET_ARCH=i386
-TARGET_BASE_ARCH=i386
-TARGET_ABI_DIR=i386
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/default-configs/targets/i386-linux-user.mak b/default-configs/targets/i386-linux-user.mak
index 5117f59222..5b2546a430 100644
--- a/default-configs/targets/i386-linux-user.mak
+++ b/default-configs/targets/i386-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=i386
-TARGET_BASE_ARCH=i386
-TARGET_ABI_DIR=i386
 TARGET_SYSTBL_ABI=i386
 TARGET_SYSTBL=syscall_32.tbl
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/default-configs/targets/i386-softmmu.mak b/default-configs/targets/i386-softmmu.mak
index 7371e87982..5babf71895 100644
--- a/default-configs/targets/i386-softmmu.mak
+++ b/default-configs/targets/i386-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=i386
-TARGET_BASE_ARCH=i386
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/default-configs/targets/lm32-softmmu.mak b/default-configs/targets/lm32-softmmu.mak
index 6e55873788..55e7184a3d 100644
--- a/default-configs/targets/lm32-softmmu.mak
+++ b/default-configs/targets/lm32-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=lm32
-TARGET_BASE_ARCH=lm32
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/m68k-linux-user.mak b/default-configs/targets/m68k-linux-user.mak
index 186d1117cf..805d16c6ab 100644
--- a/default-configs/targets/m68k-linux-user.mak
+++ b/default-configs/targets/m68k-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=m68k
-TARGET_BASE_ARCH=m68k
-TARGET_ABI_DIR=m68k
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/m68k-softmmu.mak b/default-configs/targets/m68k-softmmu.mak
index fd8975978c..5df1a2b7d7 100644
--- a/default-configs/targets/m68k-softmmu.mak
+++ b/default-configs/targets/m68k-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=m68k
-TARGET_BASE_ARCH=m68k
 TARGET_WORDS_BIGENDIAN=y
 TARGET_XML_FILES= gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
diff --git a/default-configs/targets/microblaze-linux-user.mak b/default-configs/targets/microblaze-linux-user.mak
index 249a22295a..2a25bf2fa3 100644
--- a/default-configs/targets/microblaze-linux-user.mak
+++ b/default-configs/targets/microblaze-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=microblaze
-TARGET_BASE_ARCH=microblaze
-TARGET_ABI_DIR=microblaze
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/microblaze-softmmu.mak b/default-configs/targets/microblaze-softmmu.mak
index 8e5126f0f1..0b5c78ef00 100644
--- a/default-configs/targets/microblaze-softmmu.mak
+++ b/default-configs/targets/microblaze-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=microblaze
-TARGET_BASE_ARCH=microblaze
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/microblazeel-linux-user.mak b/default-configs/targets/microblazeel-linux-user.mak
index f59156c63b..d0e775d840 100644
--- a/default-configs/targets/microblazeel-linux-user.mak
+++ b/default-configs/targets/microblazeel-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=microblaze
-TARGET_BASE_ARCH=microblaze
-TARGET_ABI_DIR=microblaze
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_HAS_BFLT=y
diff --git a/default-configs/targets/microblazeel-softmmu.mak b/default-configs/targets/microblazeel-softmmu.mak
index 2d465cf6b4..dc822219d8 100644
--- a/default-configs/targets/microblazeel-softmmu.mak
+++ b/default-configs/targets/microblazeel-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=microblaze
-TARGET_BASE_ARCH=microblaze
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/mips-linux-user.mak b/default-configs/targets/mips-linux-user.mak
index 5b8000dfb0..19f5779831 100644
--- a/default-configs/targets/mips-linux-user.mak
+++ b/default-configs/targets/mips-linux-user.mak
@@ -1,7 +1,5 @@
 TARGET_ARCH=mips
 TARGET_ABI_MIPSO32=y
-TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips
 TARGET_SYSTBL_ABI=o32
 TARGET_SYSTBL=syscall_o32.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mips-softmmu.mak b/default-configs/targets/mips-softmmu.mak
index e391801a0e..8a49999a47 100644
--- a/default-configs/targets/mips-softmmu.mak
+++ b/default-configs/targets/mips-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=mips
-TARGET_BASE_ARCH=mips
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/mips64-linux-user.mak b/default-configs/targets/mips64-linux-user.mak
index 811df35427..32fd1acdf2 100644
--- a/default-configs/targets/mips64-linux-user.mak
+++ b/default-configs/targets/mips64-linux-user.mak
@@ -1,7 +1,6 @@
 TARGET_ARCH=mips64
 TARGET_ABI_MIPSN64=y
 TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips64
 TARGET_SYSTBL_ABI=n64
 TARGET_SYSTBL=syscall_n64.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mips64el-linux-user.mak b/default-configs/targets/mips64el-linux-user.mak
index f9de5d7857..f348f35997 100644
--- a/default-configs/targets/mips64el-linux-user.mak
+++ b/default-configs/targets/mips64el-linux-user.mak
@@ -1,7 +1,6 @@
 TARGET_ARCH=mips64
 TARGET_ABI_MIPSN64=y
 TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips64
 TARGET_SYSTBL_ABI=n64
 TARGET_SYSTBL=syscall_n64.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mipsel-linux-user.mak b/default-configs/targets/mipsel-linux-user.mak
index 11c3556665..e23793070c 100644
--- a/default-configs/targets/mipsel-linux-user.mak
+++ b/default-configs/targets/mipsel-linux-user.mak
@@ -1,7 +1,5 @@
 TARGET_ARCH=mips
 TARGET_ABI_MIPSO32=y
-TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips
 TARGET_SYSTBL_ABI=o32
 TARGET_SYSTBL=syscall_o32.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mipsel-softmmu.mak b/default-configs/targets/mipsel-softmmu.mak
index a9fc3b2647..c7c41f4fb7 100644
--- a/default-configs/targets/mipsel-softmmu.mak
+++ b/default-configs/targets/mipsel-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=mips
-TARGET_BASE_ARCH=mips
 TARGET_ALIGNED_ONLY=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/mipsn32-linux-user.mak b/default-configs/targets/mipsn32-linux-user.mak
index 040022ce87..b8c2441ad0 100644
--- a/default-configs/targets/mipsn32-linux-user.mak
+++ b/default-configs/targets/mipsn32-linux-user.mak
@@ -2,7 +2,6 @@ TARGET_ARCH=mips64
 TARGET_ABI_MIPSN32=y
 TARGET_ABI32=y
 TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips64
 TARGET_SYSTBL_ABI=n32
 TARGET_SYSTBL=syscall_n32.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mipsn32el-linux-user.mak b/default-configs/targets/mipsn32el-linux-user.mak
index faeca7752e..f31a9c394b 100644
--- a/default-configs/targets/mipsn32el-linux-user.mak
+++ b/default-configs/targets/mipsn32el-linux-user.mak
@@ -2,7 +2,6 @@ TARGET_ARCH=mips64
 TARGET_ABI_MIPSN32=y
 TARGET_ABI32=y
 TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips64
 TARGET_SYSTBL_ABI=n32
 TARGET_SYSTBL=syscall_n32.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/moxie-softmmu.mak b/default-configs/targets/moxie-softmmu.mak
index b9d8d97031..183e6b0ebd 100644
--- a/default-configs/targets/moxie-softmmu.mak
+++ b/default-configs/targets/moxie-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=moxie
-TARGET_BASE_ARCH=moxie
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/nios2-linux-user.mak b/default-configs/targets/nios2-linux-user.mak
index 57ddc32838..9a372f0717 100644
--- a/default-configs/targets/nios2-linux-user.mak
+++ b/default-configs/targets/nios2-linux-user.mak
@@ -1,3 +1 @@
 TARGET_ARCH=nios2
-TARGET_BASE_ARCH=nios2
-TARGET_ABI_DIR=nios2
diff --git a/default-configs/targets/nios2-softmmu.mak b/default-configs/targets/nios2-softmmu.mak
index 787d1d1be1..9a372f0717 100644
--- a/default-configs/targets/nios2-softmmu.mak
+++ b/default-configs/targets/nios2-softmmu.mak
@@ -1,2 +1 @@
 TARGET_ARCH=nios2
-TARGET_BASE_ARCH=nios2
diff --git a/default-configs/targets/or1k-linux-user.mak b/default-configs/targets/or1k-linux-user.mak
index 88175f039b..1dfb93e46d 100644
--- a/default-configs/targets/or1k-linux-user.mak
+++ b/default-configs/targets/or1k-linux-user.mak
@@ -1,4 +1,2 @@
 TARGET_ARCH=openrisc
-TARGET_BASE_ARCH=openrisc
-TARGET_ABI_DIR=openrisc
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/or1k-softmmu.mak b/default-configs/targets/or1k-softmmu.mak
index 4c0c4165aa..1dfb93e46d 100644
--- a/default-configs/targets/or1k-softmmu.mak
+++ b/default-configs/targets/or1k-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=openrisc
-TARGET_BASE_ARCH=openrisc
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/ppc-linux-user.mak b/default-configs/targets/ppc-linux-user.mak
index dda377508b..ca4187e4aa 100644
--- a/default-configs/targets/ppc-linux-user.mak
+++ b/default-configs/targets/ppc-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=ppc
-TARGET_BASE_ARCH=ppc
-TARGET_ABI_DIR=ppc
 TARGET_SYSTBL_ABI=common,nospu,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/ppc-softmmu.mak b/default-configs/targets/ppc-softmmu.mak
index b02f1fe51a..ef69037a2c 100644
--- a/default-configs/targets/ppc-softmmu.mak
+++ b/default-configs/targets/ppc-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=ppc
-TARGET_BASE_ARCH=ppc
 TARGET_WORDS_BIGENDIAN=y
 TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
diff --git a/default-configs/targets/rx-softmmu.mak b/default-configs/targets/rx-softmmu.mak
index 07abc5cd55..2d410e0b0c 100644
--- a/default-configs/targets/rx-softmmu.mak
+++ b/default-configs/targets/rx-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=rx
-TARGET_BASE_ARCH=rx
 TARGET_XML_FILES= gdb-xml/rx-core.xml
diff --git a/default-configs/targets/s390x-linux-user.mak b/default-configs/targets/s390x-linux-user.mak
index f7e4244f43..9e31ce6457 100644
--- a/default-configs/targets/s390x-linux-user.mak
+++ b/default-configs/targets/s390x-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=s390x
-TARGET_BASE_ARCH=s390x
-TARGET_ABI_DIR=s390x
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/s390x-softmmu.mak b/default-configs/targets/s390x-softmmu.mak
index 080682f07b..fd9fbd870d 100644
--- a/default-configs/targets/s390x-softmmu.mak
+++ b/default-configs/targets/s390x-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=s390x
-TARGET_BASE_ARCH=s390x
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-gs.xml
diff --git a/default-configs/targets/sh4-linux-user.mak b/default-configs/targets/sh4-linux-user.mak
index db395a4886..0152d6621e 100644
--- a/default-configs/targets/sh4-linux-user.mak
+++ b/default-configs/targets/sh4-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=sh4
-TARGET_BASE_ARCH=sh4
-TARGET_ABI_DIR=sh4
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/sh4-softmmu.mak b/default-configs/targets/sh4-softmmu.mak
index 037cdac1d2..95896376c4 100644
--- a/default-configs/targets/sh4-softmmu.mak
+++ b/default-configs/targets/sh4-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=sh4
-TARGET_BASE_ARCH=sh4
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/sh4eb-linux-user.mak b/default-configs/targets/sh4eb-linux-user.mak
index b498e99ac2..9b6fb4c1bb 100644
--- a/default-configs/targets/sh4eb-linux-user.mak
+++ b/default-configs/targets/sh4eb-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=sh4
-TARGET_BASE_ARCH=sh4
-TARGET_ABI_DIR=sh4
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/sh4eb-softmmu.mak b/default-configs/targets/sh4eb-softmmu.mak
index e0fc9715e0..382e9a80f8 100644
--- a/default-configs/targets/sh4eb-softmmu.mak
+++ b/default-configs/targets/sh4eb-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=sh4
-TARGET_BASE_ARCH=sh4
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc-bsd-user.mak b/default-configs/targets/sparc-bsd-user.mak
index bb83a268b6..9ba3d7b07f 100644
--- a/default-configs/targets/sparc-bsd-user.mak
+++ b/default-configs/targets/sparc-bsd-user.mak
@@ -1,5 +1,3 @@
 TARGET_ARCH=sparc
-TARGET_BASE_ARCH=sparc
-TARGET_ABI_DIR=sparc
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc-linux-user.mak b/default-configs/targets/sparc-linux-user.mak
index 72a4a90219..53dc7aaed5 100644
--- a/default-configs/targets/sparc-linux-user.mak
+++ b/default-configs/targets/sparc-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=sparc
-TARGET_BASE_ARCH=sparc
-TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/sparc-softmmu.mak b/default-configs/targets/sparc-softmmu.mak
index dab69263bb..9ba3d7b07f 100644
--- a/default-configs/targets/sparc-softmmu.mak
+++ b/default-configs/targets/sparc-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=sparc
-TARGET_BASE_ARCH=sparc
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc64-bsd-user.mak b/default-configs/targets/sparc64-bsd-user.mak
index 3202825dc3..8dd3217800 100644
--- a/default-configs/targets/sparc64-bsd-user.mak
+++ b/default-configs/targets/sparc64-bsd-user.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
-TARGET_ABI_DIR=sparc64
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc64-linux-user.mak b/default-configs/targets/sparc64-linux-user.mak
index 87d880032e..846924201a 100644
--- a/default-configs/targets/sparc64-linux-user.mak
+++ b/default-configs/targets/sparc64-linux-user.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
-TARGET_ABI_DIR=sparc64
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/tilegx-linux-user.mak b/default-configs/targets/tilegx-linux-user.mak
index dfa00f4327..10480e74c9 100644
--- a/default-configs/targets/tilegx-linux-user.mak
+++ b/default-configs/targets/tilegx-linux-user.mak
@@ -1,3 +1 @@
 TARGET_ARCH=tilegx
-TARGET_BASE_ARCH=tilegx
-TARGET_ABI_DIR=tilegx
diff --git a/default-configs/targets/tricore-softmmu.mak b/default-configs/targets/tricore-softmmu.mak
index 6f4193717f..96b10af853 100644
--- a/default-configs/targets/tricore-softmmu.mak
+++ b/default-configs/targets/tricore-softmmu.mak
@@ -1,2 +1 @@
 TARGET_ARCH=tricore
-TARGET_BASE_ARCH=tricore
diff --git a/default-configs/targets/unicore32-softmmu.mak b/default-configs/targets/unicore32-softmmu.mak
index 23d02da953..57331e94fe 100644
--- a/default-configs/targets/unicore32-softmmu.mak
+++ b/default-configs/targets/unicore32-softmmu.mak
@@ -1,2 +1 @@
 TARGET_ARCH=unicore32
-TARGET_BASE_ARCH=unicore32
diff --git a/default-configs/targets/x86_64-bsd-user.mak b/default-configs/targets/x86_64-bsd-user.mak
index 83ac877606..799cd4acd4 100644
--- a/default-configs/targets/x86_64-bsd-user.mak
+++ b/default-configs/targets/x86_64-bsd-user.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_ABI_DIR=x86_64
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/default-configs/targets/x86_64-linux-user.mak b/default-configs/targets/x86_64-linux-user.mak
index 6ccc10597b..9ceefbb615 100644
--- a/default-configs/targets/x86_64-linux-user.mak
+++ b/default-configs/targets/x86_64-linux-user.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_ABI_DIR=x86_64
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/default-configs/targets/xtensa-linux-user.mak b/default-configs/targets/xtensa-linux-user.mak
index 83ac59dbc9..fc95cc60f5 100644
--- a/default-configs/targets/xtensa-linux-user.mak
+++ b/default-configs/targets/xtensa-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=xtensa
-TARGET_BASE_ARCH=xtensa
-TARGET_ABI_DIR=xtensa
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/xtensa-softmmu.mak b/default-configs/targets/xtensa-softmmu.mak
index 7ea404f8be..26c0285655 100644
--- a/default-configs/targets/xtensa-softmmu.mak
+++ b/default-configs/targets/xtensa-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=xtensa
-TARGET_BASE_ARCH=xtensa
 TARGET_ALIGNED_ONLY=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/xtensaeb-linux-user.mak b/default-configs/targets/xtensaeb-linux-user.mak
index 954e798fbe..cfc3518118 100644
--- a/default-configs/targets/xtensaeb-linux-user.mak
+++ b/default-configs/targets/xtensaeb-linux-user.mak
@@ -1,6 +1,4 @@
 TARGET_ARCH=xtensa
-TARGET_BASE_ARCH=xtensa
-TARGET_ABI_DIR=xtensa
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/xtensaeb-softmmu.mak b/default-configs/targets/xtensaeb-softmmu.mak
index c22832d236..14cb9289a6 100644
--- a/default-configs/targets/xtensaeb-softmmu.mak
+++ b/default-configs/targets/xtensaeb-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=xtensa
-TARGET_BASE_ARCH=xtensa
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/meson.build b/meson.build
index 5f5d916364..9a90d19113 100644
--- a/meson.build
+++ b/meson.build
@@ -782,6 +782,14 @@ foreach target : target_dirs
   config_target += keyval.load('default-configs/targets' / target + '.mak')
   config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
 
+  # Add default keys
+  if 'TARGET_BASE_ARCH' not in config_target
+    config_target += {'TARGET_BASE_ARCH': config_target['TARGET_ARCH']}
+  endif
+  if 'TARGET_ABI_DIR' not in config_target
+    config_target += {'TARGET_ABI_DIR': config_target['TARGET_ARCH']}
+  endif
+
   foreach k, v: disassemblers
     if config_host['ARCH'].startswith(k) or config_target['TARGET_BASE_ARCH'].startswith(k)
       foreach sym: v
-- 
2.26.2



