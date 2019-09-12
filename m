Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864C8C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613BF206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613BF206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8S3H-0007xA-Sm
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 12:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i8S0g-0005p4-BS
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i8S0e-0006Jq-OC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:31:53 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:37105 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i8S0e-00061p-Hc
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:31:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 8FEAE1A2168;
 Thu, 12 Sep 2019 18:30:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 76DBE1A1E25;
 Thu, 12 Sep 2019 18:30:46 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 18:30:36 +0200
Message-Id: <1568305840-12550-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 0/4] MIPS queue for September 12th, 2019
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The following changes since commit 6d2fdde42c3344099262431df6a3f429c509291d:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-100919-2' into staging (2019-09-10 14:52:09 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-sep-12-2019

for you to fetch changes up to d1cc1533509012916dceeb7f23accda8a9fee85c:

  target/mips: gdbstub: Revert commit 8e0b373 (2019-09-12 18:25:34 +0200)

----------------------------------------------------------------

MIPS queue for September 12th, 2019

Highlights:

  - switch to using do_transaction_failed() hook for MIPS' Jazz boards
  - revert a commit that caused problems with gdb's packet 'g' for MIPS

----------------------------------------------------------------

Libo Zhou (1):
  target/mips: gdbstub: Revert commit 8e0b373

Peter Maydell (3):
  hw/mips/mips_jazz: Override do_transaction_failed hook
  target/mips: Switch to do_transaction_failed() hook
  hw/mips/mips_jazz: Remove no-longer-necessary override of
    do_unassigned_access

 hw/mips/mips_jazz.c     | 47 +++++++++++++++++++++++++++++++++--------------
 target/mips/cpu.c       |  2 +-
 target/mips/gdbstub.c   |  3 +--
 target/mips/internal.h  |  8 +++++---
 target/mips/op_helper.c | 24 ++++++++----------------
 5 files changed, 48 insertions(+), 36 deletions(-)

-- 
2.7.4


