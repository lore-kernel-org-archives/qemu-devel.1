Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFBEC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE5A20EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE5A20EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHjmm-0003OV-BS
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1kHjeX-0003lE-Lp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:15:57 -0400
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:46964)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@cmp.felk.cvut.cz>) id 1kHjeU-0000vv-QU
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:15:57 -0400
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 08E8EDtC043035;
 Mon, 14 Sep 2020 10:14:13 +0200 (CEST)
 (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 08E8EDLq005943; Mon, 14 Sep 2020 10:14:13 +0200
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 08E8EClk005941;
 Mon, 14 Sep 2020 10:14:12 +0200
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 6/7] hw/net/can: Documentation for CTU CAN FD IP open
 hardware core emulation.
Date: Mon, 14 Sep 2020 10:13:41 +0200
Message-Id: <6d1b8db69efc4e5cfad702d2150e1960e8f63572.1600069689.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1600069689.git.pisa@cmp.felk.cvut.cz>
References: <cover.1600069689.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 08E8EDtC043035
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached, score=-0.1, 
 required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.40,
 SPF_HELO_NONE 0.00, SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1600676068.77104@tmJ9KpDds2oLtaKslLDE6Q
Received-SPF: none client-ip=2001:718:2:1611:0:1:0:70;
 envelope-from=pisa@cmp.felk.cvut.cz; helo=relay.felk.cvut.cz
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 04:11:16
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Marek Vasut <marex@denx.de>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Jiri Novak <jnovak@fel.cvut.cz>, Stefan Hajnoczi <stefanha@gmail.com>,
 Deniz Eren <deniz.eren@icloud.com>, Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jan Charvat <charvj10@fel.cvut.cz>,
 Oliver Hartkopp <socketcan@hartkopp.net>, Ondrej Ille <ondrej.ille@gmail.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Updated MAINTAINERS for CAN bus related emulation as well.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 MAINTAINERS  |   9 ++++
 docs/can.txt | 113 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 111 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf96fa8379..c0be9bbcfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2069,6 +2069,15 @@ F: hw/rx/
 F: include/hw/intc/rx_icu.h
 F: include/hw/rx/
 
