Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48E0C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:01:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F8120881
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F8120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7xN-0002ew-Oc
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:01:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hP7p4-0003fk-II
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hP7p2-0007qL-SI
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:52:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hP7p2-0007oe-Kc
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:52:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8867EA404A;
	Fri, 10 May 2019 15:52:30 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (unknown [10.65.16.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7C85160BFB;
	Fri, 10 May 2019 15:52:03 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
To: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
	qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Date: Fri, 10 May 2019 21:21:56 +0530
Message-Id: <20190510155202.14737-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 10 May 2019 15:52:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v8 0/6] virtio pmem driver
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
Cc: pagupta@redhat.com, jack@suse.cz, mst@redhat.com, jasowang@redhat.com,
	david@fromorbit.com, lcapitulino@redhat.com,
	adilger.kernel@dilger.ca, zwisler@kernel.org,
	aarcange@redhat.com, dave.jiang@intel.com, jstaron@google.com,
	darrick.wong@oracle.com, vishal.l.verma@intel.com,
	david@redhat.com, willy@infradead.org, hch@infradead.org,
	jmoyer@redhat.com, nilal@redhat.com, lenb@kernel.org,
	kilobyte@angband.pl, riel@surriel.com, yuval.shaia@oracle.com,
	stefanha@redhat.com, pbonzini@redhat.com,
	dan.j.williams@intel.com, kwolf@redhat.com, tytso@mit.edu,
	xiaoguangrong.eric@gmail.com, cohuck@redhat.com,
	rjw@rjwysocki.net, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Michael & Dan,

 Please review/ack the patch series from LIBNVDIMM & VIRTIO side.
 We have ack on ext4, xfs patches(4, 5 & 6) patch 2. Still need
 your ack on nvdimm patches(1 & 3) & virtio patch 2.=20

 Changes done from v7 are only in patch(2 & 3) and not
 affecting existing reviews. Request to please review.
 ----

 This patch series has implementation for "virtio pmem".=20
 "virtio pmem" is fake persistent memory(nvdimm) in guest=20
 which allows to bypass the guest page cache. This also
 implements a VIRTIO based asynchronous flush mechanism. =20
=20
 Sharing guest kernel driver in this patchset with the=20
 changes suggested in v4. Tested with Qemu side device=20
 emulation [6] for virtio-pmem. Documented the impact of
 possible page cache side channel attacks with suggested
 countermeasures.

 Details of project idea for 'virtio pmem' flushing interface=20
 is shared [3] & [4].

 Implementation is divided into two parts:
 New virtio pmem guest driver and qemu code changes for new=20
 virtio pmem paravirtualized device.

1. Guest virtio-pmem kernel driver
---------------------------------
   - Reads persistent memory range from paravirt device and=20
     registers with 'nvdimm_bus'. =20
   - 'nvdimm/pmem' driver uses this information to allocate=20
     persistent memory region and setup filesystem operations=20
     to the allocated memory.=20
   - virtio pmem driver implements asynchronous flushing=20
     interface to flush from guest to host.

2. Qemu virtio-pmem device
---------------------------------
   - Creates virtio pmem device and exposes a memory range to=20
     KVM guest.=20
   - At host side this is file backed memory which acts as=20
     persistent memory.=20
   - Qemu side flush uses aio thread pool API's and virtio=20
     for asynchronous guest multi request handling.=20

   David Hildenbrand CCed also posted a modified version[7] of=20
   qemu virtio-pmem code based on updated Qemu memory device API.=20

 Virtio-pmem security implications and countermeasures:
 -----------------------------------------------------

 In previous posting of kernel driver, there was discussion [9]
 on possible implications of page cache side channel attacks with=20
 virtio pmem. After thorough analysis of details of known side=20
 channel attacks, below are the suggestions:

 - Depends entirely on how host backing image file is mapped=20
   into guest address space.=20

 - virtio-pmem device emulation, by default shared mapping is used
   to map host backing file. It is recommended to use separate
   backing file at host side for every guest. This will prevent
   any possibility of executing common code from multiple guests
   and any chance of inferring guest local data based based on=20
   execution time.

 - If backing file is required to be shared among multiple guests=20
   it is recommended to don't support host page cache eviction=20
   commands from the guest driver. This will avoid any possibility
   of inferring guest local data or host data from another guest.=20

 - Proposed device specification [8] for virtio-pmem device with=20
   details of possible security implications and suggested=20
   countermeasures for device emulation.

 Virtio-pmem errors handling:
 ----------------------------------------
  Checked behaviour of virtio-pmem for below types of errors
  Need suggestions on expected behaviour for handling these errors?

  - Hardware Errors: Uncorrectable recoverable Errors:=20
  a] virtio-pmem:=20
    - As per current logic if error page belongs to Qemu process,=20
      host MCE handler isolates(hwpoison) that page and send SIGBUS.=20
      Qemu SIGBUS handler injects exception to KVM guest.=20
    - KVM guest then isolates the page and send SIGBUS to guest=20
      userspace process which has mapped the page.=20
 =20
  b] Existing implementation for ACPI pmem driver:=20
    - Handles such errors with MCE notifier and creates a list=20
      of bad blocks. Read/direct access DAX operation return EIO=20
      if accessed memory page fall in bad block list.
    - It also starts backgound scrubbing. =20
    - Similar functionality can be reused in virtio-pmem with MCE=20
      notifier but without scrubbing(no ACPI/ARS)? Need inputs to=20
      confirm if this behaviour is ok or needs any change?

