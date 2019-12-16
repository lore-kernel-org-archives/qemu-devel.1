Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0709EC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEB7206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEB7206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igpnf-0003Xu-KU
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 07:48:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1igpjO-0006kF-3G
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1igpjL-0006ue-LB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:44:09 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:42886 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1igpjL-0005lE-ES
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:44:07 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 8C6031A20B3;
 Mon, 16 Dec 2019 13:43:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 6760C1A1D72;
 Mon, 16 Dec 2019 13:43:01 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] MIPS queue for December 16th, 2019
Date: Mon, 16 Dec 2019 13:42:41 +0100
Message-Id: <1576500172-11264-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

The following changes since commit 084a398bf8aa7634738e6c6c0103236ee1b3b7=
2f:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-12-13 18:14:07 +0000)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-dec-16-2019

for you to fetch changes up to 5d480ddde36649a652152bf35f57ccad38f052d6:

  MAINTAINERS: Add a file to MIPS section (2019-12-16 13:16:15 +0100)

----------------------------------------------------------------

MIPS queue for December 16th, 2019

  - contains only maintenance/cleanup items

----------------------------------------------------------------

Aleksandar Markovic (5):
  MAINTAINERS: Add a section on UI translation
  MAINTAINERS: Adjust maintainership for Fulong 2E board
  MAINTAINERS: Adjust maintainership for Malta board
  MAINTAINERS: Add three files to Malta section
  MAINTAINERS: Add a file to MIPS section

Filip Bozuta (5):
  mips: jazz: Renovate coding style
  mips: malta: Renovate coding style
  mips: mipssim: Renovate coding style
  mips: r4000: Renovate coding style
  mips: fulong 2e: Renovate coding style

Philippe Mathieu-Daud=C3=A9 (1):
  hw/mips: Deprecate the r4k machine

 MAINTAINERS                              |  17 ++-
 hw/display/jazz_led.c                    | 123 +++++++++++-----------
 hw/dma/rc4030.c                          |  12 ++-
 hw/isa/vt82c686.c                        |  23 +++--
 hw/mips/mips_jazz.c                      |  32 +++---
 hw/mips/mips_malta.c                     | 172 ++++++++++++++++---------=
------
 hw/mips/mips_r4k.c                       |  56 ++++++----
 hw/net/mipsnet.c                         |  42 ++++----
 hw/pci-host/bonito.c                     |  60 ++++++-----
 qemu-deprecated.texi                     |   5 +
 tests/acceptance/linux_ssh_mips_malta.py |   6 +-
 11 files changed, 300 insertions(+), 248 deletions(-)

--=20
2.7.4


