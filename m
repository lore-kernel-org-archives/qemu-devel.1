Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B28C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DD120825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DD120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48933 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO2L6-0003mM-Br
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:49:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hO2Jk-0003BO-CB
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hO2Jj-00075Z-0g
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:47:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hO2Ji-00071n-Qo; Tue, 07 May 2019 11:47:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 792B0308424E;
	Tue,  7 May 2019 15:47:38 +0000 (UTC)
Received: from localhost (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DE6F460BEC;
	Tue,  7 May 2019 15:47:35 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Date: Tue,  7 May 2019 17:47:31 +0200
Message-Id: <20190507154733.28604-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 07 May 2019 15:47:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 0/2] vfio-ccw: support hsch/csch (QEMU part)
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux part of this is now merged in master, so this is mostly
a resend with a real headers update.

I'd like to queue this soon; even better would be if I could do
a header update with KVM updates as well (as then I could queue
another series at the same time).

Changes v3->v4:
- replace dummy header update with a real one
- add missing g_free [Eric]
Changes v2->v3:
- update kernel header to v4 of kernel patches
- rebased on master
Changes v1->v2:
- update kernel header to v2 of kernel patches
- rebased on master

Cornelia Huck (2):
  linux-headers: update
  vfio-ccw: support async command subregion

 hw/s390x/css.c                                |  27 ++-
 hw/vfio/ccw.c                                 | 110 +++++++++++-
 include/hw/s390x/s390-ccw.h                   |   3 +
 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h |  15 +-
 include/standard-headers/drm/drm_fourcc.h     |  63 +++++++
 include/standard-headers/linux/ethtool.h      |  37 ++--
 .../linux/input-event-codes.h                 |   8 +-
 include/standard-headers/linux/input.h        |   6 +-
 include/standard-headers/linux/pci_regs.h     |   2 +
 .../standard-headers/linux/virtio_config.h    |   6 +
 include/standard-headers/linux/virtio_ring.h  |  10 --
 .../standard-headers/rdma/vmw_pvrdma-abi.h    |   1 +
 linux-headers/asm-arm/unistd-common.h         |  26 +++
 linux-headers/asm-arm64/unistd.h              |   2 +
 linux-headers/asm-generic/mman-common.h       |   4 +-
 linux-headers/asm-generic/unistd.h            | 158 ++++++++++++++----
 linux-headers/asm-mips/mman.h                 |   4 +-
 linux-headers/asm-mips/unistd_n32.h           |  24 +++
 linux-headers/asm-mips/unistd_n64.h           |   4 +
 linux-headers/asm-mips/unistd_o32.h           |  34 ++++
 linux-headers/asm-powerpc/kvm.h               |   2 +
 linux-headers/asm-powerpc/unistd_32.h         |  34 ++++
 linux-headers/asm-powerpc/unistd_64.h         |  15 ++
 linux-headers/asm-s390/unistd_32.h            |  37 ++++
 linux-headers/asm-s390/unistd_64.h            |  18 ++
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/asm-x86/unistd_32.h             |  34 ++++
 linux-headers/asm-x86/unistd_64.h             |   4 +
 linux-headers/asm-x86/unistd_x32.h            |   4 +
 linux-headers/linux/mman.h                    |   4 +
 linux-headers/linux/psci.h                    |   7 +
 linux-headers/linux/psp-sev.h                 |  18 +-
 linux-headers/linux/vfio.h                    |   4 +
 linux-headers/linux/vfio_ccw.h                |  12 ++
 34 files changed, 661 insertions(+), 77 deletions(-)

--=20
2.20.1


