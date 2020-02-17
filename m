Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78D5C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 22:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B0C20718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 22:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B0C20718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3p29-0001B5-Va
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 17:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j3p0z-0007gN-Bi
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 17:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j3p0x-0000gL-U8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 17:37:21 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59707)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j3p0t-0000e0-Kc; Mon, 17 Feb 2020 17:37:15 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mlvr3-1jlAQZ1QDT-00iz7e; Mon, 17 Feb 2020 23:36:28 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/22] linux-user,scripts: add a script to update syscall.tbl
Date: Mon, 17 Feb 2020 23:35:55 +0100
Message-Id: <20200217223558.863199-20-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217223558.863199-1-laurent@vivier.eu>
References: <20200217223558.863199-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vH9BjD6yvEz4n19lW+JnZ7N/dIZWKM/JEgOO/LS5AXWe9JCGIIs
 jBsfaClpaqFTu8NtshAqW/Gg8PNNV4oD0vgxAJu9prgYmoFzIL99S4hhk3aNKSEx8svUEDQ
 +kKAU8sefLRFoP16/NPaCk+JCrRCFVTkJFLO1s3SUsu2fup7n2mPiSax7+pklp1N8E20AAZ
 X0lctmHydOWAfmON7utnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4mo/4WqGlkA=:6XmphGqjGQiZG074lI097W
 tAUmlZifs1qGEGQ0GTDK4e6m8vhI7chgCUkSP5XtU1ghc8+JF8O6pRdFGtyjGSzLsQ71Dn20t
 AtuYxxbknybqkhMnE6hXsIKKoQz7uOPBCGeXscfUKwvfn3xpPCohzvgIi3lcbseEXLf0XVT6B
 fOXI4IpxcSEWxX4RXhjx1WmrP6x5XqxPV5wCHaamUZIoKKklZKBHGPH3nWzdsThHM7qPiW5Jd
 xwIEa1/i5XlbjfWC/dU64l2VoMJwBfpnO4zqHVvfAVyamyYDGcnp3XXIxoBwWEDJdWboIIR12
 VfA/0mwdB0AwrPc9wDkIumzB4xZwCFpT2O3SQj/ECROHaLxDgUz99YiLPFX9K2vBXcz3j5n25
 +5YMQYlDkXSkDW5ZjEJkJQVMB138jrJRZ1AXUzB39fIdj+L9nAOkITc3+/3xc9jDzQ6CU27B8
 kOKw1zq5wU0RX8fUresNhC9CXRiD8geaoGJdMmFRNQCLSG11NWPRa55X0c28AhHLI5S4ZrQ7Z
 dcefE29wX9llIzgJo3XyB8K4Ebu7wxdy40O4asmi4AKmZuTXD7+TCEFa8ICvs4MblGGN9us3U
 5Qqd9VbDkyA4Jjb3SKGNv/sOuMkIk1D/L/Q1Bm5XjhEjD/xhdGIPkOyHB8VbTc16xZ+vLKq83
 bgsymFEGU/ca39Dc3TspBvGGAAa67vEAwJeichHetK27vd76ctMeoZ6JoU3qQcp3xmVEIuC/7
 12YoGzYrbVnZCKUvyiHWZrEqoxkR2xMJ9vFs7cm7GcjJCncljeWSLqw9TyRaQvkv1esOp+C/N
 0QQHniowP1vWYtZxkZVWGmDKUMUJ1N8eGzhxV1rLhQGpLE8jLhy76RgTv2561vzC7aEo1M+
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

scripts/update-syscalltbl.sh has the list of syscall.tbl to update and
can copy them from the linux source directory

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS                  |  1 +
 scripts/update-syscalltbl.sh | 49 ++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100755 scripts/update-syscalltbl.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 1740a4fddc14..dac93f447544 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2422,6 +2422,7 @@ S: Maintained
 F: linux-user/
 F: default-configs/*-linux-user.mak
 F: scripts/qemu-binfmt-conf.sh
+F: scripts/update-syscalltbl.sh
 
 Tiny Code Generator (TCG)
 -------------------------
diff --git a/scripts/update-syscalltbl.sh b/scripts/update-syscalltbl.sh
new file mode 100755
index 000000000000..2d23e5680075
--- /dev/null
+++ b/scripts/update-syscalltbl.sh
@@ -0,0 +1,49 @@
+TBL_LIST="\
+arch/alpha/kernel/syscalls/syscall.tbl,linux-user/alpha/syscall.tbl \
+arch/arm/tools/syscall.tbl,linux-user/arm/syscall.tbl \
+arch/m68k/kernel/syscalls/syscall.tbl,linux-user/m68k/syscall.tbl \
+arch/microblaze/kernel/syscalls/syscall.tbl,linux-user/microblaze/syscall.tbl \
+arch/mips/kernel/syscalls/syscall_n32.tbl,linux-user/mips64/syscall_n32.tbl \
+arch/mips/kernel/syscalls/syscall_n64.tbl,linux-user/mips64/syscall_n64.tbl \
+arch/mips/kernel/syscalls/syscall_o32.tbl,linux-user/mips/syscall_o32.tbl \
+arch/parisc/kernel/syscalls/syscall.tbl,linux-user/hppa/syscall.tbl \
+arch/powerpc/kernel/syscalls/syscall.tbl,linux-user/ppc/syscall.tbl \
+arch/s390/kernel/syscalls/syscall.tbl,linux-user/s390x/syscall.tbl \
+arch/sh/kernel/syscalls/syscall.tbl,linux-user/sh4/syscall.tbl \
+arch/sparc/kernel/syscalls/syscall.tbl,linux-user/sparc64/syscall.tbl \
+arch/sparc/kernel/syscalls/syscall.tbl,linux-user/sparc/syscall.tbl \
+arch/x86/entry/syscalls/syscall_32.tbl,linux-user/i386/syscall_32.tbl \
+arch/x86/entry/syscalls/syscall_64.tbl,linux-user/x86_64/syscall_64.tbl \
+arch/xtensa/kernel/syscalls/syscall.tbl,linux-user/xtensa/syscall.tbl\
+"
+
+linux="$1"
+output="$2"
+
+if [ -z "$linux" ] || ! [ -d "$linux" ]; then
+    cat << EOF
+usage: update-syscalltbl.sh LINUX_PATH [OUTPUT_PATH]
+
+LINUX_PATH      Linux kernel directory to obtain the syscall.tbl from
+OUTPUT_PATH     output directory, usually the qemu source tree (default: $PWD)
+EOF
+    exit 1
+fi
+
+if [ -z "$output" ]; then
+    output="$PWD"
+fi
+
+for entry in $TBL_LIST; do
+    OFS="$IFS"
+    IFS=,
+    set $entry
+    src=$1
+    dst=$2
+    IFS="$OFS"
+    if ! cp "$linux/$src" "$output/$dst" ; then
+        echo "Cannot copy $linux/$src to $output/$dst" 1>&2
+        exit 1
+    fi
+done
+
-- 
2.24.1


