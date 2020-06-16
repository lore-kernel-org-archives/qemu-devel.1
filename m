Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF213C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADB2207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADB2207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlC2e-00043I-QY
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jlC1j-0001vS-P8; Tue, 16 Jun 2020 09:53:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:36186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jlC1h-0002PD-HQ; Tue, 16 Jun 2020 09:53:23 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C7282748DD1;
 Tue, 16 Jun 2020 15:53:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A97FD7482CA; Tue, 16 Jun 2020 15:53:17 +0200 (CEST)
Message-Id: <cover.1592315226.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 00/11] Mac Old World ROM experiment
Date: Tue, 16 Jun 2020 15:47:06 +0200
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

v5: Rebased on master, added some more clean ups, CUDA i2c is still to
be sorted out, help with that is welcome.

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
  macio: Add dummy screamer register area
  WIP macio/cuda: Attempt to add i2c support
  mac_oldworld: Add SPD data to cover RAM

 hw/misc/macio/cuda.c         |  62 ++++++++++++++++-
 hw/misc/macio/macio.c        |  34 ++++++++++
 hw/pci-host/grackle.c        |   2 +-
 hw/ppc/mac.h                 |  15 ++++-
 hw/ppc/mac_newworld.c        |  22 +++---
 hw/ppc/mac_oldworld.c        | 127 ++++++++++++++++++++++++++---------
 include/hw/misc/macio/cuda.h |   1 +
 7 files changed, 219 insertions(+), 44 deletions(-)

-- 
2.21.3


