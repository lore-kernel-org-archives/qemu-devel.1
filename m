Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6E3C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 22:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FCA22387
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 22:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FCA22387
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq31k-0006Fh-1l
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 18:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42438)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hq31X-0005rQ-Fb
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 18:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hq31V-00047O-Lb
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 18:12:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65532
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hq31V-00046V-G0
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 18:12:41 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NMC83G089797
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 18:12:40 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tx9273y78-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 18:12:39 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Tue, 23 Jul 2019 23:12:39 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 23 Jul 2019 23:12:36 +0100
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NMCZxU60883320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 22:12:36 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF3786E05D;
 Tue, 23 Jul 2019 22:12:35 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FA616E066;
 Tue, 23 Jul 2019 22:12:35 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 22:12:35 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 17:12:31 -0500
X-TM-AS-GCONF: 00
x-cbid: 19072322-0036-0000-0000-00000ADD957D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011484; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01236479; UDB=6.00651700; IPR=6.01017835; 
 MB=3.00027860; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-23 22:12:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072322-0037-0000-0000-00004CB81039
Message-Id: <156391995184.11893.17276992491834493758@sif>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230225
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [ANNOUNCE] QEMU 4.1.0-rc2 is now available
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
third release candidate for the QEMU 4.1 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-4.1.0-rc2.tar.xz
  http://download.qemu-project.org/qemu-4.1.0-rc2.tar.xz.sig

You can help improve the quality of the QEMU 4.1 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/4.1

Please add entries to the ChangeLog for the 4.1 release below:

  http://wiki.qemu.org/ChangeLog/4.1

Thank you to everyone involved!

Changes since rc1:

061b51e919: Update version for v4.0.0-rc2 release (Peter Maydell)
b4682a63f8: filemon: fix watch IDs to avoid potential wraparound issues (Da=
niel P. Berrang=C3=A9)
ff3dc8fefe: filemon: ensure watch IDs are unique to QFileMonitor scope (Dan=
iel P. Berrang=C3=A9)
b26c3f9cbd: tests: refactor file monitor test to make it more understandabl=
e (Daniel P. Berrang=C3=A9)
79b9d4bde7: accel: Unbreak accelerator fallback (Markus Armbruster)
0427b6257e: vl: Document dependencies hiding in global and compat props (Ma=
rkus Armbruster)
daff7f0bbe: migration: Support adding migration blockers earlier (Markus Ar=
mbruster)
811f865271: Revert "migration: move only_migratable to MigrationState" (Mar=
kus Armbruster)
2fa23277d5: Revert "vl: Fix to create migration object before block backend=
s again" (Markus Armbruster)
5cc8f9eb7a: qapi/migration.json: Rename COLOStatus last_mode to last-mode (=
Zhang Chen)
966c0d4932: qapi/migration.json: Fix ColoStatus member last_mode's version =
(Zhang Chen)
17f30eae12: vl: Fix error location of positional arguments (Markus Armbrust=
er)
f18957b854: tests/qemu-iotests/235: Allow fallback to tcg (Thomas Huth)
d20ba603f2: block: test block-stream with a base node that is used by block=
-commit (Alberto Garcia)
20509c4b8b: block: freeze the backing chain earlier in stream_start() (Albe=
rto Garcia)
0f0998f621: block: continue until base is found in bdrv_freeze_backing_chai=
n() et al (Alberto Garcia)
696aaaed57: block/file-posix: do not fail on unlock bytes (Vladimir Sements=
ov-Ogievskiy)
38e694fcc9: tests/qemu-iotests: Remove redundant COPYING file (Thomas Huth)
de23e72bb7: block/gluster: limit the transfer size to 512 MiB (Stefano Garz=
arella)
a3d6ae2299: qemu-img: Enable BDRV_REQ_MAY_UNMAP in convert (Nir Soffer)
e0a59749ef: iotests: Fix test 200 on s390x without virtio-pci (Thomas Huth)
be1092afa0: audio: fix audio timer rate conversion bug (Volker R=C3=BCmelin)
b396733df3: usb-mtp: remove usb_mtp_object_free_one (Bandan Das)
4bc1591681: usb-mtp: fix return status of delete (Bandan Das)
75d34eb98c: nbd/client: Trace server noncompliance on structured reads (Eri=
c Blake)
b0245d6478: nbd/server: Advertise actual minimum block size (Eric Blake)
4841211e0d: block: Add bdrv_get_request_alignment() (Eric Blake)
9cf638508c: nbd/client: Support qemu-img convert from unaligned size (Eric =
Blake)
3add3ab782: nbd/client: Reject inaccessible tail of inconsistent server (Er=
ic Blake)
5189e30b14: hw/usb/bus.c: Handle "no speed matched" case in usb_mask_to_str=
() (Peter Maydell)
28605a22f5: Revert "audio: fix pc speaker init" (Gerd Hoffmann)
a62a85ef5c: nbd/client: Report offsets in bdrv_block_status (Eric Blake)
7da537f70d: nbd/client: Lower min_block for block-status, unaligned size (E=
ric Blake)
e9dce9cb6e: iotests: Add 241 to test NBD on unaligned images (Eric Blake)
737d3f5244: nbd-client: Work around server BLOCK_STATUS misalignment at EOF=
 (Eric Blake)
