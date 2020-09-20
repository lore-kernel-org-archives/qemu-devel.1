Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3902FC43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E9520EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKxaPZzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E9520EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJz5q-0007vb-K6
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 09:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJz3y-0006Ex-LY
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJz3k-00017l-Ip
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600607234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cTyfXW/fZyCgCKg2QYN7wd09oeGaOdP8sBIwFtpq6uI=;
 b=HKxaPZzWD9jIqOOtBw4GIS6VGvc07TaP4U7XA0a1yL9hd90LANwEmXrdipv06G0sNXTByG
 gOlu7NBBYwZSHuqkPdn4Oqv5TgvO0fxsqlrKkxAqEs6WwhPOiHds33ml9/ec2+fNlCUOGx
 nEVvycagOLF/f/mJ3KGFzNVhir/QW4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-XYynNgJPNlG8LR8nBVcoHw-1; Sun, 20 Sep 2020 09:07:12 -0400
X-MC-Unique: XYynNgJPNlG8LR8nBVcoHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06B8E186DD52
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:07:12 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9B0760C84
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:07:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/9] default-configs/targets: remove useless lines
Date: Sun, 20 Sep 2020 09:07:07 -0400
Message-Id: <20200920130708.1156310-9-pbonzini@redhat.com>
In-Reply-To: <20200920130708.1156310-1-pbonzini@redhat.com>
References: <20200920130708.1156310-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 07:54:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some lines are only meaningful for user-mode targets, remove them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/targets/aarch64-softmmu.mak      | 1 -
 default-configs/targets/alpha-softmmu.mak        | 3 ---
 default-configs/targets/arm-softmmu.mak          | 3 ---
 default-configs/targets/avr-softmmu.mak          | 1 -
 default-configs/targets/cris-softmmu.mak         | 1 -
 default-configs/targets/hppa-softmmu.mak         | 3 ---
 default-configs/targets/i386-bsd-user.mak        | 2 --
 default-configs/targets/i386-softmmu.mak         | 3 ---
 default-configs/targets/lm32-softmmu.mak         | 1 -
 default-configs/targets/m68k-softmmu.mak         | 3 ---
 default-configs/targets/microblaze-softmmu.mak   | 3 ---
 default-configs/targets/microblazeel-softmmu.mak | 3 ---
 default-configs/targets/mips-softmmu.mak         | 3 ---
 default-configs/targets/mips64-softmmu.mak       | 3 ---
 default-configs/targets/mips64el-softmmu.mak     | 3 ---
 default-configs/targets/mipsel-softmmu.mak       | 3 ---
 default-configs/targets/moxie-softmmu.mak        | 1 -
 default-configs/targets/nios2-softmmu.mak        | 1 -
 default-configs/targets/or1k-softmmu.mak         | 1 -
 default-configs/targets/ppc-softmmu.mak          | 3 ---
 default-configs/targets/ppc64-softmmu.mak        | 3 ---
 default-configs/targets/riscv32-softmmu.mak      | 1 -
 default-configs/targets/riscv64-softmmu.mak      | 1 -
 default-configs/targets/rx-softmmu.mak           | 1 -
 default-configs/targets/s390x-softmmu.mak        | 3 ---
 default-configs/targets/sh4-softmmu.mak          | 3 ---
 default-configs/targets/sh4eb-softmmu.mak        | 3 ---
 default-configs/targets/sparc-bsd-user.mak       | 2 --
 default-configs/targets/sparc-softmmu.mak        | 3 ---
 default-configs/targets/sparc64-bsd-user.mak     | 2 --
 default-configs/targets/sparc64-softmmu.mak      | 3 ---
 default-configs/targets/tricore-softmmu.mak      | 1 -
 default-configs/targets/unicore32-softmmu.mak    | 1 -
 default-configs/targets/x86_64-bsd-user.mak      | 2 --
 default-configs/targets/x86_64-softmmu.mak       | 3 ---
 default-configs/targets/xtensa-softmmu.mak       | 3 ---
 default-configs/targets/xtensaeb-softmmu.mak     | 3 ---
 37 files changed, 83 deletions(-)

diff --git a/default-configs/targets/aarch64-softmmu.mak b/default-configs/targets/aarch64-softmmu.mak
index 53f83ea81f..4eff428074 100644
--- a/default-configs/targets/aarch64-softmmu.mak
+++ b/default-configs/targets/aarch64-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_AARCH64=y
 TARGET_BASE_ARCH=arm
