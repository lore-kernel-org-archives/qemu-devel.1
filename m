Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F8CC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF5520644
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF5520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyNOA-0001nN-ET
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 17:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hyNNM-0001Kz-Mt
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hyNNK-0004FR-Qy
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:33:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15964
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hyNNK-0004CK-Me
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:33:38 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7FLNM4i139799; Thu, 15 Aug 2019 17:33:32 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2udeaead1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Aug 2019 17:33:31 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7FLKwqF012312;
 Thu, 15 Aug 2019 21:33:31 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma04wdc.us.ibm.com with ESMTP id 2u9nj6djb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Aug 2019 21:33:31 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7FLXUAt40960416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Aug 2019 21:33:30 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF1FC28058;
 Thu, 15 Aug 2019 21:33:30 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 935FA28059;
 Thu, 15 Aug 2019 21:33:30 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 15 Aug 2019 21:33:30 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <156590479404.16788.7606937810094161612@sif>
Date: Thu, 15 Aug 2019 16:33:14 -0500
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-15_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=867 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150202
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [ANNOUNCE] QEMU 4.1.0 is now available
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

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 4.1.0 release. This release contains 2000+ commits from 176
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/4.1

Highlights include:

 * ARM: FPU emulation support for Cortex-M CPUs, FPU fixes for Cortex-R5F
 * ARM: ARMv8.5-RNG extension support for CPU-generated random numbers
 * ARM: board build options now configurable via new Kconfig-based system
 * ARM: Exynos4210 SoC model now supports PL330 DMA controllers
 * MIPS: improved emulation performance of numerous MSA instructions,
         mostly integer and data permuting operations
 * MIPS: improved support for MSA ASE instructions on big-endian hosts,
         handling for 'division by zero' cases now matches reference
         hardware
 * PowerPC: pseries: support for NVIDIA V100 GPU/NVLink2 passthrough via
            VFIO
 * PowerPC: pseries: in-kernel acceleration for XIVE interrupt controller
 * PowerPC: pseries: supporting for hot-plugging PCI host bridges
 * PowerPC: emulation optimizations for vector (Altivec/VSX) instructions
 * RISC-V: support for new "spike" machine model
 * RISC-V: ISA 1.11.0 support for privileged architectures
 * RISC-V: improvements for 32-bit syscall ABI, illegal instruction
           handling, and built-in debugger
 * RISC-V: support for CPU topology in device trees
 * s390: bios support for booting from ECKD DASD assigned to guest via
         vfio-ccw
 * s390: emulation support for all "Vector Facility" instructions
 * s390: additional facilities and support for gen15 machines, including
         support for AP Queue Interruption Facility for using interrupts
         for vfio-ap devices
 * SPARC: sun4m: sun4u: fixes when running with -vga none (OpenBIOS)
 * x86: emulation support for new Hygon Dhyana and Intel SnowRidge CPU
        models
 * x86: emulation support for RDRAND extension
 * x86: md-clear/mds-no feature flags, for detection/mitigation of MDS
        vulnerabilities (CVE-2018-12126, CVE-2018-12127, CVE-2018-12130,
        CVE-2019-11091)
 * x86: CPU die topology now configurable using -smp ...,dies=3D
 * Xtensa: support for memory protection unit (MPU) option
 * Xtensa: support for Exclusive Access option

 * GUI: virtio-gpu 2D/3D rendering may now be offloaded to an external
        vhost-user process, such as QEMU vhost-user-gpu
 * GUI: semihosting output can now be redirected to a chardev backend with
        -semihosting-config enable=3Don,target=3Dnative,chardev=3D[ID]
 * qemu-img: added a --salvage option to qemu-img convert, which prevents
             the conversion process from aborting on I/O errors (can be
             used for example to salvage partially corrupted qcow2 files)
 * qemu-img: qemu-img rebase works now even when the input file doesn't
             have a backing file yet
 * VMDK block driver now has read-only support for the seSparse subformat
 * GPIO: support for SiFive GPIO controller

 * and lots more...

Thank you to everyone involved!

