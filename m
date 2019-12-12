Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F635C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2490C206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2490C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifYIi-00064r-8y
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 18:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1ifYHs-0005cO-GH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1ifYHr-0007Ky-6i
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:54:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1ifYHq-0007GG-TK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:54:27 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCNqahe061304; Thu, 12 Dec 2019 18:54:23 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuq3wrm3f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 18:54:23 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBCNnuAT005131;
 Thu, 12 Dec 2019 23:54:22 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03dal.us.ibm.com with ESMTP id 2wr3q86pct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 23:54:22 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBCNsLR643647378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 23:54:21 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 441AB6E04E;
 Thu, 12 Dec 2019 23:54:21 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DD3F6E04C;
 Thu, 12 Dec 2019 23:54:21 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 23:54:20 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <157619485543.32150.7989396570182598080@sif>
Subject: [ANNOUNCE] QEMU 4.2.0 is now available
Date: Thu, 12 Dec 2019 17:54:15 -0600
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_08:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 mlxlogscore=934 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120184
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 4.2.0 release. This release contains 2200+ commits from 198
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/4.2

Highlights include:

 * TCG plugin support for passive monitoring of instructions and memory acc=
esses
 * block: NBD block driver now supports more efficient handling of copy-on-=
read
   requests
 * block: NBD server optimizations for copying of sparse images, and general
   fixes/improvements for NBD server/client implementations
 * block/crypto: improved performance for AES-XTS encryption for LUKS disk
   encryption
 * vfio-pci support for "failover_pair_id" property for easier migration of
   VFIO devices
 * virtio-mmio now supports virtio-compatible v2 personality and virtio 1.1
   support for packed virtqueues

 * 68k: new "next-cube" machine for emulating a classic NeXTcube
 * 68k: new "q800" machine for emulating Macintosh Quadro 800
 * ARM: new "ast2600-evb" machine for  emulating Aspeed AST2600 SoC
 * ARM: semihosting v2.0 support with STDOUT_STDERR/EXIT_EXTENDED extentions
 * ARM: KVM support for more than 256 CPUs
 * ARM: "virt" machine now supports memory hotplugging
 * ARM: improved TCG emulation performance
 * ARM: KVM support for SVE SIMD instructions on SVE-capable hardware
 * PowerPC: emulation support for mffsce, mffscrn, and mffscrni POWER9
   instructions
 * PowerPC: "powernv" machine now supports Homer and OCC SRAM system devices
 * RISC-V: "-initrd" argument now supported
 * RISC-V: debugger can now see all architectural state
 * s390: emulation support for IEP (Instruction Execution Protection)
 * SPARC: "sun4u" IOMMU now supports "invert endianness" bit
 * x86: VMX features can be enabled/disabled via "-cpu" flags
 * x86: new "microvm" machine that uses virtio-mmio instead of PCI for use =
as
   baseline for performance optimizations
 * x86: emulation support for AVX512 BFloat16 extensions
 * x86: new CPU models for Denverton (server-class Atom-based SoC), Snowrid=
ge,
   and Dhyana
 * x86: macOS Hypervisor.framework support ("-accel hvf") now considered st=
able
 * xtensa: new "virt" machine type
 * xtensa: call0 ABI support for user-mode emulation

 * and lots more...

Thank you to everyone involved!


