Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F047AC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 06:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7AA20722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 06:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="S8zyhQ6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7AA20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZUBs-0001Ze-Ea
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 01:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iZU90-0007N4-T3
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 01:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iZTvF-0004NC-Vi
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 01:02:03 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:33771 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iZTvF-0004KN-0O; Tue, 26 Nov 2019 01:02:01 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47MYFc0SZ6z9sPZ; Tue, 26 Nov 2019 17:01:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574748116;
 bh=WteWA4K1bwGnS2gljt5r/1p/9ZI5GFVL5H+kZPoC40M=;
 h=From:To:Cc:Subject:Date:From;
 b=S8zyhQ6gcyTQwmqAQKN2oruiNp0ukoYE1n5KHWkvVCVzo5kdZG6cDvhmaDBmR5aSq
 0LH3lV8kZno6GQyj+jOFxctgsUQWQCnOcW9lPd0V1Yca6fM+DV2+J6XG1cosZX8HnH
 VGsFy8c6/1/xaWMuvsz7oglpdL4r88KVH2lCbp+g=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 0/8] ppc-for-4.2 queue 20191126
Date: Tue, 26 Nov 2019 17:01:43 +1100
Message-Id: <20191126060151.729845-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 65e05c82bdc6d348155e301c9d87dba7a08a57=
01:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2019-11-25 15:47:44 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20191126

for you to fetch changes up to 59d0533b85158fdbe43bad696d4f50ec29a04c32:

  ppc/spapr_events: fix potential NULL pointer dereference in rtas_event_=
log_dequeue (2019-11-26 10:12:58 +1100)

----------------------------------------------------------------
ppc patch queue for 2019-11-26

Here's the first 4.2 hard freeze pull request from me.  This has:

  * A fix for some testcases that cause errors on older host kernels
    (e.g. RHEL7), with our new default configuration of VSMT mode
  * Changes to make VFIO devices interact properly with change of irq
    chip caused by PAPR feature negotiation.  This is more involved
    than I would like, but it's a problem in real use cases and I
    can't see an easier way to handle it.
  * Fix an error with ms6522 counters for the g3beige machine
  * Fix a coverity warning

----------------------------------------------------------------
David Gibson (5):
      kvm: Introduce KVM irqchip change notifier
      vfio/pci: Split vfio_intx_update()
      vfio/pci: Respond to KVM irqchip change notifier
      spapr: Handle irq backend changes with VFIO PCI devices
      spapr: Work around spurious warnings from vfio INTx initialization

Laurent Vivier (2):
      pseries: fix migration-test and pxe-test
      mos6522: update counters when timer interrupts are off

PanNengyuan (1):
      ppc/spapr_events: fix potential NULL pointer dereference in rtas_ev=
ent_log_dequeue

 accel/kvm/kvm-all.c    | 18 ++++++++++++++
 accel/stubs/kvm-stub.c | 12 ++++++++++
 hw/misc/mos6522.c      |  8 +++++--
 hw/ppc/spapr_events.c  |  1 +
 hw/ppc/spapr_irq.c     | 17 +++++++++++++-
 hw/vfio/pci.c          | 64 ++++++++++++++++++++++++++++++++------------=
------
 hw/vfio/pci.h          |  1 +
 include/sysemu/kvm.h   |  5 ++++
 tests/migration-test.c |  4 ++--
 tests/pxe-test.c       |  6 ++---
 10 files changed, 105 insertions(+), 31 deletions(-)

