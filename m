Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157C2C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1D520658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1D520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDm7s-0002Eu-IX
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 05:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDlY8-0005nN-Im
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDlY7-0004Yh-Bp
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:56:40 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:53569)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDlY7-0004NI-2Z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:56:39 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mt71D-1jT5TE0N1l-00tULv; Mon, 16 Mar 2020 09:56:25 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] scripts: add a script to generate syscall_nr.h
Date: Mon, 16 Mar 2020 09:56:17 +0100
Message-Id: <20200316085620.309769-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316085620.309769-1-laurent@vivier.eu>
References: <20200316085620.309769-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:paUhu87fai0bc55XxkcvyXlle9WCNvuQWyw4QMXOTWHbTY3Wfou
 2+iRqN05G1mqnkryJwv6YHcyylVw9IU8fUP/tGksL/7aReGe/yz10t+iZQvk8OwqDxE+Aqr
 nq555bMP+onz8q0o2nSUE1gUM+dBl2gU/kfGzaNGKCOEwaika0E9x2w4qNnbxMgZDeX1YoR
 q9wwu9eUOjSDhxM0P+wqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O2r8lWPhCM4=:hWGagtIEwo4FE1ipiBF4DA
 14Sbx1LoP8KcJEeoEpKvtoJhzWtjsQEvP2jhiGXEtE1JfIVH1WSGpUcsbo7mAp/e6wQIg4fpJ
 buWNo9QShKVg/zlusmSq4JaOq95p7CSqIgXggq2EzBH8RkmqhSJumQlAysQIGTBIfDO9Ztfh0
 y/RLaPJnUXD+Zy0qiRVdu0AeNI3WY9mYANmC+vSyVv3afpnuQTcJj4MtZAVtWbiFKEdan2L5S
 5lq+g2zcObjvAYgyB3URxxTcI1bYo0yVjEzUbV64dhOAP2ciFALYNTvJmfIpKo4PFyp1dR0I+
 VAsjvAfwmyxyQbSkCn5/tk+KXEc+zeyDrOlSXWbKxRKD5G/fig8DbDrqalkAi1btUxBUyy+i4
 XWD0Xh5zs+bYML9v+9PJE24x54Z1MEMzl/PHhT4DhrnVv0CIHT4N31Z64S5L9usfDM3kFKBkk
 CUoAchBOZIAP16eT/NDH+nzSMjpF4QVR/v1h4inpUjfxSC+APcKKxzsN0sFKSpb6dF+nbSuq/
 WkocsiVoRte2Zx9YVeUCbpsJJqaLSftkA2a1/sy3A0PTFN4nwbTfGh8RLxGnbIGiMuNP+uzGc
 uU8SrdfaHIf0N+eK0m2NqteFwOC7LoTpGbtFs7vtF+AyNxhGclMn7HOj2nEr28ScsStvRcRvP
 40jLU2Yen7ExQHvy/eT51d1NL5ImpxAEDIWCNDVSpl9oGd8hD/cYHl5FP9fEhC37iTdCQI5mV
 5SxCeVl4FpjSVpTrNQmjNNEdsJ8uyYSeBaNweFCskqmPRyB/VH6M2KEzjOQMeTsxjGdrp7upP
 Z1VCE5x9kjHOZrrq6mxh6zVsTmrn8lDXlAmmtc1gXzU7t02fCJk47nbyw8OPGjcD5XPGXy1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This script is needed for targets based on asm-generic syscall numbers generation

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---

Notes:
    v3: remove useless upper command
    v2: add comments suggested by Taylor

 scripts/gensyscalls.sh | 102 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100755 scripts/gensyscalls.sh

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


