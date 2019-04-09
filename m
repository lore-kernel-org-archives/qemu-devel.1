Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990F7C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 07:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551B420857
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 07:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HMfczyU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551B420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36601 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDktZ-0006Ty-1Z
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 03:10:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDksA-0005gV-Ln
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 03:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDks9-0005BB-RI
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 03:08:46 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59867 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hDks8-000567-Kl; Tue, 09 Apr 2019 03:08:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44ddg72p2Tz9sRJ; Tue,  9 Apr 2019 17:08:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1554793715;
	bh=PRAxqtxmKQ+VFeim25Jljmkyi4sQ2V2lH9rPHNka+kg=;
	h=From:To:Cc:Subject:Date:From;
	b=HMfczyU/5/orqKTE9+2m0BBgLmQV8NwnoIMQNOtGteb3sD0VN5C7eniSwEE5W2EPR
	BBohjTJv/59eDgfYmkE5YXR5rlPlGd3XEVFGiCw+IZHZGq4wqRdSby4J4Vue2uBvH5
	DN9DkJovHM00tCA38kmKMDBZweX/UfDvV57qUiNs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  9 Apr 2019 17:08:28 +1000
Message-Id: <20190409070830.22430-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 0/2] ppc-for-4.0 queue 20190409
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
Cc: lvivier@redhat.com, mst@redhat.com, clg@redhat.com, qemu-devel@nongnu.org,
	groug@kaod.org, alex.williamson@redhat.com, spopovyc@redhat.com,
	qemu-ppc@nongnu.org, marcel@redhat.com,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409070828.OEGSYcZW2_TNfBAE4f62e1xvlmPmc_HqteuqqhcoWY8@z>

The following changes since commit 5263724b78f89cdea2354c8e92c53bac1b4641=
a3:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-04-08 17:53:18 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190409

for you to fetch changes up to 5cf0d326a0fec9ebac2d47c42b5f08e6bc2f686c:

  spapr_pci: Fix extended config space accesses (2019-04-09 15:03:10 +100=
0)

----------------------------------------------------------------
ppc patch queue 2019-04-09

This is a small, hard freeze, pull request which fixes a regression on
the pseries machine handling of PCI-E extended config space accesses.

----------------------------------------------------------------
Greg Kurz (2):
      pci: Allow PCI bus subtypes to support extended config space access=
es
      spapr_pci: Fix extended config space accesses

 hw/pci/pci.c             | 24 ++++++++++++++++++++++++
 hw/pci/pci_host.c        |  2 +-
 hw/ppc/spapr_pci.c       | 28 ++++++++++++++++++++++++++--
 include/hw/pci/pci.h     |  2 ++
 include/hw/pci/pci_bus.h |  1 +
 5 files changed, 54 insertions(+), 3 deletions(-)

