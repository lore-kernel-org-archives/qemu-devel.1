Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B379C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7386F2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7386F2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJhe-0008R5-HP
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFJWK-0006og-MG
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFJWJ-0008Rw-5l
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:12 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57981)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFJWI-0008PN-S6
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:11 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MV6Bs-1ioGip1xpe-00S9ls; Fri, 20 Mar 2020 16:25:01 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v4 29/32] scripts: add a script to generate syscall_nr.h
Date: Fri, 20 Mar 2020 16:24:05 +0100
Message-Id: <20200320152408.182899-30-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
References: <20200320152408.182899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+dG9ALLWDDKJODKGbawtSLBOxshlb43TP/shuH8IjThBhn5aQA6
 YYXV9BcBddxY5NodmOThrHNe/QBWADzLvNXfJkM3FlZuAwW+tCg/+k7TI179qJDWwp2WEOX
 6iXbMeazNfjAtIkT4u0+kNMvIQ+4aF3Psw63AlYyQiL2gJXTX46b3FaKMMWI29j5bg2SSX/
 iitAm6CJ374khd/FPqXkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xWDdSvqkBDI=:sUcT1Xfggg0kjUZzR3IPgh
 onwkmtucWRbF9l968itpA7tN7qmNym7CtagQqQw4LIzV1yGzk7R9ZEt4ZQLnAAJLNrpR2lFtJ
 dSF0cNEuuGgqXBEoDmdlNNAm8BwJ+ROrUO6ZEBA83vuybMuhR4kmjTaZvmrGR5MLW4q2Tteg3
 KmobFKsQQMoEv3KJPN46NeVDsKmAsC8m0H7KwFunTiXtsDtTwG41Iqcb9VjfKbmSVVDEneZjh
 t54amHlKzFyYMcn4sGLezVA9oxpQF8YqM8kpwnWIeCiPIWxmEDhjz46ZHESZUORl0E308pR10
 SIck3oCrEKVmWZ51kzVPhevGhnrn1qmllJrPKe0o3GeSLiD6EWc+D+qthxHp/xqBy8uOmr5Qg
 oK3doSZMCL9h/JhbvjNpEFd1ePsandIectyU+HiDztm5SNblHlAxJ7IuIkgt0feq5jUsBMvIW
 dQxCb3GUAmAimJ2ilsRB3IWzvdiDklAaPqv21FLhH/PqqRhv30XSqOuQDHNd9h0XEjsVVS9Iz
 4LoK4vaH+9jYn6AgVzBggZzXcNlDUtq7dRatpE8tJN0OrbsHl3pFGz3Bkgw1Yb712rEfve7q6
 ZC5HGhcIRsGFW1jizUXN4D503Y6KovivEp2y2Lqja6+U708VE97qb4pRPMhBWQ+FtQTv9LNFn
 CRckesUF+ufZxwqI9AqcGd0MS6djo+C+rBAwK1LFYKRigLZAHY+VXjQd9f2pexPCEAyIf8EXI
 PKRLoNXVQDPzD/FRKFFp+ug8hc8RG6iU20+pHP+XcW/SvqeVr4ijNrxgqqnOP9GiyHQXiMQ1l
 eDEVGloLzsP9lXTiR5s72BETBTpP5fKd2e0jLj3yFDokCgJq809SX8c/0tkHV+1+WsCb8R+
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This script is needed for targets based on asm-generic syscall numbers generation

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200316085620.309769-2-laurent@vivier.eu>
[lv: added file in MAINTAINERS]
---
 MAINTAINERS            |   1 +
 scripts/gensyscalls.sh | 102 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100755 scripts/gensyscalls.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 958e05b27f15..45d48992b13c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2450,6 +2450,7 @@ F: default-configs/*-linux-user.mak
 F: scripts/qemu-binfmt-conf.sh
 F: scripts/update-syscalltbl.sh
 F: scripts/update-mips-syscall-args.sh
+F: scripts/gensyscalls.sh
 
 Tiny Code Generator (TCG)
 -------------------------
diff --git a/scripts/gensyscalls.sh b/scripts/gensyscalls.sh
new file mode 100755
index 000000000000..b7b8456f6312
--- /dev/null
+++ b/scripts/gensyscalls.sh
@@ -0,0 +1,102 @@
+#!/bin/sh
+#
+# Update syscall_nr.h files from linux headers asm-generic/unistd.h
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+linux="$1"
+output="$2"
+
+TMP=$(mktemp -d)
+
+if [ "$linux" = "" ] ; then
+    echo "Needs path to linux source tree" 1>&2
+    exit 1
+fi
+
+if [ "$output" = "" ] ; then
+    output="$PWD"
+fi
+
+upper()
+{
+    echo "$1" | tr "[:lower:]" "[:upper:]" | tr "[:punct:]" "_"
+}
+
+qemu_arch()
+{
+    case "$1" in
+    arm64)
+        echo "aarch64"
+        ;;
+    *)
+        echo "$1"
+        ;;
+    esac
+}
+
+read_includes()
+{
+    arch=$1
+    bits=$2
+
+     cpp -P -nostdinc -fdirectives-only \
+        -D_UAPI_ASM_$(upper ${arch})_BITSPERLONG_H \
+        -D__BITS_PER_LONG=${bits} \
+        -I${linux}/arch/${arch}/include/uapi/ \
+        -I${linux}/include/uapi \
+        -I${TMP} \
+        "${linux}/arch/${arch}/include/uapi/asm/unistd.h"
+}
+
+filter_defines()
+{
+    grep -e "#define __NR_" -e "#define __NR3264"
+}
+
+rename_defines()
+{
+    sed "s/ __NR_/ TARGET_NR_/g;s/(__NR_/(TARGET_NR_/g"
+}
+
+evaluate_values()
+{
+    sed "s/#define TARGET_NR_/QEMU TARGET_NR_/" | \
+    cpp -P -nostdinc | \
+    sed "s/^QEMU /#define /"
+}
+
+generate_syscall_nr()
+{
+    arch=$1
+    bits=$2
+    file="$3"
+    guard="$(upper LINUX_USER_$(qemu_arch $arch)_$(basename "$file"))"
+
+    (echo "/*"
+    echo " * This file contains the system call numbers."
+    echo " * Do not modify."
+    echo " * This file is generated by scripts/gensyscalls.sh"
+    echo " */"
+    echo "#ifndef ${guard}"
+    echo "#define ${guard}"
+    echo
+    read_includes $arch $bits | filter_defines | rename_defines | \
+                                evaluate_values | sort -n -k 3
+    echo
+    echo "#endif /* ${guard} */"
+    echo) > "$file"
+}
+
+mkdir "$TMP/asm"
+> "$TMP/asm/bitsperlong.h"
+
+generate_syscall_nr arm64 64 "$output/linux-user/aarch64/syscall_nr.h"
+generate_syscall_nr nios2 32 "$output/linux-user/nios2/syscall_nr.h"
+generate_syscall_nr openrisc 32 "$output/linux-user/openrisc/syscall_nr.h"
+
+generate_syscall_nr riscv 32 "$output/linux-user/riscv/syscall32_nr.h"
+generate_syscall_nr riscv 64 "$output/linux-user/riscv/syscall64_nr.h"
+rm -fr "$TMP"
-- 
2.25.1


