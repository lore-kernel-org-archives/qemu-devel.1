Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF0CC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577DF2467F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577DF2467F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBclL-0000BG-Ga
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBckC-0007F1-Cb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBckB-0002EZ-AS
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:08:16 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:41381)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jBckB-0002AY-1G
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:08:15 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MCKJw-1j2F5U1tkg-009OK3; Tue, 10 Mar 2020 12:08:02 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] scripts: add a script to generate syscall_nr.h
Date: Tue, 10 Mar 2020 12:07:56 +0100
Message-Id: <20200310110759.3331020-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310110759.3331020-1-laurent@vivier.eu>
References: <20200310110759.3331020-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:46eEMsrGsrt0h5kTRAklBXrC9uDAjjf8NGYmE51xC5DOvQ6Jxcz
 aUk12Yve93dS3Sv9PCLUke/Rtj/hOLqRW/TiAADio6FgGurbXKTlpffk/7idcUwfli4h1Fw
 iX7bDa2kKms9BjzVtU48DY2g3mN5mWE3E/J74f4H/IsGByIE48/l/iYB4917FEckgSfwiuU
 EmOMzs079XRaFBcagnoag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mc8Hs1YD7x0=:0iOWgOm73iMwJATxsMAXfv
 GDAa0bOS0OaKp4MTw/gUCo8ky2l3P/psXJHXonr90Vy5a8KxRzuKB8XFtnSLi3+6idYU49gFF
 rlZlRafuOfREiMm8Tz3U26yoRZHPHNgncGUpUk6mwaIIJzsCKpr5cpLxbyN3Zv9+BSaAo1+js
 ydMiglSwKE71bo6adkB8Iu8qZD3JPqg6SoXOWTtpaY0KnOKEoU3KMJgV5sftlvl7XrLNy1xjO
 fgIUjsggC/9clVATu5yygYjoxa1cIwF4nHkh8oERsJJSWR7xxoaxIvTg3NQ5dQfmwg/pjy9ww
 wsuxph+wpwutvKNoE/B81TSqRB4uGwlErPktC1k9xp/iR7cYbtgIh7AssCqAY6EdUCDz+LW50
 vOpFAf+oTQSo7+77zrQxrpjd3TiUlCuLPFAXPS7f004SSE1/z4GYbQt2eILi3ED/XI3JjHYEg
 otYDPz9QqhDdzknnnn96YHMoDiut5nOyxEdCcmmEt1Eq9JFysQo0GFozTubdpqZkgRwMBkah2
 63eGFzRIb2Qh+i+eTDxVmxQm8Hfd327srq0dHJyQSrTdNIg15qA9PIa7vpi/S4cBWrp/G1OcE
 zbYvkGOXoL0nkCVWmLxXE7ttZSFXfrU47FaWhxRSKK8Db2kco9x1FUlhFOzx9g22RKThuDy78
 yy+SiU8I3Qio1kafkh1r4DwwpuTuUekc/ObsqZNapa6Roz7LVrqr4ZO6amqOUdwAmcQpDkdoa
 StoChzu0Huji4M1q6R3yy0MCmNaXuGdC4RnuFVNnZaHNsCMg3bNE9dyMot3BMyToekYMU11dC
 fRIF7MDXTffghbwfSmcMBvIat57agT9oxwKXD1Yz16xosERbhvdjB3VH/tYKBodpF4V/Juy
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Jia Liu <proljc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This script is needed for targets based on asm-generic syscall numbers generation

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/gensyscalls.sh | 94 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100755 scripts/gensyscalls.sh

diff --git a/scripts/gensyscalls.sh b/scripts/gensyscalls.sh
new file mode 100755
index 000000000000..3b549a665d0f
--- /dev/null
+++ b/scripts/gensyscalls.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
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


