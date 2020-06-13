Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCBDC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 13:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CAB2078E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 13:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CAB2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk6US-0004I8-5g
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 09:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jk6TH-0002Vq-V7; Sat, 13 Jun 2020 09:45:19 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:47662)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jk6TD-0002Sx-Af; Sat, 13 Jun 2020 09:45:19 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 461D1748DDB;
 Sat, 13 Jun 2020 15:45:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 20435745702; Sat, 13 Jun 2020 15:45:00 +0200 (CEST)
Message-Id: <cover.1592055375.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 0/5] Mac Old World ROM experiment
Date: Sat, 13 Jun 2020 15:36:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 09:45:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 2 with some more tweaks this now starts but drops in a Serial
Test Manager (see below) presumably because some POST step is failing,
I let others who know more about this machine figure out what's
missing from here.

Regards,
BALATON Zoltan


      1 :pci_update_mappings_add d=0x55a1bb6254a0 00:01.0 0,0xf3000000+0x80000
      1 pci_cfg_read grackle 00:0 @0x0 -> 0x21057
      1 pci_cfg_read grackle 00:0 @0xa8 -> 0x0
      1 pci_cfg_write grackle 00:0 @0xa8 <- 0x40e0c
      1 pci_cfg_read grackle 00:0 @0xac -> 0x0
      1 pci_cfg_write grackle 00:0 @0xac <- 0x12000000
      1 pci_cfg_read grackle 00:0 @0xac -> 0x12000000
      1 pci_cfg_write grackle 00:0 @0xac <- 0x2000000
      1 pci_cfg_read grackle 00:0 @0x70 -> 0x0
      1 pci_cfg_write grackle 00:0 @0x70 <- 0x11000000
      1 machine_id_read(0, 2)
      1 pci_cfg_read grackle 00:0 @0x8 -> 0x6000140
      1 pci_cfg_read grackle 00:0 @0xf0 -> 0x0
      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x12900000
      1 machine_id_read(0, 2)
      1 portA_write unimplemented
      1 CUDA: unknown command 0x22
      1 CUDA: unknown command 0x26
      3 CUDA: unknown command 0x25
      1 pci_cfg_write grackle 00:0 @0x80 <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0x88 <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0x90 <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0x98 <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0x84 <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0x8c <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0x94 <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0x9c <- 0xffffffff
      1 pci_cfg_write grackle 00:0 @0xa0 <- 0x0
      1 pci_cfg_read grackle 00:0 @0xf0 -> 0x12900000
      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x12900000
      1 machine_id_read(0, 2)
      1 pci_cfg_read grackle 00:0 @0x8 -> 0x6000140
      1 pci_cfg_read grackle 00:0 @0xf0 -> 0x12900000
      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x12940000
      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x12940000
      1 pci_cfg_write grackle 00:0 @0xf4 <- 0x40010fe4
      1 pci_cfg_write grackle 00:0 @0xf8 <- 0x7302293
      1 pci_cfg_write grackle 00:0 @0xfc <- 0x25302220
      1 pci_cfg_read grackle 00:0 @0xa0 -> 0x0
      1 pci_cfg_write grackle 00:0 @0xa0 <- 0x67000000
      1 pci_cfg_read grackle 00:0 @0xf0 -> 0x12940000
      1 pci_cfg_write grackle 00:0 @0xf0 <- 0x129c0000
 550755 Unassigned mem read 00000000f3014020
      1 
      1 >?
      1 ***************************************
      1 *                                     *
      1 *         Serial Test Manager         *
      1 *                                     *
      1 ***************************************
      1 
      1 T)  Execute a test, single test number follows command
      1 T0) Run ROM Checksum Test
      1 T1) Run Address Line Test
      1 T2) Run Data Line Test
      1 T3) Run Simple RAM Test
      1 T4) Run Mod3 Forward Test
      1 T5) Run Mod3 Reverse Test
      1 T6) Run NVRAM Test
      1 T8) Run AddrPattern Test
      1 T9) Run NTAWord Test
      1 A)  Execute all ROM-based tests
      1 Q)  Quick test
      1 X)  Exit STM (Continue booting)
      1 ?)  Print this menu
      1 
      1 >

BALATON Zoltan (5):
  mac_oldworld: Allow loading binary ROM image
  mac_oldworld: Add machine ID register
  grackle: Set revision in PCI config to match hardware
  mac_oldworld: Rename ppc_heathrow_reset reset to
    ppc_heathrow_cpu_reset
  mac_oldworld: Map macio to expected address at reset

 hw/pci-host/grackle.c |  2 +-
 hw/ppc/mac.h          | 12 +++++++++
 hw/ppc/mac_oldworld.c | 59 +++++++++++++++++++++++++++++++++----------
 3 files changed, 59 insertions(+), 14 deletions(-)

-- 
2.21.3


