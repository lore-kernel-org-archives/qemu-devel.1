Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7001C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A1C214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A1C214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAAdM-0007nV-S9
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iAAbJ-0006KX-BR
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iAAbH-0003X7-F1
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:20:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iAAbH-0003Vs-4x
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:20:47 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8HAHFDX110657
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 06:20:44 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v2w62hbgr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 06:20:43 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 17 Sep 2019 11:20:40 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 17 Sep 2019 11:20:33 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8HAKWAP45613068
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2019 10:20:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 052274C044;
 Tue, 17 Sep 2019 10:20:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AB8B4C040;
 Tue, 17 Sep 2019 10:20:31 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.22.84])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 17 Sep 2019 10:20:30 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 12:20:30 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091710-0028-0000-0000-0000039E0EDF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091710-0029-0000-0000-000024608785
Message-Id: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170106
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 00/17] Fix usage of error_append_hint()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P. =?utf-8?q?Berrang=C3=A9=22?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org"@d06av22.portsmouth.uk.ibm.com,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A recent post unveiled a potential problem when passing errp to
error_append_hint():

https://patchwork.ozlabs.org/patch/1162171/

The issue is that error_append_hint() may end up not being called
at all if errp is equal to &error_fatal or &error_abort. It turns
out that the only way to ensure error_append_hint() can do its job
regardless of how the error is handled is to use a local error
object and to propagate it to the caller.

As suggested by Markus Armbruster, this series does:
(1) update error_append_hint()'s documentation in <qapi/error.h> to
    spell this out
(2) fix other misuses of error_append_hint() in the tree

The following command was used to detect candidates for (2), which
were then manually inspected. It is possible that many of them never
exhibit the unwanted behaviour in practice because errp happens to
never be equal to &error_fatal or &error_abort. It isn't trivial to
assess though, and this is fragile and can be easily broken if the
code gets rearranged. Also, passing errp directly is a shortcut that
doesn't bring much, neither for clarity, nor for performance that
we don't really care for on an error path). Better safe than sorry,
so fix them all.

I tried to group the changes that are supposed to go through the same
tree together.

