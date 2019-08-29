Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03FEC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8351B23405
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8351B23405
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Hn5-0006IE-IE
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3HcR-0005GJ-7H
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3HcO-0005K0-Sc
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:30 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45209 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i3HcO-0005FV-H8
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:28 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 6562B1A2192;
 Thu, 29 Aug 2019 12:25:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 4B4AB1A1E16;
 Thu, 29 Aug 2019 12:25:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 12:24:42 +0200
Message-Id: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 00/31] MIPS queue for August 29th, 2019
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

The following changes since commit 1b142da5f82a8fcdc7783a418592de654d5c6052:

  target/mips: Clean up handling of CP0 register 0 (2019-08-29 11:50:18 +0200)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-aug-29-2019

for you to fetch changes up to abd4393d769d9fe2333b2e83e00f911a78475943:

  target/mips: Fix emulation of ST.W in system mode (2019-08-29 12:11:14 +0200)

----------------------------------------------------------------

MIPS queue for August 29th, 2019

Highlights:

  - cleanup of handling of configuration register CP0
  - fix for ST.W emulation (in system mode only)

----------------------------------------------------------------

Aleksandar Markovic (31):
  target/mips: Clean up handling of CP0 register 0
  target/mips: Clean up handling of CP0 register 1
  target/mips: Clean up handling of CP0 register 2
  target/mips: Clean up handling of CP0 register 3
  target/mips: Clean up handling of CP0 register 4
  target/mips: Clean up handling of CP0 register 5
  target/mips: Clean up handling of CP0 register 6
  target/mips: Clean up handling of CP0 register 7
  target/mips: Clean up handling of CP0 register 8
  target/mips: Clean up handling of CP0 register 9
  target/mips: Clean up handling of CP0 register 10
  target/mips: Clean up handling of CP0 register 11
  target/mips: Clean up handling of CP0 register 12
  target/mips: Clean up handling of CP0 register 13
  target/mips: Clean up handling of CP0 register 14
  target/mips: Clean up handling of CP0 register 15
  target/mips: Clean up handling of CP0 register 16
  target/mips: Clean up handling of CP0 register 17
  target/mips: Clean up handling of CP0 register 18
  target/mips: Clean up handling of CP0 register 19
  target/mips: Clean up handling of CP0 register 20
  target/mips: Clean up handling of CP0 register 23
  target/mips: Clean up handling of CP0 register 24
  target/mips: Clean up handling of CP0 register 25
  target/mips: Clean up handling of CP0 register 26
  target/mips: Clean up handling of CP0 register 27
  target/mips: Clean up handling of CP0 register 28
  target/mips: Clean up handling of CP0 register 29
  target/mips: Clean up handling of CP0 register 30
  target/mips: Clean up handling of CP0 register 31
  target/mips: Fix emulation of ST.W in system mode

 target/mips/cpu.h       |  113 ++++-
 target/mips/op_helper.c |   16 +-
 target/mips/translate.c | 1142 ++++++++++++++++++++++++-----------------------
 3 files changed, 685 insertions(+), 586 deletions(-)

-- 
2.7.4


