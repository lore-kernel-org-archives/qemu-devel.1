Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D6DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555FC2082F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555FC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEAj-0001u7-OQ
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iZE4E-0004dR-3f
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iZE4C-00069i-5a
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:06:14 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:45374 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1iZE4B-0005Qa-Ss
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:06:12 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 62C7F1A226C;
 Mon, 25 Nov 2019 14:05:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 43B8A1A2251;
 Mon, 25 Nov 2019 14:05:05 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] mips: machines: Renovate coding style
Date: Mon, 25 Nov 2019 14:04:53 +0100
Message-Id: <1574687098-26689-1-git-send-email-Filip.Bozuta@rt-rk.com>
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
Cc: pburton@wavecomp.com, aleksandar.rikalo@rt-rk.com, hpoussin@reactos.org,
 amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The scripts checkpatch.pl located in scripts folder
was used to check for errors and warnings in fllowing
mips machines:

   Jazz
   Malta
   Mipssim
   R4000
   Fulong 2E
   Boston

All generated errors and warnings were corrected
and the script was ran again to make sure there
are no more errors and warnings

Note:
   Boston machine was already clear of errors
   and warnings so the boston machine files 
   were not edited.

Note:
   One error occured due to the machro #IF 0.
   That error was not corrected beacuse there
   is some reduntant code within that macro that
   might be used in future versions.


Filip Bozuta (5):
  mips: jazz: Renovate coding style
  mips: malta: Renovate coding style
  mips: mipssim: Renovate coding style
  mips: r4000: Renovate coding style
  mips: fulong 2e: Renovate coding style

 hw/display/jazz_led.c                    | 123 +++++++++++++--------------
 hw/dma/rc4030.c                          |  12 +--
 hw/isa/vt82c686.c                        |  23 ++---
 hw/mips/mips_jazz.c                      |  32 ++++---
 hw/mips/mips_malta.c                     | 139 ++++++++++++++++---------------
 hw/mips/mips_r4k.c                       |  55 +++++++-----
 hw/net/mipsnet.c                         |  44 +++++-----
 hw/pci-host/bonito.c                     |  60 +++++++------
 tests/acceptance/linux_ssh_mips_malta.py |   6 +-
 9 files changed, 266 insertions(+), 228 deletions(-)

-- 
2.7.4


