Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A2CECE587
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A990F20815
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A990F20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSKY-0007jr-6A
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrv-0001Mq-E7
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrq-0001e1-7V
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRrc-0001KO-Qe; Tue, 01 Oct 2019 19:47:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlRvA086526; Tue, 1 Oct 2019 19:47:27 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vccat80mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:27 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlTo029385;
 Tue, 1 Oct 2019 23:47:17 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma01dal.us.ibm.com with ESMTP id 2v9y59fag7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:17 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlHxA53346584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:17 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C6CE28058;
 Tue,  1 Oct 2019 23:47:17 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9A572805A;
 Tue,  1 Oct 2019 23:47:16 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:16 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/97] Patch Round-up for stable 4.0.1, freeze on 2019-10-10
Date: Tue,  1 Oct 2019 18:44:39 -0500
Message-Id: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x91NlRvA086526
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi everyone,                                                             =
                                =20

The following new patches are queued for QEMU stable v4.0.1:

  https://github.com/mdroth/qemu/commits/stable-4.0-staging

The release is planned for 2019-10-17:

  https://wiki.qemu.org/Planning/4.0

Please respond here or CC qemu-stable@nongnu.org on any patches you
think should be included in the release.

Note that this update falls outside the normal stable release support
window (~1 development cycle), but is being released now since it was
delayed from its intended release date.

Thanks!

----------------------------------------------------------------
Alberto Garcia (1):
      qcow2: Fix the calculation of the maximum L2 cache size

Alex Williamson (1):
      q35: Revert to kernel irqchip

Anthony PERARD (1):
      xen-bus: Fix backend state transition on device reset

Anton Blanchard (5):
      target/ppc: Fix xvabs[sd]p, xvnabs[sd]p, xvneg[sd]p, xvcpsgn[sd]p
      target/ppc: Fix xvxsigdp
      target/ppc: Fix xxbrq, xxbrw
      target/ppc: Fix vsum2sws
      target/ppc: Fix lxvw4x, lxvh8x and lxvb16x

Christian Borntraeger (1):
      s390x/cpumodel: ignore csske for expansion

C=C3=A9dric Le Goater (1):
      spapr/xive: fix EQ page addresses above 64GB

Daniel P. Berrang=C3=A9 (1):
      docs: recommend use of md-clear feature on all Intel CPUs

David Hildenbrand (7):
      virtio-balloon: Fix wrong sign extension of PFNs
      virtio-balloon: Fix QEMU crashes on pagesize > BALLOON_PAGE_SIZE
      virtio-balloon: Simplify deflate with pbp
      virtio-balloon: Better names for offset variables in inflate/deflat=
e code
      virtio-balloon: Rework pbp tracking data
      virtio-balloon: Use temporary PBP only
      virtio-balloon: don't track subpages for the PBP

Eric Blake (1):
      cutils: Fix size_to_str() on 32-bit platforms

Evgeny Yakovlev (2):
      i386/acpi: show PCI Express bus on pxb-pcie expanders
      i386/acpi: fix gint overflow in crs_range_compare

Gerd Hoffmann (2):
      kbd-state: fix autorepeat handling
      usb-tablet: fix serial compat property

Jan Kiszka (1):
      ioapic: kvm: Skip route updates for masked pins

Johannes Berg (1):
      libvhost-user: fix SLAVE_SEND_FD handling

John Snow (13):
      Makefile: add nit-picky mode to sphinx-build
      docs/interop/bitmaps: rewrite and modernize doc
      blockdev-backup: don't check aio_context too early
      iotests.py: do not use infinite waits
      QEMUMachine: add events_wait method
      iotests.py: rewrite run_job to be pickier
      iotests: add iotest 256 for testing blockdev-backup across iothread=
 contexts
      migration/dirty-bitmaps: change bitmap enumeration method
      docs/interop/bitmaps.rst: Fix typos
      sphinx: add qmp_lexer
      docs/bitmaps: use QMP lexer instead of json
      Revert "ide/ahci: Check for -ECANCELED in aio callbacks"
      iotests: add testing shim for script-style python tests

Kevin Wolf (7):
      qcow2: Avoid COW during metadata preallocation
      qcow2: Add errp to preallocate_co()
      qcow2: Fix full preallocation with external data file
      qcow2: Fix qcow2_make_empty() with external data file
      block: Fix AioContext switch for bs->drv =3D=3D NULL
      block: Drain source node in bdrv_replace_node()
      iotests: Test commit job start with concurrent I/O

Li Hangjing (1):
      vhost: fix vhost_log size overflow during migration

