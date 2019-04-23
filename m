Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED1AC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 20:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E143218D2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 20:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E143218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59358 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ2QC-0003zB-PX
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 16:53:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hJ2PN-0003gK-Cn
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hJ2PJ-00052o-GB
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:52:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36030
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hJ2PF-0004st-Nf
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:52:45 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3NKnXRW136857
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 16:52:36 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s28whu2tt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 16:52:36 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 23 Apr 2019 21:52:35 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
	by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 23 Apr 2019 21:52:32 +0100
Received: from b03ledav005.gho.boulder.ibm.com
	(b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3NKqVKB55115968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 23 Apr 2019 20:52:31 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B20B6BE054;
	Tue, 23 Apr 2019 20:52:31 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 684F0BE04F;
	Tue, 23 Apr 2019 20:52:31 +0000 (GMT)
Received: from localhost (unknown [9.80.95.60])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 23 Apr 2019 20:52:31 +0000 (GMT)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 15:52:22 -0500
X-TM-AS-GCONF: 00
x-cbid: 19042320-0012-0000-0000-0000172B0105
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010982; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01193382; UDB=6.00625592;
	IPR=6.00974202; 
	MB=3.00026562; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 20:52:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042320-0013-0000-0000-000056FC04F3
Message-Id: <155605274242.20501.8592407664900944363@sif>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-23_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=63 spamscore=0
	clxscore=1015 lowpriorityscore=63 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904230147
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [ANNOUNCE] QEMU 4.0.0 is now available
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
Message-ID: <20190423205222.GModej0_FUFTJAB3P69whnnELls4O7OTunaWBw-tXTQ@z>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 4.0.0 release. This release contains 3100+ commits from 220
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/4.0

Highlights include:

 * ARM: ARMv8+ extensions for SB, PredInv, HPD, LOR, FHM, AA32HPD,
   PAuth, JSConv, CondM, FRINT, and BTI
 * ARM: new emulation support for "Musca" and "MPS2" development boards
 * ARM: virt: support for >255GB of RAM and u-boot "noload" image types
 * ARM: improved emulation of ARM PMU
 * HPPA: support for TLB protection IDs and TLB trace events
 * MIPS: support for multi-threaded TCG emulation
 * MIPS: emulation support for I7200 I6500 CPUs, QMP-base querying of
   CPU types, and improved support for SAARI and SAAR configuration registe=
rs
 * MIPS: improvements to Interthread Communication Unit, Fulong 2E
   machine types, and end-user documentation.
 * PowerPC: pseries/powernv: support for POWER9 large decrementer
 * PowerPC: pseries: emulation support for XIVE interrupt controller
 * PowerPC: pseries: support for hotplugging PCI host bridges (PHBs)
 * PowerPC: pseries: Spectre/Meltdown mitigations enabled by default,
   additional support for count-cache-flush mitigation
 * RISC-V: virt: support for PCI and USB
 * RISC-V: support for TSR, TW, and TVM fields of mstatus, FS field now
   supports three stats (dirty, clean, and off)
 * RISC-V: built-in gdbserver supports register lists via XML files
 * s390: support for z14 GA 2 CPU model, Multiple-epoch and PTFF
   features now enabled in z14 CPU model by default
 * s390: vfio-ap: now supports hot plug/unplug, and no longer inhibits memo=
ry
   ballooning
 * s390: emulation support for floating-point extension facility and
   vector support instructions
 * x86: HAX accelerator now supported POSIX hosts other than Darwin,
   including Linux and NetBSD
 * x86: Q35: advertised PCIe root port speeds will now optimally default
   to maximum link speed (16GT/s) and width (x32) provided by PCIe 4.0 for
   QEMU 4.0+ machine types; older machine types will retain 2.5GT/x1
   defaults for compatibility.
 * x86: Xen PVH images can now be booted with "-kernel" option
 * Xtensa: xtfpga: improved SMP support for linux (interrupt
   distributor, IPI, and runstall) and new SMP-capable test_mmuhifi_c3
   core configuration
 * Xtensa: support for Flexible length instructions extension (FLIX)

 * GUI: new '-display spice-app' to configure/launch a Spice client GUI with
   a similar UI to QEMU GTK. VNC server now supports access controls via
   tls-authz/sasl-authz options
 * QMP: support for "out-of-band" command execution, can be useful for
   postcopy migration recovery. Additional QMP commands for working with
   block devices and dirty bitmaps
 * VFIO: EDID interface for supported mdev (Intel vGPU for kernel 5.0+),
   allows resolution setting via xres/yres options.
 * Xen: new 'xen-disk' device which can create a Xen PV disk backend,
   and performance improvements for Xen PV disk backend.
 * Network Block Device: improved tracing and error diagnostics, improved
   client compatibility with buggy NBD server implementations, new
   --bitmap, --list, --tls-authz options for qemu-nbd
 * virtio-blk now supports DISCARD and WRITE_ZEROES
 * pvrdma device now supports RDMA Management Datagram services (MAD)

 * and lots more...

Thank you to everyone involved!


