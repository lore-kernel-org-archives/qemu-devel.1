Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1172AC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBDC520658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDC520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aFd-0005dP-2T
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j6Z9K-0003Sb-OO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j6Z9H-0001io-JE
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:17:18 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:54075)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j6Z9H-0001hq-8k; Tue, 25 Feb 2020 07:17:15 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MtPzy-1jQ2KM3dU6-00ut5M; Tue, 25 Feb 2020 13:16:25 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/21] linux-user,
 scripts: add a script to update syscall.tbl
Date: Tue, 25 Feb 2020 13:15:50 +0100
Message-Id: <20200225121553.2191597-19-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200225121553.2191597-1-laurent@vivier.eu>
References: <20200225121553.2191597-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Gdv/WPZYt1nmwfmKJpJEYbhhIw02ojTxT82IaD84fhmBs1O8vrc
 7smQbrZNRHgv9h92LYJEz7DpnAUUq/852eZBgQJltMbR2o5yRK8r+CvgP5VzIGFr3Rj/ZL2
 qeBtBJykPrZahOWoTtjXfiBSt+IELLheBaNTc9fPcUiZilqyweclljnX2c7OfWy/8IFOLG5
 UJmpXsL9sQXdWA2seiYsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g+d2sCVJW8k=:ZTZzaOlvE8kVeiPWx+RqzN
 39aJz3cChlvXVh6+PluuDq7WhR9FvCGPWs26GHq2cX7FqLS+h1UfzKYlh+hS9m7vnTqE1CK8N
 bCFJEPcKx/1zoMgDmcgOWnf+j0tDSIATzzw7R4EoOuD/afckFlldgNQBpycIldOByILb4G/4G
 Hu6J1UgIFkKtILzR/Y/7vOrFhpta9T83cdle5B48K2w58aag6vmbt8UdO9xTSEOmZr6/+O1ea
 d030p1MqJ5VOZVBmZBC6JO4UpPKNbeUOj9Cca67luqUgt67Tc3RRk+AouqTXa5QRt90cRLg1S
 1bG33B7N5sl7OASCJH1wCuSZKOmiX8Xgen+ZZdtxRAUF4eRLAdpLFQLXupQP5gHEF2pxiHufI
 cMfy4IR5DPkZlaL7d5T5PEhvqzkfkrNIfCGnzjH2JliRtszO1Fl408uSRNIrwIkSb90qhxM/V
 poA8kVtje+7sGmpa4syLCcc1IQFva8p3Ab/nOtxhYO0iRgJz5KEOs5MdKM5EOyOSim4kw8XFL
 K1urRTWg60dsielifNEz9Lusv0C3w2Vzsrq6oZvyt0wyL3f6LrYuYX/CuqnpsjTmiRhPcpAqG
 U5ehwtoerE2XmcfMLZ+jYJ4Jk06sn9JR+8lZ7RMWyGKFLn47z4i7dWSIC6pDsMHiZUppN/f2r
 3kFtUj4uVPeFwa2IQEm8NUSA8Dn5fIFPRnUK65yobHKlTY/TGeQskZYvIjInWek0UZsUIVAap
 +63oNqBwv9Ce4eKTy+N2y8lbWrSGYUKKjRzKoNogIwudoIjIhk4lMRx+buxGzKAsESo/2eHAr
 wgklgCJPdhkJkF2rllCu/YJXvJk2J4EG1+97kDz3Cd+sd4C2Z7hMYYiGjUb9FbKLzuc3LAX
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Cornelia Huck <cohuck@redhat.com>,
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