-TARGET_ABI_DIR=aarch64
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
diff --git a/default-configs/targets/alpha-softmmu.mak b/default-configs/targets/alpha-softmmu.mak
index b78114b028..8a484c9775 100644
--- a/default-configs/targets/alpha-softmmu.mak
+++ b/default-configs/targets/alpha-softmmu.mak
@@ -1,7 +1,4 @@
 TARGET_ALPHA=y
 TARGET_BASE_ARCH=alpha
-TARGET_ABI_DIR=alpha
-TARGET_SYSTBL_ABI=common
-TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/arm-softmmu.mak b/default-configs/targets/arm-softmmu.mak
index d40b995f25..5923f9b203 100644
--- a/default-configs/targets/arm-softmmu.mak
+++ b/default-configs/targets/arm-softmmu.mak
@@ -1,7 +1,4 @@
 TARGET_ARM=y
 TARGET_BASE_ARCH=arm
-TARGET_ABI_DIR=arm
-TARGET_SYSTBL_ABI=common,oabi
-TARGET_SYSTBL=syscall.tbl
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
diff --git a/default-configs/targets/avr-softmmu.mak b/default-configs/targets/avr-softmmu.mak
index ecd292b2f7..46b6da717c 100644
--- a/default-configs/targets/avr-softmmu.mak
+++ b/default-configs/targets/avr-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_AVR=y
 TARGET_BASE_ARCH=avr
-TARGET_ABI_DIR=avr
 TARGET_XML_FILES= gdb-xml/avr-cpu.xml
diff --git a/default-configs/targets/cris-softmmu.mak b/default-configs/targets/cris-softmmu.mak
index ba61135172..1f7b44114b 100644
--- a/default-configs/targets/cris-softmmu.mak
+++ b/default-configs/targets/cris-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_CRIS=y
 TARGET_BASE_ARCH=cris
-TARGET_ABI_DIR=cris
diff --git a/default-configs/targets/hppa-softmmu.mak b/default-configs/targets/hppa-softmmu.mak
index 617c6483c0..c4ee4e6c51 100644
--- a/default-configs/targets/hppa-softmmu.mak
+++ b/default-configs/targets/hppa-softmmu.mak
@@ -1,8 +1,5 @@
 TARGET_HPPA=y
 TARGET_BASE_ARCH=hppa
-TARGET_ABI_DIR=hppa
-TARGET_SYSTBL_ABI=common,32
-TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/i386-bsd-user.mak b/default-configs/targets/i386-bsd-user.mak
index 34b52e9ee2..c58db819ae 100644
--- a/default-configs/targets/i386-bsd-user.mak
+++ b/default-configs/targets/i386-bsd-user.mak
@@ -1,6 +1,4 @@
 TARGET_I386=y
 TARGET_BASE_ARCH=i386
 TARGET_ABI_DIR=i386
-TARGET_SYSTBL_ABI=i386
-TARGET_SYSTBL=syscall_32.tbl
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/default-configs/targets/i386-softmmu.mak b/default-configs/targets/i386-softmmu.mak
index be9198bb84..4e2eb9f369 100644
--- a/default-configs/targets/i386-softmmu.mak
+++ b/default-configs/targets/i386-softmmu.mak
@@ -1,7 +1,4 @@
 TARGET_I386=y
 TARGET_BASE_ARCH=i386
-TARGET_ABI_DIR=i386
-TARGET_SYSTBL_ABI=i386
-TARGET_SYSTBL=syscall_32.tbl
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/default-configs/targets/lm32-softmmu.mak b/default-configs/targets/lm32-softmmu.mak
index c327d27d5f..2c4b8eab79 100644
--- a/default-configs/targets/lm32-softmmu.mak
+++ b/default-configs/targets/lm32-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_LM32=y
 TARGET_BASE_ARCH=lm32
-TARGET_ABI_DIR=lm32
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/m68k-softmmu.mak b/default-configs/targets/m68k-softmmu.mak
index f8bf4fc5ac..991e626677 100644
--- a/default-configs/targets/m68k-softmmu.mak
+++ b/default-configs/targets/m68k-softmmu.mak
@@ -1,7 +1,4 @@
 TARGET_M68K=y
 TARGET_BASE_ARCH=m68k
-TARGET_ABI_DIR=m68k
-TARGET_SYSTBL_ABI=common
-TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
 TARGET_XML_FILES= gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