30065d1424: qemu-img: Gracefully shutdown when map can't finish (Eric Blake)
ebd82cd872: nbd: Permit simple error to NBD_CMD_BLOCK_STATUS (Eric Blake)
b29f3a3d2a: nbd: Don't lose server's error to NBD_CMD_BLOCK_STATUS (Eric Bl=
ake)
a39286dd61: nbd: Tolerate some server non-compliance in NBD_CMD_BLOCK_STATU=
S (Eric Blake)
2058c2ad26: qemu-img: Report bdrv_block_status failures (Eric Blake)
ab79237a15: net: tap: use qemu_set_nonblock (Li Qiang)
c6bf50ff72: MAINTAINERS: Update the latest email address (Zhang Chen)
157628d067: e1000: Delay flush queue when receive RCTL (yuchenlin)
fdec16e3c2: net/socket: learn to talk with a unix dgram socket (Marc-Andr=
=C3=A9 Lureau)
7d5489e6d1: exec: Only count mapped memory backends for qemu_getrampagesize=
() (David Gibson)
273fef83f6: spapr/irq: Add XIVE sanity checks on non-P9 machines (C=C3=A9dr=
ic Le Goater)
0a794529bd: spapr: Simplify handling of host-serial and host-model values (=
David Gibson)
3e5365b7aa: target/ppc: Fix QEMU crash with stxsdx (Greg Kurz)
15d68c5e1d: target/ppc: Improve comment of bcctr used for spectre v2 mitiga=
tion (Greg Kurz)
d0db7caddb: target/ppc: Consolidate 64-bit server processor detection in a =
helper (Greg Kurz)
fa200c95f7: target/ppc: Enable "decrement and test CTR" version of bcctr (G=
reg Kurz)
9acc95cdd3: target/ppc: Fix TCG temporary leaks in gen_bcond() (Greg Kurz)
c3c962c12c: MAINTAINERS: Update the device tree maintainers (Alistair Franc=
is)
035121d23a: seccomp: report more useful errors from seccomp (Daniel P. Berr=
ang=C3=A9)
9a1565a03b: seccomp: don't kill process for resource control syscalls (Dani=
el P. Berrang=C3=A9)
22e3284f01: pc-bios: Update palcode-clipper (Richard Henderson)
bc19449acc: tests/tcg/xtensa: clean up test set (Max Filippov)
393cf60bf7: target/xtensa: don't announce exit simcall (Max Filippov)
b9ec52188f: target/xtensa: fix break_dependency for repeated resources (Max=
 Filippov)
938912a866: virtio-vga: only enable for specific boards (Paolo Bonzini)
b7c11e5749: config-all-devices.mak: rebuild on reconfigure (Paolo Bonzini)
67163caeba: minikconf: fix parser typo (Paolo Bonzini)
4b519ef1de: intel-iommu: optimize nodmar memory regions (Peter Xu)
8b159699d4: test-announce-self: convert to qgraph (Paolo Bonzini)
9ad4994661: hw/alpha/Kconfig: DP264 hardware requires e1000 network card (P=
hilippe Mathieu-Daud=C3=A9)
b6dbcdb7b3: hw/hppa/Kconfig: Dino board requires e1000 network card (Philip=
pe Mathieu-Daud=C3=A9)
364efd1a15: hw/sh4/Kconfig: r2d machine requires the rtl8139 network card (=
Philippe Mathieu-Daud=C3=A9)
bcb7ef9d1b: hw/ppc/Kconfig: e500 based machines require virtio-net-pci devi=
ce (Philippe Mathieu-Daud=C3=A9)
f7b5cdcbf2: hw/ppc/Kconfig: Bamboo machine requires e1000 network card (Phi=
lippe Mathieu-Daud=C3=A9)
b5ea7070e5: hw/mips/Kconfig: Fulong 2e board requires ati-vga/rtl8139 PCI d=
evices (Philippe Mathieu-Daud=C3=A9)
892da02848: hw/mips/Kconfig: Malta machine requires the pcnet network card =
(Philippe Mathieu-Daud=C3=A9)
09cba51e4f: hw/i386/Kconfig: enable devices that can be created by default =
(Philippe Mathieu-Daud=C3=A9)
fa80da7b69: hw/isa/Kconfig: PIIX4 southbridge requires USB UHCI (Philippe M=
athieu-Daud=C3=A9)
aa889f7304: hw/isa/Kconfig: i82378 SuperIO requires PC speaker device (Phil=
ippe Mathieu-Daud=C3=A9)
b4f15fc4c1: prep: do not select I82374 (Paolo Bonzini)
b377471ac8: hw/i386/Kconfig: PC uses I8257, not I82374 (Paolo Bonzini)
3e3fdad6e1: hw/char/parallel: Make it possible to compile also without CONF=
IG_PARALLEL (Thomas Huth)
cedc0ad539: target/i386: sev: Do not pin the ram device memory region (Sing=
h, Brijesh)
2ddb89b00f: memory: Fix the memory region type assignment order (Singh, Bri=
jesh)
d6c1bd4a22: kconfig: add dependencies on CONFIG_MSI_NONBROKEN (Paolo Bonzin=
i)
ca9b7e29de: kconfig: add CONFIG_MSI_NONBROKEN (Paolo Bonzini)
4f5604c41d: riscv: plic: Set msi_nonbroken as true (Alistair Francis)


