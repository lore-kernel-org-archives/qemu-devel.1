Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45888C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187EB2446F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUeGozTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187EB2446F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44085 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWi88-0006B2-Do
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:03:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhov-0007Zy-BU
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhou-0000XZ-8M
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:45 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:42241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWhou-0000Vh-3b
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:44 -0400
Received: by mail-oi1-x229.google.com with SMTP id v25so7162809oic.9
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=R+n1RejJW342bFslDn26nW3Vb7JdpGcpR0skOavPjDM=;
	b=QUeGozTvP+Oq+3+odyNfjZ+5J2OqvvitucYu7bh1hQ0rU4w7IRic1hG5E8+8qI/AYc
	vWb9x6sAQU0r2GvGWIwJbW8s1o0cpIFRHzFLHoGP5afp8qVjVVEejKeSq1YYsXdgq2kq
	x7ey9y2HclzrP6ociLTCOH35mTsQPPP6oHe4jYyOHPwBrb879HQC7gZehlnaiD3xaiIl
	EGY45hxvAhiGnkERtpnH6HmQmxkZ4M9p2g8BAMeSgmGAwrACVO3DdpcTF8If5sZbX9mH
	/hGpqbr5dSlr6m10BSOtF93BMmSTtlXPvZIYZ79vWLBUDz2RNx+N1QHvBWzLHUWgoWXp
	T5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=R+n1RejJW342bFslDn26nW3Vb7JdpGcpR0skOavPjDM=;
	b=JBPf9ygxJUEEL2Gq+6qnHivMTsM0o+qs0k90JuzPz2L399JcpVjUEa/rFjx/lzaAt+
	r2e2FhcNjY8sfzHYmMyUHrh28SneLsKYVhyB7kcgGYNGsmlQfInXZ9ofo+tobLP9NaZc
	DkhedyiC0z7siRw4ALrnhzJm/fWyRC9dT/Ik2M6+QGfbv2/KuEMf0cXNRf+5RereXtYI
	e5JhFSmMdGVMxziMAAwSodMgngTvOfyYTLUYG1gcoG5cQOzxFe73NfZzAteNuJA4xff5
	Fi6TD5rQVRvCrjcLQA0Qsb3fpJusEjO2nFsC/CA1QLGtjLrt2Zf3e96vsCUsZiXITmdO
	sRAw==
X-Gm-Message-State: APjAAAVkFAIYGGeLbuKdh7gzAOIWd3B7HHeT8c9orhmtkNNCb7N/gQTD
	VrghJo0gOFF2UBzrTBYumkyomfXCA6g2eQ==
X-Google-Smtp-Source: APXvYqzpUEOob2bJXPuMmBgoYmFZR4T3cBlq75dZTolnZgGVi+4ijO2JVCmY6P3gQnj9AsEIHfxt2g==
X-Received: by 2002:a54:4f8d:: with SMTP id g13mr4398504oiy.3.1559310222759;
	Fri, 31 May 2019 06:43:42 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r23sm2391176otg.49.2019.05.31.06.43.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 06:43:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 08:43:08 -0500
Message-Id: <20190531134315.4109-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531134315.4109-1-richard.henderson@linaro.org>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: [Qemu-devel] [PATCH v16 16/23] Add rx-softmmu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: philmd@redhat.com, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20190516055244.95559-10-ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/sysemu/arch_init.h     | 1 +
 arch_init.c                    | 2 ++
 configure                      | 8 ++++++++
 default-configs/rx-softmmu.mak | 3 +++
 hw/Kconfig                     | 1 +
 5 files changed, 15 insertions(+)
 create mode 100644 default-configs/rx-softmmu.mak

diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 10cbafe970..3f4f844f7b 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -25,6 +25,7 @@ enum {
     QEMU_ARCH_NIOS2 = (1 << 17),
     QEMU_ARCH_HPPA = (1 << 18),
     QEMU_ARCH_RISCV = (1 << 19),
+    QEMU_ARCH_RX = (1 << 20),
 };
 
 extern const uint32_t arch_type;
diff --git a/arch_init.c b/arch_init.c
index f4f3f610c8..cc25ddd7ca 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -74,6 +74,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_PPC
 #elif defined(TARGET_RISCV)
 #define QEMU_ARCH QEMU_ARCH_RISCV
+#elif defined(TARGET_RX)
+#define QEMU_ARCH QEMU_ARCH_RX
 #elif defined(TARGET_S390X)
 #define QEMU_ARCH QEMU_ARCH_S390X
 #elif defined(TARGET_SH4)
diff --git a/configure b/configure
index 6cdcfb2dc3..7e5477e487 100755
--- a/configure
+++ b/configure
@@ -7605,6 +7605,11 @@ case "$target_name" in
     gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
     target_compiler=$cross_cc_riscv64
   ;;
+  rx)
+    TARGET_ARCH=rx
+    bflt="yes"
+    target_compiler=$cross_cc_rx
+  ;;
   sh4|sh4eb)
     TARGET_ARCH=sh4
     bflt="yes"
@@ -7825,6 +7830,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
   riscv*)
     disas_config "RISCV"
   ;;
+  rx)
+    disas_config "RX"
+  ;;
   s390*)
     disas_config "S390"
   ;;
diff --git a/default-configs/rx-softmmu.mak b/default-configs/rx-softmmu.mak
new file mode 100644
index 0000000000..a3eecefb11
--- /dev/null
+++ b/default-configs/rx-softmmu.mak
@@ -0,0 +1,3 @@
+# Default configuration for rx-softmmu
+
+CONFIG_RX_VIRT=y
diff --git a/hw/Kconfig b/hw/Kconfig
index 195f541e50..b0c7221240 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -54,6 +54,7 @@ source nios2/Kconfig
 source openrisc/Kconfig
 source ppc/Kconfig
 source riscv/Kconfig
+source rx/Kconfig
 source s390x/Kconfig
 source sh4/Kconfig
 source sparc/Kconfig
-- 
2.17.1