diff --git a/default-configs/targets/microblaze-softmmu.mak b/default-configs/targets/microblaze-softmmu.mak
index 1b0a76a61f..24594862bf 100644
--- a/default-configs/targets/microblaze-softmmu.mak
+++ b/default-configs/targets/microblaze-softmmu.mak
@@ -1,7 +1,4 @@
 TARGET_MICROBLAZE=y
 TARGET_BASE_ARCH=microblaze
-TARGET_ABI_DIR=microblaze
-TARGET_SYSTBL_ABI=common
-TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/microblazeel-softmmu.mak b/default-configs/targets/microblazeel-softmmu.mak
index 3a2cf8be0f..5817a63755 100644
--- a/default-configs/targets/microblazeel-softmmu.mak
+++ b/default-configs/targets/microblazeel-softmmu.mak
@@ -1,6 +1,3 @@
 TARGET_MICROBLAZE=y
 TARGET_BASE_ARCH=microblaze
-TARGET_ABI_DIR=microblaze
-TARGET_SYSTBL_ABI=common
-TARGET_SYSTBL=syscall.tbl
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/mips-softmmu.mak b/default-configs/targets/mips-softmmu.mak
index 8ab9ff2ac9..ba58d6827e 100644
--- a/default-configs/targets/mips-softmmu.mak
+++ b/default-configs/targets/mips-softmmu.mak
@@ -1,9 +1,6 @@
 TARGET_ABI_MIPSO32=y
 TARGET_MIPS=y
 TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips
-TARGET_SYSTBL_ABI=o32
-TARGET_SYSTBL=syscall_o32.tbl
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/mips64-softmmu.mak b/default-configs/targets/mips64-softmmu.mak
index c02c5460a7..4837a12cac 100644
--- a/default-configs/targets/mips64-softmmu.mak
+++ b/default-configs/targets/mips64-softmmu.mak
@@ -1,8 +1,5 @@
 TARGET_ABI_MIPSN64=y
 TARGET_MIPS64=y
 TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips64
-TARGET_SYSTBL_ABI=n64
-TARGET_SYSTBL=syscall_n64.tbl
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/mips64el-softmmu.mak b/default-configs/targets/mips64el-softmmu.mak
index 8cbbc38e78..93e3f25903 100644
--- a/default-configs/targets/mips64el-softmmu.mak
+++ b/default-configs/targets/mips64el-softmmu.mak
@@ -1,7 +1,4 @@
 TARGET_ABI_MIPSN64=y
 TARGET_MIPS64=y
 TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips64
-TARGET_SYSTBL_ABI=n64
-TARGET_SYSTBL=syscall_n64.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/mipsel-softmmu.mak b/default-configs/targets/mipsel-softmmu.mak
index afa0851887..1528516b5d 100644
--- a/default-configs/targets/mipsel-softmmu.mak
+++ b/default-configs/targets/mipsel-softmmu.mak
@@ -1,8 +1,5 @@
 TARGET_ABI_MIPSO32=y
 TARGET_MIPS=y
 TARGET_BASE_ARCH=mips
-TARGET_ABI_DIR=mips
-TARGET_SYSTBL_ABI=o32
-TARGET_SYSTBL=syscall_o32.tbl
 TARGET_ALIGNED_ONLY=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/moxie-softmmu.mak b/default-configs/targets/moxie-softmmu.mak
index da093f5b36..ada92a6b5b 100644
--- a/default-configs/targets/moxie-softmmu.mak
+++ b/default-configs/targets/moxie-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_MOXIE=y
 TARGET_BASE_ARCH=moxie
-TARGET_ABI_DIR=moxie
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/nios2-softmmu.mak b/default-configs/targets/nios2-softmmu.mak
index a2308a16aa..f10f08d0ca 100644
--- a/default-configs/targets/nios2-softmmu.mak
+++ b/default-configs/targets/nios2-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_NIOS2=y
 TARGET_BASE_ARCH=nios2
-TARGET_ABI_DIR=nios2
diff --git a/default-configs/targets/or1k-softmmu.mak b/default-configs/targets/or1k-softmmu.mak
index 2f5ff844df..a922266a98 100644
--- a/default-configs/targets/or1k-softmmu.mak
+++ b/default-configs/targets/or1k-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_OPENRISC=y
 TARGET_BASE_ARCH=openrisc
-TARGET_ABI_DIR=openrisc
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/ppc-softmmu.mak b/default-configs/targets/ppc-softmmu.mak
index c4d912bfb1..1b6d091cfb 100644
--- a/default-configs/targets/ppc-softmmu.mak
+++ b/default-configs/targets/ppc-softmmu.mak
@@ -1,7 +1,4 @@
 TARGET_PPC=y
 TARGET_BASE_ARCH=ppc