$ git grep -n error_append_hint\(errp | cut -d: -f 1-2
block/backup.c:608
block/dirty-bitmap.c:256
block/file-posix.c:393
block/file-posix.c:854
block/file-posix.c:2282
block/gluster.c:480
block/gluster.c:483
block/gluster.c:489
block/gluster.c:702
block/gluster.c:711
block/qcow.c:162
block/qcow.c:195
block/qcow2.c:1363
block/vhdx-log.c:811
block/vpc.c:1033

=> Patch for block

chardev/spice.c:284

=> Patch for chardev

hw/9pfs/9p-local.c:1474
hw/9pfs/9p-proxy.c:1119

Already posted https://patchwork.ozlabs.org/patch/1162171/

hw/arm/msf2-soc.c:131
hw/arm/virt.c:1808
hw/arm/virt.c:1836
hw/intc/arm_gicv3_kvm.c:815
hw/misc/msf2-sysreg.c:135

=> Patch for arm

hw/pci-bridge/pcie_root_port.c:76
hw/pci-bridge/pcie_root_port.c:90

=> Patch for pci

hw/ppc/mac_newworld.c:622
hw/ppc/spapr.c:4341
hw/ppc/spapr_pci.c:1874
hw/ppc/spapr_pci.c:1876
hw/ppc/spapr_pci.c:1878

=> Patch for ppc

hw/rdma/vmw/pvrdma_main.c:670

=> Patch for pvrdma

hw/s390x/s390-ccw.c:63

=> Patch for s390

hw/scsi/scsi-disk.c:2624
hw/scsi/scsi-generic.c:679

=> Patch for scsi

hw/usb/ccid-card-emulated.c:516

=> Patch for usb

hw/vfio/common.c:1473
hw/vfio/common.c:1536
hw/vfio/pci.c:2532
hw/vfio/pci.c:2718

=> Patch for vfio

hw/virtio/virtio-pci.c:1548
hw/virtio/virtio-pci.c:1742

=> Patch for virtio

migration/migration.c:988
migration/migration.c:997

=> Patch for migration

nbd/client.c:230
nbd/server.c:1627

=> Patch for nbd

qdev-monitor.c:334
qdev-monitor.c:337
qdev-monitor.c:340
qdev-monitor.c:348
qdev-monitor.c:351
qdev-monitor.c:354
qdev-monitor.c:358

No misuse here as these aren't preceded by a call to error_setg() or
error_propagate() that could terminate QEMU.

target/ppc/kvm.c:246
target/ppc/kvm.c:2089
target/ppc/kvm.c:2092

=> Patch for kvm

util/qemu-option.c:160
util/qemu-option.c:669

=> Patch for option

util/qemu-sockets.c:886
util/qemu-sockets.c:956

=> Patch for sockets

As a bonus, also teach checkpatch to detect that. Since the convention
of using the errp naming seems to be strictly followed, the check is
just to detect "error_append_hint(errp" and emit a warning, for the sake
of simplicity.

--
Greg

---

Greg Kurz (17):
      error: Update error_append_hint()'s documentation
      block: Pass local error object pointer to error_append_hint()
      char/spice: Pass local error object pointer to error_append_hint()
      ppc: Pass local error object pointer to error_append_hint()
      arm: Pass local error object pointer to error_append_hint()
      vfio: Pass local error object pointer to error_append_hint()
      virtio-pci: Pass local error object pointer to error_append_hint()
      pcie_root_port: Pass local error object pointer to error_append_hint()
      hw/rdma: Fix missing conversion to rdma_error_report()
      s390x/css: Pass local error object pointer to error_append_hint()
      scsi: Pass local error object pointer to error_append_hint()
      migration: Pass local error object pointer to error_append_hint()
      nbd: Pass local error object pointer to error_append_hint()
      ccid-card-emul: Pass local error object pointer to error_append_hint()
      option: Pass local error object pointer to error_append_hint()
      socket: Pass local error object pointer to error_append_hint()
      checkpatch: Warn when errp is passed to error_append_hint()


 block/backup.c                 |    7 +++++--
 block/dirty-bitmap.c           |    7 +++++--
 block/file-posix.c             |   20 +++++++++++++-------
 block/gluster.c                |   23 +++++++++++++++--------
 block/qcow.c                   |   10 ++++++----
 block/qcow2.c                  |    7 +++++--
 block/vhdx-log.c               |    7 +++++--
 block/vpc.c                    |    7 +++++--
 chardev/spice.c                |    6 ++++--
 hw/arm/msf2-soc.c              |    5 +++--
 hw/arm/virt.c                  |   14 ++++++++++----
 hw/intc/arm_gicv3_kvm.c        |    5 +++--
 hw/misc/msf2-sysreg.c          |    6 ++++--
 hw/pci-bridge/pcie_root_port.c |   11 +++++++----
 hw/ppc/mac_newworld.c          |    7 +++++--
 hw/ppc/spapr.c                 |    7 +++++--
 hw/ppc/spapr_pci.c             |    9 +++++----
 hw/rdma/vmw/pvrdma_main.c      |    2 +-
 hw/s390x/s390-ccw.c            |    6 ++++--
 hw/scsi/scsi-disk.c            |    7 +++++--
 hw/scsi/scsi-generic.c         |    7 +++++--
 hw/usb/ccid-card-emulated.c    |    7 +++++--
 hw/vfio/common.c               |   14 ++++++++++----
 hw/vfio/pci.c                  |   12 ++++++++----
 hw/virtio/virtio-pci.c         |   14 ++++++++++----
 include/qapi/error.h           |   11 ++++++++++-
 migration/migration.c          |   14 ++++++++++----
 nbd/client.c                   |   24 +++++++++++++-----------
 nbd/server.c                   |    7 +++++--
 scripts/checkpatch.pl          |    4 ++++
 target/ppc/kvm.c               |   13 +++++++++----
 util/qemu-option.c             |   14 ++++++++++----
 util/qemu-sockets.c            |   14 ++++++++++----
 33 files changed, 224 insertions(+), 104 deletions(-)


