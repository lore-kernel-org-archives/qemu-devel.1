Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7288DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 02:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4052321897
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 02:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4052321897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5KrB-0006sA-D7
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 22:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i5Kpf-000687-JN
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 22:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i5Kpd-0007oU-SV
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 22:15:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:34628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i5Kpd-0007o3-MI
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 22:15:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i5Kpc-0004Gu-As
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 02:15:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4D4302E80C7
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 02:15:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Sep 2019 02:00:55 -0000
From: cpw <1842530@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: chenpw2088
X-Launchpad-Bug-Reporter: cpw (chenpw2088)
X-Launchpad-Bug-Modifier: cpw (chenpw2088)
Message-Id: <156756245552.28547.15554086877936320249.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 996307a7fdd913138a53edc84a2add3cf6b657d3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] =?utf-8?q?=5BBug_1842530=5D_=5BNEW=5D_ich6_and_ich9_?=
 =?utf-8?q?sound_card_has_noisy=EF=BC=88murmur=EF=BC=89?=
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
Reply-To: Bug 1842530 <1842530@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

[root@localhost1 qemu]# lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                6
On-line CPU(s) list:   0-5
Thread(s) per core:    1
Core(s) per socket:    6
Socket(s):             1
NUMA node(s):          1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 158
Model name:            Intel(R) Core(TM) i5-8400 CPU @ 2.80GHz
Stepping:              10
CPU MHz:               899.951
CPU max MHz:           4000.0000
CPU min MHz:           800.0000
BogoMIPS:              5616.00
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              9216K
NUMA node0 CPU(s):     0-5
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=
 mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall=
 nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_c=
pl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movb=
e popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowpref=
etch epb intel_pt ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpi=
d fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap =
clflushopt xsaveopt xsavec xgetbv1 dtherm ida arat pln pts hwp hwp_notify h=
wp_act_window hwp_epp spec_ctrl intel_stibp flush_l1d


[root@localhost1 qemu]# lsb_release -a
LSB Version:    :core-4.1-amd64:core-4.1-noarch
Distributor ID: CentOS
Description:    CentOS Linux release 7.6.1810 (Core)
Release:        7.6.1810
Codename:       Core

Installed as Virtualization Server (qemuV1.5)=EF=BC=9B
create win7-32 or 64 GuestOS by virt-manager=EF=BC=8Cand select default sou=
nd card ich6=EF=BC=9B

<graphics type=3D'spice' autoport=3D'yes'>
      <listen type=3D'address'/>
      <image compression=3D'off'/>
    </graphics>
    <sound model=3D'ich6'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' fu=
nction=3D'0x0'/>
    </sound>
    <video>
      <model type=3D'qxl' ram=3D'65536' vram=3D'65536' vgamem=3D'16384' hea=
ds=3D'1' primary=3D'yes'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x0'/>
    </video>


but obvious noise found when login guest os to play music. :(

And the problem remains after I update qemu to 2.12.0-18 , 3.1.0 &etc.


[root@localhost1 qemu]# /usr/bin/qemu-system-x86_64 --version
QEMU emulator version 3.1.0
Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1842530

Title:
  ich6 and ich9 sound card has noisy=EF=BC=88murmur=EF=BC=89

Status in QEMU:
  New

Bug description:
  [root@localhost1 qemu]# lscpu
  Architecture:          x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Byte Order:            Little Endian
  CPU(s):                6
  On-line CPU(s) list:   0-5
  Thread(s) per core:    1
  Core(s) per socket:    6
  Socket(s):             1
  NUMA node(s):          1
  Vendor ID:             GenuineIntel
  CPU family:            6
  Model:                 158
  Model name:            Intel(R) Core(TM) i5-8400 CPU @ 2.80GHz
  Stepping:              10
  CPU MHz:               899.951
  CPU max MHz:           4000.0000
  CPU min MHz:           800.0000
  BogoMIPS:              5616.00
  Virtualization:        VT-x
  L1d cache:             32K
  L1i cache:             32K
  L2 cache:              256K
  L3 cache:              9216K
  NUMA node0 CPU(s):     0-5
  Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sysca=
ll nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nop=
l xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds=
_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic mo=
vbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowpr=
efetch epb intel_pt ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept v=
pid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx sma=
p clflushopt xsaveopt xsavec xgetbv1 dtherm ida arat pln pts hwp hwp_notify=
 hwp_act_window hwp_epp spec_ctrl intel_stibp flush_l1d

  =

  [root@localhost1 qemu]# lsb_release -a
  LSB Version:    :core-4.1-amd64:core-4.1-noarch
  Distributor ID: CentOS
  Description:    CentOS Linux release 7.6.1810 (Core)
  Release:        7.6.1810
  Codename:       Core

  Installed as Virtualization Server (qemuV1.5)=EF=BC=9B
  create win7-32 or 64 GuestOS by virt-manager=EF=BC=8Cand select default s=
ound card ich6=EF=BC=9B

  <graphics type=3D'spice' autoport=3D'yes'>
        <listen type=3D'address'/>
        <image compression=3D'off'/>
      </graphics>
      <sound model=3D'ich6'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' =
function=3D'0x0'/>
      </sound>
      <video>
        <model type=3D'qxl' ram=3D'65536' vram=3D'65536' vgamem=3D'16384' h=
eads=3D'1' primary=3D'yes'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0'/>
      </video>

  =

  but obvious noise found when login guest os to play music. :(

  And the problem remains after I update qemu to 2.12.0-18 , 3.1.0 &etc.

  =

  [root@localhost1 qemu]# /usr/bin/qemu-system-x86_64 --version
  QEMU emulator version 3.1.0
  Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1842530/+subscriptions

