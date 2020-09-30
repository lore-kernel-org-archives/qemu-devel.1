Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D73C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3B22076B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3B22076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNat5-0002cj-CB
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 08:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kNarv-0002CU-N2
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:05:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:52624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kNarq-0006ho-61
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:05:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kNaro-0001w0-8f
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 12:05:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3B5C62E80AB
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 12:05:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2020 11:59:42 -0000
From: Sergiy K <1897481@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alex-l-williamson sergey-kukunin
X-Launchpad-Bug-Reporter: Sergiy K (sergey-kukunin)
X-Launchpad-Bug-Modifier: Sergiy K (sergey-kukunin)
References: <160123953126.1246.10707501292033522741.malonedeb@gac.canonical.com>
Message-Id: <160146718282.22373.13121335509354672760.malone@gac.canonical.com>
Subject: [Bug 1897481] Re: qemu crashes with VGA pass-through, e-GPU,
 nvidia 1060
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d685c0a40836eb9844ed835c9700f20633c1d7af"; Instance="production"
X-Launchpad-Hash: 11a12bef9307f4c6f6b7d1e73ac0209bff1c866b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 07:16:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1897481 <1897481@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dmesg:

[    0.000000] microcode: microcode updated early to revision 0x21, date =
=3D 2019-02-13
[    0.000000] Linux version 5.8.6-1-MANJARO (builder@db927223e331) (gcc (G=
CC) 10.2.0, GNU ld (GNU Binutils) 2.35) #1 SMP PREEMPT Thu Sep 3 14:19:36 U=
TC 2020
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-5.8-x86_64 root=3DU=
UID=3Df04fa3cc-b1c5-433a-896b-7194abdefa13 rw resume=3DUUID=3Df04fa3cc-b1c5=
-433a-896b-7194abdefa13 resume_offset=3D7829504 intel_iommu=3Don quiet resu=
me=3DUUID=3Df04fa3cc-b1c5-433a-896b-7194abdefa13 resume_offset=3D7829504 in=
tel_iommu=3Don
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  =

[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x00000000000bffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x0000000040003fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000040004000-0x0000000040004fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000040005000-0x00000000cfef6fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cfef7000-0x00000000d00f8fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000d00f9000-0x00000000d684efff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d684f000-0x00000000d6a4efff] type =
20
[    0.000000] BIOS-e820: [mem 0x00000000d6a4f000-0x00000000dae9efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000dae9f000-0x00000000daf9efff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000daf9f000-0x00000000daffefff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000dafff000-0x00000000daffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000db000000-0x00000000df9fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f80f8000-0x00000000f80f8fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041e5fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000041e600000-0x000000041effffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.31 by Lenovo
[    0.000000] efi: ACPI 2.0=3D0xdaffe014 ACPI=3D0xdaffe000 SMBIOS=3D0xdae9=
e000 =

[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: LENOVO 2325KZ5/2325KZ5, BIOS G2ETB5WW (2.75 ) 04/09/2019
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2594.172 MHz processor
[    0.000921] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000923] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000929] last_pfn =3D 0x41e600 max_arch_pfn =3D 0x400000000
[    0.000933] MTRR default type: uncachable
[    0.000934] MTRR fixed ranges enabled:
[    0.000935]   00000-9FFFF write-back
[    0.000936]   A0000-BFFFF uncachable
[    0.000937]   C0000-FFFFF write-protect
[    0.000938] MTRR variable ranges enabled:
[    0.000939]   0 base 0FFC00000 mask FFFC00000 write-protect
[    0.000940]   1 base 000000000 mask F80000000 write-back
[    0.000941]   2 base 080000000 mask FC0000000 write-back
[    0.000942]   3 base 0C0000000 mask FE0000000 write-back
[    0.000943]   4 base 0DC000000 mask FFC000000 uncachable
[    0.000944]   5 base 0DB000000 mask FFF000000 uncachable
[    0.000944]   6 base 100000000 mask F00000000 write-back
[    0.000945]   7 base 200000000 mask E00000000 write-back
[    0.000946]   8 base 400000000 mask FE0000000 write-back
[    0.000947]   9 base 41F000000 mask FFF000000 uncachable
[    0.001364] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
  =

[    0.001580] last_pfn =3D 0xdb000 max_arch_pfn =3D 0x400000000
[    0.011180] check: Scanning 1 areas for low memory corruption
[    0.011968] Secure boot could not be determined
[    0.011969] RAMDISK: [mem 0x3676b000-0x373acfff]
[    0.011975] ACPI: Early table checksum verification disabled
[    0.011979] ACPI: RSDP 0x00000000DAFFE014 000024 (v02 LENOVO)
[    0.011982] ACPI: XSDT 0x00000000DAFFE170 0000C4 (v01 LENOVO TP-G2    00=
002750 PTL  00000002)
[    0.011988] ACPI: FACP 0x00000000DAFE5000 00010C (v05 LENOVO TP-G2    00=
002750 PTL  00000002)
[    0.011994] ACPI: DSDT 0x00000000DAFE7000 011383 (v01 LENOVO TP-G2    00=
002750 INTL 20061109)
[    0.011997] ACPI: FACS 0x00000000DAF5A000 000040
[    0.012000] ACPI: SLIC 0x00000000DAFFD000 000176 (v01 LENOVO TP-G2    00=
002750 PTL  00000001)
[    0.012003] ACPI: TCPA 0x00000000DAFFC000 000032 (v02 PTL    LENOVO   06=
040000 LNVO 00000001)
[    0.012006] ACPI: SSDT 0x00000000DAFFB000 000408 (v01 LENOVO TP-SSDT2 00=
000200 INTL 20061109)
[    0.012009] ACPI: SSDT 0x00000000DAFFA000 000033 (v01 LENOVO TP-SSDT1 00=
000100 INTL 20061109)
[    0.012012] ACPI: SSDT 0x00000000DAFF9000 0007A8 (v01 LENOVO SataAhci 00=
001000 INTL 20061109)
[    0.012014] ACPI: HPET 0x00000000DAFE3000 000038 (v01 LENOVO TP-G2    00=
002750 PTL  00000002)
[    0.012017] ACPI: APIC 0x00000000DAFE2000 000098 (v01 LENOVO TP-G2    00=
002750 PTL  00000002)
[    0.012020] ACPI: MCFG 0x00000000DAFE1000 00003C (v01 LENOVO TP-G2    00=
002750 PTL  00000002)
[    0.012023] ACPI: ECDT 0x00000000DAFE0000 000052 (v01 LENOVO TP-G2    00=
002750 PTL  00000002)
[    0.012026] ACPI: FPDT 0x00000000DAFDF000 000064 (v01 LENOVO TP-G2    00=
002750 PTL  00000002)
[    0.012028] ACPI: ASF! 0x00000000DAFE6000 0000A5 (v32 LENOVO TP-G2    00=
002750 PTL  00000002)
[    0.012031] ACPI: UEFI 0x00000000DAFDE000 00003E (v01 LENOVO TP-G2    00=
002750 PTL  00000002)
[    0.012034] ACPI: UEFI 0x00000000DAFDD000 000042 (v01 PTL    COMBUF   00=
000001 PTL  00000001)
[    0.012037] ACPI: POAT 0x00000000DAFDC000 000055 (v03 LENOVO TP-G2    00=
002750 PTL  00000002)
[    0.012040] ACPI: SSDT 0x00000000DAFDB000 000C79 (v01 PmRef  Cpu0Ist  00=
003000 INTL 20061109)
[    0.012043] ACPI: SSDT 0x00000000DAFDA000 000A83 (v01 PmRef  CpuPm    00=
003000 INTL 20061109)
[    0.012046] ACPI: DMAR 0x00000000DAFD9000 0000B8 (v01 INTEL  SNB      00=
000001 INTL 00000001)
[    0.012049] ACPI: UEFI 0x00000000DAFD8000 000292 (v01 LENOVO TP-G2    00=
002750 PTL  00000002)
[    0.012052] ACPI: DBG2 0x00000000DAFD7000 0000E9 (v00 LENOVO TP-G2    00=
002750 PTL  00000002)
[    0.012059] ACPI: Local APIC address 0xfee00000
[    0.012101] No NUMA configuration found
[    0.012101] Faking a node at [mem 0x0000000000000000-0x000000041e5fffff]
[    0.012105] NODE_DATA(0) allocated [mem 0x41e5ef000-0x41e5f2fff]
[    0.012143] Zone ranges:
[    0.012144]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.012145]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.012146]   Normal   [mem 0x0000000100000000-0x000000041e5fffff]
[    0.012147]   Device   empty
[    0.012148] Movable zone start for each node
[    0.012148] Early memory node ranges
[    0.012149]   node   0: [mem 0x0000000000001000-0x000000000008ffff]
[    0.012150]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.012151]   node   0: [mem 0x0000000020200000-0x0000000040003fff]
[    0.012151]   node   0: [mem 0x0000000040005000-0x00000000cfef6fff]
[    0.012152]   node   0: [mem 0x00000000d00f9000-0x00000000d684efff]
[    0.012153]   node   0: [mem 0x00000000dafff000-0x00000000daffffff]
[    0.012153]   node   0: [mem 0x0000000100000000-0x000000041e5fffff]
[    0.012637] Zeroed struct page in unavailable ranges: 46628 pages
[    0.012639] Initmem setup node 0 [mem 0x0000000000001000-0x000000041e5ff=
fff]
[    0.012640] On node 0 totalpages: 4147676
[    0.012642]   DMA zone: 64 pages used for memmap
[    0.012642]   DMA zone: 92 pages reserved
[    0.012643]   DMA zone: 3983 pages, LIFO batch:0
[    0.012668]   DMA32 zone: 13650 pages used for memmap
[    0.012669]   DMA32 zone: 873549 pages, LIFO batch:63
[    0.018035]   Normal zone: 51096 pages used for memmap
[    0.018038]   Normal zone: 3270144 pages, LIFO batch:63
[    0.038035] Reserving Intel graphics memory at [mem 0xdba00000-0xdf9ffff=
f]
[    0.038332] ACPI: PM-Timer IO Port: 0x408
[    0.038335] ACPI: Local APIC address 0xfee00000
[    0.038343] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.038343] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.038355] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
23
[    0.038358] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.038359] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.038361] ACPI: IRQ0 used by override.
[    0.038362] ACPI: IRQ9 used by override.
[    0.038364] Using ACPI (MADT) for SMP configuration information
[    0.038365] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.038370] TSC deadline timer available
[    0.038371] smpboot: Allowing 8 CPUs, 4 hotplug CPUs
[    0.038390] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.038392] PM: hibernation: Registered nosave memory: [mem 0x00090000-0=
x000bffff]
[    0.038393] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0=
x000fffff]
[    0.038394] PM: hibernation: Registered nosave memory: [mem 0x20000000-0=
x201fffff]
[    0.038395] PM: hibernation: Registered nosave memory: [mem 0x40004000-0=
x40004fff]
[    0.038397] PM: hibernation: Registered nosave memory: [mem 0xcfef7000-0=
xd00f8fff]
[    0.038398] PM: hibernation: Registered nosave memory: [mem 0xd684f000-0=
xd6a4efff]
[    0.038399] PM: hibernation: Registered nosave memory: [mem 0xd6a4f000-0=
xdae9efff]
[    0.038400] PM: hibernation: Registered nosave memory: [mem 0xdae9f000-0=
xdaf9efff]
[    0.038400] PM: hibernation: Registered nosave memory: [mem 0xdaf9f000-0=
xdaffefff]
[    0.038402] PM: hibernation: Registered nosave memory: [mem 0xdb000000-0=
xdf9fffff]
[    0.038402] PM: hibernation: Registered nosave memory: [mem 0xdfa00000-0=
xf80f7fff]
[    0.038403] PM: hibernation: Registered nosave memory: [mem 0xf80f8000-0=
xf80f8fff]
[    0.038403] PM: hibernation: Registered nosave memory: [mem 0xf80f9000-0=
xfed1bfff]
[    0.038404] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0=
xfed1ffff]
[    0.038405] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0=
xffffffff]
[    0.038406] [mem 0xdfa00000-0xf80f7fff] available for PCI devices
[    0.038408] Booting paravirtualized kernel on bare hardware
[    0.038411] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.043530] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:8 n=
r_node_ids:1
[    0.043778] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
[    0.043785] pcpu-alloc: s192512 r8192 d28672 u262144 alloc=3D1*2097152
[    0.043786] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 =

