Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18574C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 13:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F7320738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 13:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F7320738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEBvk-00076U-TC
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 09:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1jEBuk-0005Yp-8S
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1jEBui-0007Hk-QN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:05:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60513 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1jEBui-00067E-Ia
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:05:44 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 1105C1A21C3;
 Tue, 17 Mar 2020 14:04:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id EDD4D1A20EC;
 Tue, 17 Mar 2020 14:04:39 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] MIPS queue for March 17th, 2020
Date: Tue, 17 Mar 2020 14:04:26 +0100
Message-Id: <1584450269-26897-1-git-send-email-aleksandar.markovic@rt-rk.com>
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

The following changes since commit a98135f727595382e200d04c2996e868b7925a01:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-request' into staging (2020-03-16 14:55:59 +0000)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-mar-17-2020

for you to fetch changes up to c0ac595b69a71fe04529b05406b7aa958b7efb99:

  MAINTAINERS: Add a file to the main MIPS section (2020-03-17 13:51:37 +0100)

----------------------------------------------------------------

MIPS queue for March 17th, 2020

  - maintaining and enhancing MIPS maintainership

----------------------------------------------------------------

Aleksandar Markovic (3):
  MAINTAINERS: Adjust maintainer's status for some MIPS items
  MAINTAINERS: Adjust maintainer's email
  MAINTAINERS: Add a file to the main MIPS section

 .mailmap    |  5 +++--
 MAINTAINERS | 21 ++++++++++++---------
 2 files changed, 15 insertions(+), 11 deletions(-)

-- 
2.7.4


