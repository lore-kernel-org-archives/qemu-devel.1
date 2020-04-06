Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7613C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 815532054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKdHypOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815532054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOow-00079v-JV
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjs-0006o9-IR
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOji-0002fy-FC
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLOji-0002e0-8b
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id 65so16735239wrl.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=23FVCxWRdzytJIfFsLBs2sn5kGjGfAHscUs7FUshwno=;
 b=CKdHypObjrV9wfTfeDD2hmraXvw5waw+EL3CPbN/9oYhnvi1dK5xq7Iml49o1XzYHq
 R0zhfX2/n+JD5aiaKrSe+O40P1r0Mf3OdFHZN3Wvfzag6kQ+yiPT3vOTqgpbep94f+Ar
 EoaLKuTxEv5xUgxTm5URn1Av5I+fDL7tqlVefKBd/MCdJgS7qV00r0cOrZcSOTaDcaaM
 IDo6O4CPvUCZFj19+1MX4FGy4ouif5lxPFOoIMkccroymJUfWeZkJa4Y7lNBxnuKyqO+
 h+i3WLod+Nso65uajr0pbZGZq+IqH/OC1m7ANKHVtCVCF2a6vhECTCDvnztTbpUtY919
 TW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=23FVCxWRdzytJIfFsLBs2sn5kGjGfAHscUs7FUshwno=;
 b=cuOryT/9DaW1wbJcBVTwkiycenoTQ7GRG1ZZ4Mg5lSgES+9P6IpONUSFCwoRFwiJh4
 sNJZTp1FIRiEo/nZeyqA03HMn7hMFu1BkgBsDNX7l5ZJf+GVyWBHpUZzIAVBS6Jmjg5A
 ItfhOBt5KnWYDFjv41pL4Awiv0rowJW7S0tj7OMxW1lYrRm2M3B0QRDL8H5kWvAg/lHI
 Pd7WlFnmeZmvzNOTeW/SebfKJMDfsNMuob3AFHS1g5PRm2PXxOobu/bzLfH73/i+Zh5t
 p6VsAKQAs68PCiizVt9JuHi8kR0BAMFR8/XAq8eKLKzXyANvdglnMadRMRKGGyM/5ATP
 QvLQ==
X-Gm-Message-State: AGi0Pua5wUvZCMfz0h3TrT/csQ61gx+5Z+BKJl5jdkSMMgJFRovD/vZ1
 4gsxSjF4BVy4PnKHtwW8EYwtYeYs2m7k5w==
X-Google-Smtp-Source: APiQypKKU3Si+8T9cgOflFdkufU9OHnl25/51JN/n/ffu5Bkw5HliXezEQH93foh2LeYIIzVH6fH/A==
X-Received: by 2002:adf:fc4c:: with SMTP id e12mr23225776wrs.265.1586167927931; 
 Mon, 06 Apr 2020 03:12:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f187sm25163765wme.9.2020.04.06.03.12.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 03:12:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] target-arm queue
Date: Mon,  6 Apr 2020 11:11:54 +0100
Message-Id: <20200406101205.23027-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A collection of bug fixes for rc2...

The following changes since commit 146aa0f104bb3bf88e43c4082a0bfc4bbda4fbd8:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-04-03 15:30:11 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200406

for you to fetch changes up to 8893790966d9c964557ad01be4a68ef50696ace8:

  dma/xlnx-zdma: Reorg to fix CUR_DSCR (2020-04-06 10:59:56 +0100)

----------------------------------------------------------------
target-arm queue:
 * don't expose "ieee_half" via gdbstub (prevents gdb crashes or errors
   with older GDB versions)
 * hw/arm/collie: Put StrongARMState* into a CollieMachineState struct
 * PSTATE.PAN should not clear exec bits
 * hw/gpio/aspeed_gpio.c: Don't directly include assert.h
   (fixes compilation on some Windows build scenarios)
 * dump: Fix writing of ELF section
 * dma/xlnx-zdma: various bug fixes
 * target/arm/helperc. delete obsolete TODO comment

----------------------------------------------------------------
Alex Bennée (1):
      target/arm: don't expose "ieee_half" via gdbstub

Edgar E. Iglesias (5):
      dma/xlnx-zdma: Remove comment
      dma/xlnx-zdma: Populate DBG0.CMN_BUF_FREE
      dma/xlnx-zdma: Clear DMA_DONE when halting
      dma/xlnx-zdma: Advance the descriptor address when stopping
      dma/xlnx-zdma: Reorg to fix CUR_DSCR

Peter Maydell (5):
      hw/arm/collie: Put StrongARMState* into a CollieMachineState struct
      target/arm: PSTATE.PAN should not clear exec bits
      target/arm: Remove obsolete TODO note from get_phys_addr_lpae()
      hw/gpio/aspeed_gpio.c: Don't directly include assert.h
      dump: Fix writing of ELF section

 dump/dump.c           |  2 +-
 hw/arm/collie.c       | 33 +++++++++++++++++++++++++-----
 hw/dma/xlnx-zdma.c    | 56 ++++++++++++++++++++++++++-------------------------
 hw/gpio/aspeed_gpio.c |  2 --
 target/arm/gdbstub.c  |  7 ++++++-
 target/arm/helper.c   | 13 +++++-------
 6 files changed, 69 insertions(+), 44 deletions(-)

