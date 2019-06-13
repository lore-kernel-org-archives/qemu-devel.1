Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E117BC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F14208CA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F14208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45852 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbXTV-0006Ia-W2
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 17:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51510)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hbXMK-0000Gn-Od
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hbXMH-000323-OS
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:34:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hbXMG-0002s9-Up
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:34:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5207013AAE
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 21:33:40 +0000 (UTC)
Received: from gimli.home (ovpn-116-190.phx2.redhat.com [10.3.116.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 211D15C257;
 Thu, 13 Jun 2019 21:33:37 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 15:33:37 -0600
Message-ID: <156046151566.26543.17274661862206856605.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 13 Jun 2019 21:33:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/3] vfio updates 2019-06-13
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 650a379d505bf558bcb41124bc6c951a76cbc113:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190613-1' into staging (2019-06-13 15:16:39 +0100)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20190613.0

for you to fetch changes up to 201a733145751aa691e7e3b9c0f263f0c92db0c5:

  vfio/common: Introduce vfio_set_irq_signaling helper (2019-06-13 09:57:37 -0600)

----------------------------------------------------------------
VFIO updates 2019-06-13

 - Hide resizable BAR capability to prevent false guest resizing
   (Alex Williamson)

 - Allow relocation to fix bogus MSI-X hardware (Alex Williamson)

 - Condense IRQ setup into a common helper (Eric Auger)

----------------------------------------------------------------
Alex Williamson (2):
      vfio/pci: Hide Resizable BAR capability
      vfio/pci: Allow MSI-X relocation to fixup bogus PBA

Eric Auger (1):
      vfio/common: Introduce vfio_set_irq_signaling helper

 hw/vfio/common.c              |  78 +++++++++++++++
 hw/vfio/pci.c                 | 220 ++++++++++--------------------------------
 hw/vfio/platform.c            |  68 +++++--------
 include/hw/vfio/vfio-common.h |   2 +
 4 files changed, 156 insertions(+), 212 deletions(-)

