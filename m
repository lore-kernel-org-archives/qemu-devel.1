Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA78C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6845520EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6845520EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHjfX-0003z2-Rg
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1kHja7-0001WA-90
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:11:23 -0400
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:46338)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@cmp.felk.cvut.cz>) id 1kHja4-0000Fk-OP
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:11:23 -0400
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 08E89RMg042509;
 Mon, 14 Sep 2020 10:09:27 +0200 (CEST)
 (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 08E89QrA003036; Mon, 14 Sep 2020 10:09:26 +0200
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 08E89QLE003033;
 Mon, 14 Sep 2020 10:09:26 +0200
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 0/7] CTU CAN FD core support
Date: Mon, 14 Sep 2020 10:09:01 +0200
Message-Id: <cover.1600069689.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 08E89RMg042509
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached, score=-0.1, 
 required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.40,
 SPF_HELO_NONE 0.00, SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1600675804.1066@jTEN4dzIg/i87ITDw/YapQ
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

CTU CAN FD is an open source soft core written in VHDL.
It originated in 2015 as Ondrej Ille's project at the
Department of Measurement of FEE at CTU.

Integration for Xilinx Zynq and Intel based SoCs is available
as well as support for PCIe integration of the core.

The core sources

  https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core

The controller model and QEMU CAN subsystem extension to CAN FD
has been implemented in frame of bachelor theses of Jan Charvat.
The development branch ctu-canfd in CTU local project repository

  https://gitlab.fel.cvut.cz/canbus/qemu-canbus

More CAN bus related project from Czech Technical University
in Prague, Faculty of Electrical Engineering at

  http://canbus.pages.fel.cvut.cz/

Patches v3 updates:

 - resend triggered by switch to DECLARE_INSTANCE_CHECKER
   in mainline. I try to follow mainline as time allows.

 - SJA1000, CTU CAN FD and SocketCAN support retested
   with QEMU mainline from 9/12/20 10:17 PM

 - Added Reviewed-by: Vikram Garhwal
   to reviewed and tested patches which are used as common
   CAN FD base at Xilinx

 - Added Vikram Garhwal to MAINTAINERS file as the second person
   who has interrest in QEMU CAN (FD) support and would
   like to be notified about changes and help with reviews.

 - excuse massive TO/CC list but I do not know who has and who
   does not interrest in the series. If you sent me that
   it is unwanted load for you to be patch series addressees,
   I would remove you from my git send command arguments.

Patches v2 updates:

 - CTU CAN FD IP core emulation tested on x86 host
   with big-endian MIPS MALTA target as well.
   This helped t correct Linux driver to support
   big-endian systems.

 - CTU CAN FD IP core emulation updated to pass CAN frame
   data correctly on big-endian host systems. Big-endian
   host not tested, would required whole QEMU build
   for MIPS MALTA or big-endian POWER and run it nested
   emulation, because I have no access to Linux based big-endian
   system capable for QEMU build.

 - Makefile.objs changes applied to meson.build and Kconfig.

 - The common CAN support update for CAN FD tested and reviewed
   by Vikram Garhwal from Xilinx. They base their CAN FD
   controllers emulation on our work.

 - Vikram Garhwal agrees to help with common QEMU CAN bus
   infrastructure reviews. I add him and myself into maintainers.

 - Corrected SJA1000 dependencies in Kconfig after (probably)
   automated switch to meson build from make build.

Please, let me know if somebody from recipients list does
no longer have interrest in QEMU CAN bus emulation
and I would remove you from recipients list to not load
you by uniteresting content in future.


Jan Charvat (5):
  net/can: Initial host SocketCan support for CAN FD.
  hw/net/can: sja1000 ignore CAN FD frames
  net/can: Add can_dlc2len and can_len2dlc for CAN FD.
  hw/net/can/ctucafd: Add CTU CAN FD core register definitions.
  hw/net/can: CTU CAN FD IP open hardware core emulation.

Pavel Pisa (2):
  hw/net/can: Documentation for CTU CAN FD IP open hardware core
    emulation.
  hw/net/can: Correct Kconfig dependencies after switch to meson build.

 MAINTAINERS                   |   9 +
 docs/can.txt                  | 113 +++-
 hw/net/Kconfig                |  16 +-
 hw/net/can/can_sja1000.c      |  31 +-
 hw/net/can/ctu_can_fd_frame.h | 189 +++++++
 hw/net/can/ctu_can_fd_regs.h  | 971 ++++++++++++++++++++++++++++++++++
 hw/net/can/ctucan_core.c      | 696 ++++++++++++++++++++++++
 hw/net/can/ctucan_core.h      | 127 +++++
 hw/net/can/ctucan_pci.c       | 281 ++++++++++
 hw/net/can/meson.build        |   2 +
 include/net/can_emu.h         |  12 +-
 net/can/can_core.c            |  36 ++
 net/can/can_socketcan.c       |  47 +-
 13 files changed, 2506 insertions(+), 24 deletions(-)
 create mode 100644 hw/net/can/ctu_can_fd_frame.h
 create mode 100644 hw/net/can/ctu_can_fd_regs.h
 create mode 100644 hw/net/can/ctucan_core.c
 create mode 100644 hw/net/can/ctucan_core.h
 create mode 100644 hw/net/can/ctucan_pci.c

-- 
2.20.1