[    0.043809] Built 1 zonelists, mobility grouping on.  Total pages: 40827=
74
[    0.043810] Policy zone: Normal
[    0.043811] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-5.8-x86_64 r=
oot=3DUUID=3Df04fa3cc-b1c5-433a-896b-7194abdefa13 rw resume=3DUUID=3Df04fa3=
cc-b1c5-433a-896b-7194abdefa13 resume_offset=3D7829504 intel_iommu=3Don qui=
et resume=3DUUID=3Df04fa3cc-b1c5-433a-896b-7194abdefa13 resume_offset=3D782=
9504 intel_iommu=3Don
[    0.043874] DMAR: IOMMU enabled
[    0.043916] DMAR: IOMMU enabled
[    0.044717] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.045120] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.045211] mem auto-init: stack:byref_all, heap alloc:on, heap free:off
[    0.086772] Memory: 16117516K/16590704K available (14339K kernel code, 1=
480K rwdata, 4656K rodata, 1648K init, 3016K bss, 473188K reserved, 0K cma-=
reserved)
[    0.086780] random: get_random_u64 called from __kmem_cache_create+0x3e/=
0x600 with crng_init=3D0
[    0.086908] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.086920] Kernel/User page tables isolation: enabled
[    0.086939] ftrace: allocating 40167 entries in 157 pages
[    0.101966] ftrace: allocated 157 pages with 5 groups
[    0.102079] rcu: Preemptible hierarchical RCU implementation.
[    0.102080] rcu: 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.102081] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D8.
[    0.102082] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.102083] 	Trampoline variant of Tasks RCU enabled.
[    0.102083] 	Rude variant of Tasks RCU enabled.
[    0.102084] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.102084] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.105514] NR_IRQS: 20736, nr_irqs: 488, preallocated irqs: 16
[    0.105776] Console: colour dummy device 80x25
[    0.105780] printk: console [tty0] enabled
[    0.105797] ACPI: Core revision 20200528
[    0.105953] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484882848 ns
[    0.105967] APIC: Switch to symmetric I/O mode setup
[    0.105969] DMAR: Host address width 36
[    0.105970] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.105975] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c0000020e602=
62 ecap f0101a
[    0.105976] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.105979] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap c90080206602=
62 ecap f0105a
[    0.105979] DMAR: RMRR base: 0x000000da2ba000 end: 0x000000da2d0fff
[    0.105981] DMAR: RMRR base: 0x000000db800000 end: 0x000000df9fffff
[    0.105983] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.105983] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.105984] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.
[    0.106395] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.106396] x2apic enabled
[    0.106403] Switched APIC routing to cluster x2apic.
[    0.106850] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.122635] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2564baca675, max_idle_ns: 440795329072 ns
[    0.122639] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 5190.52 BogoMIPS (lpj=3D8647240)
[    0.122642] pid_max: default: 32768 minimum: 301
[    0.128651] LSM: Security Framework initializing
[    0.128657] Yama: becoming mindful.
[    0.128696] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.128720] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.129469] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.129480] process: using mwait in idle threads
[    0.129482] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.129483] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.129486] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.129488] Spectre V2 : Mitigation: Full generic retpoline
[    0.129489] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.129489] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    0.129491] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.129491] Spectre V2 : User space: Mitigation: STIBP via seccomp and p=
rctl
[    0.129493] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl and seccomp
[    0.129496] SRBDS: Vulnerable: No microcode
[    0.129497] MDS: Mitigation: Clear CPU buffers
[    0.129713] Freeing SMP alternatives memory: 32K
[    0.131560] smpboot: CPU0: Intel(R) Core(TM) i5-3320M CPU @ 2.60GHz (fam=
ily: 0x6, model: 0x3a, stepping: 0x9)
[    0.131675] Performance Events: PEBS fmt1+, IvyBridge events, 16-deep LB=
R, full-width counters, Intel PMU driver.
[    0.131682] ... version:                3
[    0.131682] ... bit width:              48
[    0.131683] ... generic registers:      4
[    0.131683] ... value mask:             0000ffffffffffff
[    0.131684] ... max period:             00007fffffffffff
[    0.131684] ... fixed-purpose events:   3
[    0.131685] ... event mask:             000000070000000f
[    0.131727] rcu: Hierarchical SRCU implementation.
[    0.132580] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.132636] smp: Bringing up secondary CPUs ...
[    0.132636] x86: Booting SMP configuration:
[    0.132636] .... node  #0, CPUs:      #1
[    0.132748] MDS CPU bug present and SMT on, data leak possible. See http=
s://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more de=
tails.
[    0.132822]  #2 #3
[    0.138404] smp: Brought up 1 node, 4 CPUs
[    0.138404] smpboot: Max logical packages: 2
[    0.138404] smpboot: Total of 4 processors activated (20761.10 BogoMIPS)
[    0.139729] devtmpfs: initialized
[    0.139729] x86/mm: Memory block size: 128MB
[    0.140581] PM: Registering ACPI NVS region [mem 0xdae9f000-0xdaf9efff] =
(1048576 bytes)
[    0.140581] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.140581] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.140581] pinctrl core: initialized pinctrl subsystem
[    0.140581] PM: RTC time: 14:55:39, date: 2020-09-30
[    0.140581] thermal_sys: Registered thermal governor 'fair_share'
[    0.140581] thermal_sys: Registered thermal governor 'bang_bang'
[    0.140581] thermal_sys: Registered thermal governor 'step_wise'
[    0.140581] thermal_sys: Registered thermal governor 'user_space'
[    0.140581] thermal_sys: Registered thermal governor 'power_allocator'
[    0.140581] NET: Registered protocol family 16
[    0.140581] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.140581] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.140581] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.140581] audit: initializing netlink subsys (disabled)
[    0.140581] audit: type=3D2000 audit(1601477739.033:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.140581] cpuidle: using governor ladder
[    0.140581] cpuidle: using governor menu
[    0.140581] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    0.140581] ACPI: bus type PCI registered
[    0.140581] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.140581] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000=
-0xfbffffff] (base 0xf8000000)
[    0.140581] PCI: not using MMCONFIG
[    0.140581] PCI: Using configuration type 1 for base access
[    0.140581] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.142898] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.143934] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.143934] ACPI: Added _OSI(Module Device)
[    0.143934] ACPI: Added _OSI(Processor Device)
[    0.143934] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.143934] ACPI: Added _OSI(Processor Aggregator Device)
[    0.143934] ACPI: Added _OSI(Linux-Dell-Video)
[    0.143934] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.143934] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.160850] ACPI: 6 ACPI AML tables successfully acquired and loaded
[    0.161606] ACPI: EC: EC started
[    0.161606] ACPI: EC: interrupt blocked
[    0.162552] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.162553] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.162869] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.167432] ACPI: Dynamic OEM Table Load:
[    0.167440] ACPI: SSDT 0xFFFFA3690B880000 000A01 (v01 PmRef  Cpu0Cst  00=
003001 INTL 20061109)
[    0.168544] ACPI: Dynamic OEM Table Load:
[    0.168549] ACPI: SSDT 0xFFFFA3690BA2CC00 000303 (v01 PmRef  ApIst    00=
003000 INTL 20061109)
[    0.169420] ACPI: Dynamic OEM Table Load:
[    0.169425] ACPI: SSDT 0xFFFFA3690BA17800 000119 (v01 PmRef  ApCst    00=
003000 INTL 20061109)
[    0.171021] ACPI: Interpreter enabled
[    0.171043] ACPI: (supports S0 S3 S4 S5)
[    0.171044] ACPI: Using IOAPIC for interrupt routing
[    0.171070] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000=
-0xfbffffff] (base 0xf8000000)
[    0.171729] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in ACP=
I motherboard resources
[    0.171738] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.172087] ACPI: Enabled 6 GPEs in block 00 to 3F
[    0.175796] ACPI: Power Resource [PUBS] (on)
[    0.175953] acpi PNP0C0A:01: ACPI dock station (docks/bays count: 1)
[    0.177107] acpi LNXIOBAY:00: ACPI dock station (docks/bays count: 2)
[    0.179763] acpi IBM0079:00: ACPI dock station (docks/bays count: 3)
[    0.180348] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
[    0.180449] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11) *0,=
 disabled.
[    0.180547] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11) *0,=
 disabled.
[    0.180645] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11) *0,=
 disabled.
[    0.180742] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0,=
 disabled.
[    0.180839] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0,=
 disabled.
[    0.180936] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0,=
 disabled.
[    0.181034] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11) *0,=
 disabled.
[    0.181137] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    0.181142] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.181329] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplu=
g PCIeCapability LTR DPC]
[    0.181414] acpi PNP0A08:00: _OSC: not requesting control; platform does=
 not support [PCIeCapability]
[    0.181416] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHotplug=
 PME AER PCIeCapability LTR DPC]
[    0.181417] acpi PNP0A08:00: _OSC: platform willing to grant [PCIeHotplu=
g PME AER]
[    0.181418] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    0.181622] PCI host bridge to bus 0000:00
[    0.181624] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.181626] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.181627] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.181628] pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebffff=
f window]
[    0.181629] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed4bff=
f window]
[    0.181630] pci_bus 0000:00: root bus resource [bus 00-3f]
[    0.181640] pci 0000:00:00.0: [8086:0154] type 00 class 0x060000
[    0.181733] pci 0000:00:02.0: [8086:0166] type 00 class 0x030000
[    0.181745] pci 0000:00:02.0: reg 0x10: [mem 0xf0000000-0xf03fffff 64bit]
[    0.181750] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit=
 pref]
[    0.181755] pci 0000:00:02.0: reg 0x20: [io  0x7000-0x703f]
[    0.181768] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.181871] pci 0000:00:14.0: [8086:1e31] type 00 class 0x0c0330
[    0.181895] pci 0000:00:14.0: reg 0x10: [mem 0xf2520000-0xf252ffff 64bit]
[    0.181966] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.182056] pci 0000:00:16.0: [8086:1e3a] type 00 class 0x078000
[    0.182078] pci 0000:00:16.0: reg 0x10: [mem 0xf2535000-0xf253500f 64bit]
[    0.182143] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.182213] pci 0000:00:16.3: [8086:1e3d] type 00 class 0x070002
[    0.182231] pci 0000:00:16.3: reg 0x10: [io  0x70b0-0x70b7]
[    0.182240] pci 0000:00:16.3: reg 0x14: [mem 0xf253c000-0xf253cfff]
[    0.182374] pci 0000:00:19.0: [8086:1502] type 00 class 0x020000
[    0.182394] pci 0000:00:19.0: reg 0x10: [mem 0xf2500000-0xf251ffff]
[    0.182402] pci 0000:00:19.0: reg 0x14: [mem 0xf253b000-0xf253bfff]
[    0.182410] pci 0000:00:19.0: reg 0x18: [io  0x7080-0x709f]
[    0.182472] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.182560] pci 0000:00:1a.0: [8086:1e2d] type 00 class 0x0c0320
[    0.182583] pci 0000:00:1a.0: reg 0x10: [mem 0xf253a000-0xf253a3ff]
[    0.182670] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.182762] pci 0000:00:1b.0: [8086:1e20] type 00 class 0x040300
[    0.182784] pci 0000:00:1b.0: reg 0x10: [mem 0xf2530000-0xf2533fff 64bit]
[    0.182865] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.182961] pci 0000:00:1c.0: [8086:1e10] type 01 class 0x060400
[    0.183061] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.183084] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    0.183087] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    0.183175] pci 0000:00:1c.1: [8086:1e12] type 01 class 0x060400
[    0.183273] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.183295] pci 0000:00:1c.1: Enabling MPC IRBNCE
[    0.183297] pci 0000:00:1c.1: Intel PCH root port ACS workaround enabled
[    0.183384] pci 0000:00:1c.2: [8086:1e14] type 01 class 0x060400
[    0.183483] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.183503] pci 0000:00:1c.2: Enabling MPC IRBNCE
[    0.183506] pci 0000:00:1c.2: Intel PCH root port ACS workaround enabled
[    0.183596] pci 0000:00:1d.0: [8086:1e26] type 00 class 0x0c0320
[    0.183619] pci 0000:00:1d.0: reg 0x10: [mem 0xf2539000-0xf25393ff]
[    0.183704] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.183793] pci 0000:00:1f.0: [8086:1e55] type 00 class 0x060100
[    0.183982] pci 0000:00:1f.2: [8086:1e03] type 00 class 0x010601
[    0.184000] pci 0000:00:1f.2: reg 0x10: [io  0x70a8-0x70af]
[    0.184008] pci 0000:00:1f.2: reg 0x14: [io  0x70bc-0x70bf]
[    0.184015] pci 0000:00:1f.2: reg 0x18: [io  0x70a0-0x70a7]
[    0.184023] pci 0000:00:1f.2: reg 0x1c: [io  0x70b8-0x70bb]
[    0.184031] pci 0000:00:1f.2: reg 0x20: [io  0x7060-0x707f]
[    0.184038] pci 0000:00:1f.2: reg 0x24: [mem 0xf2538000-0xf25387ff]
[    0.184081] pci 0000:00:1f.2: PME# supported from D3hot
[    0.184164] pci 0000:00:1f.3: [8086:1e22] type 00 class 0x0c0500
[    0.184182] pci 0000:00:1f.3: reg 0x10: [mem 0xf2534000-0xf25340ff 64bit]
[    0.184203] pci 0000:00:1f.3: reg 0x20: [io  0xefa0-0xefbf]
[    0.184567] pci 0000:02:00.0: [1180:e823] type 00 class 0x088001
[    0.184595] pci 0000:02:00.0: MMC controller base frequency changed to 5=
0Mhz.
[    0.184633] pci 0000:02:00.0: reg 0x10: [mem 0xf1d00000-0xf1d000ff]
[    0.184864] pci 0000:02:00.0: supports D1 D2
[    0.184865] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.185275] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.185279] pci 0000:00:1c.0:   bridge window [io  0x6000-0x6fff]
[    0.185283] pci 0000:00:1c.0:   bridge window [mem 0xf1d00000-0xf24fffff]
[    0.185289] pci 0000:00:1c.0:   bridge window [mem 0xf0400000-0xf0bfffff=
 64bit pref]
