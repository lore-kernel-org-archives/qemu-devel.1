Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13727C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 08:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB31C2082C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 08:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB31C2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzd4m-0005aM-VC
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 04:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sathnaga@linux.vnet.ibm.com>) id 1hzd26-0002m5-T4
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sathnaga@linux.vnet.ibm.com>) id 1hzd24-0000Bc-VJ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:28:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44540
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sathnaga@linux.vnet.ibm.com>)
 id 1hzd24-0000AJ-Qp
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:28:52 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7J8RvG2054863
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 04:28:52 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ufmwx7bjc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 04:28:51 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sathnaga@linux.vnet.ibm.com>;
 Mon, 19 Aug 2019 09:28:49 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 19 Aug 2019 09:28:46 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7J8SjUW49742010
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Aug 2019 08:28:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F175A405C;
 Mon, 19 Aug 2019 08:28:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9285A405B;
 Mon, 19 Aug 2019 08:28:42 +0000 (GMT)
Received: from sathnaga86.in.ibm.com (unknown [9.193.110.61])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 19 Aug 2019 08:28:42 +0000 (GMT)
From: sathnaga@linux.vnet.ibm.com
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 13:58:40 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
X-TM-AS-GCONF: 00
x-cbid: 19081908-0028-0000-0000-0000039143D2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081908-0029-0000-0000-0000245362AC
Message-Id: <20190819082840.14873-1-sathnaga@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-19_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190098
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x7J8RvG2054863
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH V2 2/2] tests.acceptance.boot_linux_console:
 Add pseries linux boot console test
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
Cc: ehabkost@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 crosa@redhat.com, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Add pseries linux boot console test

