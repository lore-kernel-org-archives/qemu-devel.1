Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307C8C5ACC4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC582206EF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC582206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32961 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4XcH-0003XM-4d
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 17:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4XSu-0005VY-FX
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4XSs-0001qd-V7
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:05:08 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:51545)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4XSo-0001nv-SY; Wed, 19 Feb 2020 17:05:03 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MsaeR-1jK9f91rCN-00u4Ku; Wed, 19 Feb 2020 23:04:16 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/20] linux-user,
 scripts: add a script to update syscall.tbl
Date: Wed, 19 Feb 2020 23:03:30 +0100
Message-Id: <20200219220333.1411905-18-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219220333.1411905-1-laurent@vivier.eu>
References: <20200219220333.1411905-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S7ioDDKes+F+FOBy98ieNKLVaxwSGfX+ngXVuG0VfelrGHjnzSW
 w7IKRFarcsF6eJ6KIHzZwdD4LdDPsG2Z4X3M3qKPwqGOpojkzPgxkofCFZpQdEFYudB/Cdi
 eWD+IpxreIKbmu8sdJbLzJPjBulO6Rp1h0f0RuqSxM/T7PwMDwE3eia8/EcGbI9fSMu0rLb
 Jkr9NVtiio0a+uFEEKU4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J7T1a+hTmYA=:322SRAyh2dxvu9E4KEzvR/
 V74K43XxN2C7KxGujeBZF0Sa/7ZgXLNsyc47ca/B1/6yU3jQPYXDBJCYa6G5ieW9h9FDlzqv+
 zXBxfG3zDTNhRXQYW03YS6z+3a44+QjXoJD87HEKKoA/7uiXyckFvdUmNvxqMKRQj3rs2LN8S
 XhatSFsF5125ybhK1/10Om1smJELtoaN7ermkHjb41spBgCK0mmj2oLbBOTrY66GRGV4QRluw
 Tsn4dG/jOogQs8EQaM/hLt/LQPUE9TFH/Lbk3mMMsTh7pN210IbpDe9tt5NtTQdRZClLiz9tr
 ATHyL8TfahVaYNnoKzx+FTCCmzkINdJjUky70b9V65cFzAKLV5O/0Ymm1AeTObWGBc8nHyH+m
 MzX2WDzGSLiZiKTpP/w/C7j+F8hWF1bVpO+x80O7T1m8YehRmHxmptf1k8lItsUeMV12kNlx5
 RRXGxkqS+F0nDY04idBqMCd2uv3ZTHgCs5gbCrNVQQy+YrmHq3s+Mj2tzFYQrqzu7ukov+IwE
 3vMj8FGrKB4aqJi7QZbTw/bScjCIaKQLnVCPBX53PkInm1zus/jw06fd9wmhAv0ectiIe/elo
 /C5kwdj5FNVWTNYK7ncVchsP+13KER3WyldnTdFWb1iB3/p0hLHjR+kwlxd83t70k2hlXwDb1
 6Nv7PpakwaIbKkmkKxVqxcZXizsBKYCvEkF4Jk4X/3wza8COjYJ3c4JMB2BxIlMCEbQds+Na+
 kcikkRKwrHoqWgGZH0Y23sm8EzYN1XS6YEB4S1BoDXv+Af288IiSvBEiJEAdonXQgJPQLjPDd
 BV5rJ/HKOQSGQJ3OiTB9vdbIefKXI6BlIP4vXLKrGlhS3fyUNPgTAoGC3u7HAICwoUOOQiM
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
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


