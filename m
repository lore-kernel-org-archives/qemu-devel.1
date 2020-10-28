Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28D1C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B9322267
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B9322267
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXglk-0003uQ-Q3
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 04:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXgkw-0002id-9f
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:24:30 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:51650
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXgks-000432-Nv
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:24:29 -0400
Received: from host81-158-111-11.range81-158.btcentralplus.com
 ([81.158.111.11] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXgkv-0006Q8-Sb; Wed, 28 Oct 2020 08:24:34 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Wed, 28 Oct 2020 08:23:48 +0000
Message-Id: <20201028082358.23761-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.158.111.11
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 00/10] qemu-sparc queue 20201028
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit cfc1105649947f03134294a2448ce2b2e117456f:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/acceptance-testing-20201026' into staging (2020-10-27 16:58:39 +0000)

are available in the Git repository at:

  git://github.com/mcayland/qemu.git tags/qemu-sparc-20201028

for you to fetch changes up to 0980307e705b5677d9b4158a0a0346abf5041f33:

  hw/pci-host/sabre: Simplify code initializing variable once (2020-10-28 07:59:26 +0000)

----------------------------------------------------------------
qemu-sparc queue

----------------------------------------------------------------
Mark Cave-Ayland (6):
      sparc32-dma: use object_initialize_child() for espdma and ledma child objects
      sparc32-ledma: use object_initialize_child() for lance child object
      sparc32-espdma: use object_initialize_child() for esp child object
      sparc32-ledma: don't reference nd_table directly within the device
      sabre: don't call sysbus_mmio_map() in sabre_realize()
      sabre: increase number of PCI bus IRQs from 32 to 64

Philippe Mathieu-Daudé (4):
      hw/display/tcx: Allow 64-bit accesses to framebuffer stippler and blitter
      hw/pci-host/sabre: Update documentation link
      hw/pci-host/sabre: Remove superfluous address range check
      hw/pci-host/sabre: Simplify code initializing variable once

 hw/display/tcx.c               | 18 +++++++++++++---
 hw/dma/sparc32_dma.c           | 49 +++++++++++++++++++++---------------------
 hw/pci-host/sabre.c            | 28 +++++-------------------
 hw/sparc/sun4m.c               | 21 +++++++++++-------
 hw/sparc64/sun4u.c             |  7 ++++++
 include/hw/sparc/sparc32_dma.h |  8 +++----
 6 files changed, 68 insertions(+), 63 deletions(-)

