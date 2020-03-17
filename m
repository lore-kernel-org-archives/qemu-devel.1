Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361BFC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F56720714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F56720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEsJ-0002Ys-2W
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEEWC-0006F1-VQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEEW7-0001VR-Qy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:36 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:41469)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEEW7-0001PX-HC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:31 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MTAJl-1irru1395j-00UYB9; Tue, 17 Mar 2020 16:52:19 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 34/37] scripts: add a script to generate syscall_nr.h
Date: Tue, 17 Mar 2020 16:51:13 +0100
Message-Id: <20200317155116.1227513-35-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317155116.1227513-1-laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UTV4/sM+Slrzhp9dxg1B7hgaWSTSIjlHRB9uYfpQf9py9QVPOuk
 SDM9P5Kv3keQ+w6Quk5DfeK5SY/pncLb4Kz1idB//O9dCpZ+Y4XJAVY8I1WvXeexR8CLkF9
 0LJj8dpoSGjtyk4++SQAwWirPo0TsPFaqeSOmX/jFVmQZqCEtiwJJzUC5vpw/Y4JRZ1Q460
 UW8CwSJMdxTvG/iZen4og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KowhE5Ka8Io=:sFQRnLLFlxRk9Vfu4KNGEI
 qko68Pj+p+E/YReU1xFW061fK6s1bzQw7Zwuki2aI/n9G1oPjKu5fmqvYcocLns4gLot6JT2p
 lAY8cCCK36IaAYVFjJhpFpSMe7d0T+HMVszWbLBBdltyizo5kd9gCyrdkE8859K+TFxJwJigC
 7E8pECgCVHS6cBiTTHSEFaP/u919WU++1nEp5p3l5qVwnyUkX3USpymlBbamcQnTK2cQIwcbL
 io4m4t8gU+p66IVgL/1FBaP/wxpbm4GILZgeH/yzUvShfA9gSmBkhK9e22hG0txzTmcTJlDb9
 6ESXrkyH6R2b58NQwaeiw2ltmHj7GqtSnFBd2bD7og3OhHJQbRSj9VzxUsY3Baxpy2TF04uUL
 W343OJP1hNLV6vtY3CjVSddCYqZywIYvA1I6v8CMAreVGNurplcCCjImaSMX1bcMSFTVtlAvg
 arjiY9HQLoAn2kZ/M/0V6UsfvepkEZ1SEqMIPyMupDpdDOZbuJlOSvZFtaW5p4ETIBvKJxhJa
 RrWvqXn82axpFoxFdM8ACU3FsgW/uF4KL9Jr6wZ0cihxZmVWTtEdX4ulCjVyRN1b7gRVpsdFV
 vwbPkQczKfkwfanpB8HuwaWs/benlLBs2CSrjv9g4+Syb6XRRwDkp8zpW5dmC5bJWm51tf/XM
 iuH2qcqpiZ6/8Wde+rFmk5uv0VGxP2B4UQ0Ezi58Ha7kgDbfLhhdW8btjCY5H5wu0WwVUU9g8
 ty0Zp3aUKIE4me3Zm5z2w/n8RjnmPwMdXeUHZRiiiD1i/d2o5hWANJ6ZEqPMdtJlcCE9Pxjqd
 6iQeRnjlcuUVcu14YrrluM9JGFm5qLenwFrrSxazXYcWeq2w1jmYyz0+/jv3QKXOu+R9HEC
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
2.24.1