Changes from PATCH v7: [1]
 - Corrected pending request queue logic (patch 2) - Jakub Staro=C5=84
 - Used unsigned long flags for passing DAXDEV_F_SYNC (patch 3) - Dan
 - Fixed typo =3D>  vma 'flag' to 'vm_flag' (patch 4)
 - Added rob in patch 6 & patch 2

Changes from PATCH v6: [1]
 - Corrected comment format in patch 5 & patch 6. [Dave]
 - Changed variable declaration indentation in patch 6 [Darrick]
 - Add Reviewed-by tag by 'Jan Kara' in patch 4 & patch 5

Changes from PATCH v5: [2]
  Changes suggested in by - [Cornelia, Yuval]
- Remove assignment chaining in virtio driver
- Better error message and remove not required free
- Check nd_region before use

  Changes suggested by - [Jan Kara]
- dax_synchronous() for !CONFIG_DAX
- Correct 'daxdev_mapping_supported' comment and non-dax implementation

  Changes suggested by - [Dan Williams]
- Pass meaningful flag 'DAXDEV_F_SYNC' to alloc_dax
- Gate nvdimm_flush instead of additional async parameter
- Move block chaining logic to flush callback than common nvdimm_flush
- Use NULL flush callback for generic flush for better readability [Dan, =
Jan]

- Use virtio device id 27 from 25(already used) - [MST]

Changes from PATCH v4:
- Factor out MAP_SYNC supported functionality to a common helper
				[Dave, Darrick, Jan]
- Comment, indentation and virtqueue_kick failure handle - Yuval Shaia

Changes from PATCH v3:=20
- Use generic dax_synchronous() helper to check for DAXDEV_SYNC=20
  flag - [Dan, Darrick, Jan]
- Add 'is_nvdimm_async' function
- Document page cache side channel attacks implications &=20
  countermeasures - [Dave Chinner, Michael]

Changes from PATCH v2:=20
- Disable MAP_SYNC for ext4 & XFS filesystems - [Dan]=20
- Use name 'virtio pmem' in place of 'fake dax'=20

Changes from PATCH v1:=20
- 0-day build test for build dependency on libnvdimm=20

 Changes suggested by - [Dan Williams]
- Split the driver into two parts virtio & pmem =20
- Move queuing of async block request to block layer
- Add "sync" parameter in nvdimm_flush function
- Use indirect call for nvdimm_flush
- Don=E2=80=99t move declarations to common global header e.g nd.h
- nvdimm_flush() return 0 or -EIO if it fails
- Teach nsio_rw_bytes() that the flush can fail
- Rename nvdimm_flush() to generic_nvdimm_flush()
- Use 'nd_region->provider_data' for long dereferencing
- Remove virtio_pmem_freeze/restore functions
- Remove BSD license text with SPDX license text

- Add might_sleep() in virtio_pmem_flush - [Luiz]
- Make spin_lock_irqsave() narrow

Pankaj Gupta (6):
   libnvdimm: nd_region flush callback support
   virtio-pmem: Add virtio-pmem guest driver
   libnvdimm: add nd_region buffered dax_dev flag
   dax: check synchronous mapping is supported
   ext4: disable map_sync for virtio pmem
   xfs: disable map_sync for virtio pmem

[1] https://lkml.org/lkml/2019/4/26/36
[2] https://lkml.org/lkml/2019/4/23/1092
[3] https://www.spinics.net/lists/kvm/msg149761.html
[4] https://www.spinics.net/lists/kvm/msg153095.html =20
[5] https://lkml.org/lkml/2018/8/31/413
[6] https://marc.info/?l=3Dlinux-kernel&m=3D153572228719237&w=3D2=20
[7] https://marc.info/?l=3Dqemu-devel&m=3D153555721901824&w=3D2
[8] https://lists.oasis-open.org/archives/virtio-dev/201903/msg00083.html
[9] https://lkml.org/lkml/2019/1/9/1191

 drivers/acpi/nfit/core.c         |    4 -
 drivers/dax/bus.c                |    2=20
 drivers/dax/super.c              |   13 +++
 drivers/md/dm.c                  |    3=20
 drivers/nvdimm/Makefile          |    1=20
 drivers/nvdimm/claim.c           |    6 +
 drivers/nvdimm/nd.h              |    1=20
 drivers/nvdimm/nd_virtio.c       |  129 ++++++++++++++++++++++++++++++++=
+++++++
 drivers/nvdimm/pmem.c            |   18 +++--
 drivers/nvdimm/region_devs.c     |   33 +++++++++
 drivers/nvdimm/virtio_pmem.c     |  117 ++++++++++++++++++++++++++++++++=
+++
 drivers/virtio/Kconfig           |   10 +++
 fs/ext4/file.c                   |   10 +--
 fs/xfs/xfs_file.c                |    9 +-
 include/linux/dax.h              |   25 ++++++-
 include/linux/libnvdimm.h        |    9 ++
 include/linux/virtio_pmem.h      |   60 ++++++++++++++++++
 include/uapi/linux/virtio_ids.h  |    1=20
 include/uapi/linux/virtio_pmem.h |   10 +++
 19 files changed, 436 insertions(+), 25 deletions(-)

