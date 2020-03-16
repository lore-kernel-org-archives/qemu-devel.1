Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EC2C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79197205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79197205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtjR-0000IR-LH
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsQB-00084D-Aj
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsQ9-00053j-UJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:55 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56771)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsQ9-0004td-KV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:53 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MzkK9-1jZYAk0tWr-00vgqc; Mon, 16 Mar 2020 17:16:43 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 31/38] linux-user, scripts: add a script to update syscall.tbl
Date: Mon, 16 Mar 2020 17:15:43 +0100
Message-Id: <20200316161550.336150-32-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bo+4eCueW07i8o5qeGAoknKn1StuF58hkciYp7+w59TT5ReDtrp
 Jy9/HDleUxsWfqAbzmlyeZbjH81dfC/fqFcUVE0S2WRXLTyzxMJYZNZjCrwZ29XDcaTgPR9
 gkDT9V5CsETumKreZWh9TT8Kwj8b2Qr+ZrW2ORCdnZdx1nz+TwDq9tHYboJd6nTIcinWU6M
 ZZ7AddQ6eVz3IfG8vBOlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9xhrsaNCoZg=:/XlHe6MjtL+hbusrMVpSox
 fQpeM6jFzST62wvbpqQ57SxafrEmxI7vJsUe00gj6mXbj753SqadfrcFSV2O641+QF9+2H1vT
 cEoyBn9qevuRV+WPpwpJqCU2r02rQN//eOFHUduGASjIMh3YgontmV/6uQSyJ57z123IVayWr
 poIba66Xf9u6GASsBt35FAtYBAzeKS8XwrO18oxVw1ELEq7oM9EtNVfYwnw0CMrD4yRjOtJfc
 NGMXVCtApa5Lu0s6J3YEcpWeARA4LOagdWv+9jIgXQlSBklkTds/mYpPp01lRPW/WHWA9j2ab
 o2F4n3kV2Ha+Wio44Mppt1wiBPh4n5cOGlbKaBG7PwJ776B+JO0yE3Tngb3kGWNR9p5CDer0N
 d2N0ZMRr28V6eObhtVX/c59R2CW+8IV4FwmvIuuX1miq1COQBHkBffRKHEmxaApI/GPxumb6c
 u8XhxUPBfDaS+W0h3C9M3ZcfQsmYwNi761MBBWZ0YCeYDs48EaGHtu/1DOpFMPtGd5XrFrhdP
 DEW+D5iWZbdHrzPr3qEyuqeQ1QM7fCeEP1BwlZ5m7ROCzeNVOa/ADoViD+fzmeGSqbrlzguMd
 o4y/7tfc1KuC3iX6qN5Ex2Crl7QnmMRLaLCC39Snz2/G8Y4lSLcIIc8mCLX/fI6f9NyhYM1vm
 USZPPwQjvLH3jLSnnuZnBjqR2v6+hHL/B/nl9PJbSsrkxKCwj6ZMc8mVyB5cuQEhqJSkGCFsL
 6oItj9G+k76feFfwa8XohexKJIai+x0LBpSFKp1lAFeeoN8Nigket82/NG4/hrdXLsAR0AF7A
 dHE1KZjEseNO33+DLWSOStJmwChd9mufYMFjrQuo8gfeha5IzdRicJ9GqLmZq1/f00BXG3P
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

scripts/update-syscalltbl.sh has the list of syscall.tbl to update and
can copy them from the linux source directory

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200310103403.3284090-19-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS                  |  1 +
 scripts/update-syscalltbl.sh | 49 ++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100755 scripts/update-syscalltbl.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 36d0c6887a99..709832758e51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2448,6 +2448,7 @@ S: Maintained
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


