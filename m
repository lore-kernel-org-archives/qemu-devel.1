Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82E7C17447
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 13:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09F0222BD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 13:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09F0222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUt2u-0002Ux-FD
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 08:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iUt0c-0000lY-Tl
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:48:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iUt0a-0005L6-Mz
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:48:34 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:47821 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iUt0Y-0004vw-NG
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:48:32 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 048921A216E;
 Wed, 13 Nov 2019 14:47:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id DD2C81A214E;
 Wed, 13 Nov 2019 14:47:15 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] MAINTAINERS: Fine adjustment for (mostly mips) content
Date: Wed, 13 Nov 2019 14:47:01 +0100
Message-Id: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: peter.maydell@linaro.org, hpoussin@reactos.org, amarkovic@wavecomp.com,
 aleksandar.rikalo@rt-rk.com, philmd@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

v1->v2:

  - removed patch on new git infrastructure section
  - added a patch that adds two files in Malta section

The goal of this series is to:

  * reduce the amount of "unmainatined" files (not having their
    maintainer in "MAINTAINERS")
  * reduce the amount of nominally maintained files, but unmaintained
    in reality
  * increase the role of non-mips open source participants in
    maintaining and reviewing mips content

I contacted most of the involved persons regarding these changes.
I am asking all to accept new roles, since really there seems to
be no better option than this. Please help QEMU maintainance, and
best wishes to all in future activities and enavours!

I am fine with Philippe and Herve sending direct pull requests from
coresponding areas to Peter.

Aleksandar Markovic (5):
  MAINTAINERS: Add a section on UI translation
  MAINTAINERS: Adjust maintainership for Fulong 2E board
  MAINTAINERS: Adjust maintainership for Malta board
  MAINTAINERS: Adjust maintainership for R4000 systems
  MAINTAINERS: Add two files to Malta section

 MAINTAINERS | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

-- 
2.7.4