-TARGET_ABI_DIR=ppc
-TARGET_SYSTBL_ABI=common,nospu,32
-TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
 TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
diff --git a/default-configs/targets/ppc64-softmmu.mak b/default-configs/targets/ppc64-softmmu.mak
index a73211918a..e431feffeb 100644
--- a/default-configs/targets/ppc64-softmmu.mak
+++ b/default-configs/targets/ppc64-softmmu.mak
@@ -1,8 +1,5 @@
 TARGET_PPC64=y
 TARGET_BASE_ARCH=ppc
-TARGET_ABI_DIR=ppc
-TARGET_SYSTBL_ABI=common,nospu,64
-TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
diff --git a/default-configs/targets/riscv32-softmmu.mak b/default-configs/targets/riscv32-softmmu.mak
index 35e5b2fb85..caa5829af8 100644
--- a/default-configs/targets/riscv32-softmmu.mak
+++ b/default-configs/targets/riscv32-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_RISCV32=y
 TARGET_BASE_ARCH=riscv
-TARGET_ABI_DIR=riscv
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-csr.xml gdb-xml/riscv-32bit-virtual.xml
diff --git a/default-configs/targets/riscv64-softmmu.mak b/default-configs/targets/riscv64-softmmu.mak
index 4b9a61cd8f..e190c0363b 100644
--- a/default-configs/targets/riscv64-softmmu.mak
+++ b/default-configs/targets/riscv64-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_RISCV64=y
 TARGET_BASE_ARCH=riscv
-TARGET_ABI_DIR=riscv
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-csr.xml gdb-xml/riscv-64bit-virtual.xml
diff --git a/default-configs/targets/rx-softmmu.mak b/default-configs/targets/rx-softmmu.mak
index 52a8c0df10..37b365475f 100644
--- a/default-configs/targets/rx-softmmu.mak
+++ b/default-configs/targets/rx-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_RX=y
 TARGET_BASE_ARCH=rx
-TARGET_ABI_DIR=rx
 TARGET_XML_FILES= gdb-xml/rx-core.xml
diff --git a/default-configs/targets/s390x-softmmu.mak b/default-configs/targets/s390x-softmmu.mak
index f2a80d3208..f08d25d3c3 100644
--- a/default-configs/targets/s390x-softmmu.mak
+++ b/default-configs/targets/s390x-softmmu.mak
@@ -1,8 +1,5 @@
 TARGET_S390X=y
 TARGET_BASE_ARCH=s390x
-TARGET_ABI_DIR=s390x
-TARGET_SYSTBL_ABI=common,64
-TARGET_SYSTBL=syscall.tbl
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-gs.xml
diff --git a/default-configs/targets/sh4-softmmu.mak b/default-configs/targets/sh4-softmmu.mak
index e46bf0e278..8c7e9eaa7b 100644
--- a/default-configs/targets/sh4-softmmu.mak
+++ b/default-configs/targets/sh4-softmmu.mak
@@ -1,6 +1,3 @@
 TARGET_SH4=y
 TARGET_BASE_ARCH=sh4
-TARGET_ABI_DIR=sh4
-TARGET_SYSTBL_ABI=common
-TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
diff --git a/default-configs/targets/sh4eb-softmmu.mak b/default-configs/targets/sh4eb-softmmu.mak
index db4140ec32..f1848b89b6 100644
--- a/default-configs/targets/sh4eb-softmmu.mak
+++ b/default-configs/targets/sh4eb-softmmu.mak
@@ -1,7 +1,4 @@
 TARGET_SH4=y
 TARGET_BASE_ARCH=sh4
-TARGET_ABI_DIR=sh4
-TARGET_SYSTBL_ABI=common
-TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc-bsd-user.mak b/default-configs/targets/sparc-bsd-user.mak
index 7f2fcba978..f478255591 100644
--- a/default-configs/targets/sparc-bsd-user.mak
+++ b/default-configs/targets/sparc-bsd-user.mak
@@ -1,7 +1,5 @@
 TARGET_SPARC=y
 TARGET_BASE_ARCH=sparc
 TARGET_ABI_DIR=sparc
-TARGET_SYSTBL_ABI=common,32
-TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc-softmmu.mak b/default-configs/targets/sparc-softmmu.mak
index 7f2fcba978..fb3dbb0d61 100644
--- a/default-configs/targets/sparc-softmmu.mak
+++ b/default-configs/targets/sparc-softmmu.mak
@@ -1,7 +1,4 @@
 TARGET_SPARC=y
 TARGET_BASE_ARCH=sparc