$avocado --show=3Dconsole run -t arch:ppc64le boot_linux_console.py
console: SLOF ***********************************************************=
***********
console: QEMU Starting
console:  Build Date =3D Jul  3 2019 12:26:14
console: FW Version =3D git-ba1ab360eebe6338
console: Press "s" to enter Open Firmware.
console: C0000
console: C0100
console: C0120
console: C0140
console: C0200
console: C0240
console: C0260
console: C02E0
console: C0300
console: C0320
console: C0340
console: C0360
console: C0370
console: C0380
console: C0371
console: C0372
console: C0373
console: C0374
console: C03F0
console: C0400
console: C0480
console: C04C0
console: C04D0
console: C0500
console: Populating /vdevice methods
console: Populating /vdevice/vty@71000000
console: Populating /vdevice/nvram@71000001
console: Populating /vdevice/l-lan@71000002
console: Populating /vdevice/v-scsi@71000003
console: SCSI: Looking for devices
console: 8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
console: C05A0
console: Populating /pci@800000020000000
console: C0600
console: C06C0
console: C0700
console: C0800
console: C0880
console: No NVRAM common partition, re-initializing...
console: C0890
console: C08A0
console: C08A8
console: C08B0
console: Scanning USB
console: C08C0
console: C08D0
console: Using default console: /vdevice/vty@71000000
console: C08E0
console: C08E8
console: Detected RAM kernel at 400000 (1a57b38 bytes)
console: C08FF
console: Welcome to Open Firmware
console: Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
console: This program and the accompanying materials are made available
console: under the terms of the BSD License available at
console: http://www.opensource.org/licenses/bsd-license.php
console: Booting from memory...
console: OF stdout device is: /vdevice/vty@71000000
console: Preparing to boot Linux version 4.15.0-50-generic (buildd@bos02-=
ppc64el-006) (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #54-Ubuntu SMP =
Mon May 6 18:55:18 UTC 2019 (Ubuntu 4.15.0-50.54-generic 4.15.18)
console: Detected machine type: 0000000000000101
console: command line: printk.time=3D0 console=3Dhvc0
console: Max number of cores passed to firmware: u (NR_CPUS =3D 2048)
console: Calling ibm,client-architecture-support... done
console: memory layout at init:
console: memory_limit : 0000000000000000 (16 MB aligned)
console: alloc_bottom : 0000000001e70000
console: alloc_top    : 0000000020000000
console: alloc_top_hi : 0000000020000000
console: rmo_top      : 0000000020000000
console: ram_top      : 0000000020000000
console: instantiating rtas at 0x000000001daf0000... done
console: prom_hold_cpus: skipped
console: copying OF device tree...
console: Building dt strings...
console: Building dt structure...
console: Device tree strings 0x0000000001e80000 -> 0x0000000001e80a46
console: Device tree struct  0x0000000001e90000 -> 0x0000000001ea0000
console: Quiescing Open Firmware ...
console: Booting Linux via __start() @ 0x0000000000400000 ...
console: [    0.000000] hash-mmu: Page sizes from device-tree:
console: [    0.000000] hash-mmu: base_shift=3D12: shift=3D12, sllp=3D0x0=
000, avpnm=3D0x00000000, tlbiel=3D1, penc=3D0
console: [    0.000000] hash-mmu: base_shift=3D16: shift=3D16, sllp=3D0x0=
110, avpnm=3D0x00000000, tlbiel=3D1, penc=3D1
console: [    0.000000] Using 1TB segments
console: [    0.000000] hash-mmu: Initializing hash mmu with SLB
console: [    0.000000] Linux version 4.15.0-50-generic (buildd@bos02-ppc=
64el-006) (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #54-Ubuntu SMP Mon=
 May 6 18:55:18 UTC 2019 (Ubuntu 4.15.0-50.54-generic 4.15.18)
console: [    0.000000] Using pSeries machine description
console: [    0.000000] bootconsole [udbg0] enabled
console: [    0.000000] Partition configured for 1 cpus.
console: [    0.000000] CPU maps initialized for 1 thread per core
console: -> smp_release_cpus()
console: spinning_secondaries =3D 0
console: <- smp_release_cpus()
console: [    0.000000] -------------------------------------------------=
----
console: [    0.000000] ppc64_pft_size    =3D 0x16
console: [    0.000000] phys_mem_size     =3D 0x20000000
console: [    0.000000] dcache_bsize      =3D 0x80
console: [    0.000000] icache_bsize      =3D 0x80
console: [    0.000000] cpu_features      =3D 0x000000eb8f4d91a7
console: [    0.000000]   possible        =3D 0x0000fffbfffff1af
console: [    0.000000]   always          =3D 0x00000000000001a0
console: [    0.000000] cpu_user_features =3D 0xdc0065c2 0xae000000
console: [    0.000000] mmu_features      =3D 0x78006001
console: [    0.000000] firmware_features =3D 0x00000001455a445f
console: [    0.000000] htab_hash_mask    =3D 0x7fff
console: [    0.000000] -------------------------------------------------=
----
console: [    0.000000] numa:   NODE_DATA [mem 0x1ffc3c80-0x1ffcffff]
console: [    0.000000] rfi-flush: fallback displacement flush available
console: [    0.000000] rfi-flush: ori type flush available
console: [    0.000000] rfi-flush: mttrig type flush available
console: [    0.000000] count-cache-flush: full software flush sequence e=
nabled.
console: [    0.000000] stf-barrier: hwsync barrier available
console: [    0.000000] PCI host bridge /pci@800000020000000  ranges:
console: [    0.000000]   IO 0x0000200000000000..0x000020000000ffff -> 0x=
0000000000000000
console: [    0.000000]  MEM 0x0000200080000000..0x00002000ffffffff -> 0x=
0000000080000000
console: [    0.000000]  MEM 0x0000210000000000..0x000021ffffffffff -> 0x=
0000210000000000
console: [    0.000000] PPC64 nvram contains 65536 bytes
console: [    0.000000] barrier-nospec: using ORI speculation barrier
console: [    0.000000] Zone ranges:
console: [    0.000000]   DMA      [mem 0x0000000000000000-0x000000001fff=
ffff]
console: [    0.000000]   DMA32    empty
console: [    0.000000]   Normal   empty
console: [    0.000000]   Device   empty
console: [    0.000000] Movable zone start for each node
console: [    0.000000] Early memory node ranges
console: [    0.000000]   node   0: [mem 0x0000000000000000-0x000000001ff=
fffff]
console: [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00=
0000001fffffff]
console: [    0.000000] percpu: Embedded 4 pages/cpu @        (ptrval) s1=
71032 r0 d91112 u1048576
console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total p=
ages: 8184
console: [    0.000000] Policy zone: DMA
console: [    0.000000] Kernel command line: printk.time=3D0 console=3Dhv=
c0

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
---
 tests/acceptance/boot_linux_console.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 32159503e9..b808245273 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -90,6 +90,26 @@ class BootLinuxConsole(Test):
         console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
         self.wait_for_console_pattern(console_pattern)
=20
+    def test_ppc64le_pseries(self):
+        """
+        :avocado: tags=3Darch:ppc64le
+        :avocado: tags=3Dmachine:pseries
+        """
+        kernel_url =3D ('http://ports.ubuntu.com/ubuntu-ports/'
+                      'dists/bionic-updates/main/installer-ppc64el/'
+                      'current/images/netboot/ubuntu-installer/ppc64el/v=
mlinux')
+        kernel_hash =3D '2b8f6dae700aaee44a1371e878570bc9d4b77fa3'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
+
+        self.vm.set_machine('pseries')
+        self.vm.set_console()
+        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3Dhvc0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line, '-enable-kvm')
+        self.vm.launch()
+        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
+        self.wait_for_console_pattern(console_pattern)
+
     def test_mips_malta(self):
         """
         :avocado: tags=3Darch:mips
--=20
2.21.0


