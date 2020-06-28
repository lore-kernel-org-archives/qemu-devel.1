Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD44C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 18:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387C420702
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 18:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387C420702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpbvw-0003vN-Bx
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 14:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpbuS-00024i-Fe; Sun, 28 Jun 2020 14:20:08 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:38343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpbuP-0005KY-3x; Sun, 28 Jun 2020 14:20:08 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 25AEC74594E;
 Sun, 28 Jun 2020 20:20:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9E8E5745712; Sun, 28 Jun 2020 20:20:00 +0200 (CEST)
Message-Id: <cover.1593367416.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 00/11] Mac Old World ROM experiment
Date: Sun, 28 Jun 2020 20:03:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

Latest version of this series with addressing review comments, adding
review tags and tweaks to the WIP CUDA I2C support so with this on top
of Mark's screaper patches (with a small fix) the ROM now plays the
startup sound but then gets confused about some memory addresses. I
don't want to debug this further so either some hints are needed what
may be needed or someone could take over and finish these.

I think at least up to patch 8 this could be merged already, the rest
needs more work.

Regards,
BALATON Zoltan

BALATON Zoltan (11):
  mac_oldworld: Allow loading binary ROM image
  mac_newworld: Allow loading binary ROM image
  mac_oldworld: Drop a variable, use get_system_memory() directly
  mac_oldworld: Drop some variables
  grackle: Set revision in PCI config to match hardware
  mac_oldworld: Rename ppc_heathrow_reset to ppc_heathrow_cpu_reset
  mac_oldworld: Map macio to expected address at reset
  mac_oldworld: Add machine ID register
  i2c: Match parameters of i2c_start_transfer and i2c_send_recv
  WIP macio/cuda: Attempt to add i2c support
  mac_oldworld: Add SPD data to cover RAM

 hw/display/sm501.c           |   2 +-
 hw/i2c/core.c                |  34 +++++-----
 hw/i2c/ppc4xx_i2c.c          |   2 +-
 hw/misc/macio/cuda.c         |  76 ++++++++++++++++++++-
 hw/pci-host/grackle.c        |   2 +-
 hw/ppc/mac.h                 |  15 ++++-
 hw/ppc/mac_newworld.c        |  22 +++---
 hw/ppc/mac_oldworld.c        | 127 ++++++++++++++++++++++++++---------
 include/hw/i2c/i2c.h         |   4 +-
 include/hw/misc/macio/cuda.h |   1 +
 10 files changed, 220 insertions(+), 65 deletions(-)

-- 
2.21.3


