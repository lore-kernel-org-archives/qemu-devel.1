Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CADC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971D2206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971D2206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKiR-0003S3-Ri
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58292)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hiKMl-0005jA-3D
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hiKMj-00089v-Sb
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hiKMj-000893-Jp
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D4CE3082AF2;
 Tue,  2 Jul 2019 15:06:30 +0000 (UTC)
Received: from redhat.com (ovpn-124-209.rdu2.redhat.com [10.10.124.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92DDB1001B18;
 Tue,  2 Jul 2019 15:06:28 +0000 (UTC)
Date: Tue, 2 Jul 2019 11:06:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190702150606.24851-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 02 Jul 2019 15:06:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/22] virtio, pc, pci: features, fixes, cleanups
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

The following changes since commit 7fec76a02267598a4e437ddfdaeaeb6de09b92=
f3:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-06-=
24' into staging (2019-07-01 11:28:28 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to a360cd11de5ae59db55e128fd209290c777eb177:

  docs: avoid vhost-user-net specifics in multiqueue section (2019-07-01 =
10:39:35 -0400)

----------------------------------------------------------------
virtio, pc, pci: features, fixes, cleanups

virtio-pmem support.
libvhost user mq support.
A bunch of fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Hildenbrand (4):
      virtio-pci: Allow to specify additional interfaces for the base typ=
e
      hmp: Handle virtio-pmem when printing memory device infos
      numa: Handle virtio-pmem in NUMA stats
      pc: Support for virtio-pmem-pci

Eduardo Habkost (1):
      pc: Move compat_apic_id_mode variable to PCMachineClass

Marc-Andr=C3=A9 Lureau (1):
      virtio-pci: fix missing device properties

Michael S. Tsirkin (4):
      pcie: don't skip multi-mask events
      pcie: check that slt ctrl changed before deleting
      pcie: work around for racy guest init
      pcie: minor cleanups for slot control/status

Pankaj Gupta (3):
      virtio-pmem: add virtio device
      virtio-pmem: sync linux headers
      virtio-pci: Proxy for virtio-pmem

Stefan Hajnoczi (4):
      libvhost-user: add vmsg_set_reply_u64() helper
      libvhost-user: support many virtqueues
      libvhost-user: implement VHOST_USER_PROTOCOL_F_MQ
      docs: avoid vhost-user-net specifics in multiqueue section

Xie Yongji (5):
      virtio: add "use-started" property
      virtio: Set "start_on_kick" for legacy devices
      virtio: Set "start_on_kick" on virtio_set_features()
      virtio: Make sure we get correct state of device on handle_aio_outp=
ut()
      virtio: Don't change "started" flag on virtio_vmstate_change()

 qapi/misc.json                               |  28 +++-
 contrib/libvhost-user/libvhost-user-glib.h   |   2 +-
 contrib/libvhost-user/libvhost-user.h        |  10 +-
 hw/virtio/virtio-pci.h                       |   1 +
 hw/virtio/virtio-pmem-pci.h                  |  34 +++++
 include/hw/i386/pc.h                         |   3 +
 include/hw/pci/pci.h                         |   1 +
 include/hw/pci/pcie.h                        |   2 +
 include/hw/virtio/virtio-pmem.h              |  49 +++++++
 include/hw/virtio/virtio.h                   |  23 +++-
 include/standard-headers/linux/virtio_ids.h  |   1 +
 include/standard-headers/linux/virtio_pmem.h |  35 +++++
 contrib/libvhost-user/libvhost-user-glib.c   |  12 +-
 contrib/libvhost-user/libvhost-user.c        |  66 ++++++----
 contrib/vhost-user-blk/vhost-user-blk.c      |  16 ++-
 contrib/vhost-user-gpu/main.c                |   9 +-
 contrib/vhost-user-input/main.c              |  11 +-
 contrib/vhost-user-scsi/vhost-user-scsi.c    |  21 ++-
 hw/block/vhost-user-blk.c                    |   4 +-
 hw/core/machine.c                            |   1 +
 hw/i386/pc.c                                 |  94 +++++++++++--
 hw/i386/pc_piix.c                            |   3 +-
 hw/pci-bridge/pcie_root_port.c               |   5 +-
 hw/pci-bridge/xio3130_downstream.c           |   5 +-
 hw/pci/pcie.c                                |  40 +++++-
 hw/virtio/virtio-pci.c                       |  29 ++--
 hw/virtio/virtio-pmem-pci.c                  | 131 +++++++++++++++++++
 hw/virtio/virtio-pmem.c                      | 189 +++++++++++++++++++++=
++++++
 hw/virtio/virtio.c                           |  53 ++++----
 monitor/hmp-cmds.c                           |  27 ++--
 numa.c                                       |  24 ++--
 tests/vhost-user-bridge.c                    |  42 ++++--
 docs/interop/vhost-user.rst                  |  21 +--
 hw/i386/Kconfig                              |   1 +
 hw/virtio/Kconfig                            |  10 ++
 hw/virtio/Makefile.objs                      |   2 +
 36 files changed, 844 insertions(+), 161 deletions(-)
 create mode 100644 hw/virtio/virtio-pmem-pci.h
 create mode 100644 include/hw/virtio/virtio-pmem.h
 create mode 100644 include/standard-headers/linux/virtio_pmem.h
 create mode 100644 hw/virtio/virtio-pmem-pci.c
 create mode 100644 hw/virtio/virtio-pmem.c