[    0.185355] pci 0000:03:00.0: [10ec:8176] type 00 class 0x028000
[    0.185404] pci 0000:03:00.0: reg 0x10: [io  0x5000-0x50ff]
[    0.185452] pci 0000:03:00.0: reg 0x18: [mem 0xf1c00000-0xf1c03fff 64bit]
[    0.185646] pci 0000:03:00.0: supports D1 D2
[    0.185647] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.185820] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.185824] pci 0000:00:1c.1:   bridge window [io  0x5000-0x5fff]
[    0.185828] pci 0000:00:1c.1:   bridge window [mem 0xf1c00000-0xf1cfffff]
[    0.185904] acpiphp: Slot [1] registered
[    0.185910] pci 0000:00:1c.2: PCI bridge to [bus 04-0b]
[    0.185914] pci 0000:00:1c.2:   bridge window [io  0x4000-0x4fff]
[    0.185918] pci 0000:00:1c.2:   bridge window [mem 0xf1400000-0xf1bfffff]
[    0.185924] pci 0000:00:1c.2:   bridge window [mem 0xf0c00000-0xf13fffff=
 64bit pref]
[    0.187251] ACPI: EC: interrupt unblocked
[    0.187251] ACPI: EC: event unblocked
[    0.187257] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.187258] ACPI: EC: GPE=3D0x11
[    0.187260] ACPI: \_SB_.PCI0.LPC_.EC__: Boot ECDT EC initialization comp=
lete
[    0.187261] ACPI: \_SB_.PCI0.LPC_.EC__: EC: Used to handle transactions =
and events
[    0.187337] iommu: Default domain type: Translated =

[    0.187350] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.187350] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    0.187350] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.187350] vgaarb: loaded
[    0.187350] SCSI subsystem initialized
[    0.187350] libata version 3.00 loaded.
[    0.187350] ACPI: bus type USB registered
[    0.187350] usbcore: registered new interface driver usbfs
[    0.187350] usbcore: registered new interface driver hub
[    0.187350] usbcore: registered new device driver usb
[    0.187350] pps_core: LinuxPPS API ver. 1 registered
[    0.187350] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.187350] PTP clock support registered
[    0.187350] EDAC MC: Ver: 3.0.0
[    0.187350] Registered efivars operations
[    0.187350] NetLabel: Initializing
[    0.187350] NetLabel:  domain hash size =3D 128
[    0.187350] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.187350] NetLabel:  unlabeled traffic allowed by default
[    0.187350] PCI: Using ACPI for IRQ routing
[    0.187350] PCI: pci_cache_line_size set to 64 bytes
[    0.187350] e820: reserve RAM buffer [mem 0x40004000-0x43ffffff]
[    0.187350] e820: reserve RAM buffer [mem 0xcfef7000-0xcfffffff]
[    0.187350] e820: reserve RAM buffer [mem 0xd684f000-0xd7ffffff]
[    0.187350] e820: reserve RAM buffer [mem 0xdb000000-0xdbffffff]
[    0.187350] e820: reserve RAM buffer [mem 0x41e600000-0x41fffffff]
[    0.189970] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.189975] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.192689] clocksource: Switched to clocksource tsc-early
[    0.205145] VFS: Disk quotas dquot_6.6.0
[    0.205164] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.205242] pnp: PnP ACPI init
[    0.205897] system 00:00: [mem 0x00000000-0x0009ffff] could not be reser=
ved
[    0.205899] system 00:00: [mem 0x000c0000-0x000c3fff] could not be reser=
ved
[    0.205900] system 00:00: [mem 0x000c4000-0x000c7fff] could not be reser=
ved
[    0.205902] system 00:00: [mem 0x000c8000-0x000cbfff] has been reserved
[    0.205904] system 00:00: [mem 0x000cc000-0x000cffff] has been reserved
[    0.205905] system 00:00: [mem 0x000d0000-0x000d3fff] has been reserved
[    0.205906] system 00:00: [mem 0x000d4000-0x000d7fff] has been reserved
[    0.205908] system 00:00: [mem 0x000d8000-0x000dbfff] has been reserved
[    0.205909] system 00:00: [mem 0x000dc000-0x000dffff] has been reserved
[    0.205910] system 00:00: [mem 0x000e0000-0x000e3fff] has been reserved
[    0.205911] system 00:00: [mem 0x000e4000-0x000e7fff] has been reserved
[    0.205913] system 00:00: [mem 0x000e8000-0x000ebfff] has been reserved
[    0.205914] system 00:00: [mem 0x000ec000-0x000effff] has been reserved
[    0.205915] system 00:00: [mem 0x000f0000-0x000fffff] could not be reser=
ved
[    0.205916] system 00:00: [mem 0x00100000-0xdf9fffff] could not be reser=
ved
[    0.205918] system 00:00: [mem 0xfec00000-0xfed3ffff] could not be reser=
ved
[    0.205919] system 00:00: [mem 0xfed4c000-0xffffffff] could not be reser=
ved
[    0.205926] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.206051] pnp 00:01: [Firmware Bug]: PNP resource [mem 0xfed10000-0xfe=
d13fff] covers only part of 0000:00:00.0 Intel MCH; extending to [mem 0xfed=
10000-0xfed17fff]
[    0.206071] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.206072] system 00:01: [io  0x0500-0x057f] has been reserved
[    0.206073] system 00:01: [io  0x0800-0x080f] has been reserved
[    0.206075] system 00:01: [io  0x15e0-0x15ef] has been reserved
[    0.206076] system 00:01: [io  0x1600-0x167f] has been reserved
[    0.206079] system 00:01: [mem 0xf8000000-0xfbffffff] could not be reser=
ved
[    0.206080] system 00:01: [mem 0xfffff000-0xffffffff] has been reserved
[    0.206082] system 00:01: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.206083] system 00:01: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.206084] system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.206086] system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.206087] system 00:01: [mem 0xfed45000-0xfed4bfff] has been reserved
[    0.206091] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.206154] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.206177] pnp 00:03: Plug and Play ACPI device, IDs LEN0071 PNP0303 (a=
ctive)
[    0.206197] pnp 00:04: Plug and Play ACPI device, IDs LEN0020 PNP0f13 (a=
ctive)
[    0.206250] pnp 00:05: Plug and Play ACPI device, IDs SMO1200 PNP0c31 (a=
ctive)
[    0.206871] pnp: PnP ACPI: found 6 devices
[    0.212684] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.212744] NET: Registered protocol family 2
[    0.212898] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.212978] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.213207] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    0.213287] TCP: Hash tables configured (established 131072 bind 65536)
[    0.213405] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.213449] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)
[    0.213550] NET: Registered protocol family 1
[    0.213555] NET: Registered protocol family 44
[    0.213567] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.213571] pci 0000:00:1c.0:   bridge window [io  0x6000-0x6fff]
[    0.213577] pci 0000:00:1c.0:   bridge window [mem 0xf1d00000-0xf24fffff]
[    0.213581] pci 0000:00:1c.0:   bridge window [mem 0xf0400000-0xf0bfffff=
 64bit pref]
[    0.213587] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.213590] pci 0000:00:1c.1:   bridge window [io  0x5000-0x5fff]
[    0.213595] pci 0000:00:1c.1:   bridge window [mem 0xf1c00000-0xf1cfffff]
[    0.213603] pci 0000:00:1c.2: PCI bridge to [bus 04-0b]
[    0.213606] pci 0000:00:1c.2:   bridge window [io  0x4000-0x4fff]
[    0.213611] pci 0000:00:1c.2:   bridge window [mem 0xf1400000-0xf1bfffff]
[    0.213615] pci 0000:00:1c.2:   bridge window [mem 0xf0c00000-0xf13fffff=
 64bit pref]
[    0.213621] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.213623] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.213624] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.213625] pci_bus 0000:00: resource 7 [mem 0xdfa00000-0xfebfffff windo=
w]
[    0.213626] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed4bfff windo=
w]
[    0.213628] pci_bus 0000:02: resource 0 [io  0x6000-0x6fff]
[    0.213629] pci_bus 0000:02: resource 1 [mem 0xf1d00000-0xf24fffff]
[    0.213630] pci_bus 0000:02: resource 2 [mem 0xf0400000-0xf0bfffff 64bit=
 pref]
[    0.213631] pci_bus 0000:03: resource 0 [io  0x5000-0x5fff]
[    0.213632] pci_bus 0000:03: resource 1 [mem 0xf1c00000-0xf1cfffff]
[    0.213633] pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
[    0.213634] pci_bus 0000:04: resource 1 [mem 0xf1400000-0xf1bfffff]
[    0.213635] pci_bus 0000:04: resource 2 [mem 0xf0c00000-0xf13fffff 64bit=
 pref]
[    0.213740] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.214328] PCI: CLS 64 bytes, default 64
[    0.214377] Trying to unpack rootfs image as initramfs...
[    0.352872] Freeing initrd memory: 12552K
[    0.352906] DMAR: No ATSR found
[    0.352951] DMAR: dmar0: Using Queued invalidation
[    0.352956] DMAR: dmar1: Using Queued invalidation
[    0.428205] pci 0000:00:00.0: Adding to iommu group 0
[    0.428215] pci 0000:00:02.0: Adding to iommu group 1
[    0.428223] pci 0000:00:14.0: Adding to iommu group 2
[    0.428238] pci 0000:00:16.0: Adding to iommu group 3
[    0.428246] pci 0000:00:16.3: Adding to iommu group 3
[    0.428256] pci 0000:00:19.0: Adding to iommu group 4
[    0.428265] pci 0000:00:1a.0: Adding to iommu group 5
[    0.428273] pci 0000:00:1b.0: Adding to iommu group 6
[    0.428283] pci 0000:00:1c.0: Adding to iommu group 7
[    0.428291] pci 0000:00:1c.1: Adding to iommu group 8
[    0.428300] pci 0000:00:1c.2: Adding to iommu group 9
[    0.428308] pci 0000:00:1d.0: Adding to iommu group 10
[    0.428327] pci 0000:00:1f.0: Adding to iommu group 11
[    0.428336] pci 0000:00:1f.2: Adding to iommu group 11
[    0.428345] pci 0000:00:1f.3: Adding to iommu group 11
[    0.428520] pci 0000:02:00.0: Adding to iommu group 12
[    0.428529] pci 0000:03:00.0: Adding to iommu group 13
[    0.436768] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.436770] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.436772] software IO TLB: mapped [mem 0xc9b58000-0xcdb58000] (64MB)
[    0.436923] check: Scanning for low memory corruption every 60 seconds
[    0.437269] Initialise system trusted keyrings
[    0.437278] Key type blacklist registered
[    0.437328] workingset: timestamp_bits=3D41 max_order=3D22 bucket_order=
=3D0
[    0.438473] zbud: loaded
[    0.449701] Key type asymmetric registered
[    0.449702] Asymmetric key parser 'x509' registered
[    0.449710] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 245)
[    0.449758] io scheduler mq-deadline registered
[    0.449759] io scheduler kyber registered
[    0.449784] io scheduler bfq registered
[    0.450464] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.450538] efifb: probing for efifb
[    0.450554] efifb: No BGRT, not showing boot graphics
[    0.450555] efifb: framebuffer at 0xe0000000, using 1216k, total 1216k
[    0.450556] efifb: mode is 640x480x32, linelength=3D2560, pages=3D1
[    0.450557] efifb: scrolling: redraw
[    0.450558] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.450597] fbcon: Deferring console take-over
[    0.450598] fb0: EFI VGA frame buffer device
[    0.450605] intel_idle: MWAIT substates: 0x21120
[    0.450606] intel_idle: v0.5.1 model 0x3A
[    0.450787] intel_idle: Local APIC timer is reliable in all C-states
[    0.450840] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input0
[    0.452673] ACPI: Lid Switch [LID]
[    0.452708] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input1
[    0.452803] ACPI: Sleep Button [SLPB]
[    0.452856] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[    0.459347] ACPI: Power Button [PWRF]
[    0.461649] thermal LNXTHERM:00: registered as thermal_zone0
[    0.461650] ACPI: Thermal Zone [THM0] (69 C)
[    0.461851] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.462453] 0000:00:16.3: ttyS0 at I/O 0x70b0 (irq =3D 19, base_baud =3D=
 115200) is a 16550A
[    0.462614] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    0.462615] AMD-Vi: AMD IOMMUv2 functionality not available on this syst=
em
[    0.463199] ahci 0000:00:1f.2: version 3.0
[    0.463335] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    0.476048] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x=
13 impl SATA mode
[    0.476050] ahci 0000:00:1f.2: flags: 64bit ncq stag pm led clo pio slum=
 part ems sxs apst =

