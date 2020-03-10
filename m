Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF453C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C7A24649
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C7A24649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcFv-0006gw-Pl
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBcEa-000502-SP
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBcEZ-0001Ip-2o
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:35:36 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33355)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBcEU-00015C-Jh; Tue, 10 Mar 2020 06:35:30 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mwfn8-1jZLOb1d18-00yCMx; Tue, 10 Mar 2020 11:34:35 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 18/21] linux-user,
 scripts: add a script to update syscall.tbl
Date: Tue, 10 Mar 2020 11:34:00 +0100
Message-Id: <20200310103403.3284090-19-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310103403.3284090-1-laurent@vivier.eu>
References: <20200310103403.3284090-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:s1bzgPY2Vf/MOHs2PEGnkQKPE33w0q71iaBmCRUZuR3rWmD0jVR
 2UqlgrXvbuNKcK+t+y5MbuLoDMB/hL+/BuLN31a8bHRw4b6cjweaA+7Pd96pgKfRZWhy/c5
 LXLXxpMigr6g7kEbAo3MrkfnJCVrWHCmwIANPOELbTeiNr98gs7bmtfXu12B6Rp7oNdBK63
 dewECRzzm6W3G7mJ4gfmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:twoqnOooQRk=:ZiUuaIOqFKWfgEDTPgAI+S
 9tvBOvRLflPbbYeX8csLHlKO0IYvskEI9V1YdvxCJeqiTAvS3TiW4zwQo2wr6uoMW10iTA977
 GXda6MIBf16YPOamwY2M83vYnvagAGHt+E6EnsRKzxxtnf0iJm3jlKAtm84O2rI534iIzR4O3
 W6l+4twpNSosChRx3dnRry30DrpjELuilAnb31bhGRV7tttBqbIgdKsoqKcNIkWSStaID01zV
 QlgfpdQb+SdDUd1MmcfDE3lnWZNkG7l+oQV2obaiU/Q4N0c8P4RkkzxyjCDSl9IeajicjlSYF
 SZha2O/SRy1AXHpHKnhMksHW+iH/vAt9kxdlJQRVzL5zNXJi3sWXDTO9U/6m3lKXlZnXEiQm/
 USAseNz1FVlmhx+NP1xM8bECaiUN9TalRBb5QVfO0U72frtIrg3LkDUUz+7zNVVmGcXfnpaKY
 SOMzcR5M8kCj06tudbGO7CjpC08Aku3TDJExF31uAhXtGTSqNQgZBWvzXtUaZ6vGOp7iZROLu
 7FDH6A7v/sXkvCQtvvmhG+nMnBHJazZmywFUMYM09Nm9+GufBALZe/tNqQby4P/rTniCzTumj
 MWo/3rZYjFmEBjmKxdEyMaFCGVkl1ciqUW65hwDJxN7cl90IGbAXYbwhz3kSivJNq8nLwta8A
 sR1LL3LuVjkpihBI9DUHt2kOU5byqwtzBeYUOkx8a7r8lDdawJrj+Kuk39IRGl2Md+oLn0rQt
 IdNScroMdqhe5nDT6SNuqMUiSgMlXNlKZpf1OZISYXhHXJqi0jVB5LrHVmkacr3Df7r0DktL7
 kwEx8qVeVQCHjY75lvSPDSjfdfLeqslb2qJyt9bJpBftJUe1vZPBwa9hOWEQMjpX/acXJqt
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
 Richard Henderson <richard.henderson@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

scripts/update-syscalltbl.sh has the list of syscall.tbl to update and
can copy them from the linux source directory

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
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


