Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D17C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 05:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C450020833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 05:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="weCcnbQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C450020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRV1X-000736-45
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 01:03:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRUqZ-0006IF-Ot
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRUqX-0007oy-PR
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:55 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRUqX-0007o3-GH
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:53 -0400
Received: by mail-pf1-x442.google.com with SMTP id u17so3038930pfn.7
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 21:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=5Wb4o8hGJvfUpM2qJ6vfNYYMCW70cYJebXgl3I7+Ni0=;
	b=weCcnbQYZYedyd3baYFPk2UQrlLnjpYjxp9hMDK7KJ6w/7H9vaHhUEH1yju6yr94lm
	4j63DEPhd/ih/v85Gu7nce3FshFD7Q2j5/7gitvxIOkKG2sRcV8+UuBYvTtpuiI78wtz
	m2ljfZTBUMu7S8sNVAz8ZVymjGnyNsydV7xKj4bKqNt+RKOMPioN/0fIAGy75SQLvzuD
	bDVJ/mXSRH8dJ+S1wdrVqDvThSUi32rPHspIWWT70XcVRpaDVZXbhID+g1yK0DgSkIpU
	CaMuFTLUQ2INE5FZJmc8r3nwJTAICjaSHsDSW6bkSVt508dz7OYJUQm/ZZUVoWrd6ZjJ
	RI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=5Wb4o8hGJvfUpM2qJ6vfNYYMCW70cYJebXgl3I7+Ni0=;
	b=PLlHA35WSJS3wn+AdGyscxwTrp4ojJPGhVI4ndR24TC5hAqxYt+tzZlccIWHJX6aXk
	k6+9wdQD3weeoYTslWhX2iadlO0aYGAXDbF0SrDUHxvb6cAImOp4Yk9MVgHvlI/8tUzT
	Rh+odCNi1Z+k8PZ4htkl5MpZPOQoIclnCHdwuEokUBjIr658zFj0AHvU8k4aQX0juVsZ
	9OWnkNlRK5K6fPBDLDYJi2fbKIYjgtND0c5CWsZPjEQ6aju9pnLUIeQTB9nmgR9heUv2
	+q2Ye4ND23J72xnZ6wjdRMOroRD4lB5E0yXGxllXlsvjE6H1YswbKrmmDk8AnSQNuWr6
	NDUg==
X-Gm-Message-State: APjAAAVU/tsYwRr7dz38ZhBPe/Ofd/CVBz9/iNsQV0vysq2yQ3Ru9TpI
	0c9DHCdoHG7oXyUSPu3euoZ2Ox/rIoc=
X-Google-Smtp-Source: APXvYqy7PLA2goRbLUHzDjh9FxGnqbFsqgutWKCKA3s4USbcDFfJzyVPTklN/gBuMS9gBVDti3mPiQ==
X-Received: by 2002:a62:1a51:: with SMTP id a78mr57275928pfa.133.1558068712285;
	Thu, 16 May 2019 21:51:52 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	132sm7709625pga.79.2019.05.16.21.51.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 21:51:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 21:51:35 -0700
Message-Id: <20190517045136.3509-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517045136.3509-1-richard.henderson@linaro.org>
References: <20190517045136.3509-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v14 12/13] Add rx-softmmu
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
index 8999698bc2..28782762dd 100755
--- a/configure
+++ b/configure
@@ -7547,6 +7547,11 @@ case "$target_name" in
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
@@ -7767,6 +7772,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
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
index 88b9f15007..63a071092e 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -53,6 +53,7 @@ source nios2/Kconfig
 source openrisc/Kconfig
 source ppc/Kconfig
 source riscv/Kconfig
+source rx/Kconfig
 source s390x/Kconfig
 source sh4/Kconfig
 source sparc/Kconfig
-- 
2.17.1