Marc-Andr=C3=A9 Lureau (2):
      virtio-pci: fix missing device properties
      usbredir: fix buffer-overflow on vmload

Markus Armbruster (2):
      vl: Fix -drive / -blockdev persistent reservation management
      pr-manager: Fix invalid g_free() crash bug

Matthew Rosato (1):
      s390: PCI: fix IOMMU region init

Max Reitz (20):
      block/file-posix: Unaligned O_DIRECT block-status
      iotests: Test unaligned raw images with O_DIRECT
      iotests.py: Fix VM.run_job
      backup: Copy only dirty areas
      iotests: Test backup job with two guest writes
      iotests: Test incremental backup after truncation
      mirror: Only mirror granularity-aligned chunks
      iotests: Test unaligned blocking mirror write
      vpc: Return 0 from vpc_co_create() on success
      iotests: Add supported protocols to execute_test()
      iotests: Restrict file Python tests to file
      iotests: Restrict nbd Python tests to nbd
      iotests: Test blockdev-create for vpc
      curl: Keep pointer to the CURLState in CURLSocket
      curl: Keep *socket until the end of curl_sock_cb()
      curl: Check completion in curl_multi_do()
      curl: Pass CURLSocket to curl_multi_do()
      curl: Report only ready sockets
      curl: Handle success in multi_check_completion
      curl: Check curl_multi_add_handle()'s return code

Michael Roth (2):
      slirp: Fix heap overflow in ip_reass on big packet input
      slirp: ip_reass: Fix use after free

Michael S. Tsirkin (1):
      virtio-balloon: free pbp more aggressively

Paolo Bonzini (4):
      target/i386: add MDS-NO feature
      target/i386: define md-clear bit
      dma-helpers: ensure AIO callback is invoked after cancellation
      scsi: lsi: exit infinite loop while executing script (CVE-2019-1206=
8)

Peter Lieven (2):
      megasas: fix mapped frame size
      block/nfs: tear down aio before nfs_close

Peter Maydell (1):
      target/arm: Don't abort on M-profile exception return in linux-user=
 mode

Philippe Mathieu-Daud=C3=A9 (4):
      hw/ssi/xilinx_spips: Convert lqspi_read() to read_with_attrs
      hw/ssi/xilinx_spips: Avoid AXI writes to the LQSPI linear memory
      hw/ssi/xilinx_spips: Avoid out-of-bound access to lqspi_buf[]
      block/create: Do not abort if a block driver is not available

Sergio Lopez (1):
      blockjob: update nodes head while removing all bdrv

Stefan Berger (2):
      tpm: Exit in reset when backend indicates failure
      tpm_emulator: Translate TPM error codes to strings

Stefan Hajnoczi (1):
      virtio-balloon: fix QEMU 4.0 config size migration incompatibility

Thomas Huth (1):
      hw/core/loader: Fix possible crash in rom_copy()

Vladimir Sementsov-Ogievskiy (7):
      block/backup: simplify backup_incremental_init_copy_bitmap
      block/backup: move to copy_bitmap with granularity
      block/backup: refactor and tolerate unallocated cluster skipping
      block/backup: unify different modes code path
      block/backup: refactor: split out backup_calculate_cluster_size
      util/hbitmap: update orig_size on truncate
      block/backup: disable copy_range for compressed backup

 Makefile                              |    2 +-
 block.c                               |   19 +-
 block/backup.c                        |  258 +++---
 block/create.c                        |    6 +-
 block/curl.c                          |  133 ++-
 block/file-posix.c                    |   16 +
 block/mirror.c                        |   29 +
 block/nfs.c                           |    6 +-
 block/qcow2.c                         |   59 +-
 block/vpc.c                           |    3 +-
 blockdev.c                            |    4 -
 blockjob.c                            |   17 +-
 contrib/libvhost-user/libvhost-user.c |    3 +-
 dma-helpers.c                         |   13 +-
 docs/conf.py                          |    4 +-
 docs/interop/bitmaps.rst              | 1585 ++++++++++++++++++++++++++-=
