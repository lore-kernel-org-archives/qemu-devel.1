Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4D8C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FDE2205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDE2205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtlK-0003bi-G0
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsQK-0008FA-CM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsQG-0005mE-On
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:04 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42961)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsQG-0005fh-Cz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:00 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MWhxY-1ipjoo3aGW-00X6bn; Mon, 16 Mar 2020 17:16:51 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 35/38] scripts: add a script to generate syscall_nr.h
Date: Mon, 16 Mar 2020 17:15:47 +0100
Message-Id: <20200316161550.336150-36-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0PBAPYPHrfYFgos0A4IzO7khiE+tqctDPkMDXNwMXUXLJsQ2K5k
 tC7qVVnH1yhsvNmZBxAs+P+iQ6XkAFVtmBcbqCmCTGjyoRnMs8/dGO0SQ0Bki5IePXC+Suo
 sMum16ihRIBxyk2cE1UrlTof+ycYPVIqSD8ZqE86RMT+auw6imDGpgltUxBZn0J85l08Kd/
 IM0E5QwMx+sodafQ5dopg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IHnW0WlVUbE=:zDvhSerBa7f/bUxVJwG+oB
 C2IvRczfZtxqjnvlWTDL7Vl48/piAO7mTkynZtSJH3NRkLF7Rpqe5fvwPRwR815C9TO1LqTDK
 75o1nDF5/M8V3yaaKoZsD+iSE2xwHQ6BPHz9JnGeikYna/TuAlE4iCF7vnoAuBzMfdr0IiP5B
 AgtbISrJq9Q5Gp+YyR6A1UozitahhKZKEGd7ifNu0FRSoqKJmCg1m60DzFLIdyHboU9Ubjdx5
 IYzh5q+9gGEc3DBmBMIrh3UthJzhQDjwmb9j2yCN5yU/H3V7qW7WKFD1lj/j84Zo3BGHjwt1w
 TbXqb4dPc4pWy54mxZraTl/QPgrhlY8VZpJsYAunG8oRbntur1xspuVvsOqVqWgKlYUVrr6Vo
 AsnkBxfP9259FSVqyBV1EhYM+XnCYlOTjQK2Gl0Cqq3M0r2EFiUwofpsGevBj1KWnYmrAJT0O
 pH7A9RwNmdkZIBrHkvoRx1mVbXF7Nv8ECxgBpWH75lxECf2UO8G8oWkpnDdyb/eHpIQVMvE4q
 77dIPUaEOyZ0ZTQ88dMEybT9nO1/rn+WwgDDm24l/C9HYY7MzIIjDMTELi8arocN1XA6tqths
 fkh7DkKSp78xcX9mvrNqyYKC2px7u9MMbqdMJSfI/SNku112PbsYbPKGjXyKJM8mkih5MrHCR
 ZvVbN+LK4QOM5Zzlwizp2AggXpZ4ZqLUrgqNVZ1EelaRAanP/cPgLRGd47vRvCf7/ZVPlmXsr
 BjE09FVs7ak1Spstgpqh7DfmNNWAvpVa3T2WVTiqDXqomTQu05rHW0JRXsFS6BeZPbagQpFZm
 sYNLazr0saursyLrTTMpKRlFgR1RjgDaIpsox2ND6lM8emzvvJuhk7lrpH9s/gop5AmkZLN
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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