[    0.496625] scsi host0: ahci
[    0.496888] scsi host1: ahci
[    0.497098] scsi host2: ahci
[    0.497198] scsi host3: ahci
[    0.497278] scsi host4: ahci
[    0.497360] scsi host5: ahci
[    0.497398] ata1: SATA max UDMA/133 abar m2048@0xf2538000 port 0xf253810=
0 irq 29
[    0.497400] ata2: SATA max UDMA/133 abar m2048@0xf2538000 port 0xf253818=
0 irq 29
[    0.497401] ata3: DUMMY
[    0.497402] ata4: DUMMY
[    0.497404] ata5: SATA max UDMA/133 abar m2048@0xf2538000 port 0xf253830=
0 irq 29
[    0.497405] ata6: DUMMY
[    0.497458] usbcore: registered new interface driver usbserial_generic
[    0.497462] usbserial: USB Serial support registered for generic
[    0.497483] rtc_cmos 00:02: RTC can wake from S4
[    0.497692] rtc_cmos 00:02: registered as rtc0
[    0.497722] rtc_cmos 00:02: setting system clock to 2020-09-30T14:55:40 =
UTC (1601477740)
[    0.497738] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram=
, hpet irqs
[    0.497800] intel_pstate: Intel P-state driver initializing
[    0.498090] ledtrig-cpu: registered to indicate activity on CPUs
[    0.498292] drop_monitor: Initializing network drop monitor service
[    0.498617] NET: Registered protocol family 10
[    0.503608] Segment Routing with IPv6
[    0.503610] RPL Segment Routing with IPv6
[    0.503645] NET: Registered protocol family 17
[    0.503977] microcode: sig=3D0x306a9, pf=3D0x10, revision=3D0x21
[    0.504057] microcode: Microcode Update Driver: v2.2.
[    0.504061] IPI shorthand broadcast: enabled
[    0.504067] sched_clock: Marking stable (503804188, 248333)->(526000639,=
 -21948118)
[    0.504159] registered taskstats version 1
[    0.504166] Loading compiled-in X.509 certificates
[    0.506862] Loaded X.509 cert 'Build time autogenerated kernel key: 5996=
b3c054c5a5d45f30f3a31bd2b8088edb6449'
[    0.507441] zswap: loaded using pool zstd/z3fold
[    0.507638] Key type ._fscrypt registered
[    0.507639] Key type .fscrypt registered
[    0.507639] Key type fscrypt-provisioning registered
[    0.507942] PM:   Magic number: 4:649:941
[    0.508087] RAS: Correctable Errors collector initialized.
[    0.812686] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.813178] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succee=
ded
[    0.813180] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK=
) filtered out
[    0.813182] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filter=
ed out
[    0.813570] ata1.00: supports DRM functions and may not be fully accessi=
ble
[    0.814813] ata1.00: ATA-11: Samsung SSD 860 EVO 1TB, RVT02B6Q, max UDMA=
/133
[    0.814817] ata1.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth 32), =
AA
[    0.817782] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succee=
ded
[    0.817788] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK=
) filtered out
[    0.817791] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filter=
ed out
[    0.818135] ata1.00: supports DRM functions and may not be fully accessi=
ble
[    0.821054] ata1.00: configured for UDMA/133
[    0.832922] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 860  2B=
6Q PQ: 0 ANSI: 5
[    0.833090] ata1.00: Enabling discard_zeroes_data
[    0.833177] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/932 GiB)
[    0.833186] sd 0:0:0:0: [sda] Write Protect is off
[    0.833188] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.833200] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.833383] ata1.00: Enabling discard_zeroes_data
[    0.835027]  sda: sda1 sda2 sda3 sda4 sda5 sda6
[    0.835615] ata1.00: Enabling discard_zeroes_data
[    0.836706] sd 0:0:0:0: [sda] supports TCG Opal
[    0.836708] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.149363] ata2: SATA link down (SStatus 0 SControl 300)
[    1.439347] tsc: Refined TSC clocksource calibration: 2594.106 MHz
[    1.439360] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x256=
47bfab01, max_idle_ns: 440795211785 ns
[    1.439409] clocksource: Switched to clocksource tsc
[    1.462669] ata5: SATA link down (SStatus 0 SControl 300)
[    1.465182] Freeing unused decrypted memory: 2040K
[    1.465785] Freeing unused kernel image (initmem) memory: 1648K
[    1.465870] Write protecting the kernel read-only data: 22528k
[    1.467009] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.467616] Freeing unused kernel image (rodata/data gap) memory: 1488K
[    1.559627] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.559629] x86/mm: Checking user space page tables
[    1.606251] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.606257] Run /init as init process
[    1.606258]   with arguments:
[    1.606259]     /init
[    1.606260]   with environment:
[    1.606260]     HOME=3D/
[    1.606260]     TERM=3Dlinux
[    1.606261]     BOOT_IMAGE=3D/boot/vmlinuz-5.8-x86_64
[    1.606261]     intel_iommu=3Don
[    1.694613] VFIO - User Level meta-driver version: 0.3
[    1.700271] vfio_pci: add [10de:1c03[ffffffff:ffffffff]] class 0x000000/=
00000000
[    1.700275] vfio_pci: add [10de:10f1[ffffffff:ffffffff]] class 0x000000/=
00000000
[    1.764714] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    1.766602] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.766655] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.776170] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.789364] ehci-pci: EHCI PCI platform driver
[    1.789543] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    1.790301] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus =
number 1
[    1.790317] ehci-pci 0000:00:1a.0: debug port 2
[    1.795166] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    1.795190] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf253a000
[    1.798914] sdhci: Secure Digital Host Controller Interface driver
[    1.798916] sdhci: Copyright(c) Pierre Ossman
[    1.801256] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input3
[    1.804905] sdhci-pci 0000:02:00.0: SDHCI controller found [1180:e823] (=
rev 4)
[    1.805339] mmc0 bounce up to 128 segments into one, max segment size 65=
536 bytes
[    1.805692] mmc0: SDHCI controller on PCI [0000:02:00.0] using DMA
[    1.806182] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    1.806293] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.08
[    1.806295] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.806297] usb usb1: Product: EHCI Host Controller
[    1.806298] usb usb1: Manufacturer: Linux 5.8.6-1-MANJARO ehci_hcd
[    1.806300] usb usb1: SerialNumber: 0000:00:1a.0
[    1.806450] hub 1-0:1.0: USB hub found
[    1.806461] hub 1-0:1.0: 3 ports detected
[    1.806654] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.806661] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    1.807744] xhci_hcd 0000:00:14.0: hcc params 0x20007181 hci version 0x1=
00 quirks 0x000000000000b930
[    1.807750] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.807908] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.08
[    1.807910] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.807911] usb usb2: Product: xHCI Host Controller
[    1.807912] usb usb2: Manufacturer: Linux 5.8.6-1-MANJARO xhci-hcd
[    1.807913] usb usb2: SerialNumber: 0000:00:14.0
[    1.808031] hub 2-0:1.0: USB hub found
[    1.808041] hub 2-0:1.0: 4 ports detected
[    1.808472] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    1.808478] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus =
number 3
[    1.808494] ehci-pci 0000:00:1d.0: debug port 2
[    1.808509] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.808512] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 4
[    1.808515] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    1.808574] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.08
[    1.808575] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.808577] usb usb4: Product: xHCI Host Controller
[    1.808578] usb usb4: Manufacturer: Linux 5.8.6-1-MANJARO xhci-hcd
[    1.808579] usb usb4: SerialNumber: 0000:00:14.0
[    1.808685] hub 4-0:1.0: USB hub found
[    1.808697] hub 4-0:1.0: 4 ports detected
[    1.812429] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    1.812446] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf2539000
[    1.822660] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.822720] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.08
[    1.822722] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.822723] usb usb3: Product: EHCI Host Controller
[    1.822724] usb usb3: Manufacturer: Linux 5.8.6-1-MANJARO ehci_hcd
[    1.822725] usb usb3: SerialNumber: 0000:00:1d.0
[    1.823025] hub 3-0:1.0: USB hub found
[    1.823033] hub 3-0:1.0: 3 ports detected
[    1.847655] PM: Image not found (code -22)
[    1.850473] random: fast init done
[    1.885663] EXT4-fs (sda2): mounted filesystem with ordered data mode. O=
pts: (null)
[    1.991139] systemd[1]: RTC configured in localtime, applying delta of 1=
80 minutes to system time.
[    2.013666] systemd[1]: systemd 246.4-1-manjaro running in system mode. =
(+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP =
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -=
IDN +PCRE2 default-hierarchy=3Dhybrid)
[    2.029440] systemd[1]: Detected architecture x86-64.
[    2.044045] systemd[1]: Set hostname to <thinkpad>.
[    2.135993] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    2.152659] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    2.216664] systemd[1]: Queued start job for default target Graphical In=
terface.
[    2.217451] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[    2.217964] systemd[1]: Created slice system-getty.slice.
[    2.218211] systemd[1]: Created slice system-modprobe.slice.
[    2.218516] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    2.218748] systemd[1]: Created slice User and Session Slice.
[    2.218806] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    2.218849] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    2.219000] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    2.219029] systemd[1]: Reached target Local Encrypted Volumes.
[    2.219040] systemd[1]: Reached target Login Prompts.
[    2.219064] systemd[1]: Reached target Remote File Systems.
[    2.219074] systemd[1]: Reached target Slices.
[    2.219143] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    2.219409] systemd[1]: Listening on LVM2 metadata daemon socket.
[    2.219477] systemd[1]: Listening on LVM2 poll daemon socket.
[    2.220755] systemd[1]: Listening on Process Core Dump Socket.
[    2.220880] systemd[1]: Listening on Journal Audit Socket.
[    2.220959] systemd[1]: Listening on Journal Socket (/dev/log).
[    2.221047] systemd[1]: Listening on Journal Socket.
[    2.221142] systemd[1]: Listening on udev Control Socket.
[    2.221207] systemd[1]: Listening on udev Kernel Socket.
[    2.222093] systemd[1]: Mounting Huge Pages File System...
[    2.223184] systemd[1]: Mounting POSIX Message Queue File System...
[    2.224506] systemd[1]: Mounting Kernel Debug File System...
[    2.225932] systemd[1]: Mounting Kernel Trace File System...
[    2.227458] systemd[1]: Starting Create list of static device nodes for =
the current kernel...
[    2.228877] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[    2.229812] systemd[1]: Starting Load Kernel Module drm...
[    2.231475] systemd[1]: Starting Set Up Additional Binary Formats...
[    2.231570] systemd[1]: Condition check resulted in File System Check on=
 Root Device being skipped.
[    2.233649] systemd[1]: Starting Journal Service...
[    2.237952] systemd[1]: Starting Load Kernel Modules...
[    2.239270] Linux agpgart interface v0.103
[    2.239725] systemd[1]: Starting Remount Root and Kernel File Systems...
[    2.239836] systemd[1]: Condition check resulted in Repartition Root Dis=
k being skipped.
[    2.242013] systemd[1]: Starting Coldplug All udev Devices...
[    2.247722] systemd[1]: Mounted Huge Pages File System.
[    2.247922] systemd[1]: Mounted POSIX Message Queue File System.
[    2.248097] systemd[1]: Mounted Kernel Debug File System.
[    2.248268] systemd[1]: Mounted Kernel Trace File System.
[    2.249206] systemd[1]: Finished Create list of static device nodes for =
the current kernel.
[    2.249492] systemd[1]: proc-sys-fs-binfmt_misc.automount: Got automount=
 request for /proc/sys/fs/binfmt_misc, triggered by 237 (systemd-binfmt)
[    2.251082] systemd[1]: Mounting Arbitrary Executable File Formats File =
System...
[    2.252759] random: lvm: uninitialized urandom read (4 bytes read)
[    2.254303] systemd[1]: Mounted Arbitrary Executable File Formats File S=
ystem.
[    2.257672] EXT4-fs (sda2): re-mounted. Opts: discard
[    2.259658] systemd[1]: Finished Set Up Additional Binary Formats.
[    2.260720] systemd[1]: Finished Remount Root and Kernel File Systems.
[    2.262093] systemd[1]: Activating swap /swapfile...
[    2.262194] systemd[1]: Condition check resulted in First Boot Wizard be=
ing skipped.
[    2.263201] systemd[1]: Condition check resulted in Rebuild Hardware Dat=
abase being skipped.
[    2.264580] systemd[1]: Starting Load/Save Random Seed...
[    2.264697] systemd[1]: Condition check resulted in Create System Users =
being skipped.
[    2.266147] systemd[1]: Starting Create Static Device Nodes in /dev...
[    2.283363] usb 1-1: New USB device found, idVendor=3D8087, idProduct=3D=
0024, bcdDevice=3D 0.00
[    2.283367] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    2.283896] hub 1-1:1.0: USB hub found
[    2.284101] hub 1-1:1.0: 6 ports detected
[    2.299736] usb 3-1: New USB device found, idVendor=3D8087, idProduct=3D=
0024, bcdDevice=3D 0.00
[    2.299739] usb 3-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    2.299830] systemd[1]: modprobe@drm.service: Succeeded.
[    2.300029] hub 3-1:1.0: USB hub found
[    2.300105] hub 3-1:1.0: 8 ports detected
[    2.300160] systemd[1]: Finished Load Kernel Module drm.
[    2.320351] vboxdrv: loading out-of-tree module taints kernel.
[    2.320579] vboxdrv: module verification failed: signature and/or requir=
ed key missing - tainting kernel
[    2.330511] systemd[1]: Finished Create Static Device Nodes in /dev.
[    2.332431] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[    2.333641] vboxdrv: Found 4 processor cores
[    2.359495] vboxdrv: TSC mode is Invariant, tentative frequency 25941056=
00 Hz
[    2.359497] vboxdrv: Successfully loaded version 6.1.14 (interface 0x002=
e0000)
[    2.360661] VBoxNetAdp: Successfully started.
[    2.363175] VBoxNetFlt: Successfully started.
[    2.364683] systemd[1]: Finished Coldplug All udev Devices.
[    2.369357] systemd[1]: Finished Load Kernel Modules.
[    2.369651] systemd[1]: Condition check resulted in FUSE Control File Sy=
stem being skipped.
[    2.370971] systemd[1]: Mounting Kernel Configuration File System...
[    2.372281] systemd[1]: Starting Apply Kernel Variables...
[    2.375624] systemd[1]: Mounted Kernel Configuration File System.
[    2.384195] systemd[1]: Finished Apply Kernel Variables.
[    2.386538] systemd[1]: Starting CLI Netfilter Manager...
[    2.404397] systemd[1]: Finished CLI Netfilter Manager.
[    2.565984] usb 1-1.4: new full-speed USB device number 3 using ehci-pci
[    2.662343] systemd[1]: Started Journal Service.
[    2.662451] audit: type=3D1130 audit(1601466942.659:2): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journald comm=3D"s=
ystemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?=
 res=3Dsuccess'