-TARGET_ABI_DIR=sparc
-TARGET_SYSTBL_ABI=common,32
-TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc64-bsd-user.mak b/default-configs/targets/sparc64-bsd-user.mak
index 817529e587..0ae8ea5420 100644
--- a/default-configs/targets/sparc64-bsd-user.mak
+++ b/default-configs/targets/sparc64-bsd-user.mak
@@ -1,7 +1,5 @@
 TARGET_SPARC64=y
 TARGET_BASE_ARCH=sparc
 TARGET_ABI_DIR=sparc64
-TARGET_SYSTBL_ABI=common,64
-TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/sparc64-softmmu.mak b/default-configs/targets/sparc64-softmmu.mak
index 817529e587..bc07bfdb0a 100644
--- a/default-configs/targets/sparc64-softmmu.mak
+++ b/default-configs/targets/sparc64-softmmu.mak
@@ -1,7 +1,4 @@
 TARGET_SPARC64=y
 TARGET_BASE_ARCH=sparc
-TARGET_ABI_DIR=sparc64
-TARGET_SYSTBL_ABI=common,64
-TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
diff --git a/default-configs/targets/tricore-softmmu.mak b/default-configs/targets/tricore-softmmu.mak
index 356e5d8669..a29aa2d6dd 100644
--- a/default-configs/targets/tricore-softmmu.mak
+++ b/default-configs/targets/tricore-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_TRICORE=y
 TARGET_BASE_ARCH=tricore
-TARGET_ABI_DIR=tricore
diff --git a/default-configs/targets/unicore32-softmmu.mak b/default-configs/targets/unicore32-softmmu.mak
index d8c7860ac1..85f37dc88f 100644
--- a/default-configs/targets/unicore32-softmmu.mak
+++ b/default-configs/targets/unicore32-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_UNICORE32=y
 TARGET_BASE_ARCH=unicore32
-TARGET_ABI_DIR=unicore32
diff --git a/default-configs/targets/x86_64-bsd-user.mak b/default-configs/targets/x86_64-bsd-user.mak
index 6a9418f9ff..935b10e22c 100644
--- a/default-configs/targets/x86_64-bsd-user.mak
+++ b/default-configs/targets/x86_64-bsd-user.mak
@@ -1,6 +1,4 @@
 TARGET_X86_64=y
 TARGET_BASE_ARCH=i386
 TARGET_ABI_DIR=x86_64
-TARGET_SYSTBL_ABI=common,64
-TARGET_SYSTBL=syscall_64.tbl
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/default-configs/targets/x86_64-softmmu.mak b/default-configs/targets/x86_64-softmmu.mak
index 8b56e6e6da..377c63e823 100644
--- a/default-configs/targets/x86_64-softmmu.mak
+++ b/default-configs/targets/x86_64-softmmu.mak
@@ -1,7 +1,4 @@
 TARGET_X86_64=y
 TARGET_BASE_ARCH=i386
-TARGET_ABI_DIR=x86_64
-TARGET_SYSTBL_ABI=common,64
-TARGET_SYSTBL=syscall_64.tbl
 TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/default-configs/targets/xtensa-softmmu.mak b/default-configs/targets/xtensa-softmmu.mak
index 2166f97738..96f892c4a8 100644
--- a/default-configs/targets/xtensa-softmmu.mak
+++ b/default-configs/targets/xtensa-softmmu.mak
@@ -1,7 +1,4 @@
 TARGET_XTENSA=y
 TARGET_BASE_ARCH=xtensa
-TARGET_ABI_DIR=xtensa
-TARGET_SYSTBL_ABI=common
-TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
 TARGET_SUPPORTS_MTTCG=y
diff --git a/default-configs/targets/xtensaeb-softmmu.mak b/default-configs/targets/xtensaeb-softmmu.mak
index 2372d22492..e6f53a1272 100644
--- a/default-configs/targets/xtensaeb-softmmu.mak
+++ b/default-configs/targets/xtensaeb-softmmu.mak
@@ -1,8 +1,5 @@
 TARGET_XTENSA=y
 TARGET_BASE_ARCH=xtensa
-TARGET_ABI_DIR=xtensa
-TARGET_SYSTBL_ABI=common
-TARGET_SYSTBL=syscall.tbl
 TARGET_ALIGNED_ONLY=y
 TARGET_WORDS_BIGENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
-- 
2.26.2



