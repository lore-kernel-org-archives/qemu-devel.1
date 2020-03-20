Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12E1C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48FB2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48FB2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJWt-0007fx-Rs
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFJVp-0005lw-D5
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFJVo-0007lH-85
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:41 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43261)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFJVn-0007jU-Vb
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:40 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MG9Xu-1j3D5L1mAO-00GZAE; Fri, 20 Mar 2020 16:24:27 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v4 08/32] linux-user: introduce parameters to generate
 syscall_nr.h
Date: Fri, 20 Mar 2020 16:23:44 +0100
Message-Id: <20200320152408.182899-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
References: <20200320152408.182899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KtfwIWII0JsyZB3RE613lSMz2RWmmq23/dxXxy4N+o/0yCmyw7+
 5JgSfd8IK3+QG7oTnf2rUsB8A2WDwjvitC/PADkHKqchX/o8BKPWmFc0zEndWi1kEnWbFdp
 tIe+WBGctSYMGZm3iRCrMf7vw2t2wk6ZPtelR3wjqPSGZ28Hm8ZP+TnZRbtnVw19sNFl0VC
 RqPxJZnK435ZtXl5F3drw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sWIbpB1X3Gg=:djNDv5gpjuuA/goKykfNNo
 7SDkB6YlCi1SNXGcbXkEKXbEzmCBNTjxm7+2AQrHo/tjtw1TWwicj82kxZD34V7EYLWTnmQqH
 P2clgB/PjR1R6dUEJz+gL0qxTic/rp/augGHeQto52/C1DujBQSXqH8J1xp0TvnzR6TkjUmBX
 pXpCqAd6leBWmdm1cY8602LL6XfqlRGe/91xphhs1xFuMvx7tLehpK1WAhXAAzh9MRo3D+lFn
 Nyxs5idawDbLX0ZGvgpKKG+DGGOUxIV3DrDJgf9fY7fWynMOw8oJkQ+9vzAmKN2dvw9niuGDi
 VgI3StPE78sdnbgNYh57iNf1oKO1Xil0umfBIejeWZXV74EvyTaFRNM66PsSZCNzUiljbSeC8
 5J68/NcWD3W+dcz4+g8iRB6fPqrQc3EQSazTz1lh6dUlhkjt3LJE3deh7umkIBhPwViQK47mf
 EEI5H6pkr+QyJjF4fKqfuMy57aSF6WOfmCbO3q6dcV+oenKSZ/ARnuXrB9CEGN6yfVD6UQaBG
 NiWno7BeadWBJnvutMvMAus7jP5Wz5XfGOlx3NpBzAnOR9R8Ia8W9NyJdsF+yCOyouoAV3iPp
 Jnsly5hH10r3Znjd0v+HyuFYd59+6fAiuU9t69LpMY4Rc1TSwGBXoLfALerY6ILOEZmnimbnl
 +Bx8D2gnbGY3B5hsV9OktFgQLhhVu75mStjfVhlJlIcuvzdWEtyEoK0hFFFaOhj/qdWVw0eNH
 xHLXQtdRGZLpr4qBLJQ9NL+ktLz/m5kSVl2lFChx60WnWJo8wkV5OgokIouVeq5+2pw5xEPrr
 bEog6C0oxOpHDVmejjijDr1N7K7e2IMtwxzA2KZdt2x3ZZnpDH9oLdmhRAdFoP//SV4tbPf
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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

This will be used when we'll import syscall.tbl from the kernel

Add a script to remove all the dependencies to syscall_nr.h
that point to source directory and not to the build directory.
The list of arch will be update while the generated files are added.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200310103403.3284090-2-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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
2.25.1


