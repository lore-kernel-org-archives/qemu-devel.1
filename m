Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99420C4332E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:44:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC932070A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC932070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJoq-0003AU-Kp
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFJWA-0006SP-67
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFJW8-0008Ci-RX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:02 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35979)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFJW8-0008AA-In
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:00 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MCKJw-1j723g1uHi-009Nto; Fri, 20 Mar 2020 16:24:55 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v4 25/32] linux-user,
 scripts: add a script to update syscall.tbl
Date: Fri, 20 Mar 2020 16:24:01 +0100
Message-Id: <20200320152408.182899-26-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
References: <20200320152408.182899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cSjOTy3o/ukdNHcxOP2PXAdzDTnFhCKW/6lfWulJhXYbuDmOx7e
 c/UFaAsGFhm1kqX0T2dw1VTyxUN9QSJS9kkKAZvSo24M52W3kH5MIaw0B1/9ESTthGTbIz9
 y8ncH3SGeZntDHHs0Z4skofFfWeRDn6j5iY388BA8028t1TKXtRx/TmVzlvK3mqjArTiLqK
 zN2gYJhzsqoo+hno2aZSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:93Lv8LrdbmU=:60N5LHd3sOvfIuiN8qO1IH
 xuM6BcVPsAYx6Q5d7Xe8dmRQUNQLbXElafRLRiB8NBQnX/Tf90wp+DnasyaD6z3VYrXHHh258
 ipOODACKFIxB6QqXHEuEuh6E9TO0dDRljEQ7z4E6kDA9XkA1y5c39UmSdoevRJzhF6HBbtNje
 63dstQof2AZR0wk1ci2K3EYNJZeH23BhhQZqvaui5u3ndZRF8ja71UTyUOnPzQiMHhiKuOr1t
 uQmmcItupM08Jboc5ycug/sqrcBO9rHDoffdpzcwnDyLnAckqVwL70pR/kU+Ld7ptMb7stgDX
 hFmD9Sbsqa3MWUiG+yYLXPwLBzJPYsdrLjwGCU6mBn0pxipRJQPXVOHbCvUU/w4+wOU4ut+uZ
 POIAqu1ba3v5UXLkWUQ3/E0KtIZgXN2PffXs3o8zKLY6xmWzKRekeJhtrIJupABow4Dj+v3YH
 RYyevbErk2a5hMGLbFIjRvzaLB7aRmBVqacjmTHZ/1UZxV/zFHOU47sB55+rXoaB0p4fha5LQ
 LCisCASzb7D+E09JxjAdhTnVXunxMXShZENy+vUPTfVA+oZiN7HbFFjTFYFyJ9YajorZmPH1Y
 uyLmSyR8PwVVrGAizJ3dVLOJsuqTv/UMi8ENGGKPNRqRetEe4OvymQLRNqw4m2wwhM972Owvl
 uG4DYYvBRYyfzSIkNbimAmYePBhOpyFtncaOmu6BHNCieOmH7IP8EczxlA8DhArbzCF1l8uV1
 VfZheFFElQ2/0zWNAjvfeqr+jFXzarKkBTtfEITN4MklIynv2mbaJgAGKKPpteHfZ2TPtfZZi
 48MdMOEpuZW29M0RO/BI1VlnW5lSDhP8o9a/HaEZzYOHgnvRpgFUQ2gMUsVlJ2mafZA+Da4
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
2.25.1