[    2.670056] usb 1-1.4: New USB device found, idVendor=3D0a5c, idProduct=
=3D21e6, bcdDevice=3D 1.12
[    2.670059] usb 1-1.4: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3
[    2.670061] usb 1-1.4: Product: BCM20702A0
[    2.670063] usb 1-1.4: Manufacturer: Broadcom Corp
[    2.670064] usb 1-1.4: SerialNumber: F4B7E2E92DEF
[    2.745987] usb 1-1.6: new high-speed USB device number 4 using ehci-pci
[    2.770684] audit: type=3D1130 audit(1601466942.769:3): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journal-flush comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[    2.770915] audit: type=3D1130 audit(1601466942.769:4): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-udevd comm=3D"syst=
emd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
[    2.772398] audit: type=3D1130 audit(1601466942.769:5): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dlvm2-lvmetad comm=3D"syste=
md" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[    2.851031] usb 1-1.6: New USB device found, idVendor=3D5986, idProduct=
=3D02d2, bcdDevice=3D 0.11
[    2.851035] usb 1-1.6: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
[    2.851037] usb 1-1.6: Product: Integrated Camera
[    2.851038] usb 1-1.6: Manufacturer: Ricoh Company Ltd.
[    2.904083] ACPI: AC Adapter [AC] (on-line)
[    2.966499] battery: ACPI: Battery Slot [BAT0] (battery present)
[    2.976328] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:00)
[    2.976465] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:00)
[    3.017433] random: mktemp: uninitialized urandom read (6 bytes read)
[    3.017676] ACPI Warning: SystemIO range 0x0000000000000428-0x0000000000=
00042F conflicts with OpRegion 0x0000000000000400-0x000000000000047F (\_SB.=
PCI0.LPC.PMIO) (20200528/utaddress-204)
[    3.017682] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[    3.017686] ACPI Warning: SystemIO range 0x0000000000000540-0x0000000000=
00054F conflicts with OpRegion 0x0000000000000500-0x000000000000057F (\_SB.=
PCI0.LPC.LPIO) (20200528/utaddress-204)
[    3.017690] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[    3.017691] ACPI Warning: SystemIO range 0x0000000000000530-0x0000000000=
00053F conflicts with OpRegion 0x0000000000000500-0x000000000000057F (\_SB.=
PCI0.LPC.LPIO) (20200528/utaddress-204)
[    3.017694] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[    3.017695] ACPI Warning: SystemIO range 0x0000000000000500-0x0000000000=
00052F conflicts with OpRegion 0x0000000000000500-0x000000000000057F (\_SB.=
PCI0.LPC.LPIO) (20200528/utaddress-204)
[    3.017699] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[    3.017699] lpc_ich: Resource conflict(s) found affecting gpio_ich
[    3.035132] random: tlp-readconfs: uninitialized urandom read (4 bytes r=
ead)
[    3.094537] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    3.094539] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    3.094756] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[    3.127128] tpm_tis 00:05: 1.2 TPM (device-id 0x0, rev-id 78)
[    3.147475] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    3.150102] i2c i2c-0: 2/2 memory slots populated (from DMI)
[    3.150460] i2c i2c-0: Successfully instantiated SPD at 0x50
[    3.150800] i2c i2c-0: Successfully instantiated SPD at 0x51
[    3.192717] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): registered=
 PHC clock
[    3.211534] Non-volatile memory driver v1.3
[    3.213353] input: PC Speaker as /devices/platform/pcspkr/input/input5
[    3.251233] audit: type=3D1130 audit(1601466943.249:6): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dlvm2-monitor comm=3D"syste=
md" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[    3.264130] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    3.289666] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.303123] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 3c:=
97:0e:91:ec:f6
[    3.303131] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connecti=
on
[    3.303180] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: 1000FF-0=
FF
[    3.311874] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    3.311875] thinkpad_acpi: http://ibm-acpi.sf.net/
[    3.311877] thinkpad_acpi: ThinkPad BIOS G2ETB5WW (2.75 ), EC G2HT35WW
[    3.311878] thinkpad_acpi: Lenovo ThinkPad X230, model 2325KZ5
[    3.317265] thinkpad_acpi: radio switch found; radios are enabled
[    3.317428] thinkpad_acpi: This ThinkPad has standard ACPI backlight bri=
ghtness control, supported by the ACPI video driver
[    3.317429] thinkpad_acpi: Disabling thinkpad-acpi brightness events by =
default...
[    3.321289] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is u=
nblocked
[    3.326080] audit: type=3D1130 audit(1601466943.323:7): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-fsck@dev-disk-by\x=
2duuid-93fcb36f\x2df56a\x2d40a4\x2d844f\x2d9119b0bd77ce comm=3D"systemd" ex=
e=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuc=
cess'
[    3.340751] thinkpad_acpi: battery 1 registered (start 0, stop 100)
[    3.340757] battery: new extension: ThinkPad Battery Extension
[    3.340817] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_=
acpi/input/input6
[    3.343823] EXT4-fs (sda3): mounted filesystem with ordered data mode. O=
pts: discard
[    3.405270] audit: type=3D1130 audit(1601466943.403:8): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-fsck@dev-disk-by\x=
2duuid-4AF3\x2d613F comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostn=
ame=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    3.466596] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163840=
 ms ovfl timer
[    3.466598] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[    3.466599] RAPL PMU: hw unit of domain package 2^-16 Joules
[    3.466600] RAPL PMU: hw unit of domain pp1-gpu 2^-16 Joules
[    3.576034] cryptd: max_cpu_qlen set to 1000
[    3.584933] iTCO_vendor_support: vendor-support=3D0
[    3.605149] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    3.605206] iTCO_wdt: Found a Panther Point TCO device (Version=3D2, TCO=
BASE=3D0x0460)
[    3.609336] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[    3.660146] urandom_read: 6 callbacks suppressed
[    3.660148] random: mktemp: uninitialized urandom read (6 bytes read)
[    3.703193] at24 0-0050: supply vcc not found, using dummy regulator
[    3.703847] AVX version of gcm_enc/dec engaged.
[    3.703848] AES CTR mode by8 optimization enabled
[    3.704961] at24 0-0050: 256 byte spd EEPROM, read-only
[    3.704998] at24 0-0051: supply vcc not found, using dummy regulator
[    3.705693] at24 0-0051: 256 byte spd EEPROM, read-only
[    3.724158] e1000e 0000:00:19.0 enp0s25: renamed from eth0
[    3.749166] audit: type=3D1130 audit(1601466943.746:9): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D"sys=
temd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'
[    3.766769] audit: type=3D1130 audit(1601466943.766:10): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-backlight@leds:tp=
acpi::kbd_backlight comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostn=
ame=3D? addr=3D? terminal=3D? res=3Dsuccess'
[    3.880398] rtl8192ce: Chip Version ID: B_CHIP_88C
[    3.890805] rtl8192ce: Using firmware rtlwifi/rtl8192cfw.bin
[    3.893648] ieee80211 phy0: Selected rate control algorithm 'rtl_rc'
[    3.894756] rtlwifi: rtlwifi: wireless switch is on
[    3.898985] rtl8192ce 0000:03:00.0 wlp3s0: renamed from wlan0
[    3.970027] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    3.970031] checking generic (e0000000 130000) vs hw (f0000000 400000)
[    3.970032] checking generic (e0000000 130000) vs hw (e0000000 10000000)
[    3.970033] fb0: switching to inteldrmfb from EFI VGA
[    3.970116] i915 0000:00:02.0: vgaarb: deactivate vga console
[    3.970165] i915 0000:00:02.0: [drm] DMAR active, disabling use of stole=
n memory
[    3.970759] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.971190] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    4.015237] [drm] Initialized i915 1.6.0 20200515 for 0000:00:02.0 on mi=
nor 0
[    4.016186] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[    4.016482] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input8
[    4.016700] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops i915_aud=
io_component_bind_ops [i915])
[    4.045994] Adding 17825788k swap on /swapfile.  Priority:-2 extents:13 =
across:19259388k SSFS
[    4.080096] psmouse serio1: synaptics: queried max coordinates: x [..576=
8], y [..5062]
[    4.110834] psmouse serio1: synaptics: queried min coordinates: x [1174.=
.], y [790..]
[    4.163668] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0=
x1e2b1, caps: 0xd002a3/0x940300/0x123800/0x0, board id: 1611, fw id: 1099905
[    4.163677] psmouse serio1: synaptics: serio: Synaptics pass-through por=
t at isa0060/serio1/input0
[    4.203728] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042=
/serio1/input/input7
[    4.216023] fbcon: i915drmfb (fb0) is primary device
[    4.216025] fbcon: Deferring console take-over
[    4.216028] i915 0000:00:02.0: fb0: i915drmfb frame buffer device
[    4.242713] intel_rapl_common: Found RAPL domain package
[    4.242715] intel_rapl_common: Found RAPL domain core
[    4.242716] intel_rapl_common: Found RAPL domain uncore
[    4.242724] intel_rapl_common: RAPL package-0 domain package locked by B=
IOS
[    4.244682] mousedev: PS/2 mouse device common for all mice
[    4.247572] random: crng init done
[    4.285878] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269VC: =
line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    4.285881] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    4.285883] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D2 (0x15/0x1b=
/0x0/0x0/0x0)
[    4.285884] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[    4.285886] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    4.285888] snd_hda_codec_realtek hdaudioC0D0:      Mic=3D0x18
[    4.285889] snd_hda_codec_realtek hdaudioC0D0:      Dock Mic=3D0x19
[    4.285891] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D0x12
[    4.318453] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.=
0/sound/card0/input10
[    4.318514] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0=
/sound/card0/input11
[    4.318566] input: HDA Intel PCH Dock Mic as /devices/pci0000:00/0000:00=
:1b.0/sound/card0/input12
[    4.318620] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:0=
0:1b.0/sound/card0/input13
[    4.318670] input: HDA Intel PCH Dock Headphone as /devices/pci0000:00/0=
000:00:1b.0/sound/card0/input14
[    4.318722] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000:00/=
0000:00:1b.0/sound/card0/input15
[    4.318775] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000:00/=
0000:00:1b.0/sound/card0/input16
[    4.318825] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000:00/=
0000:00:1b.0/sound/card0/input17
[    4.822473] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, b=
uttons: 3/3
[    5.012240] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/seri=
o1/serio2/input/input9
[    5.230247] kauditd_printk_skb: 23 callbacks suppressed
[    5.230249] audit: type=3D1130 audit(1601466945.229:34): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-logind comm=3D"sy=
stemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? =
res=3Dsuccess'
[    5.232515] audit: type=3D1130 audit(1601466945.229:35): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dlibvirtd comm=3D"systemd"=
 exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
[    5.236612] audit: type=3D1130 audit(1601466945.236:36): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dlightdm comm=3D"systemd" =
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[    5.256886] audit: type=3D1130 audit(1601466945.256:37): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Daccounts-daemon comm=3D"s=
ystemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?=
 res=3Dsuccess'
[    5.335642] i915 0000:00:02.0: [drm] *ERROR* uncleared fifo underrun on =
pipe A
[    5.335644] i915 0000:00:02.0: [drm] *ERROR* CPU pipe A FIFO underrun
[    5.337805] i915 0000:00:02.0: [drm] *ERROR* uncleared pch fifo underrun=
 on pch transcoder A
