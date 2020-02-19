Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD66BC7114E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80AF920656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AF920656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4XTn-0006Kd-Fu
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 17:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4XSF-0004ep-BY
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4XSE-0001Y5-44
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:04:27 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:60391)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4XSB-0001Wc-8o; Wed, 19 Feb 2020 17:04:23 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQ8OG-1irOIx09PU-00M8Ed; Wed, 19 Feb 2020 23:03:43 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/20] linux-user: introduce parameters to generate
 syscall_nr.h
Date: Wed, 19 Feb 2020 23:03:14 +0100
Message-Id: <20200219220333.1411905-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219220333.1411905-1-laurent@vivier.eu>
References: <20200219220333.1411905-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EZ1DzYDfgTQrUlN1OWMWVVPjaJhLLPoykx3fDPYO82vnEsJ6lXT
 0U/A2Pifolv68qFWUQCzfzX//gV1PUEXPRNKm//k76OT7Ll3uM/41SUmJtn7iFNbNMmxUdU
 M97hj0YtA7VZ6vd0rt6BOcvb9Dwo1C8VOxL6qm63bKymwB2/VT0o28KH7slFEmIVKxDVuQX
 8x7tI/GST4Z07CA2LF4qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hqngFSB4ULU=:FV/YXf7yDyk/1zzveOnp7O
 7CPGob/EyF6bmobb5Yg6NhT59zvPRKkfuKVnI1OHI3hiuz8xJseQJkn/+2x5GRSdkB9XGW3dz
 jHD1Mnien1Kxj1Qh9xTR6i2uTvdZeCViUQeXdMXuXWPa57YldrKgMguLyXuqrwo+wqabWoi7x
 vGkgkQWckZdwhHbqEhqdODGO2o2uKtL/Vfdn4wcgWAR/BVM7Cr0uPpEI1LZz26Dpn1IVvnPld
 VMYsK9a1/BPM0L/XnzMmonOHeCPJH4Jf+RPh0ddKndSelJd8tG/xZijsewoCHVNITZ2dw5tNN
 0XZbcW+WWuIhE06Kfxo44iuO2MDPihi4PXVGvU5eW3EJmQpZyWLFYrfkxax4anPyvH3OUfZCr
 MHZHCBSeVw8k5jhCsUu1KlWVXap2RTPODTbzIegh6kTEJQdhwdjr2B2Bq34EN4gVWZj5oMOfk
 oHK9xMX9tCy4ubtrL5WEhs1ripZzOYQl4Ttps2f6rjYL3Ua+PTNLXhA+dm27M/pkfCWq33TYI
 p5DIDavP3cj35iF1ZBoIXLdIOFZDyiUHnxfiy/DDnVPzKYVj7euJnx6IbvQfkeQiPkLFylXC6
 6lrgcS6JzN7oSzW+Au42dqVWrLo8XnQGgiXEEti1yk0UNGOo3VenLqmGQfMH9AK9c3t8yVf6+
 IxtvmXlTMZfrn9iGVhzmLZ4R0S5cgHvPeUxm4SPUZDe7/IwYjsgJ9hwxospGy4o9UyEn/RYkm
 JKwPEiaFeoNDHVSqD4INkRRnuE2PD1pVwp1XlzPhTuvzfw599yVwf5llpI82dYdnLhh4knDpQ
 3+iXn6nSSqPRemrpK+eoKQf8DfdFgn1O0PL0g3boJLwVyz/+Xca+qDShURoWvCZUQ0OWCqi
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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

This will be used when we'll import syscall.tbl from the kernel

Add a script to remove all the dependencies to syscall_nr.h
that point to source directory and not to the build directory.
The list of arch will be update while the generated files are added.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2: add script to remove dependencies to syscall_nr.h in source directory

 Makefile.target |  3 ++-
 configure       | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Makefile.target b/Makefile.target
index 6e61f607b14a..9babf2643e0b 100644
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
index 6f5d85094965..795adf41195f 100755
--- a/configure
+++ b/configure
@@ -1855,6 +1855,17 @@ fi
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
@@ -7829,6 +7840,9 @@ echo "TARGET_ABI_DIR=$TARGET_ABI_DIR" >> $config_target_mak
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