+CAN bus subsystem and hardware
+M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
+M: Vikram Garhwal <fnu.vikram@xilinx.com>
+S: Maintained
+W: https://canbus.pages.fel.cvut.cz/
+F: net/can/*
+F: hw/net/can/*
+F: include/net/can_*.h
+
 Subsystems
 ----------
 Audio
diff --git a/docs/can.txt b/docs/can.txt
index 11ed8f2d68..5838f6620c 100644
--- a/docs/can.txt
+++ b/docs/can.txt
@@ -8,13 +8,22 @@ can be connected to host system CAN API (at this time only Linux
 SocketCAN is supported).
 
 The concept of busses is generic and different CAN controllers
-can be implemented for it but at this time only SJA1000 chip
-controller is implemented.
+can be implemented.
+
+The initial submission implemented SJA1000 controller which
+is common and well supported by by drivers for the most operating
+systems.
 
 The PCI addon card hardware has been selected as the first CAN
 interface to implement because such device can be easily connected
 to systems with different CPU architectures (x86, PowerPC, Arm, etc.).
 
+In 2020, CTU CAN FD controller model has been added as part
+of the bachelor theses of Jan Charvat. This controller is complete
+open-source/design/hardware solution. The core designer
+of the project is Ondrej Ille, the financial support has been
+provided by CTU, and more companies including Volkswagen subsidiaries.
+
 The project has been initially started in frame of RTEMS GSoC 2013
 slot by Jin Yang under our mentoring  The initial idea was to provide generic
 CAN subsystem for RTEMS. But lack of common environment for code and RTEMS
@@ -22,8 +31,8 @@ testing lead to goal change to provide environment which provides complete
 emulated environment for testing and RTEMS GSoC slot has been donated
 to work on CAN hardware emulation on QEMU.
 
-Examples how to use CAN emulation
-=================================
+Examples how to use CAN emulation for SJA1000 based borads
+==========================================================
 
 When QEMU with CAN PCI support is compiled then one of the next
 CAN boards can be selected
@@ -90,18 +99,100 @@ traffic with "candump" command which is included in "can-utils".
 
   candump can0
 
+CTU CAN FD support examples
+===========================
+
+This open-source core provides CAN FD support. CAN FD drames are
+delivered even to the host systems when SocketCAN interface is found
+CAN FD capable.
+
+The PCIe borad emulation is provided for now (the device identifier is
+ctucan_pci). The defauld build defines two CTU CAN FD cores
+on the board.
+
+Example how to connect the canbus0-bus (virtual wire) to the host
+Linux system (SocketCAN used) and to both CTU CAN FD cores emulated
+on the corresponding PCI card expects that host system CAN bus
+is setup according to the previous SJA1000 section.
+
+  qemu-system-x86_64 -enable-kvm -kernel /boot/vmlinuz-4.19.52+ \
+      -initrd ramdisk.cpio \
+      -virtfs local,path=shareddir,security_model=none,mount_tag=shareddir \
+      -vga cirrus \
+      -append "console=ttyS0" \
+      -object can-bus,id=canbus0-bus \
+      -object can-host-socketcan,if=can0,canbus=canbus0-bus,id=canbus0-socketcan \
+      -device ctucan_pci,canbus0=canbus0-bus,canbus1=canbus0-bus \
+      -nographic
+
+Setup of CTU CAN FD controller in a guest Linux system
+
+  insmod ctucanfd.ko || modprobe ctucanfd
+  insmod ctucanfd_pci.ko || modprobe ctucanfd_pci
+
+  for ifc in /sys/class/net/can* ; do
+    if [ -e  $ifc/device/vendor ] ; then
+      if ! grep -q 0x1760 $ifc/device/vendor ; then
+        continue;
+      fi
+    else
+      continue;
+    fi
+    if [ -e  $ifc/device/device ] ; then
+       if ! grep -q 0xff00 $ifc/device/device ; then
+         continue;
+       fi
+    else
+      continue;
+    fi
+    ifc=$(basename $ifc)
+    /bin/ip link set $ifc type can bitrate 1000000 dbitrate 10000000 fd on
+    /bin/ip link set $ifc up
+  done
+
+The test can run for example
+
+  candump can1
+
+in the guest system and next commands in the host system for basic CAN
+
+  cangen can0
+
+for CAN FD without bitrate switch
+
+  cangen can0 -f
+
+and with bitrate switch
+
+  cangen can0 -b
+
+The test can be run viceversa, generate messages in the guest system and capture them
+in the host one and much more combinations.
+
 Links to other resources
 ========================
 
- (1) Repository with development branch can-pci at Czech Technical University
-     https://gitlab.fel.cvut.cz/canbus/qemu-canbus
- (2) GitHub repository with can-pci and our other changes included
+ (1) CAN related projects at Czech Technical University, Faculty of Electrical Engineering
+     http://canbus.pages.fel.cvut.cz/
+ (2) Repository with development can-pci branch at Czech Technical University
      https://gitlab.fel.cvut.cz/canbus/qemu-canbus
  (3) RTEMS page describing project
      https://devel.rtems.org/wiki/Developer/Simulators/QEMU/CANEmulation
  (4) RTLWS 2015 article about the project and its use with CANopen emulation
-     http://rtime.felk.cvut.cz/publications/public/rtlws2015-qemu-can.pdf
-     Slides
-     http://rtime.felk.cvut.cz/publications/public/rtlws2015-qemu-can-slides.pdf
- (5) Linux SocketCAN utilities
+     http://cmp.felk.cvut.cz/~pisa/can/doc/rtlws-17-pisa-qemu-can.pdf
+ (5) GNU/Linux, CAN and CANopen in Real-time Control Applications
+     Slides from LinuxDays 2017 (include updated RTLWS 2015 content)
+     https://www.linuxdays.cz/2017/video/Pavel_Pisa-CAN_canopen.pdf
+ (6) Linux SocketCAN utilities
      https://github.com/linux-can/can-utils/
+ (7) CTU CAN FD project including core VHDL design, Linux driver,
+     test utilities etc.
+     https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core
+ (8) CTU CAN FD Core Datasheet Documentation
+     http://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/Progdokum.pdf
+ (9) CTU CAN FD Core System Architecture Documentation
+     http://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/ctu_can_fd_architecture.pdf
+ (10) CTU CAN FD Driver Documentation
+     http://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/driver_doc/ctucanfd-driver.html
+ (11) Integration with PCIe interfacing for Intel/Altera Cyclone IV based board
+     https://gitlab.fel.cvut.cz/canbus/pcie-ctu_can_fd
-- 
2.20.1


