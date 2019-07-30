Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991E8C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA142087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA142087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsbki-0001KP-Nz
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 19:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hsbiF-00062k-ID
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hsbiC-0002XV-4u
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:39:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hsbi3-0002TR-RC
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:39:14 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6UNbCx8013092; Tue, 30 Jul 2019 19:39:05 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u2wqdbxs2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2019 19:39:04 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6UNU8vA020671;
 Tue, 30 Jul 2019 23:39:03 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04wdc.us.ibm.com with ESMTP id 2u0e85txv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2019 23:39:03 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6UNd2PV34996606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jul 2019 23:39:02 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97FF4C605A;
 Tue, 30 Jul 2019 23:39:02 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FDBCC6055;
 Tue, 30 Jul 2019 23:39:02 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jul 2019 23:39:02 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <156452993884.16169.12168229409049273970@sif>
Date: Tue, 30 Jul 2019 18:38:58 -0500
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-30_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300239
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [ANNOUNCE] QEMU 4.1.0-rc3 is now available
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fourth release candidate for the QEMU 4.1 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-4.1.0-rc3.tar.xz
  http://download.qemu-project.org/qemu-4.1.0-rc3.tar.xz.sig

A note from the maintainer:

  Unless there are any release critical bugs discovered, this
  will be the last release candidate before final release of 4.1.0
  on the 6th August. Otherwise we'll do an rc4 and release on
  the 13th August.

You can help improve the quality of the QEMU 4.1 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/4.1

Please add entries to the ChangeLog for the 4.1 release below:

  http://wiki.qemu.org/ChangeLog/4.1

Thank you to everyone involved!

Changes since rc2:

3bd6cbbb18: Update version for v4.1.0-rc3 release (Peter Maydell)
c8557f1b48: pcie_root_port: Disable ACS on older machines (Dr. David Alan G=
ilbert)
a58dfba201: pcie_root_port: Allow ACS to be disabled (Dr. David Alan Gilber=
t)
987a232242: target/arm: Deliver BKPT/BRK exceptions to correct exception le=
vel (Peter Maydell)
6817416014: iotests/118: Test inserting a read-only medium (Kevin Wolf)
0b9e918f03: fdc: Fix inserting read-only media in empty drive (Kevin Wolf)
1120407bdf: nvme: Limit blkshift to 12 (for 4 kB blocks) (Max Reitz)
7cef3d1290: scsi-cd: Fix inserting read-only media in empty drive (Kevin Wo=
lf)
2b23f28639: block/copy-on-read: Fix permissions for inactive node (Kevin Wo=
lf)
251071e0c0: Fixes: add read-zeroes to 051.out (Andrey Shinkevich)
6078a0b64f: tests/multiboot: Fix load address of test kernels (Kevin Wolf)
22235bb609: pc-dimm: fix crash when invalid slot number is used (Igor Mamme=
dov)
dd56040d29: Revert "hw: report invalid disable-legacy|modern usage for virt=
io-1-only devs" (Dr. David Alan Gilbert)
92fd453c67: Revert "Revert "globals: Allow global properties to be optional=
"" (Dr. David Alan Gilbert)
ff656fcd33: i386: Fix Snowridge CPU model name and features (Paul Lai)
f77bed14f0: net/colo-compare.c: Fix memory leak and code style issue. (Zhan=
g Chen)
389abe1dd1: net: tap: replace snprintf with g_strdup_printf calls (Prasad J=
 Pandit)
3283dde4b5: qemu-bridge-helper: move repeating code in parse_acl_file (Pras=
ad J Pandit)
6f5d867122: qemu-bridge-helper: restrict interface name to IFNAMSIZ (Prasad=
 J Pandit)
f46efa9b08: e1000: don't raise interrupt in pre_save() (Jason Wang)
8d216d8c53: xics/kvm: Fix fallback to emulated XICS (Greg Kurz)
f5bda01066: spapr/irq: Inform the user when falling back to emulated IC (Gr=
eg Kurz)
75ea2529cf: riscv/boot: Fixup the RISC-V firmware warning (Alistair Francis)
5bfce0b74f: linux-user: Make sigaltstack stacks per-thread (Peter Maydell)
67505c114e: hw/arm/boot: Further improve initrd positioning code (Peter May=
dell)
d5fef92f6a: hw/arm/boot: Rename elf_{low, high}_addr to image_{low, high}_a=
ddr (Peter Maydell)
0c413ba0d8: vmstate.h: Type check VMSTATE_STRUCT_VARRAY macros (Peter Mayde=
ll)
372e458ebc: stellaris_input: Fix vmstate description of buttons field (Pete=
r Maydell)
830fc739d0: pl330: fix vmstate description (Damien Hedde)
7e095e84ba: tpm_emulator: Translate TPM error codes to strings (Stefan Berg=
er)
1b47b37c33: virtio-balloon: free pbp more aggressively (Michael S. Tsirkin)
bcfd16fe26: tpm: Exit in reset when backend indicates failure (Stefan Berge=
r)
9a7ca8a7c9: virtio-balloon: don't track subpages for the PBP (David Hildenb=
rand)
a8cd64d488: virtio-balloon: Use temporary PBP only (David Hildenbrand)
1c5cfc2b71: virtio-balloon: Rework pbp tracking data (David Hildenbrand)
e6129b271b: virtio-balloon: Better names for offset variables in inflate/de=
flate code (David Hildenbrand)
2ffc49eea1: virtio-balloon: Simplify deflate with pbp (David Hildenbrand)
483f13524b: virtio-balloon: Fix QEMU crashes on pagesize > BALLOON_PAGE_SIZ=
E (David Hildenbrand)
ffa207d082: virtio-balloon: Fix wrong sign extension of PFNs (David Hildenb=
rand)
ee4b0c8686: i386/acpi: show PCI Express bus on pxb-pcie expanders (Evgeny Y=
akovlev)
be1927c97e: ioapic: kvm: Skip route updates for masked pins (Jan Kiszka)
21e2acd583: i386/acpi: fix gint overflow in crs_range_compare (Evgeny Yakov=
lev)
df98d7ccc2: docs: clarify multiqueue vs multiple virtqueues (Stefan Hajnocz=
i)
6ef2d01abf: MAINTAINERS: vfio-ccw: Remove myself as the maintainer (Farhan =
Ali)
f193bc0c53: migration: fix migrate_cancel multifd migration leads destinati=
on hung forever (Ivan Ren)
3c3ca25d1f: migration: Make explicit that we are quitting multifd (Juan Qui=
ntela)
a3ec6b7d23: migration: fix migrate_cancel leads live_migration thread hung =
forever (Ivan Ren)
713f762a31: migration: fix migrate_cancel leads live_migration thread endle=
ss loop (Ivan Ren)
6baabe5cf8: docs: correct kconfig option (Marc-Andr=C3=A9 Lureau)
bec7156a45: i386/kvm: Do not sync nested state during runtime (Jan Kiszka)
9c5aad84da: virtio-scsi: fixed virtio_scsi_ctx_check failed when detaching =
scsi disk (Zhengui li)