[    5.337808] i915 0000:00:02.0: [drm] *ERROR* PCH transcoder A FIFO under=
run
[    5.934162] mc: Linux media interface: v0.10
[    5.961594] videodev: Linux video capture interface: v2.00
[    5.985997] Bluetooth: Core ver 2.22
[    5.986064] NET: Registered protocol family 31
[    5.986065] Bluetooth: HCI device and connection manager initialized
[    5.986069] Bluetooth: HCI socket layer initialized
[    5.986072] Bluetooth: L2CAP socket layer initialized
[    5.986077] Bluetooth: SCO socket layer initialized
[    6.002062] usbcore: registered new interface driver btusb
[    6.033197] audit: type=3D1130 audit(1601466946.033:38): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dbluetooth comm=3D"systemd=
" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[    6.039668] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.039670] Bluetooth: BNEP filters: protocol multicast
[    6.039676] Bluetooth: BNEP socket layer initialized
[    6.060552] uvcvideo: Found UVC 1.00 device Integrated Camera (5986:02d2)
[    6.070700] uvcvideo 1-1.6:1.0: Entity type for entity Extension 4 was n=
ot initialized!
[    6.070703] uvcvideo 1-1.6:1.0: Entity type for entity Extension 3 was n=
ot initialized!
[    6.070704] uvcvideo 1-1.6:1.0: Entity type for entity Processing 2 was =
not initialized!
[    6.070706] uvcvideo 1-1.6:1.0: Entity type for entity Camera 1 was not =
initialized!
[    6.070786] input: Integrated Camera: Integrated C as /devices/pci0000:0=
0/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6:1.0/input/input18
[    6.070861] usbcore: registered new interface driver uvcvideo
[    6.070862] USB Video Class driver (1.1.1)
[    6.111534] Bluetooth: hci0: BCM: chip id 63
[    6.112503] Bluetooth: hci0: BCM: features 0x07
[    6.116008] audit: type=3D1130 audit(1601466946.113:39): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dwpa_supplicant comm=3D"sy=
stemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? =
res=3Dsuccess'
[    6.122845] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[    6.128588] Bluetooth: hci0: BCM20702A
[    6.128593] Bluetooth: hci0: BCM20702A1 (001.002.014) build 0000
[    6.129778] Bluetooth: hci0: BCM: firmware Patch file not found, tried:
[    6.129780] Bluetooth: hci0: BCM: 'brcm/BCM20702A1-0a5c-21e6.hcd'
[    6.129781] Bluetooth: hci0: BCM: 'brcm/BCM-0a5c-21e6.hcd'
[    6.133100] tun: Universal TUN/TAP device driver, 1.6
[    6.133959] virbr0: port 1(virbr0-nic) entered blocking state
[    6.134022] virbr0: port 1(virbr0-nic) entered disabled state
[    6.134083] device virbr0-nic entered promiscuous mode
[    6.134109] audit: type=3D1700 audit(1601466946.133:40): dev=3Dvirbr0-ni=
c prom=3D256 old_prom=3D0 auid=3D4294967295 uid=3D0 gid=3D0 ses=3D4294967295
[    6.145750] audit: type=3D1325 audit(1601466946.143:41): table=3Dfilter =
family=3D2 entries=3D0 op=3Dregister pid=3D848 comm=3D"modprobe"
[    6.163630] audit: type=3D1325 audit(1601466946.159:42): table=3Dfilter =
family=3D10 entries=3D0 op=3Dregister pid=3D851 comm=3D"modprobe"
[    6.183964] audit: type=3D1325 audit(1601466946.183:43): table=3Dfilter =
family=3D7 entries=3D0 op=3Dregister pid=3D854 comm=3D"modprobe"
[    6.189144] NET: Registered protocol family 38
[    6.578829] fuse: init (API version 7.31)
[    6.648185] virbr0: port 1(virbr0-nic) entered blocking state
[    6.648188] virbr0: port 1(virbr0-nic) entered listening state
[    6.702935] virbr0: port 1(virbr0-nic) entered disabled state
[    7.014810] L1TF CPU bug present and SMT on, data leak possible. See CVE=
-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l=
1tf.html for details.
[   10.892892] wlp3s0: authenticate with 50:d4:f7:b7:b0:ed
[   10.910194] wlp3s0: send auth to 50:d4:f7:b7:b0:ed (try 1/3)
[   10.912094] wlp3s0: authenticated
[   10.912715] wlp3s0: associate with 50:d4:f7:b7:b0:ed (try 1/3)
[   10.932804] wlp3s0: RX AssocResp from 50:d4:f7:b7:b0:ed (capab=3D0xc11 s=
tatus=3D0 aid=3D5)
[   10.933479] wlp3s0: associated
[   11.025620] kauditd_printk_skb: 81 callbacks suppressed
[   11.025624] audit: type=3D1131 audit(1601466951.023:124): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D"s=
ystemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?=
 res=3Dsuccess'
[   11.055536] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link becomes ready
[   13.309352] audit: type=3D1130 audit(1601466953.306:125): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-wait-onli=
ne comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? =
terminal=3D? res=3Dsuccess'
[   13.423001] audit: type=3D1130 audit(1601466953.423:126): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dcolord comm=3D"systemd" =
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[   13.544579] audit: type=3D1130 audit(1601466953.543:127): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dorg.cups.cupsd comm=3D"s=
ystemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?=
 res=3Dsuccess'
[   14.221038] Bridge firewalling registered
[   14.249278] audit: type=3D1325 audit(1601466954.246:128): table=3Dnat fa=
mily=3D2 entries=3D13 op=3Dreplace pid=3D1141 comm=3D"iptables"
[   14.251315] audit: type=3D1325 audit(1601466954.249:129): table=3Dfilter=
 family=3D2 entries=3D32 op=3Dreplace pid=3D1143 comm=3D"iptables"
[   14.253178] audit: type=3D1325 audit(1601466954.253:130): table=3Dfilter=
 family=3D2 entries=3D34 op=3Dreplace pid=3D1145 comm=3D"iptables"
[   14.254933] audit: type=3D1325 audit(1601466954.253:131): table=3Dfilter=
 family=3D2 entries=3D36 op=3Dreplace pid=3D1147 comm=3D"iptables"
[   14.257058] audit: type=3D1325 audit(1601466954.256:132): table=3Dfilter=
 family=3D2 entries=3D38 op=3Dreplace pid=3D1149 comm=3D"iptables"
[   14.259112] audit: type=3D1325 audit(1601466954.256:133): table=3Dfilter=
 family=3D2 entries=3D39 op=3Dreplace pid=3D1151 comm=3D"iptables"
[   14.268897] Initializing XFRM netlink socket
[   14.558667] docker0: port 1(vethc346366) entered blocking state
[   14.558684] docker0: port 1(vethc346366) entered disabled state
[   14.558779] device vethc346366 entered promiscuous mode
[   14.558998] docker0: port 1(vethc346366) entered blocking state
[   14.559001] docker0: port 1(vethc346366) entered forwarding state
[   14.559059] IPv6: ADDRCONF(NETDEV_CHANGE): docker0: link becomes ready
[   14.559147] docker0: port 1(vethc346366) entered disabled state
[   14.622969] docker0: port 2(vethefbac9e) entered blocking state
[   14.624737] docker0: port 2(vethefbac9e) entered disabled state
[   14.625098] device vethefbac9e entered promiscuous mode
[   14.625858] docker0: port 2(vethefbac9e) entered blocking state
[   14.625862] docker0: port 2(vethefbac9e) entered forwarding state
[   14.701963] docker0: port 3(veth7ff194c) entered blocking state
[   14.702134] docker0: port 3(veth7ff194c) entered disabled state
[   14.702204] device veth7ff194c entered promiscuous mode
[   14.705997] docker0: port 3(veth7ff194c) entered blocking state
[   14.706000] docker0: port 3(veth7ff194c) entered forwarding state
[   14.863084] cgroup: cgroup: disabling cgroup2 socket matching due to net=
_prio or net_cls activation
[   15.190945] eth0: renamed from veth4181187
[   15.206320] IPv6: ADDRCONF(NETDEV_CHANGE): vethefbac9e: link becomes rea=
dy
[   15.206427] docker0: port 3(veth7ff194c) entered disabled state
[   15.252007] eth0: renamed from veth33298ad
[   15.283368] IPv6: ADDRCONF(NETDEV_CHANGE): vethc346366: link becomes rea=
dy
[   15.283406] docker0: port 1(vethc346366) entered blocking state
[   15.283409] docker0: port 1(vethc346366) entered forwarding state
[   15.283620] eth0: renamed from vethbac852e
[   15.294070] IPv6: ADDRCONF(NETDEV_CHANGE): veth7ff194c: link becomes rea=
dy
[   15.294111] docker0: port 3(veth7ff194c) entered blocking state
[   15.294112] docker0: port 3(veth7ff194c) entered forwarding state
[   15.750977] process 'docker/tmp/qemu-check214394182/check' started with =
executable stack
[   16.354169] kauditd_printk_skb: 99 callbacks suppressed
[   16.354171] audit: type=3D1130 audit(1601466956.353:233): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dtlp comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
[   19.288351] audit: type=3D1131 audit(1601466959.286:234): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Duser@620 comm=3D"systemd=
" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[   19.305252] audit: type=3D1131 audit(1601466959.303:235): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Duser-runtime-dir@620 com=
m=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termin=
al=3D? res=3Dsuccess'
[   23.420216] audit: type=3D1334 audit(1601466963.416:236): prog-id=3D16 o=
p=3DLOAD
[   23.420222] audit: type=3D1334 audit(1601466963.416:237): prog-id=3D17 o=
p=3DLOAD
[   24.227782] audit: type=3D1325 audit(1601466964.226:238): table=3Dfilter=
 family=3D7 entries=3D0 op=3Dregister pid=3D2255 comm=3D"(t-daemon)"
[   24.234672] audit: type=3D1130 audit(1601466964.233:239): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Drtkit-daemon comm=3D"sys=
temd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'
[   24.272943] audit: type=3D1130 audit(1601466964.273:240): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dupower comm=3D"systemd" =
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
[   24.589346] Bluetooth: RFCOMM TTY layer initialized
[   24.589353] Bluetooth: RFCOMM socket layer initialized
[   24.589360] Bluetooth: RFCOMM ver 1.11
[   36.076399] audit: type=3D1131 audit(1601466970.474:241): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hostnamed comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[   36.287646] audit: type=3D1325 audit(1601466970.684:242): table=3Dfilter=
 family=3D7 entries=3D0 op=3Dunregister pid=3D122 comm=3D"kworker/u16:3"
[   36.326100] audit: type=3D1334 audit(1601466970.727:243): prog-id=3D12 o=
p=3DUNLOAD
[   36.326105] audit: type=3D1334 audit(1601466970.727:244): prog-id=3D11 o=
p=3DUNLOAD
[   39.871925] audit: type=3D1130 audit(1601466974.270:245): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dudisks2 comm=3D"systemd"=
 exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
[   42.210875] audit: type=3D1325 audit(1601466976.610:246): table=3Dfilter=
 family=3D7 entries=3D0 op=3Dregister pid=3D2359 comm=3D"skypeforlinux"
[   42.319924] audit: type=3D1325 audit(1601466976.714:247): table=3Dfilter=
 family=3D7 entries=3D0 op=3Dregister pid=3D2351 comm=3D"slack"
[   46.362800] audit: type=3D1130 audit(1601466980.760:248): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dblueman-mechanism comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[   47.283320] audit: type=3D1325 audit(1601466981.680:249): table=3Dfilter=
 family=3D7 entries=3D0 op=3Dregister pid=3D2860 comm=3D"electron"
[   71.687189] pci 0000:04:00.0: [10de:1c03] type 00 class 0x030000
[   71.687253] pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x00ffffff]
[   71.687286] pci 0000:04:00.0: reg 0x14: [mem 0x00000000-0x0fffffff 64bit=
 pref]
[   71.687312] pci 0000:04:00.0: reg 0x1c: [mem 0x00000000-0x01ffffff 64bit=
 pref]
[   71.687327] pci 0000:04:00.0: reg 0x24: [io  0x0000-0x007f]
[   71.687341] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[   71.687663] pci 0000:04:00.0: 4.000 Gb/s available PCIe bandwidth, limit=
ed by 5.0 GT/s PCIe x1 link at 0000:00:1c.2 (capable of 126.016 Gb/s with 8=
.0 GT/s PCIe x16 link)
[   71.687809] pci 0000:04:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[   71.687814] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=
=3Dio+mem,decodes=3Dnone:owns=3Dio+mem
[   71.687857] pci 0000:04:00.0: Adding to iommu group 14
[   71.688011] pci 0000:04:00.1: [10de:10f1] type 00 class 0x040300
[   71.688054] pci 0000:04:00.1: reg 0x10: [mem 0x00000000-0x00003fff]
[   71.688404] pci 0000:04:00.1: Adding to iommu group 14
[   71.688544] pci 0000:04:00.0: BAR 1: no space for [mem size 0x10000000 6=
4bit pref]
[   71.688546] pci 0000:04:00.0: BAR 1: failed to assign [mem size 0x100000=
00 64bit pref]
[   71.688549] pci 0000:04:00.0: BAR 3: no space for [mem size 0x02000000 6=
4bit pref]
[   71.688551] pci 0000:04:00.0: BAR 3: failed to assign [mem size 0x020000=
00 64bit pref]
[   71.688553] pci 0000:04:00.0: BAR 0: no space for [mem size 0x01000000]
[   71.688554] pci 0000:04:00.0: BAR 0: failed to assign [mem size 0x010000=
00]
[   71.688556] pci 0000:04:00.0: BAR 6: assigned [mem 0xf1400000-0xf147ffff=
 pref]
