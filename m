Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E48BC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143EF2467F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143EF2467F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcFA-0005PQ-6r
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBcDw-00045O-JV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBcDu-0008KX-Np
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:34:56 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60261)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBcDo-0008Eh-O2; Tue, 10 Mar 2020 06:34:50 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MDQNq-1j18561zoU-00ATOl; Tue, 10 Mar 2020 11:34:10 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/21] linux-user: introduce parameters to generate
 syscall_nr.h
Date: Tue, 10 Mar 2020 11:33:43 +0100
Message-Id: <20200310103403.3284090-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310103403.3284090-1-laurent@vivier.eu>
References: <20200310103403.3284090-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1wgLWl5U+m4trAd3M3frNG218zT3M77mKIgGqPClpjyB7/c3CRF
 22jqoBrucvuQeXKyikSZuxWEBAK02qWf7hu6HWyoxaf1e0LQARSCKRn7TinSElHlvZroMy6
 q2DPtlnLsU0JlXFDDoqc50LEN9pokvoqYMqSmUrCeo+W9bZXhDfJ8yH+7Zl5M7BZDGYaZJm
 6KyWWosWTZqnJQyeM1qFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eYUMUVlSGVk=:Y3+Mjp2zF9CtQtrbbVJ9Jx
 xn7SC0uh0grmswtH+DW0zquVpcqsdcSoqWzPv09SCWLB/2n1MLpFQd08BKuWALNVz2LllKUhY
 ikE5j3Mst0XIGXL5NbFWKLfCaVOUq7rnCnF+FFMSW85zeAM+sAVifpiQUUKy2ozg0NtXdGBCD
 XLZN09o0SKecAUiTgqSynfEcfJxv2kA2OApPqnOx96xnTVdAXZs8UdOJegwu0+5IgVC3ibOCM
 ZnOZsGse6jzkN8gs68W6BydVBogEeoyw127cHe8FC/duaaZY1uctK7NhnU44BuBEAIreXZxD1
 g5bH/L9bRGUHwxgl5d1ChnK/QdwiBtkk+eR/tP2lTT0ZLys6/wkyFAeFY0G0AhJecbXf/Ri4G
 W6ErkXLXvWXPxnkVUOczYS783ByJo9QOFEpsoAe36rmTukG7lzP47gVW03Jj44j5JoZrVyNtH
 /2OF3w6sN8+QWIAKOUxAHj+cId5xYl7KHz556QCNTbWcI/9eT/S3nC0/ob2m4dAMxuQVyKxRW
 Q1gAj6X9yF36nCaNFRxhS0PIfwgHJ73o09aIaMctEE4j2eAcUrg6Hk6Eked4h4IluAmWZdyLZ
 IMmBtvwOJfidPVaSHvbtBijUkEqS/hAyU7OjABhoOJ9i4rL40Lkky0FFINIre+gUNremHa43i
 HpXEvPPFBZUklSbOXNK/MBiG8SALIE45jrYa0wsqXxJfBj0dHl8oCWHyESkXoj/K6w8E4K7NX
 FP3o3ImhvaMsUPMBLZuXhGViY+Zvhhhm4Tcx3cjm4yHjva9r0Z4LRwa20M7+cgsnTirTj8PTS
 YbYdzPrgbPcHSa81Hum4ldrsrXOSPGxXXGtJsFgPHSKJUcFE2ehuK89BZhQF2U82I1RhtNu
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

This will be used when we'll import syscall.tbl from the kernel

Add a script to remove all the dependencies to syscall_nr.h
that point to source directory and not to the build directory.
The list of arch will be update while the generated files are added.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
---
 Makefile.target |  3 ++-
 configure       | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Makefile.target b/Makefile.target
index 2d43dc586a10..cb3a6fa5e704 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -128,7 +128,8 @@ ifdef CONFIG_LINUX_USER
 
 QEMU_CFLAGS+=-I$(SRC_PATH)/linux-user/$(TARGET_ABI_DIR) \
              -I$(SRC_PATH)/linux-user/host/$(ARCH) \
-             -I$(SRC_PATH)/linux-user
+             -I$(SRC_PATH)/linux-user \
+             -Ilinux-user/$(TARGET_ABI_DIR)
 
 obj-y += linux-user/
 obj-y += gdbstub.o thunk.o
diff --git a/configure b/configure
index cbf864bff1be..39e55a1ecf06 100755
--- a/configure
+++ b/configure
@@ -1887,6 +1887,17 @@ fi
 # Remove old dependency files to make sure that they get properly regenerated
 rm -f */config-devices.mak.d
 
+# Remove syscall_nr.h to be sure they will be regenerated in the build
+# directory, not in the source directory
+for arch in ; do
+    # remove the file if it has been generated in the source directory
+    rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
+    # remove the dependency files
+    find . -name "*.d" \
+           -exec grep -q "${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
+           -exec rm {} \;
+done
+
 if test -z "$python"
 then
     error_exit "Python not found. Use --python=/path/to/python"
@@ -7931,6 +7942,9 @@ echo "TARGET_ABI_DIR=$TARGET_ABI_DIR" >> $config_target_mak
 if [ "$HOST_VARIANT_DIR" != "" ]; then
     echo "HOST_VARIANT_DIR=$HOST_VARIANT_DIR" >> $config_target_mak
 fi
+if [ "$TARGET_SYSTBL_ABI" != "" ]; then
+    echo "TARGET_SYSTBL_ABI=$TARGET_SYSTBL_ABI" >> $config_target_mak
+fi
 
 if supported_xen_target $target; then
     echo "CONFIG_XEN=y" >> $config_target_mak
-- 
2.24.1


