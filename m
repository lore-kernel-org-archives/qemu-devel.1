Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6B1C49ED6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 01:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7192085B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 01:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7192085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8E3E-0008BH-PU
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 21:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1i8E2Q-0007e4-G9
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 21:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1i8E2O-00034i-Pv
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 21:36:46 -0400
Received: from ozlabs.ru ([107.173.13.209]:39522)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1i8E2O-00034E-Km; Wed, 11 Sep 2019 21:36:44 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id BBBB3AE80020;
 Wed, 11 Sep 2019 21:36:13 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Sep 2019 11:36:33 +1000
Message-Id: <20190912013633.7950-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 107.173.13.209
Subject: [Qemu-devel] [GIT PULL for qemu-pseries] pseries: Update SLOF
 firmware image
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 0d0b906ae20d763db0f07fc74aef2c355b8474c7:

  spapr: Render full FDT on ibm,client-architecture-support (2019-09-11 16:22:29 +1000)

are available in the Git repository at:

  git@github.com:aik/qemu.git tags/qemu-slof-20190911

for you to fetch changes up to 96159c298b655506ccf65863486b062a43645099:

  pseries: Update SLOF firmware image (2019-09-11 16:27:01 +1000)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 930656 -> 930640 bytes
 roms/SLOF        |   2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)


*** Note: this is not for master, this is for pseries

