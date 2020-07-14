Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93E7C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A136522447
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="VFOfUSUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A136522447
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvJxQ-0003pd-QD
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 08:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <autobot.majer@seznam.cz>)
 id 1jvJvN-0003KE-GY
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:20:41 -0400
Received: from mxa2.seznam.cz ([2a02:598:2::90]:38563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <autobot.majer@seznam.cz>)
 id 1jvJvK-0006xK-4q
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:20:41 -0400
Received: from email.seznam.cz
 by email-smtpc10a.ng.seznam.cz (email-smtpc10a.ng.seznam.cz [10.23.11.45])
 id 0506ce8fc7b9d1ce00742abb; Tue, 14 Jul 2020 14:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
 t=1594729230; bh=wXc3KGvg1StmYaAqv0SevzSTd/zaaCRUQvMKAo/8hbw=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 b=VFOfUSUHnFX39zezERVfMls9HVXBQfjOZo8Q/R/2ICMnMjQpQP3gF/rVJgCoCwJmW
 ThrWff9rRPjvMruxzf6Zgw5NdVvgMxlqvLP94fTqJfFxT/AekSzl1zwD2qS48PM3Ci
 Rk4CS1TcvGWiL8huoVE6LF7oN6qk43O6ehdSOQCw=
Received: from hathi.duckdns.org (2001:718:2:1654:e269:95ff:fec3:1c81
 [2001:718:2:1654:e269:95ff:fec3:1c81])
 by email-relay2.ng.seznam.cz (Seznam SMTPD 1.3.119) with ESMTP;
 Tue, 14 Jul 2020 14:20:27 +0200 (CEST)  
From: pisa@cmp.felk.cvut.cz
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 0/6] CTU CAN FD core support
Date: Tue, 14 Jul 2020 14:20:13 +0200
Message-Id: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
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

Jan Charvat (5):
  net/can: Initial host SocketCan support for CAN FD.
  hw/net/can: sja1000 ignore CAN FD frames
  net/can: Add can_dlc2len and can_len2dlc for CAN FD.
  hw/net/can/ctucafd: Add CTU CAN FD core register definitions.
  hw/net/can: CTU CAN FD IP open hardware core emulation.

Pavel Pisa (1):
  hw/net/can: Documentation for CTU CAN FD IP open hardware core
    emulation.

 MAINTAINERS                   |   8 +
 docs/can.txt                  | 113 +++-
 hw/net/can/Makefile.objs      |   3 +
 hw/net/can/can_sja1000.c      |  31 +-
 hw/net/can/ctu_can_fd_frame.h | 190 +++++++
 hw/net/can/ctu_can_fd_regs.h  | 972 ++++++++++++++++++++++++++++++++++
 hw/net/can/ctucan_core.c      | 691 ++++++++++++++++++++++++
 hw/net/can/ctucan_core.h      | 127 +++++
 hw/net/can/ctucan_pci.c       | 281 ++++++++++
 include/net/can_emu.h         |  12 +-
 net/can/can_core.c            |  36 ++
 net/can/can_socketcan.c       |  47 +-
 12 files changed, 2490 insertions(+), 21 deletions(-)
 create mode 100644 hw/net/can/ctu_can_fd_frame.h
 create mode 100644 hw/net/can/ctu_can_fd_regs.h
 create mode 100644 hw/net/can/ctucan_core.c
 create mode 100644 hw/net/can/ctucan_core.h
 create mode 100644 hw/net/can/ctucan_pci.c

-- 
2.20.1


