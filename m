Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C74C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77AC42087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77AC42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioq1G-0005xW-4B
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1iopyo-0002mA-6m
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1iopyi-00035Z-QR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:37:09 -0500
Received: from goliath.siemens.de ([192.35.17.28]:54898)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1iopyi-0002wa-Fr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:37:04 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 007EaiNQ008533
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2020 15:36:44 +0100
Received: from md1f2u6c.ad001.siemens.net ([139.25.68.37])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 007Eai7Q011484;
 Tue, 7 Jan 2020 15:36:44 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [RFC][PATCH v2 0/3] IVSHMEM version 2 device for QEMU
Date: Tue,  7 Jan 2020 15:36:39 +0100
Message-Id: <cover.1578407802.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.16.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 192.35.17.28
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
Cc: liang yan <lyan@suse.com>, Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Overdue update of the ivshmem 2.0 device model as presented at [1].

Changes in v2:
 - changed PCI device ID to Siemens-granted one,
   adjusted PCI device revision to 0
 - removed unused feature register from device
 - addressed feedback on specification document
 - rebased over master

This version is now fully in sync with the implementation for Jailhouse
that is currently under review [2][3], UIO and virtio-ivshmem drivers
are shared. Jailhouse will very likely pick up this revision of the
device in order to move forward with stressing it.

More details on the usage with QEMU were in the original cover letter
(with adjustements to the new device ID):

If you want to play with this, the basic setup of the shared memory
device is described in patch 1 and 3. UIO driver and also the
virtio-ivshmem prototype can be found at

    http://git.kiszka.org/?p=linux.git;a=shortlog;h=refs/heads/queues/ivshmem2

Accessing the device via UIO is trivial enough. If you want to use it
for virtio, this is additionally to the description in patch 3 needed on
the virtio console backend side:

    modprobe uio_ivshmem
    echo "110a 4106 1af4 1100 ffc003 ffffff" > /sys/bus/pci/drivers/uio_ivshmem/new_id
    linux/tools/virtio/virtio-ivshmem-console /dev/uio0

And for virtio block:

    echo "110a 4106 1af4 1100 ffc002 ffffff" > /sys/bus/pci/drivers/uio_ivshmem/new_id
    linux/tools/virtio/virtio-ivshmem-console /dev/uio0 /path/to/disk.img

After that, you can start the QEMU frontend instance with the
virtio-ivshmem driver installed which can use the new /dev/hvc* or
/dev/vda* as usual.

Any feedback welcome!

Jan

PS: Let me know if I missed someone potentially interested in this topic
on CC - or if you would like to be dropped from the list.

[1] https://kvmforum2019.sched.com/event/TmxI
[2] https://groups.google.com/forum/#!topic/jailhouse-dev/ffnCcRh8LOs
[3] https://groups.google.com/forum/#!topic/jailhouse-dev/HX-0AGF1cjg

Jan Kiszka (3):
  hw/misc: Add implementation of ivshmem revision 2 device
  docs/specs: Add specification of ivshmem device revision 2
  contrib: Add server for ivshmem revision 2

 Makefile                                  |    3 +
 Makefile.objs                             |    1 +
 configure                                 |    1 +
 contrib/ivshmem2-server/Makefile.objs     |    1 +
 contrib/ivshmem2-server/ivshmem2-server.c |  462 ++++++++++++
 contrib/ivshmem2-server/ivshmem2-server.h |  158 +++++
 contrib/ivshmem2-server/main.c            |  313 +++++++++
 docs/specs/ivshmem-2-device-spec.md       |  376 ++++++++++
 hw/misc/Makefile.objs                     |    2 +-
 hw/misc/ivshmem2.c                        | 1085 +++++++++++++++++++++++++++++
 include/hw/misc/ivshmem2.h                |   48 ++
 include/hw/pci/pci_ids.h                  |    2 +
 12 files changed, 2451 insertions(+), 1 deletion(-)
 create mode 100644 contrib/ivshmem2-server/Makefile.objs
 create mode 100644 contrib/ivshmem2-server/ivshmem2-server.c
 create mode 100644 contrib/ivshmem2-server/ivshmem2-server.h
 create mode 100644 contrib/ivshmem2-server/main.c
 create mode 100644 docs/specs/ivshmem-2-device-spec.md
 create mode 100644 hw/misc/ivshmem2.c
 create mode 100644 include/hw/misc/ivshmem2.h

-- 
2.16.4


