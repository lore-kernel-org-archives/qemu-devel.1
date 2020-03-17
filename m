Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CA7C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5354C20724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5354C20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEpX-0005yC-Fb
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEEVM-0004rt-QU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEEVL-0007KP-B0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:44 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:57907)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEEVL-0007ID-1K
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:43 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MhlCg-1jisQb2D5s-00dqL6; Tue, 17 Mar 2020 16:51:37 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 13/37] linux-user: introduce parameters to generate
 syscall_nr.h
Date: Tue, 17 Mar 2020 16:50:52 +0100
Message-Id: <20200317155116.1227513-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317155116.1227513-1-laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6NHXIfcUR0Zx/J6vagcByP7zjECY1pb75OLot/bxHx5DEnytTa3
 ImrQqHPnltKG08i99/wwKKOnXvVriO2Ntm39MkEErtepNhXpl4cK+hJU0yRD0GcSaIsWI8y
 tMZ8OQ3SCy2lGsUl2aSbhAIhjjFCjhdqvIB83L6S0/m7qH1ak3T7fatOdRk6Z4ejnI8FVih
 8AvNTVEC4msCrroPDgrWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n7Oi7ACxLoo=:GRCwIB6Zwt0XwJzaea11s4
 x7jwQfblIDSoHvm2wI1oOFbIZQLf2Y4A/bNHj/AA5Z4jPPDTNLY7XEA2G9+y85Vp6IK9dEe8r
 NUGsbqUZpx8Dku1AdGJIOsM4bn8QWLfJkQ2oEjMYQAH6xehZrsZ1T/oc7BAt43cc04Vg00P3r
 eWzoJPVuRogqQgfmjP9viGthuUP2r6k57mcNPURkFxWHoOwXlv3AM9BJwBFD8SobnTCAlO5SJ
 fRzJ9Z9gqy36KeWksDEs+HjCoZT/BYskjsfN1lkhLZZ4uQeECwrhuaoesrpHgJFsieec4VdvX
 /EYEXAG64/Mz6JYK/TuzWvddgJLtY/8xD/6yYgfgnRhQt4nVj/aUYF5vkj9jdJulKrs8VMaaB
 0Q8X02ti8YaJmdIez6bo91WCwFaTVuhqqgTdaXwRaqVWQ5NfSRKl3aNZyEjnhON7BlXJ6VYzp
 YiXsV/dfwu+fEO/ClDxGoxJo5/6paRcx3cp5XvE8XQRRFMLawg6x740uG9tlal7Gmq0pVf37n
 +oVkiACwP5o1D0KTB87pqLN/Qem5+PdKG1LbxMv/y5E4+AE6NydY4WyHLD2IZGIEfVOkVi/7g
 sLxRO8/Lxgbjgta5TMS1+LeXVdyyn5TWIylFtqFkJyetqQ+UeHX5TvGNL9G8ZKpp1K611H3I1
 Qh5sAot6mhF+eT0NM34kyJh308FozqJbRq9TxlKfzZTc2FW1+WcFntxLxj0Aw0hLmOm6YS47n
 cf7xGnLG/too8awpmMlqbk/SlNYpdScmmoJ9jkUs5MonA75sr7eVTl375doJDpSo7epmyVFpR
 4+twQAsASP9B7N6hJrFFg0AUEsn4pxFVRRixH1EoGSdHMv+PpfNsOVo6iYzCRysb8x0Rsqv
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


