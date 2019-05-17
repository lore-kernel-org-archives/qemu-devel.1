Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A761C072AD
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEA920833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEA920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45302 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRZNu-0005T1-F8
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 05:42:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hRZM0-0004IM-76
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hRZLz-0001zH-2e
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:40 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:55332
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hRZLy-0001o4-Bs
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:39 -0400
Received: from host109-146-247-8.range109-146.btcentralplus.com
	([109.146.247.8] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hRZLC-00018L-PF; Fri, 17 May 2019 10:39:51 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Fri, 17 May 2019 10:40:21 +0100
Message-Id: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 109.146.247.8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PULL 0/8] qemu-sparc queue 20190517
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d8276573da58e8ce78dab8c46dd660efd664bcb7:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190510' into staging (2019-05-16 13:15:08 +0100)

are available in the git repository at:

  git://github.com/mcayland/qemu.git tags/qemu-sparc-20190517

for you to fetch changes up to 918b8adeb20d9635b16ffde7a413b15f6761b7f3:

  MAINTAINERS: add myself for leon3 (2019-05-17 09:17:11 +0100)

----------------------------------------------------------------
qemu-sparc queue

----------------------------------------------------------------
KONRAD Frederic (7):
      leon3: fix the error message when no bios are provided
      grlib, irqmp: get rid of the old-style create function
      grlib, gptimer: get rid of the old-style create function
      grlib, apbuart: get rid of the old-style create function
      leon3: add a little bootloader
      leon3: introduce the plug and play mechanism
      MAINTAINERS: add myself for leon3

Stephen Checkoway (1):
      hw/char/escc: Lower irq when transmit buffer is filled

 MAINTAINERS                         |   3 +-
 hw/char/escc.c                      |   7 +
 hw/char/grlib_apbuart.c             |   4 +-
 hw/intc/grlib_irqmp.c               |   3 +-
 hw/misc/Makefile.objs               |   2 +
 hw/misc/grlib_ahb_apb_pnp.c         | 269 ++++++++++++++++++++++++++++++++++++
 hw/sparc/leon3.c                    | 157 ++++++++++++++++++---
 hw/timer/grlib_gptimer.c            |   4 +-
 include/hw/misc/grlib_ahb_apb_pnp.h |  60 ++++++++
 include/hw/sparc/grlib.h            |  78 +----------
 10 files changed, 490 insertions(+), 97 deletions(-)
 create mode 100644 hw/misc/grlib_ahb_apb_pnp.c
 create mode 100644 include/hw/misc/grlib_ahb_apb_pnp.h

