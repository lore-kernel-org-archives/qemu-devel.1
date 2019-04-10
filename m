Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BE3C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 19:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C2320820
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 19:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C2320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37031 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEJGp-0007wZ-Sg
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 15:52:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hEJFm-0007Ul-2S
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hEJFk-0001P1-6I
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:51:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hEJFg-0001Iu-CE
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:51:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3AJnabx072714
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 15:51:14 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rsmj1ex4j-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 15:51:13 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 10 Apr 2019 20:51:13 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
	by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 10 Apr 2019 20:51:10 +0100
Received: from b03ledav005.gho.boulder.ibm.com
	(b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3AJp9XH56492212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 10 Apr 2019 19:51:09 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A197BE05A;
	Wed, 10 Apr 2019 19:51:09 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F30F9BE058;
	Wed, 10 Apr 2019 19:51:07 +0000 (GMT)
Received: from localhost (unknown [9.80.109.80])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed, 10 Apr 2019 19:51:07 +0000 (GMT)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Date: Wed, 10 Apr 2019 14:51:03 -0500
X-TM-AS-GCONF: 00
x-cbid: 19041019-0004-0000-0000-000014FB0A44
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010904; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000284; SDB=6.01187199; UDB=6.00621844;
	IPR=6.00967963; 
	MB=3.00026381; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-10 19:51:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041019-0005-0000-0000-00008B361365
Message-Id: <155492586302.15309.9543551179442327138@sif>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-10_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904100129
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [ANNOUNCE] QEMU 4.0.0-rc3 is now available
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410195103.PQ3oddmlz-DCo5-6akVoNsqtrtNVJuhJKhQKn6beMWY@z>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fourth release candidate for the QEMU 4.0 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-4.0.0-rc3.tar.xz
  http://download.qemu-project.org/qemu-4.0.0-rc3.tar.xz.sig

A note from the maintainer:

  If no release-critical bugs are reported with this release
  candidate, then we plan to release with no further changes
  on the 16th April. If we need to roll an rc4 then we'll do
  that on the 16th, with final 4.0.0 release on the 23rd.

You can help improve the quality of the QEMU 4.0 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/4.0

Please add entries to the ChangeLog for the 4.0 release below:

  http://wiki.qemu.org/ChangeLog/4.0

Thank you to everyone involved!

Changes since rc2:

532cc6da74: Update version for v4.0.0-rc3 release (Peter Maydell)
065e6298a7: device_tree: Fix integer overflowing in load_device_tree() (Mar=
kus Armbruster)
f151f8aca5: migration/ram.c: Fix use-after-free in multifd_recv_unfill_pack=
et() (Peter Maydell)
3e20c81ed8: tests: Make check-block a phony target (Markus Armbruster)
ae909496e9: hw/i386/pc: Fix crash when hot-plugging nvdimm on older machine=
 types (Thomas Huth)
77b1757090: include/qemu/bswap.h: Use __builtin_memcpy() in accessor functi=
ons (Peter Maydell)
1cab464136: roms: Allow passing configure options to the EDK2 build tools (=
Philippe Mathieu-Daud=C3=A9)
d912e795e0: roms: Rename the EFIROM variable to avoid clashing with iPXE (P=
hilippe Mathieu-Daud=C3=A9)
8cb2ca3d74: target/i386: Generate #UD for LOCK on a register increment (Pet=
er Maydell)
5cf0d326a0: spapr_pci: Fix extended config space accesses (Greg Kurz)
1c685a9026: pci: Allow PCI bus subtypes to support extended config space ac=
cesses (Greg Kurz)
e53f88df77: nbd/client: Fix error message for server with unusable sizing (=
Eric Blake)
099fbcd65c: nbd/server: Don't fail NBD_OPT_INFO for byte-aligned sources (E=
ric Blake)
6e280648d2: nbd/server: Trace client noncompliance on unaligned requests (E=
ric Blake)
2178a569be: nbd/server: Fix blockstatus trace (Eric Blake)
ab63817119: hmp: Fix drive_add ... format=3Dhelp crash (Markus Armbruster)
71ba74f67e: linux-user: rename gettid() to sys_gettid() to avoid clash with=
 glibc (Daniel P. Berrang=C3=A9)
184943d827: linux-user: assume __NR_gettid always exists (Daniel P. Berrang=
=C3=A9)
3f48686fac: block: Forward 'discard' to temporary overlay (Kevin Wolf)
c19f2b711e: test qgraph.c: Fix segs due to out of scope default (Dr. David =
Alan Gilbert)
c098aac7dc: tests/libqos: fix usage of bool in pci-spapr.c (Jafar Abdi)
08f7ad1b00: tests/libqos: fix usage of bool in pci-pc.c (Jafar Abdi)
d013283a46: migration: Fix migrate_set_parameter (Juan Quintela)
c6e5bafb6f: migration/ram.c: Fix codes conflict about bitmap_mutex (Zhang C=
hen)
79bcac250f: riscv: plic: Log guest errors (Alistair Francis)
0feb4a7129: riscv: plic: Fix incorrect irq calculation (Alistair Francis)
2bcd05cf24: xen-block: scale sector based quantities correctly (Paul Durran=
t)
15f084505a: xen-block: only advertize discard to the frontend when it is en=
abled... (Paul Durrant)
7357b22159: hw/s390x/3270-ccw: avoid taking address of fields in packed str=
uct (Daniel P. Berrang=C3=A9)
5d45a33292: hw/s390x/ipl: avoid taking address of fields in packed struct (=
Daniel P. Berrang=C3=A9)
bea0279b72: hw/s390/css: avoid taking address members in packed structs (Da=
niel P. Berrang=C3=A9)
e1d0b37261: hw/vfio/ccw: avoid taking address members in packed structs (Da=
niel P. Berrang=C3=A9)
81fb1e646e: intel_iommu: Drop extended root field (Peter Xu)
2811af3b49: intel_iommu: Fix root_scalable migration breakage (Peter Xu)
20f86a75a7: virtio-net: Fix typo in comment (Yuval Shaia)
75c5626c88: intel_iommu: Correct caching-mode error message (Alex Williamso=
n)
22132828d1: acpi: verify file entries in bios_linker_loader_add_pointer() (=
Liam Merwick)