[   71.688559] pci 0000:04:00.1: BAR 0: assigned [mem 0xf1480000-0xf1483fff]
[   71.688566] pci 0000:04:00.0: BAR 5: assigned [io  0x4000-0x407f]
[   71.688733] vfio-pci 0000:04:00.0: vgaarb: changed VGA decodes: olddecod=
es=3Dio+mem,decodes=3Dio+mem:owns=3Dnone
[   71.703798] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
[   78.083410] audit: type=3D2502 audit(1601467012.486:250): pid=3D716 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'virt=3Dkvm vm=3D"Win10" uuid=
=3D7043c77b-4903-4527-8089-9679d9a17fee vm-ctx=3D+65534:+992 img-ctx=3D+655=
34:+992 model=3Ddac exe=3D"/usr/bin/libvirtd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
[   78.097608] audit: type=3D1130 audit(1601467012.503:251): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dvirtlogd comm=3D"systemd=
" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
[   78.117228] virbr0: port 2(vnet0) entered blocking state
[   78.117699] virbr0: port 2(vnet0) entered disabled state
[   78.117830] device vnet0 entered promiscuous mode
[   78.117854] audit: type=3D1700 audit(1601467012.523:252): dev=3Dvnet0 pr=
om=3D256 old_prom=3D0 auid=3D4294967295 uid=3D0 gid=3D0 ses=3D4294967295
[   78.123436] virbr0: port 2(vnet0) entered blocking state
[   78.123440] virbr0: port 2(vnet0) entered listening state
[   78.125703] audit: type=3D2501 audit(1601467012.529:253): pid=3D716 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'virt=3Dkvm resrc=3Dnet reaso=
n=3Dopen vm=3D"Win10" uuid=3D7043c77b-4903-4527-8089-9679d9a17fee net=3D52:=
54:00:91:65:de path=3D"/dev/net/tun" rdev=3D0A:C8 exe=3D"/usr/bin/libvirtd"=
 hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   78.167333] audit: type=3D2501 audit(1601467012.573:254): pid=3D716 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'virt=3Dkvm resrc=3Dcgroup re=
ason=3Ddeny vm=3D"Win10" uuid=3D7043c77b-4903-4527-8089-9679d9a17fee cgroup=
=3D"/sys/fs/cgroup/devices/machine.slice/machine-qemu\x2d1\x2dWin10.scope/"=
 class=3Dall exe=3D"/usr/bin/libvirtd" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'
[   78.167449] audit: type=3D2501 audit(1601467012.573:255): pid=3D716 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'virt=3Dkvm resrc=3Dcgroup re=
ason=3Dallow vm=3D"Win10" uuid=3D7043c77b-4903-4527-8089-9679d9a17fee cgrou=
p=3D"/sys/fs/cgroup/devices/machine.slice/machine-qemu\x2d1\x2dWin10.scope/=
" class=3Dmajor category=3Dpty maj=3D88 acl=3Drw exe=3D"/usr/bin/libvirtd" =
hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   78.167514] audit: type=3D2501 audit(1601467012.573:256): pid=3D716 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'virt=3Dkvm resrc=3Dcgroup re=
ason=3Dallow vm=3D"Win10" uuid=3D7043c77b-4903-4527-8089-9679d9a17fee cgrou=
p=3D"/sys/fs/cgroup/devices/machine.slice/machine-qemu\x2d1\x2dWin10.scope/=
" class=3Dpath path=3D"/dev/null" rdev=3D01:03 acl=3Drw exe=3D"/usr/bin/lib=
virtd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   78.167575] audit: type=3D2501 audit(1601467012.573:257): pid=3D716 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'virt=3Dkvm resrc=3Dcgroup re=
ason=3Dallow vm=3D"Win10" uuid=3D7043c77b-4903-4527-8089-9679d9a17fee cgrou=
p=3D"/sys/fs/cgroup/devices/machine.slice/machine-qemu\x2d1\x2dWin10.scope/=
" class=3Dpath path=3D"/dev/full" rdev=3D01:07 acl=3Drw exe=3D"/usr/bin/lib=
virtd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   78.167636] audit: type=3D2501 audit(1601467012.573:258): pid=3D716 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'virt=3Dkvm resrc=3Dcgroup re=
ason=3Dallow vm=3D"Win10" uuid=3D7043c77b-4903-4527-8089-9679d9a17fee cgrou=
p=3D"/sys/fs/cgroup/devices/machine.slice/machine-qemu\x2d1\x2dWin10.scope/=
" class=3Dpath path=3D"/dev/zero" rdev=3D01:05 acl=3Drw exe=3D"/usr/bin/lib=
virtd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   78.167696] audit: type=3D2501 audit(1601467012.573:259): pid=3D716 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'virt=3Dkvm resrc=3Dcgroup re=
ason=3Dallow vm=3D"Win10" uuid=3D7043c77b-4903-4527-8089-9679d9a17fee cgrou=
p=3D"/sys/fs/cgroup/devices/machine.slice/machine-qemu\x2d1\x2dWin10.scope/=
" class=3Dpath path=3D"/dev/random" rdev=3D01:08 acl=3Drw exe=3D"/usr/bin/l=
ibvirtd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   79.719645] vfio-pci 0000:04:00.0: enabling device (0000 -> 0001)
[   79.720391] vfio-pci 0000:04:00.0: vfio_ecap_init: hiding ecap 0x19@0x900
[   80.016048] virbr0: port 2(vnet0) entered disabled state
[   80.019134] device vnet0 left promiscuous mode
[   80.019146] virbr0: port 2(vnet0) entered disabled state
[   88.001283] kauditd_printk_skb: 28 callbacks suppressed
[   88.001287] audit: type=3D1131 audit(1601467022.409:287): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispatche=
r comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? t=
erminal=3D? res=3Dsuccess'
[   99.367742] audit: type=3D1100 audit(1601467033.774:288): pid=3D6124 uid=
=3D1000 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:authentication grantors=3Dpam_f=
aillock,pam_permit,pam_faillock acct=3D"sergiy" exe=3D"/usr/bin/sudo" hostn=
ame=3D? addr=3D? terminal=3D/dev/pts/0 res=3Dsuccess'
[   99.369626] audit: type=3D1101 audit(1601467033.778:289): pid=3D6124 uid=
=3D1000 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:accounting grantors=3Dpam_permi=
t,pam_time acct=3D"sergiy" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? term=
inal=3D/dev/pts/0 res=3Dsuccess'
[   99.369821] audit: type=3D1110 audit(1601467033.778:290): pid=3D6124 uid=
=3D0 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock,pa=
m_permit,pam_faillock acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=
=3D? terminal=3D/dev/pts/0 res=3Dsuccess'
[   99.370907] audit: type=3D1105 audit(1601467033.778:291): pid=3D6124 uid=
=3D0 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:session_open grantors=3Dpam_limits=
,pam_unix,pam_permit acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=
=3D? terminal=3D/dev/pts/0 res=3Dsuccess'
[  100.802449] vfio-pci 0000:04:00.0: vfio_ecap_init: hiding ecap 0x19@0x900
[  100.805303] qemu-system-x86[6198]: segfault at a8 ip 0000000000614c49 sp=
 00007ffc9a791da0 error 4 in qemu-system-x86_64[4fe000+51c000]
[  100.805310] Code: 00 55 53 48 89 fb 48 83 ec 08 48 8b 6f 58 67 e8 3d fe =
ee ff 48 8b 7b 40 83 05 4e 02 a8 00 01 48 85 ff 74 06 67 e8 e7 4f 27 00 <48=
> 8b 85 a8 00 00 00 48 85 c0 74 53 8b 93 a0 00 00 00 eb 0f 0f 1f
[  100.805337] audit: type=3D1701 audit(1601467035.215:292): auid=3D1000 ui=
d=3D0 gid=3D0 ses=3D2 pid=3D6198 comm=3D"qemu-system-x86" exe=3D"/usr/bin/q=
emu-system-x86_64" sig=3D11 res=3D1
[  100.817647] audit: type=3D1334 audit(1601467035.225:293): prog-id=3D20 o=
p=3DLOAD
[  100.817803] audit: type=3D1334 audit(1601467035.225:294): prog-id=3D21 o=
p=3DLOAD
[  100.819022] audit: type=3D1130 audit(1601467035.228:295): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-coredump@1-6254-=
0 comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? t=
erminal=3D? res=3Dsuccess'
[  100.819781] audit: type=3D1325 audit(1601467035.228:296): table=3Dfilter=
 family=3D7 entries=3D0 op=3Dregister pid=3D6255 comm=3D"(coredump)"
[  114.388954] kauditd_printk_skb: 6 callbacks suppressed
[  114.388957] audit: type=3D1101 audit(1601467048.799:303): pid=3D6766 uid=
=3D1000 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:accounting grantors=3Dpam_permi=
t,pam_time acct=3D"sergiy" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? term=
inal=3D/dev/pts/0 res=3Dsuccess'
[  114.389190] audit: type=3D1110 audit(1601467048.799:304): pid=3D6766 uid=
=3D0 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:setcred grantors=3Dpam_faillock,pa=
m_permit,pam_env,pam_faillock acct=3D"root" exe=3D"/usr/bin/sudo" hostname=
=3D? addr=3D? terminal=3D/dev/pts/0 res=3Dsuccess'
[  114.389701] audit: type=3D1105 audit(1601467048.799:305): pid=3D6766 uid=
=3D0 auid=3D1000 ses=3D2 msg=3D'op=3DPAM:session_open grantors=3Dpam_limits=
,pam_unix,pam_permit acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=
=3D? terminal=3D/dev/pts/0 res=3Dsuccess'

lspci -vvv:

00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM Controll=
er (rev 09)
	Subsystem: Lenovo Device 21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	IOMMU group: 0
	Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
	Kernel driver in use: ivb_uncore

00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor=
 Graphics Controller (rev 09) (prog-if 00 [VGA controller])
	Subsystem: Lenovo Device 21fa
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 33
	IOMMU group: 1
	Region 0: Memory at f0000000 (64-bit, non-prefetchable) [size=3D4M]
	Region 2: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]
	Region 4: I/O ports at 7000 [size=3D64]
	Expansion ROM at 000c0000 [virtual] [disabled] [size=3D128K]
	Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee00018  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915
	Kernel modules: i915

