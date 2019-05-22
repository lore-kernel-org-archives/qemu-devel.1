Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA94CC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8166920821
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8166920821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTSNa-0006cD-5N
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 10:38:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hTSG3-00007C-Mu
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hTSG0-0007Xa-O3
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:30:19 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:44417)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hTSG0-0007Tg-99
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:30:16 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
	[61.195.96.97]) (Authenticated sender: PQ4Y-STU)
	by mail02.asahi-net.or.jp (Postfix) with ESMTPA id E0A403EA39;
	Wed, 22 May 2019 23:30:10 +0900 (JST)
Received: from yo-satoh-debian.localdomain
	(v045049.dynamic.ppp.asahi-net.or.jp [124.155.45.49])
	by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 4A602240086; 
	Wed, 22 May 2019 23:30:10 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 23:29:55 +0900
Message-Id: <20190522142956.41916-12-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190522142956.41916-1-ysato@users.sourceforge.jp>
References: <20190522142956.41916-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 202.224.55.14
Subject: [Qemu-devel] [PATCH v15 11/12] Add rx-softmmu
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure                      | 8 ++++++++
 default-configs/rx-softmmu.mak | 3 +++
 include/sysemu/arch_init.h     | 1 +
 arch_init.c                    | 2 ++
 hw/Kconfig                     | 1 +
 5 files changed, 15 insertions(+)
 create mode 100644 default-configs/rx-softmmu.mak

diff --git a/configure b/configure
index d2fc346302..426917b819 100755
--- a/configure
+++ b/configure
@@ -7549,6 +7549,11 @@ case "$target_name" in
     gdb_xml_files=3D"riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit=
-csr.xml"
     target_compiler=3D$cross_cc_riscv64
   ;;
+  rx)
+    TARGET_ARCH=3Drx
+    bflt=3D"yes"
+    target_compiler=3D$cross_cc_rx
+  ;;
   sh4|sh4eb)
     TARGET_ARCH=3Dsh4
     bflt=3D"yes"
@@ -7769,6 +7774,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
   riscv*)
     disas_config "RISCV"
   ;;
+  rx)
+    disas_config "RX"
+  ;;
   s390*)
     disas_config "S390"
   ;;
diff --git a/default-configs/rx-softmmu.mak b/default-configs/rx-softmmu.=
mak
new file mode 100644
index 0000000000..a3eecefb11
--- /dev/null
+++ b/default-configs/rx-softmmu.mak
@@ -0,0 +1,3 @@
+# Default configuration for rx-softmmu
+
+CONFIG_RX_VIRT=3Dy
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 10cbafe970..3f4f844f7b 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -25,6 +25,7 @@ enum {
     QEMU_ARCH_NIOS2 =3D (1 << 17),
     QEMU_ARCH_HPPA =3D (1 << 18),
     QEMU_ARCH_RISCV =3D (1 << 19),
+    QEMU_ARCH_RX =3D (1 << 20),
 };
=20
 extern const uint32_t arch_type;
diff --git a/arch_init.c b/arch_init.c
index f4f3f610c8..cc25ddd7ca 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -74,6 +74,8 @@ int graphic_depth =3D 32;
 #define QEMU_ARCH QEMU_ARCH_PPC
 #elif defined(TARGET_RISCV)
 #define QEMU_ARCH QEMU_ARCH_RISCV
+#elif defined(TARGET_RX)
+#define QEMU_ARCH QEMU_ARCH_RX
 #elif defined(TARGET_S390X)
 #define QEMU_ARCH QEMU_ARCH_S390X
 #elif defined(TARGET_SH4)
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
--=20
2.11.0


