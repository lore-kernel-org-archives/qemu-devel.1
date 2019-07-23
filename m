Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA8AC7618E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5586E223BE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5586E223BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprst-0006V5-G5
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59721)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hprsV-0005Eu-Ky
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hprsT-0000ts-51
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:18:39 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50194 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hprsS-0000sL-TX
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:18:37 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 060651A20F6;
 Tue, 23 Jul 2019 12:18:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id DCC5A1A20DA;
 Tue, 23 Jul 2019 12:18:32 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 12:18:25 +0200
Message-Id: <1563877107-5486-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 0/2] MIPS queue for July 23rd, 2019
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

The following changes since commit 23da9e297b4120ca9702cabec91599a44255fe96:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190722' into staging (2019-07-22 15:16:48 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu-2 tags/mips-queue-jul-23-2019

for you to fetch changes up to 51229582583a4b64e93f2655153d905e4d8583d2:

  target/mips: Fix emulation of MSA pack instructions on big endian hosts (2019-07-22 19:33:09 +0200)

----------------------------------------------------------------
MIPS queue for July 23rd, 2019

Highlights:

  - a '/* fall thourgh */' patch
  - fix for MSA pack emulation on big endian hosts

----------------------------------------------------------------

Aleksandar Markovic (2):
  target/mips: Add 'fall through' comments for handling nanoMips' SHXS,
    SWXS
  target/mips: Fix emulation of MSA pack instructions on big endian
    hosts

 target/mips/msa_helper.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/mips/translate.c  |  2 ++
 2 files changed, 76 insertions(+)

-- 
2.7.4


