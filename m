Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6B7C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 11:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E642076E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 11:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E642076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD5A9-0005TF-UZ
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 07:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jD58m-00040o-2g
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jD58i-0004vl-ST
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:39:39 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36489)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jD58h-0004n1-L3
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:39:35 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTznO-1inCFY2syI-00R1TA; Sat, 14 Mar 2020 12:39:26 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] scripts: add a script to generate syscall_nr.h
Date: Sat, 14 Mar 2020 12:39:19 +0100
Message-Id: <20200314113922.233353-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200314113922.233353-1-laurent@vivier.eu>
References: <20200314113922.233353-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/waqe7BHcdWI/bjungRZH1rmP7Q5rqRXDhR7H9n91n3I0nm/u64
 XHgHaKNMGYEN3rMA4QwaU6E39gZ3eS0LIF8pdI82X2/MofnhDJ1DQ59reGY+J6Uok/YNYUA
 wnDyYcLAxJb3x+Ny5F+kzP2LnAmwYIqjbt748DlMd9f+ZakVRSvte7c4G+L2iikXVbcisxW
 6rKaA+SNUWqTgL+dJJoVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A4n6unve7z8=:b8eBrPDygn5lbg3udnAGM9
 We20VKwtlyDoPqsJlrsamnSRaG2tYQ5w2dDFxm0wfHeSMdeurSRTtAGXtwZJ7SUJNEyVWp1as
 1ylG9slCa3T7SDs6Q4epLjKJuBFKABh4GM5epcqjoPGYtw2Q0lSMbPUf0km45aqgaoeVirSSR
 GveLNEcO5QMwlOM92m2bcZPcOiYn1HlLgP7w2t+XvnTFQQW3pAkECVeMTsRd4T9veilmOLwbt
 VH0cUf5HBmzXGwqhDOunoiq5ZPUXOKOUSQReIanzFr9IFbNhMYwHVPx/nFI6Sa3SDACrAlZPJ
 JrhPslyke4ViR0m2l1+Zb2fuTHNpEAvgvDRRR9XFhG+wV/q++1krRUrpOsFI+wDoljvtKJOgF
 h/oLCFpIawAtkmGbDgYY9xbEUmNDkMUBL69oVjhmIhsPw0IjfAPeNAYi9QEXjP2xFaa+9biAY
 DlH1WpwHH3PnlkDsitJBpHgnRw7IO/BaBn7NFrQ95tlbOJx0B2cFagIK4AomIfl0B2hva+DLi
 EtHDwiiAcLzAk7qPZfW3ZBaKKggFZT7a9ETi7/3AYN4F8gFjxItPBk5OwQzkg5TCinpJMVErm
 xR6aSCFezfsJRYJTMI8/axZG2munNmBmyy0OWZkmmAJdFAXe56bSOeWu+EKIzlqyc6iZJBd4Q
 m5NEbKnOIdlZfoCytjcWFnKCnyeeYabykKmNw7HSGWa/udeow+6jmSk5Ss2lr7agfxXaNCNyC
 tJKcEEFg/pywx3FDAcxzLbRUbotM3voOjjJHdAGwkTvKyGb1zbA7NZQZJ0Tp9ixvTU5tUyGMU
 DsG6XoEhpsz9FlTn6TEyJdRv92RXp78rb05VuHXw+RJtCXzsmoWsRbVylxNnIjNoNr9ENdr
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This script is needed for targets based on asm-generic syscall numbers generation

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
---

Notes:
    v2: add comments suggested by Taylor

 scripts/gensyscalls.sh | 102 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100755 scripts/gensyscalls.sh

diff --git a/scripts/gensyscalls.sh b/scripts/gensyscalls.sh
new file mode 100755
index 000000000000..71557ab45be3
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
+        upper "$1"
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


