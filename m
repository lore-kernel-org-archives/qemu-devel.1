Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B51CC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01370206D7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01370206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAveh-0008Dv-24
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 09:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1jAvdq-0007pG-0s
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1jAvdp-0004Bp-02
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:06:49 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:45168)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1jAvdo-0004Am-O5
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:06:48 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail03.asahi-net.or.jp (Postfix) with ESMTPA id E8A80E328E;
 Sun,  8 Mar 2020 22:06:44 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id 6781F1C0DBF;
 Sun,  8 Mar 2020 22:06:44 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org,
	philmd@redhat.com
Subject: [PATCH] docs: Add RX target.
Date: Sun,  8 Mar 2020 22:06:37 +0900
Message-Id: <20200308130637.37651-1-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.15
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add rx-virt target specificaion document.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 docs/system/target-rx.rst | 35 +++++++++++++++++++++++++++++++++++
 docs/system/targets.rst   |  1 +
 2 files changed, 36 insertions(+)
 create mode 100644 docs/system/target-rx.rst

diff --git a/docs/system/target-rx.rst b/docs/system/target-rx.rst
new file mode 100644
index 0000000000..8540fd5218
--- /dev/null
+++ b/docs/system/target-rx.rst
@@ -0,0 +1,35 @@
+.. _RX-System-emulator:
+
+RX System emulator
+--------------------
+
+Use the executable ``qemu-system-rx`` to simulate a Virtual RX target.
+This target emulated following devices.
+
+-  R5F562N8 MCU
+
+   -  On-chip memory (ROM 512KB, RAM 96KB)
+   -  Interrupt Control Unit (ICUa)
+   -  8Bit Timer x 1CH (TMR0,1)
+   -  Compare Match Timer x 2CH (CMT0,1)
+   -  Serial Communication Interface x 1CH (SCI0)
+
+-  External memory 16MByte
+
+Example of ``qemu-system-rx`` usage for RX is shown below:
+
+Download ``<u-boot_image_file>`` from
+https://osdn.net/users/ysato/pf/qemu/dl/u-boot.bin.gz
+
+Start emulation of rx-virt::
+  qemu-system-rx -bios <u-boot_image_file>
+
+Download ``kernel_image_file`` from
+https://osdn.net/users/ysato/pf/qemu/dl/zImage
+
+Download ``device_tree_blob`` from
+https://osdn.net/users/ysato/pf/qemu/dl/rx-virt.dtb
+
+Start emulation of rx-virt::
+  qemu-system-rx -kernel <kernel_image_file> -dtb <device_tree_blob> \
+      -append "earlycon"
diff --git a/docs/system/targets.rst b/docs/system/targets.rst
index eba3111247..946f513daa 100644
--- a/docs/system/targets.rst
+++ b/docs/system/targets.rst
@@ -17,3 +17,4 @@ Contents:
    target-arm
    target-m68k
    target-xtensa
+   target-rx
--=20
2.20.1


