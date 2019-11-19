Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCCCC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 22:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14180222DC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 22:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14180222DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXBrn-0001hy-72
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 17:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iXBqm-00018o-68
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 17:19:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iXBqk-0007p7-Mm
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 17:19:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15264
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iXBqk-0007ny-Hk
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 17:19:54 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAJM7FQc140185; Tue, 19 Nov 2019 17:19:51 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf583ysv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2019 17:19:51 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAJM5KGJ030164;
 Tue, 19 Nov 2019 22:19:55 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma01wdc.us.ibm.com with ESMTP id 2wa8r676y1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2019 22:19:55 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAJMJoot35324242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2019 22:19:50 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF822AC05B;
 Tue, 19 Nov 2019 22:19:50 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 886FFAC059;
 Tue, 19 Nov 2019 22:19:50 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 19 Nov 2019 22:19:50 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <157420196919.4193.6836320233726056229@sif>
Subject: [ANNOUNCE] QEMU 4.2.0-rc2 is now available
Date: Tue, 19 Nov 2019 16:19:29 -0600
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_08:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190178
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
third release candidate for the QEMU 4.2 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-4.2.0-rc2.tar.xz
  http://download.qemu-project.org/qemu-4.2.0-rc2.tar.xz.sig

You can help improve the quality of the QEMU 4.2 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/4.2

Please add entries to the ChangeLog for the 4.2 release below:

  http://wiki.qemu.org/ChangeLog/4.2

Thank you to everyone involved!

Changes since rc1:

39e2821077: Update version for v4.2.0-rc2 release (Peter Maydell)
abc7cf3655: hw/mips/gt64xxx: Remove dynamic field width from trace events (=
Philippe Mathieu-Daud=C3=A9)
10f9f1fbed: hw/block/pflash: Remove dynamic field width from trace events (=
Philippe Mathieu-Daud=C3=A9)
04c9c81b8f: target/arm: Support EL0 v7m msr/mrs for CONFIG_USER_ONLY (Richa=
rd Henderson)
d46ad79efa: target/arm: Relax r13 restriction for ldrex/strex for v8.0 (Ric=
hard Henderson)
655b02646d: target/arm: Do not reject rt =3D=3D rt2 for strexd (Richard Hen=
derson)
6623d21445: net/cadence_gem: Set PHY autonegotiation restart status (Linus =
Ziegert)
3a6606c7aa: ssi: xilinx_spips: Skip spi bus update for a few register write=
s (Sai Pavan Boddu)
6e553f2a1b: target/arm: Merge arm_cpu_vq_map_next_smaller into sole caller =
(Richard Henderson)
83ad95957c: pl031: Expose RTCICR as proper WC register (Alexander Graf)
7a3e29b12f: mc146818rtc: fix timer interrupt reinjection again (Paolo Bonzi=
ni)
3ae32adff1: Revert "mc146818rtc: fix timer interrupt reinjection" (Paolo Bo=
nzini)
0d074bf8e7: scsi: deprecate scsi-disk (Paolo Bonzini)
2f34ebf222: hw/i386: Move save_tsc_khz from PCMachineClass to X86MachineCla=
ss (Liam Merwick)
62e9dc3582: docs/microvm.rst: add instructions for shutting down the guest =
(Sergio Lopez)
ff9d708933: docs/microvm.rst: fix alignment in "Limitations" (Sergio Lopez)
7771e1ae1b: vfio: vfio-pci requires EDID (Paolo Bonzini)
c9d6da3a5e: hw/i386: Fix compiler warning when CONFIG_IDE_ISA is disabled (=
Thomas Huth)
7fac38635e: target/i386: Export TAA_NO bit to guests (Pawan Gupta)
7f7a585d5b: target/i386: add PSCHANGE_NO bit for the ARCH_CAPABILITIES MSR =
(Paolo Bonzini)
c3157b74c4: microvm: fix memory leak in microvm_fix_kernel_cmdline (Sergio =
Lopez)
b73f059cf2: scripts: Detect git worktrees for get_maintainer.pl --git (Alex=
ey Kardashevskiy)
2895aaa139: monitor/qmp: resume monitor when clearing its queue (Wolfgang B=
umiller)
296416ff0f: tests: More iotest 223 improvements (Eric Blake)
a98b1a1fef: iotests: Include QMP input in .out files (Eric Blake)
f3923a72f1: iotests: Switch nbd tests to use Unix rather than TCP (Eric Bla=
ke)
509e91c127: iotests: Fix 173 (Eric Blake)
052db8e714: MAINTAINERS: add more bitmap-related to Dirty Bitmaps section (=
Vladimir Sementsov-Ogievskiy)
93676c88d7: nbd: Don't send oversize strings (Eric Blake)
cf7c49cf6a: bitmap: Enforce maximum bitmap name length (Eric Blake)
9d7ab222da: nbd/server: Prefer heap over stack for parsing client names (Er=
ic Blake)
f61ffad53f: qemu-coroutine-sleep: Silence Coverity warning (Eric Blake)
a4d925f8f0: iotests: Test NBD client reconnection (Andrey Shinkevich)
29b95c992a: vfio: vfio-pci requires EDID (Paolo Bonzini)
ed92369a57: vfio: don't ignore return value of migrate_add_blocker (Jens Fr=
eimann)
1335d64323: hw/vfio/pci: Fix double free of migration_blocker (Michal Privo=
znik)
b1f6a8e180: iotests: Test multiple blockdev-snapshot calls (Kevin Wolf)
ae0f57f0aa: block: Remove 'backing': null from bs->{explicit_,}options (Kev=
in Wolf)
d44abcc0f7: iotests: Fix "no qualified output" error path (Kevin Wolf)
dbf231d7b4: qemu-iotests/iotests.py: improve assert_qmp message (Vladimir S=
ementsov-Ogievskiy)
0285747737: seabios: update to pre-1.13 snapshot again (Gerd Hoffmann)
cd8843ff25: mos6522: fix T1 and T2 timers (Laurent Vivier)
165dc3edd7: spapr/kvm: Set default cpu model for all machine classes (David=
 Gibson)
a49f62b9fd: spapr: Add /chosen to FDT only at reset time to preserve kernel=
 and initramdisk (Alexey Kardashevskiy)
0a83b47055: ppc: Skip partially initialized vCPUs in 'info pic' (Greg Kurz)
35886de140: xive, xics: Fix reference counting on CPU objects (Greg Kurz)
0990ce6a2e: ppc: Add intc_destroy() handlers to SpaprInterruptController/Pn=
vChip (Greg Kurz)
369e8f5bbd: buildfix: update texinfo menu (Gerd Hoffmann)
6911fde410: riscv/virt: Increase flash size (Alistair Francis)
3158add2bd: opensbi: Upgrade from v0.4 to v0.5 (Alistair Francis)
7ec5d3030b: target/riscv: Remove atomic accesses to MIP CSR (Alistair Franc=
is)
f480f6e8c5: remove unnecessary ifdef TARGET_RISCV64 (hiroyuki.obinata)
0221d73ce6: seabios: update to pre-1.13 snapshot (Gerd Hoffmann)


