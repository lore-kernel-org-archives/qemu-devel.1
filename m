Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3483FC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 22:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0683020718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 22:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0683020718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3p1v-0000bq-5k
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 17:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j3p0e-00075C-Le
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 17:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j3p0d-0000XL-KH
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 17:37:00 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:44477)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j3p0d-0000Wu-BQ; Mon, 17 Feb 2020 17:36:59 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MekKJ-1jdycw2Nwj-00amAy; Mon, 17 Feb 2020 23:36:03 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/22] linux-user: introduce parameters to generate
 syscall_nr.h
Date: Mon, 17 Feb 2020 23:35:37 +0100
Message-Id: <20200217223558.863199-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217223558.863199-1-laurent@vivier.eu>
References: <20200217223558.863199-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AjoOwfMEguODUdG2IRZDQTg+/xRc7nHY6vRtnr1YPrrAUoxwj+N
 IUJC2ePDyvCdvnBC2I6LQ8rZgJy+UGni99c2y6bfJ+YeQVZkJwayzZL4W526yHRQtSNw2p/
 nXmzU0IlfHPu7FhuCA55ykjKw3kVT81e1rTIJgdjnyXGzI4+Vu/kf1QX+QlLuFuAkFkMZvO
 YugGRRYRIFJ5Wg83Z9Vcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oaa9NziznHA=:QkUlgmFeTeY1UEWpshY6HR
 swbsJbZjDmoWRGCcydjWs2y7VSODV4lpJzXK2e1XIcPBDt6uY0uCDlFKy4XohzHsycBQcQSr3
 Q2HU6GwSSU0mwzzRP/NSeaJdML7iRLlfBYGEq/h2UHYpiDbUR0G1YkTqHzMmWXuMoVcve4lO1
 Yuz8A/LH33ErlVJWne0tQ2bQKT447ks6U6lFSEdM63DefbZTCNGjRZjhvjmWJ6+vM4TKlU1lM
 T6ifdmcUzHSZ5ENMaVLrrHo3uKxcecylMvJ8EuD+6zKoIYyNvx5Hj/c4QSG8YGkcQ7bjtXobz
 75L4dw5GXSF0riaNXaDkevhG79FNy9dK4fduIbduVTp4BpGXPwcNxPEqOG96m8nIg6BL3GxVl
 Q6/D43HBNqJ4EBz48u2md23/qBOAlWnzQvUIfhLh62yY/89xDoXxnw8Jh/q4svuCWj0JgnH+0
 J1xsfERrnbqr6xB7tD3rhUi8ALV+uNUTGM7Q0Q3l0P69o9B4gHAHE8nzcDcoODeseqDo/Mngw
 0eVHPWbIUp5ibNNqFCICIFZTESxlr1FuK/ZpnsxtXivS6kZNqUgVE1UtZE8inKGTe/O/89tMo
 HCy2aJF493KqPnaNSI8I5hyg7x8EHE/W736oJO11g2X8ubnFjH2I2W1G7zvbDnMAoq8U/V9aP
 Ou/iMExOQfrrbsAw7q6jBA57qZEBgj3ZDfcvrfSnmkpDMcxhcU9HHX36ZgI6lUOYh3Bm52Rpo
 4Hcgl85RIh+r0BQoIA6x0401pczUymqmdRyEKqxvAM/ytMLMy04QHoXsc34ngrXFeeVnDPUiF
 VbllWWC77SaR8lU3K7MIoAx+YfftGptNYIa+iDFlfnP5UFFpkCn/zfF1baOHzyMyujZhD4d
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will be used when we'll import syscall.tbl from the kernel

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 Makefile.target | 3 ++-
 configure       | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

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
index 6f5d85094965..a6778828e8e1 100755
--- a/configure
+++ b/configure
@@ -7829,6 +7829,9 @@ echo "TARGET_ABI_DIR=$TARGET_ABI_DIR" >> $config_target_mak
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


