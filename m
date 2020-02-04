Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C41C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 06:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051BB2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 06:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051BB2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyrwN-0005EF-3x
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 01:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iyrv7-00046x-7x
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:42:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iyrv5-0001HO-EI
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:42:48 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:56820 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iyrv5-000195-7i
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:42:47 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 7F9291A1D16;
 Tue,  4 Feb 2020 07:42:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 5E3371A0EEE;
 Tue,  4 Feb 2020 07:42:43 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] MIPS queue for February 4th, 2020
Date: Tue,  4 Feb 2020 07:42:29 +0100
Message-Id: <1580798552-703-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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

The following changes since commit f31160c7d1b89cfb4dd4001a23575b42141cb0ec:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20200203' into staging (2020-02-03 11:14:24 +0000)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-feb-04-2020

for you to fetch changes up to 78e91b612eb746c7916cce3ea91f709b916b007c:

  target/mips: Separate FPU-related helpers into their own file (2020-02-03 23:55:53 +0100)

----------------------------------------------------------------

MIPS queue for February 4th, 2020

  Content:

    - fix for a recent regression in LL/SC
    - mechanical reorganization of files containing helpers

  Note:

    - six checkpatch errors and two warnings are benign and should be
      ignored

----------------------------------------------------------------

Aleksandar Markovic (2):
  target/mips: Separate CP0-related helpers into their own file
  target/mips: Separate FPU-related helpers into their own file

Alex Richardson (1):
  target/mips: Fix ll/sc after 7dd547e5ab6b31e7a0cfc182d3ad131dd55a948f

 target/mips/Makefile.objs |    5 +-
 target/mips/cp0_helper.c  | 1678 +++++++++++++++++
 target/mips/fpu_helper.c  | 1911 ++++++++++++++++++++
 target/mips/op_helper.c   | 4422 +++++----------------------------------------
 4 files changed, 4044 insertions(+), 3972 deletions(-)
 create mode 100644 target/mips/cp0_helper.c
 create mode 100644 target/mips/fpu_helper.c

-- 
2.7.4


