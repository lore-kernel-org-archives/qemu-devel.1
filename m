Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C822C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276022242C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="KhEYzyZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276022242C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvKBC-0006Hi-9m
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 08:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <autobot.majer@seznam.cz>)
 id 1jvK9D-0004ws-8U
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:34:59 -0400
Received: from mxa2.seznam.cz ([2a02:598:2::90]:45033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <autobot.majer@seznam.cz>)
 id 1jvK9A-0000rW-5f
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:34:58 -0400
Received: from email.seznam.cz
 by email-smtpc12a.ng.seznam.cz (email-smtpc12a.ng.seznam.cz [10.23.11.105])
 id 2b360d85e98912c42e44e9b1; Tue, 14 Jul 2020 14:34:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
 t=1594730094; bh=a5trzYPjqclh9cya/iXKxEDJPM1pb3jQln9rJiZJyGU=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding;
 b=KhEYzyZt0Ma9o9XNSl//oopaXMjXq/8WKUxHp0sIcINp/HdJ/pLqOlpkW/6FO2dy0
 +iVdvCNNOeavp3rK0e2BNTLuNghCiIT+AHcl5b0elzfuJWTsNmdsR0IWo2E5YwLL0R
 fAFMVQTwJJ+bJi2jiidHlTDJcwsVIiVTrHzuItq0=
Received: from hathi.duckdns.org (2001:718:2:1654:e269:95ff:fec3:1c81
 [2001:718:2:1654:e269:95ff:fec3:1c81])
 by email-relay22.ng.seznam.cz (Seznam SMTPD 1.3.119) with ESMTP;
 Tue, 14 Jul 2020 14:34:49 +0200 (CEST)  
From: pisa@cmp.felk.cvut.cz
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 6/6] hw/net/can: Documentation for CTU CAN FD IP open
 hardware core emulation.
Date: Tue, 14 Jul 2020 14:20:19 +0200
Message-Id: <54a135d7017f3a98dc6c6f8e6b20917779e4c345.1594725647.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
References: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:598:2::90;
 envelope-from=autobot.majer@seznam.cz; helo=mxa2.seznam.cz
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>,
 Jiri Novak <jnovak@fel.cvut.cz>, Stefan Hajnoczi <stefanha@gmail.com>,
 Deniz Eren <deniz.eren@icloud.com>, Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Charvat <charvj10@fel.cvut.cz>, Jan Kiszka <jan.kiszka@siemens.com>,
 Ondrej Ille <ondrej.ille@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 MAINTAINERS  |   8 ++++
 docs/can.txt | 113 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 110 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe8139f367..d554a1cb41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2058,6 +2058,14 @@ F: hw/rx/
 F: include/hw/intc/rx_icu.h
 F: include/hw/rx/
 
+CAN bus subsystem and hardware
+M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
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