00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Fami=
ly USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
	Subsystem: Lenovo Device 21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 30
	IOMMU group: 2
	Region 0: Memory at f2520000 (64-bit, non-prefetchable) [size=3D64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0-,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
		Address: 00000000fee00318  Data: 0000
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

00:16.0 Communication controller: Intel Corporation 7 Series/C216 Chipset F=
amily MEI Controller #1 (rev 04)
	Subsystem: Lenovo Device 21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 32
	IOMMU group: 3
	Region 0: Memory at f2535000 (64-bit, non-prefetchable) [size=3D16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00378  Data: 0000
	Kernel driver in use: mei_me
	Kernel modules: mei_me

00:16.3 Serial controller: Intel Corporation 7 Series/C210 Series Chipset F=
amily KT Controller (rev 04) (prog-if 02 [16550])
	Subsystem: Lenovo Device 21fa
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Interrupt: pin B routed to IRQ 19
	IOMMU group: 3
	Region 0: I/O ports at 70b0 [size=3D8]
	Region 1: Memory at f253c000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Kernel driver in use: serial

00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network Conn=
ection (Lewisville) (rev 04)
	Subsystem: Lenovo Device 21f3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 31
	IOMMU group: 4
	Region 0: Memory at f2500000 (32-bit, non-prefetchable) [size=3D128K]
	Region 1: Memory at f253b000 (32-bit, non-prefetchable) [size=3D4K]
	Region 2: I/O ports at 7080 [size=3D32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00358  Data: 0000
	Capabilities: [e0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: e1000e
	Kernel modules: e1000e

00:1a.0 USB controller: Intel Corporation 7 Series/C216 Chipset Family USB =
Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Lenovo Device 21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 5
	Region 0: Memory at f253a000 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci
	Kernel modules: ehci_pci

00:1b.0 Audio device: Intel Corporation 7 Series/C216 Chipset Family High D=
efinition Audio Controller (rev 04)
	Subsystem: Lenovo Device 21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 34
	IOMMU group: 6
	Region 0: Memory at f2530000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot+,D3co=
ld+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee003b8  Data: 0000
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE- FLReset+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D1 ArbSelect=3DFixed TC/VC=3D22
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=3D0f ComponentID=3D00 EltType=3DConfig
		Link0:	Desc:	TargetPort=3D00 TargetComponent=3D00 AssocRCRB- LinkType=3DM=
emMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 7 Series/C216 Chipset Family PCI Expr=
ess Root Port 1 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 26
	IOMMU group: 7
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
	I/O behind bridge: 00006000-00006fff [size=3D4K]
	Memory behind bridge: f1d00000-f24fffff [size=3D8M]
	Prefetchable memory behind bridge: 00000000f0400000-00000000f0bfffff [size=
=3D8M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <51=
2ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled=
, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- Equaliz=
ationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee00218  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 21fa
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family P=
CI Express Root Port 2 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 27
	IOMMU group: 8
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
	I/O behind bridge: 00005000-00005fff [size=3D4K]
	Memory behind bridge: f1c00000-f1cfffff [size=3D1M]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [disa=
bled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <51=
2ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled=
, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- Equaliz=
ationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee00258  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 21fa
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family P=
CI Express Root Port 3 (rev c4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 28
	IOMMU group: 9
	Bus: primary=3D00, secondary=3D04, subordinate=3D0b, sec-latency=3D0
	I/O behind bridge: 00004000-00004fff [size=3D4K]
	Memory behind bridge: f1400000-f1bfffff [size=3D8M]
	Prefetchable memory behind bridge: 00000000f0c00000-00000000f13fffff [size=
=3D8M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <51=
2ns, L1 <16us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCap: CRSVisible-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled=
, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- Equalizat=
ionPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee00298  Data: 0000
	Capabilities: [90] Subsystem: Lenovo Device 21fa
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 7 Series/C216 Chipset Family USB =
Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Lenovo Device 21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	IOMMU group: 10
	Region 0: Memory at f2539000 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci
	Kernel modules: ehci_pci

00:1f.0 ISA bridge: Intel Corporation QM77 Express Chipset LPC Controller (=
rev 04)
	Subsystem: Lenovo Device 21fa
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	IOMMU group: 11
	Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
	Kernel driver in use: lpc_ich
	Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 6-port S=
ATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
	Subsystem: Lenovo Device 21fa
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 29
	IOMMU group: 11
	Region 0: I/O ports at 70a8 [size=3D8]
	Region 1: I/O ports at 70bc [size=3D4]
	Region 2: I/O ports at 70a0 [size=3D8]
	Region 3: I/O ports at 70b8 [size=3D4]
	Region 4: I/O ports at 7060 [size=3D32]
	Region 5: Memory at f2538000 (32-bit, non-prefetchable) [size=3D2K]
	Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
		Address: fee002d8  Data: 0000
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D3col=
d-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
	Capabilities: [b0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 7 Series/C216 Chipset Family SMBus Control=
ler (rev 04)
	Subsystem: Lenovo Device 21fa
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 18
	IOMMU group: 11
	Region 0: Memory at f2534000 (64-bit, non-prefetchable) [size=3D256]
	Region 4: I/O ports at efa0 [size=3D32]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801

02:00.0 System peripheral: Ricoh Co Ltd PCIe SDXC/MMC Host Controller (rev =
07) (prog-if 01)
	Subsystem: Lenovo Device 21fa
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	IOMMU group: 12
	Region 0: Memory at f1d00000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D2 PME-
	Capabilities: [80] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unli=
mited
			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset- SlotPowerLimit 10.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <=
4us, L1 unlimited
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
			Status:	NegoPending- InProgress-
	Capabilities: [800 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr+ BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCC=
hkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Kernel driver in use: sdhci-pci
	Kernel modules: sdhci_pci

03:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8188CE 802.1=
1b/g/n WiFi Adapter (rev 01)
	Subsystem: Realtek Semiconductor Co., Ltd. Device 8195
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	IOMMU group: 13
	Region 0: I/O ports at 5000 [size=3D256]
	Region 2: Memory at f1c00000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <=
512ns, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+ LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- Equalizat=
ionPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr+ BadTLP- BadDLLP+ Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCC=
hkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 01-91-81-fe-ff-4c-e0-00
	Kernel driver in use: rtl8192ce
	Kernel modules: rtl8192ce

04:00.0 VGA compatible controller: NVIDIA Corporation GP106 [GeForce GTX 10=
60 6GB] (rev a1) (prog-if 00 [VGA controller])
	Subsystem: ASUSTeK Computer Inc. Device 85b6
	Physical Slot: 1
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 18
	IOMMU group: 14
	Region 1: Memory at <unassigned> (64-bit, prefetchable) [disabled]
	Region 3: Memory at <unassigned> (64-bit, prefetchable) [disabled]
	Region 5: I/O ports at 4000 [size=3D128]
	Expansion ROM at f1400000 [virtual] [disabled] [size=3D512K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D3 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [68] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <5=
12ns, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s (downgraded), Width x1 (downgraded)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers-=
 DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Compl=
ianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- Equalizat=
ionPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=3DFixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3Dff
			Status:	NegoPending- InProgress-
	Capabilities: [250 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [128 v1] Power Budgeting <?>
	Capabilities: [420 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCC=
hkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [600 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D024 <?>
	Capabilities: [900 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Kernel driver in use: vfio-pci
	Kernel modules: nouveau

04:00.1 Audio device: NVIDIA Corporation GP106 High Definition Audio Contro=
ller (rev a1)
	Subsystem: ASUSTeK Computer Inc. Device 85b6
	Physical Slot: 1
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Interrupt: pin B routed to IRQ 0
	IOMMU group: 14
	Region 0: Memory at f1480000 (32-bit, non-prefetchable) [disabled] [size=
=3D16K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D3 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [68] MSI: Enable- Count=3D1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <5=
12ns, L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s (downgraded), Width x1 (downgraded)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- Equalizat=
ionPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+=
 ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCC=
hkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Kernel driver in use: vfio-pci
	Kernel modules: snd_hda_intel


** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2018-3646

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1897481

Title:
  qemu crashes with VGA pass-through, e-GPU, nvidia 1060

Status in QEMU:
  New

Bug description:
  I try to pass-through nvidia 1060 6gb card, which is connected via
  ExpressCard (EXP-GDC converter).

  I can successfully run my virtual machine without pass-through, but
  when I try to add the devices, qemu crashes.

  The coredump contains:

  Stack trace of thread 3289311:
  #0  0x0000000000614c49 memory_region_update_container_subregions (qemu-sy=
stem-x86_64 + 0x214c49)
  #1  0x00000000005c0e8c vfio_probe_nvidia_bar0_quirk (qemu-system-x86_64 +=
 0x1c0e8c)
  #2  0x00000000005bcec0 vfio_realize (qemu-system-x86_64 + 0x1bcec0)
  #3  0x000000000079b423 pci_qdev_realize (qemu-system-x86_64 + 0x39b423)
  #4  0x00000000006facda device_set_realized (qemu-system-x86_64 + 0x2facda)
  #5  0x0000000000887e57 property_set_bool (qemu-system-x86_64 + 0x487e57)
  #6  0x000000000088ac48 object_property_set (qemu-system-x86_64 + 0x48ac48)
  #7  0x000000000088d1d2 object_property_set_qobject (qemu-system-x86_64 + =
0x48d1d2)
  #8  0x000000000088b1f7 object_property_set_bool (qemu-system-x86_64 + 0x4=
8b1f7)
  #9  0x0000000000693785 qdev_device_add (qemu-system-x86_64 + 0x293785)
  #10 0x000000000061aad0 device_init_func (qemu-system-x86_64 + 0x21aad0)
  #11 0x000000000098c87b qemu_opts_foreach (qemu-system-x86_64 + 0x58c87b)
  #12 0x00000000006211cb qemu_init (qemu-system-x86_64 + 0x2211cb)
  #13 0x00000000005002aa main (qemu-system-x86_64 + 0x1002aa)
  #14 0x00007fce8af21152 __libc_start_main (libc.so.6 + 0x28152)
  #15 0x000000000050087e _start (qemu-system-x86_64 + 0x10087e)

  The whole running command is pretty long, since I use libvirt to
  manage my machines:

  LC_ALL=3DC \
  PATH=3D/usr/local/sbin:/usr/local/bin:/usr/bin \
  HOME=3D/var/lib/libvirt/qemu/domain-2-Win10 \
  XDG_DATA_HOME=3D/var/lib/libvirt/qemu/domain-2-Win10/.local/share \
  XDG_CACHE_HOME=3D/var/lib/libvirt/qemu/domain-2-Win10/.cache \
  XDG_CONFIG_HOME=3D/var/lib/libvirt/qemu/domain-2-Win10/.config \
  QEMU_AUDIO_DRV=3Dspice \
  /usr/bin/qemu-system-x86_64 \
  -name guest=3DWin10,debug-threads=3Don \
  -S \
  -blockdev '{"driver":"file","filename":"/usr/share/edk2-ovmf/x64/OVMF_COD=
E.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discard"=
:"unmap"}' \
  -blockdev '{"node-name":"libvirt-pflash0-format","read-only":true,"driver=
":"raw","file":"libvirt-pflash0-storage"}' \
  -blockdev '{"driver":"file","filename":"/var/lib/libvirt/qemu/nvram/Win10=
_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"disc=
ard":"unmap"}' \
  -blockdev '{"node-name":"libvirt-pflash1-format","read-only":false,"drive=
r":"raw","file":"libvirt-pflash1-storage"}' \
  -machine pc-q35-5.1,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-guest-core=3D=
off,pflash0=3Dlibvirt-pflash0-format,pflash1=3Dlibvirt-pflash1-format \
  -cpu host,migratable=3Don,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=3D0x1f=
ff \
  -m 8192 \
  -overcommit mem-lock=3Doff \
  -smp 2,sockets=3D2,cores=3D1,threads=3D1 \
  -uuid 7043c77b-4903-4527-8089-9679d9a17fee \
  -no-user-config \
  -nodefaults \
  -chardev stdio,mux=3Don,id=3Dcharmonitor \
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
  -rtc base=3Dlocaltime,driftfix=3Dslew \
  -global kvm-pit.lost_tick_policy=3Ddelay \
  -no-hpet \
  -no-shutdown \
  -global ICH9-LPC.disable_s3=3D1 \
  -global ICH9-LPC.disable_s4=3D1 \
  -boot strict=3Don \
  -device pcie-root-port,port=3D0x10,chassis=3D1,id=3Dpci.1,bus=3Dpcie.0,mu=
ltifunction=3Don,addr=3D0x2 \
  -device pcie-root-port,port=3D0x11,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,ad=
dr=3D0x2.0x1 \
  -device pcie-root-port,port=3D0x12,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,ad=
dr=3D0x2.0x2 \
  -device pcie-root-port,port=3D0x13,chassis=3D4,id=3Dpci.4,bus=3Dpcie.0,ad=
dr=3D0x2.0x3 \
  -device pcie-root-port,port=3D0x14,chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,ad=
dr=3D0x2.0x4 \
  -device pcie-root-port,port=3D0x15,chassis=3D6,id=3Dpci.6,bus=3Dpcie.0,ad=
dr=3D0x2.0x5 \
  -device qemu-xhci,p2=3D15,p3=3D15,id=3Dusb,bus=3Dpci.2,addr=3D0x0 \
  -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.3,addr=3D0x0 \
  -blockdev '{"driver":"file","filename":"/home/sergiy/VirtualBox VMs/win4g=
ames.img","node-name":"libvirt-2-storage","auto-read-only":true,"discard":"=
unmap"}' \
  -blockdev '{"node-name":"libvirt-2-format","read-only":false,"driver":"ra=
w","file":"libvirt-2-storage"}' \
  -device ide-hd,bus=3Dide.0,drive=3Dlibvirt-2-format,id=3Dsata0-0-0,bootin=
dex=3D1 \
  -blockdev '{"driver":"file","filename":"/home/sergiy/Downloads/Win10_2004=
_Ukrainian_x64.iso","node-name":"libvirt-1-storage","auto-read-only":true,"=
discard":"unmap"}' \
  -blockdev '{"node-name":"libvirt-1-format","read-only":true,"driver":"raw=
","file":"libvirt-1-storage"}' \
  -device ide-cd,bus=3Dide.1,drive=3Dlibvirt-1-format,id=3Dsata0-0-1 \
  -chardev pty,id=3Dcharserial0 \
  -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 \
  -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent \
  -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchanne=
l0,id=3Dchannel0,name=3Dcom.redhat.spice.0 \
  -spice port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-compression=
=3Doff,seamless-migration=3Don \
  -device qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram=
64_size_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1 \
  -chardev spicevmc,id=3Dcharredir0,name=3Dusbredir \
  -device usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D1 \
  -chardev spicevmc,id=3Dcharredir1,name=3Dusbredir \
  -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D2 \
  -device vfio-pci,host=3D0000:04:00.0,id=3Dhostdev0,bus=3Dpci.4,multifunct=
ion=3Don,addr=3D0x0 \
  -device vfio-pci,host=3D0000:04:00.1,id=3Dhostdev1,bus=3Dpci.4,addr=3D0x0=
.0x1 \
  -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.5,addr=3D0x0 \
  -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourc=
econtrol=3Ddeny \
  -msg timestamp=3Don

  I've forced vfio_pci module for the VGA, and ensured that lspci shows

    Kernel driver in use: vfio_pci

  My laptop is Thinkpad x230, that runs on Intel(R) Core(TM) i5-3320M CPU @=
 2.60GHz. =

  I run 5.8.6-1-MANJARO kernel and run QEMU emulator version 5.1.0.

  Thank you for your attention. I'd love to provide more information,
  but I don't know what else matters.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1897481/+subscriptions

