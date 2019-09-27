Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62296C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3485720872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 06:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3485720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDk7g-0002IZ-Tp
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 02:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iDjex-0007JW-P5
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iDjeu-0004Jd-Sh
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:19 -0400
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:54404)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iDjeu-0004Gd-I7
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:16 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail01.asahi-net.or.jp (Postfix) with ESMTPA id C28E586E95;
 Fri, 27 Sep 2019 15:23:15 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 6EDBE240086;
 Fri, 27 Sep 2019 15:23:15 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH v25 20/22] Add rx-softmmu
Date: Fri, 27 Sep 2019 15:23:00 +0900
Message-Id: <20190927062302.110144-21-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927062302.110144-1-ysato@users.sourceforge.jp>
References: <20190927062302.110144-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.13
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
Cc: peter.maydell@linaro.org, imammedo@redhat.com, richard.henderson@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20190607091116.49044-17-ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
pick ed65c02993 target/rx: Add RX to SysEmuTarget
pick 01372568ae tests: Add rx to machine-none-test.c
[PMD: Squashed patches from Richard Henderson modifying
      qapi/common.json and tests/machine-none-test.c]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure                      | 8 ++++++++
 default-configs/rx-softmmu.mak | 3 +++
 include/exec/poison.h          | 1 +
 include/sysemu/arch_init.h     | 1 +
 arch_init.c                    | 2 ++
 tests/machine-none-test.c      | 1 +
 hw/Kconfig                     | 1 +
 7 files changed, 17 insertions(+)
 create mode 100644 default-configs/rx-softmmu.mak

diff --git a/configure b/configure
index 397bb476e1..66a8db524e 100755
--- a/configure
+++ b/configure
@@ -7523,6 +7523,11 @@ case "$target_name" in
     mttcg=3Dyes
     gdb_xml_files=3D"riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit=
-csr.xml"
   ;;
+  rx)
+    TARGET_ARCH=3Drx
+    bflt=3D"yes"
+    target_compiler=3D$cross_cc_rx
+  ;;
   sh4|sh4eb)
     TARGET_ARCH=3Dsh4
     bflt=3D"yes"
@@ -7704,6 +7709,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
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
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 955eb863ab..7b9ac361dc 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -26,6 +26,7 @@
 #pragma GCC poison TARGET_PPC
 #pragma GCC poison TARGET_PPC64
 #pragma GCC poison TARGET_ABI32
+#pragma GCC poison TARGET_RX
 #pragma GCC poison TARGET_S390X
 #pragma GCC poison TARGET_SH4
 #pragma GCC poison TARGET_SPARC
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 62c6fe4cf1..6c011acc52 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -24,6 +24,7 @@ enum {
     QEMU_ARCH_NIOS2 =3D (1 << 17),
     QEMU_ARCH_HPPA =3D (1 << 18),
     QEMU_ARCH_RISCV =3D (1 << 19),
+    QEMU_ARCH_RX =3D (1 << 20),
 };
=20
 extern const uint32_t arch_type;
diff --git a/arch_init.c b/arch_init.c
index 0a1531124c..7a37fb2c34 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -73,6 +73,8 @@ int graphic_depth =3D 32;
 #define QEMU_ARCH QEMU_ARCH_PPC
 #elif defined(TARGET_RISCV)
 #define QEMU_ARCH QEMU_ARCH_RISCV
+#elif defined(TARGET_RX)
+#define QEMU_ARCH QEMU_ARCH_RX
 #elif defined(TARGET_S390X)
 #define QEMU_ARCH QEMU_ARCH_S390X
 #elif defined(TARGET_SH4)
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 5953d31755..8bb54a6360 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -56,6 +56,7 @@ static struct arch2cpu cpus_map[] =3D {
     { "hppa", "hppa" },
     { "riscv64", "rv64gcsu-v1.10.0" },
     { "riscv32", "rv32gcsu-v1.9.1" },
+    { "rx", "rx62n" },
 };
=20
 static const char *get_cpu_model_by_arch(const char *arch)
diff --git a/hw/Kconfig b/hw/Kconfig
index b45db3c813..77bbc59cc7 100644
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
--=20
2.20.1