------
 docs/qemu-cpu-models.texi             |   12 +
 docs/sphinx/qmp_lexer.py              |   43 +
 hw/core/loader.c                      |    2 +-
 hw/core/machine.c                     |    8 +-
 hw/i386/acpi-build.c                  |   17 +-
 hw/i386/pc.c                          |    3 +
 hw/i386/pc_q35.c                      |   16 +-
 hw/ide/ahci.c                         |    3 -
 hw/ide/core.c                         |   14 -
 hw/intc/ioapic.c                      |    8 +-
 hw/intc/spapr_xive.c                  |    3 +-
 hw/intc/xive.c                        |    9 +-
 hw/s390x/s390-pci-bus.c               |    7 +-
 hw/scsi/lsi53c895a.c                  |   41 +-
 hw/scsi/megasas.c                     |    2 +-
 hw/ssi/xilinx_spips.c                 |   43 +-
 hw/tpm/tpm_crb.c                      |    4 +-
 hw/tpm/tpm_emulator.c                 |   60 +-
 hw/tpm/tpm_int.h                      |   13 +
 hw/tpm/tpm_tis.c                      |    4 +-
 hw/usb/redirect.c                     |    5 +
 hw/virtio/vhost.c                     |   10 +
 hw/virtio/virtio-balloon.c            |  143 +--
 hw/virtio/virtio-pci.c                |   28 +-
 hw/xen/xen-bus.c                      |   23 +-
 include/hw/boards.h                   |    3 +
 include/hw/i386/pc.h                  |    3 +
 include/hw/ppc/xive_regs.h            |    6 +
 include/hw/virtio/virtio-balloon.h    |    5 +-
 migration/block-dirty-bitmap.c        |   14 +-
 python/qemu/__init__.py               |   69 +-
 scsi/pr-manager.c                     |    1 -
 slirp/src/ip_input.c                  |   19 +-
 target/arm/translate.c                |   21 +-
 target/i386/cpu.c                     |    4 +-
 target/ppc/int_helper.c               |    2 +-
 target/ppc/translate/vsx-impl.inc.c   |   23 +-
 target/s390x/cpu_models.c             |    2 +
 tests/bios-tables-test.c              |    9 +
 tests/qemu-iotests/030                |    3 +-
 tests/qemu-iotests/040                |    3 +-
 tests/qemu-iotests/041                |    3 +-
 tests/qemu-iotests/044                |    3 +-
 tests/qemu-iotests/045                |    3 +-
 tests/qemu-iotests/055                |    3 +-
 tests/qemu-iotests/056                |   42 +-
 tests/qemu-iotests/056.out            |    4 +-
 tests/qemu-iotests/057                |    3 +-
 tests/qemu-iotests/065                |    3 +-
 tests/qemu-iotests/096                |    3 +-
 tests/qemu-iotests/118                |    3 +-
 tests/qemu-iotests/124                |   41 +-
 tests/qemu-iotests/124.out            |    4 +-
 tests/qemu-iotests/129                |    3 +-
 tests/qemu-iotests/132                |    3 +-
 tests/qemu-iotests/139                |    3 +-
 tests/qemu-iotests/147                |    5 +-
 tests/qemu-iotests/148                |    3 +-
 tests/qemu-iotests/151                |   28 +-
 tests/qemu-iotests/151.out            |    4 +-
 tests/qemu-iotests/152                |    3 +-
 tests/qemu-iotests/155                |    3 +-
 tests/qemu-iotests/163                |    3 +-
 tests/qemu-iotests/165                |    3 +-
 tests/qemu-iotests/169                |    3 +-
 tests/qemu-iotests/196                |    3 +-
 tests/qemu-iotests/199                |    3 +-
 tests/qemu-iotests/205                |    3 +-
 tests/qemu-iotests/221                |    4 +
 tests/qemu-iotests/245                |    3 +-
 tests/qemu-iotests/253                |   84 ++
 tests/qemu-iotests/253.out            |   14 +
 tests/qemu-iotests/255                |   83 ++
 tests/qemu-iotests/255.out            |   16 +
 tests/qemu-iotests/256                |  122 +++
 tests/qemu-iotests/256.out            |  119 +++
 tests/qemu-iotests/266                |  153 ++++
 tests/qemu-iotests/266.out            |  137 +++
 tests/qemu-iotests/group              |    4 +
 tests/qemu-iotests/iotests.py         |  106 ++-
 ui/kbd-state.c                        |    6 +-
 util/cutils.c                         |    2 +-
 util/hbitmap.c                        |    6 +-
 vl.c                                  |    3 +-
 100 files changed, 3022 insertions(+), 893 deletions(-)
 create mode 100644 docs/sphinx/qmp_lexer.py
 create mode 100755 tests/qemu-iotests/253
 create mode 100644 tests/qemu-iotests/253.out
 create mode 100755 tests/qemu-iotests/255
 create mode 100644 tests/qemu-iotests/255.out
 create mode 100755 tests/qemu-iotests/256
 create mode 100644 tests/qemu-iotests/256.out
 create mode 100755 tests/qemu-iotests/266
 create mode 100644 tests/qemu-iotests/266.out




