Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C888C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D5A2077C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D5A2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52074 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hItfg-0002lf-1x
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 07:33:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItda-0001cr-35
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItdZ-0005W2-5G
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41149 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hItdY-0004AY-TO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 433F61A2438;
	Tue, 23 Apr 2019 13:29:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 28FB41A1E4D;
	Tue, 23 Apr 2019 13:29:53 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 13:29:34 +0200
Message-Id: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 0/8] target/mips: Clean up misc code segments
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423112934.koRBlwMSUayj-5MYNIUbVwHoDrMps6EtR0iZ4bBPv2w@z>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This series removes a number of checkpatch errors and warnings
to improve code readibility and maintainability.

Aleksandar Markovic (4):
  target/mips: Clean up dsp_helper.c
  target/mips: Clean up lmi_helper.c
  target/mips: Fix some space checkpatch errors in translate.c
  target/mips: Fix if-else arms checkpatch errors in translate.c

Jules Irenge (4):
  target/mips: Add or remove space to fix checkpatch errors
  target/mips: Realign comments to fix checkpatch warnings
  target/mips: Remove a space before open parenthesis to fix checkpatch
    errors
  target/mips: Add * to comments and realign them to fix checkpatch
    warnings

 target/mips/cp0_timer.c  |  26 +++---
 target/mips/cpu.h        | 211 ++++++++++++++++++++++-------------------
 target/mips/dsp_helper.c |  40 +++++---
 target/mips/lmi_helper.c |   8 +-
 target/mips/translate.c  | 238 +++++++++++++++++++++++++++--------------------
 5 files changed, 301 insertions(+), 222 deletions(-)

-- 
2.7.4


