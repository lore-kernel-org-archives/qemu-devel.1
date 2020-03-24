Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E52C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130AA20714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SOv0Fo+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130AA20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGbv6-0005vA-24
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 01:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbu4-0004Z6-5B
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbu2-0001ai-SM
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:15:03 -0400
Received: from ozlabs.org ([203.11.71.1]:48227)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jGbu2-0001Zg-3k; Tue, 24 Mar 2020 01:15:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48mfZW2ZTzz9sSJ; Tue, 24 Mar 2020 16:14:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585026899;
 bh=whnxjEJPjFOEb8+ITJkcDgvca6RPHoLTg/QNs6qvY9o=;
 h=From:To:Cc:Subject:Date:From;
 b=SOv0Fo+0/16qCZLoWiRHLCwfT7Sbj6RWX9CYatifKbyMFBnlgWhb5xBXKPz7c+O/K
 M23k1Z7Fv+fC7uvSCa3n+TeY5hvQNhlhD4luKqnnS+NbV6+BA6wBFm9+Lq/+IVwy3E
 w24OfKFaDs8+Y6anEiIjbui7hlouwoj2EViZQDqk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 0/7] ppc-for-5.0 queue 20200324
Date: Tue, 24 Mar 2020 16:14:49 +1100
Message-Id: <20200324051456.256116-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit c532b954d96f96d361ca31308f75f1b95bd4df=
76:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
00323' into staging (2020-03-23 17:41:21 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200324

for you to fetch changes up to 1583794b9b36911df116cc726750dadbeeac506a:

  ppc/ppc405_boards: Remove unnecessary NULL check (2020-03-24 11:56:37 +=
1100)

----------------------------------------------------------------
ppc patch queue for 2020-03-24

Here's a final pull request before the qemu-5.0 hard freeze.

We have an implementation of the POWER9 forms of the slbia
instruction, a small cleanup and a handful of assorted fixes.

----------------------------------------------------------------
Greg Kurz (1):
      spapr: Fix memory leak in h_client_architecture_support()

Mahesh Salgaonkar (1):
      ppc/spapr: Set the effective address provided flag in mc error log.

Nicholas Piggin (2):
      target/ppc: Fix slbia TLB invalidation gap
      target/ppc: Fix ISA v3.0 (POWER9) slbia implementation

Peter Maydell (1):
      hw/ppc: Take QEMU lock when calling ppc_dcr_read/write()

Philippe Mathieu-Daud=C3=A9 (1):
      ppc/ppc405_boards: Remove unnecessary NULL check

Vincent Fazio (1):
      target/ppc: don't byte swap ELFv2 signal handler

 hw/ppc/ppc405_boards.c       |  6 ++--
 hw/ppc/spapr_events.c        | 26 ++++++++++++++++
 hw/ppc/spapr_hcall.c         |  1 +
 linux-user/ppc/signal.c      |  6 ++--
 target/ppc/helper.h          |  2 +-
 target/ppc/mmu-hash64.c      | 73 +++++++++++++++++++++++++++++++++++++-=
------
 target/ppc/timebase_helper.c | 40 +++++++++++++++---------
 target/ppc/translate.c       |  5 ++-
 8 files changed, 125 insertions(+), 34 deletions(-)

