Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A692C742A8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD0A208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Krjdh38L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD0A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlp0E-0006It-Gi
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 02:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hlozt-0005MX-Eo
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hlozs-00041E-C8
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:25:33 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47375 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hlozr-0003vP-At; Fri, 12 Jul 2019 02:25:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45lNFn0tXCz9sBt; Fri, 12 Jul 2019 16:25:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562912717;
 bh=7Qvz8vwSGkDuAOX/MDRF42S6q9GHLHS19eWtgv3BIt0=;
 h=From:To:Cc:Subject:Date:From;
 b=Krjdh38LQQrHBnQtYC6vhePVdFbVSHY/IjRZZgE5Nq25dBWyYgbPlZIU3Gh++n8Lz
 SoDpoXf2OS1KIsa/0WPo3lNP+81uVTDuAt3j5r11I1otaYP1k3hcxJjEkDx/JCLMmV
 FLdbZH2NAeX98yFaKmLQM+UY+ppzmwCo+V2Euuys=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 12 Jul 2019 16:25:07 +1000
Message-Id: <20190712062509.31370-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 0/2] ppc-for-4.1 queue 20190712
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
Cc: gkurz@redhat.com, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9411db8f37c64b9adb3e4b393c623a5760bcb8=
47:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-07-11 11:58:14 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190712

for you to fetch changes up to 38298611d5a87d2739d0a21d5f9e47ba43570c22:

  xics/kvm: Always set the MASKED bit if interrupt is masked (2019-07-12 =
15:50:00 +1000)

----------------------------------------------------------------
ppc patch queue for 2019-07-12

First 4.1 hard freeze pull request.  Not much here, just a bug fix for
the XICS interrupt controller and a SLOF firmware update to fix a bug
with IP discovery when there are multiple NICs.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

Greg Kurz (1):
      xics/kvm: Always set the MASKED bit if interrupt is masked

 hw/intc/xics_kvm.c |   3 +++
 pc-bios/README     |   2 +-
 pc-bios/slof.bin   | Bin 926392 -> 926432 bytes
 roms/SLOF          |   2 +-
 4 files changed, 5 insertions(+), 2 deletions(-)

