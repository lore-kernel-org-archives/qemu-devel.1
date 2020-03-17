Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D60CC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F67920714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F67920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEzz-0006lq-BS
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEEVx-0005nA-6X
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEEVv-0000nZ-Lx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:21 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60917)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEEVv-0000hI-1e
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:19 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Md6V3-1jo7MU0O8p-00aHpf; Tue, 17 Mar 2020 16:52:13 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 30/37] linux-user,
 scripts: add a script to update syscall.tbl
Date: Tue, 17 Mar 2020 16:51:09 +0100
Message-Id: <20200317155116.1227513-31-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317155116.1227513-1-laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zczIHcFNviwsApZGtNJYxLgK5zAHn7kJA6IYl0DNO3P2Pd1+gyN
 IcGR/a20KnEUFWTV8G7uqevNhEaMrvifb7GW1IC8g0EbQmuYwRgDTl+rkd1N18e8ryRaHBA
 wUxAldt6CwzVqubPmrI30crcx5c0r4ivOxAhUVzAJo4gg9tfuAZKIQ3M1uwh6rMp/LpDRbn
 2zRsNWJZpCUJh/aIyBd8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fhon14Mhv2k=:NlnbO/88LKuRoJKeLdsqFs
 pP6tScvCF0CVOkEFOSwWQyJsToZE7wmQIc0Jz6yy6Aac0v2sNLTGis91otVpn4t/iSn+S5c75
 TzzcMJSrIo9VwnTYNuMKORgbaWPVic1PqCWhlvItNajC1zE9O2h1xSlY2C00qYFIpyNl5Cfzt
 Ek122jhdNc0GkLqpZCwhFSjD4lO/6UlDgnllaWnRKMlUmP1GWjFeD73i/WHNfvlt4gARudaAf
 S//jvDuID1TLidjQXdZdiScylUD1vgSimuoUep3pfZ8v5BVxKuG3E89QGQdwDl2J5vno7Qx3i
 nXQqlaRoxjZnIlMXCOFm6IOpgNrVPaVSugEkVOIKpOOi2Gi1mYpzmXLGdE6r7IEcnFZHoYbhF
 yYzkznzqVIDsGaB6iRrGq4DxbMQIiYn35HSfI2cR0YVDjR1WSQ3lbQMceetFXq3m7p3jOTRoR
 +7ASz7y0DFaKiLRoj+umHWGfJsTSb4aaPzkYbHSKcyeUdnS48EWMAaVIxZ5AVz8bzTPUys7aw
 ECkpQgkYzauZGgZe0MkwLX8V7M/+Vwjt3KSlisijwj9x1SOMz61Q9E/WmbFCo/FVw/YmfvY2e
 TV716d4u/Hs35WXDbA/7uqvkOwD23o2dXBtpu/fXOr0KHe4GTaUtbJxj4pPm4J8e29iicLqZR
 HPpY+aACuu+qNE7ZQ6RU3/VUzKZ0tGgVNTWM4XnSDlEbGzcTvMevZ1+BlWJek4QOc2jTlbRAz
 Ngi13Png+EWCiIeQkS07YWzgDuT9ywuh8l94wu/dxI5pc0eLIYx1ldhF1dOt6nq7CWJ32zifr
 YAgK3sFp30e76f49izCh1qIZmJzV1WZNFlymCpp27tC6pXzrKhZsvOd+DNR++OAMfKV01/a
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


