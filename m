Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAE1C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7512051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7512051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtHw-0001BG-BJ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsQI-0008Ck-Av
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsQG-0005is-9k
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:02 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58777)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsQF-0005YK-U5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:00 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGgRW-1j8uKv3Fnm-00Dnbh; Mon, 16 Mar 2020 17:16:20 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 14/38] linux-user: introduce parameters to generate syscall_nr.h
Date: Mon, 16 Mar 2020 17:15:26 +0100
Message-Id: <20200316161550.336150-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:04D9jpp5Jxz6iBsjonAr6GKhTALGknq+EQKLql4B8xYydCedLSZ
 1JkDexlQa3569QLopFe8p8kHuKA5oUjj0L5tU6ghUMUNnCUd6p2fYbR2rZg8vuwL+fi4J2Q
 6/OPdabpoA/ncalBSgbT/i0wT44Np/wtVmkY+sV9QFFDUcVSTFdeRzltwqk6nAfQ7S/Udhy
 UJGXi4ggZikMNAKWm4rwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VYX4WaDV9WU=:cOGmEbrtQ9D7cIS/kXJ/Im
 43IbGSs5h1QQfDnSUMdZGSsk0hfrkXPvbazi6a5oiv+GcW4lM9yi/rGOrOO2oyG97fZ5zev2/
 uuHA7TUjLJZ0ZRG6ahwM1OI2UkP1CPMJ1tuiaR3CTs+Zpl+uGL7cagt+/sH/GtO5nP42B9rYg
 qotLajJkOD0Vi77Zvp9RDGaXUamnL9bWX9IERCAKDEgd8HlQXadxU6BREwKj2CiYpQ5QuYbim
 nXZEvcY9I2NUektozkQegjxXbbBmT3RpdDhlbCRQxyYKW6p7YJ1RT1WzIMi87Yzvud1TqFicG
 sGTCBm9sac7rNZc9H6lnPeFBSYSp/FhlgsecZSArK7hQXuO7yBU71i06w8YlTAbrMRHkiOwZp
 /thX/uCnD3QMKKFk1hDTbW59Px/SMuMrHpQ561dploxy+yLZoezGcqPnOlsUo+eRK/RBPWCg5
 P4AZXNDDMGoCBBP0lhaOUTRUTh2kkxNV8IYdJPbczku1sGC1koXI1uedJuntb72plgQWbfqBH
 Tkeyyspgwz8xzQN/cSm+C4Ks1ZpO7qL5vf9vOG5DLqJqgkrkNvDBCJj4uH+pNwbbaw1Tre+y3
 IH2GOYqmKzqxMGPme3TFjnf7zRJzNZezuGfEa7MOyAXxswBtOH440F2Nxh2VCadrb8j1yF7+x
 hvAAQ6F5ZaB9z9zkQRGWoP01A762Ew5/SbjNOSFfWSnmVJ/zvW+WbxfiJfg2oRdcrWxU0FGb6
 6faZSHXZ7RbwFd/svNpZxoV39IQIVNSiBgrZKNHxCPNirz6Tbh7sn9q514x7fCzu9SEpWVTOc
 Cvc0YJRLQ/MHBoaDMFIGYd4/1XFJKm+TzdY3U7+YiTyfqjcq1l4iBDcUVzr4YuoigzCn77w
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
2.24.1


