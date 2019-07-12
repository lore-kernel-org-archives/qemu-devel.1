Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13AEC742CA
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6465208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6465208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlxay-0005LP-SK
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 11:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35167)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hlxak-0004nf-BU
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hlxaj-0003XR-As
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:36:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hlxaj-0003Wv-5B
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:36:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3BBF930024A4;
 Fri, 12 Jul 2019 15:36:08 +0000 (UTC)
Received: from redhat.com (ovpn-116-209.ams2.redhat.com [10.36.116.209])
 by smtp.corp.redhat.com (Postfix) with SMTP id 505515C232;
 Fri, 12 Jul 2019 15:36:07 +0000 (UTC)
Date: Fri, 12 Jul 2019 11:36:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190712153504.14937-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 12 Jul 2019 15:36:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/8] virtio, pc, pci: fixes, cleanups, tests
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a2a9d4adabe340617a24eb73a8b2a116d28a6b38:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190712' into staging (2019-07-12 11:06:48 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 207efa18ac9eb7085a44cad24489d0da54bc5f65:

  virtio pmem: remove transitional names (2019-07-12 10:57:27 -0400)

----------------------------------------------------------------
virtio, pc, pci: fixes, cleanups, tests

A bunch of fixes all over the place.
ACPI tests will now run on more systems: might
introduce new failure reports but that's for
the best, isn't it?

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Igor Mammedov (2):
      tests: acpi: do not require IASL for dumping AML blobs
      tests: acpi: do not skip tests when IASL is not installed

Michael S. Tsirkin (2):
      xio3130_downstream: typo fix
      pcie: consistent names for function args

Pankaj Gupta (3):
      virtio pmem: fix wrong mem region condition
      virtio pmem: remove memdev null check
      virtio pmem: remove transitional names

Stefan Hajnoczi (1):
      virtio-balloon: fix QEMU 4.0 config size migration incompatibility

 include/hw/pci/pcie.h              |  4 ++--
 include/hw/virtio/virtio-balloon.h |  2 ++
 hw/core/machine.c                  |  2 ++
 hw/pci-bridge/xio3130_downstream.c |  2 +-
 hw/virtio/virtio-balloon.c         | 28 +++++++++++++++++++++++++---
 hw/virtio/virtio-pmem-pci.c        |  4 +---
 hw/virtio/virtio-pmem.c            |  4 ++--
 tests/bios-tables-test.c           | 23 +++++++++++++++++------
 8 files changed, 52 insertions(+), 17 deletions(-)


