Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C7EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691E520720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691E520720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJlf-0003op-O3
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 19:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jtJl3-0003Bb-Kt
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:45:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:37998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jtJl1-0003PG-CF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:45:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jtJkz-0000rv-Pu
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 23:45:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BB14C2E80ED
 for <qemu-devel@nongnu.org>; Wed,  8 Jul 2020 23:45:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2020 23:36:22 -0000
From: Alex Austin <1886602@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: circuitsoft lersek
X-Launchpad-Bug-Reporter: Alex Austin (circuitsoft)
X-Launchpad-Bug-Modifier: Alex Austin (circuitsoft)
References: <159408874500.32011.1427435858163411654.malonedeb@gac.canonical.com>
Message-Id: <159425138304.26885.1674346626863488567.malone@wampee.canonical.com>
Subject: [Bug 1886602] Re: Windows 10 very slow with OVMF
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b24753402d6321ed1b9083e580f5f014a46bab00";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1e637d589c0d2c36bbad06a7ff19fb45a884dc09
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 15:50:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1886602 <1886602@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I did try the most recent OVMF from QEMU 5.0
(https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Dpc-
bios/edk2-x86_64-code.fd.bz2;hb=3Dfdd76fecdde) and there was no
difference.

I will re-build qemu sometime soon.

=3D=3D=3D=3D=3D=3D=3D
$ cat /proc/cpuinfo =

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 142
model name      : Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz
stepping        : 9
microcode       : 0xca
cpu MHz         : 659.478
cache size      : 4096 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx p=
dpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopo=
logy nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monit=
or ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2ap=
ic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3d=
nowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_sha=
dow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bm=
i2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xge=
tbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp m=
d_clear flush_l1d
bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf=
 mds swapgs itlb_multihit srbds
bogomips        : 5808.00
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

=3D=3D=3D=3D=3D=3D=3D
$ grep . /sys/module/kvm_*/parameters/*
/sys/module/kvm_intel/parameters/emulate_invalid_guest_state:Y
/sys/module/kvm_intel/parameters/enable_apicv:N
/sys/module/kvm_intel/parameters/enable_shadow_vmcs:N
/sys/module/kvm_intel/parameters/enlightened_vmcs:N
/sys/module/kvm_intel/parameters/ept:Y
/sys/module/kvm_intel/parameters/eptad:Y
/sys/module/kvm_intel/parameters/fasteoi:Y
/sys/module/kvm_intel/parameters/flexpriority:Y
/sys/module/kvm_intel/parameters/nested:N
/sys/module/kvm_intel/parameters/ple_gap:128
/sys/module/kvm_intel/parameters/ple_window:4096
/sys/module/kvm_intel/parameters/ple_window_grow:2
/sys/module/kvm_intel/parameters/ple_window_max:4294967295
/sys/module/kvm_intel/parameters/ple_window_shrink:0
/sys/module/kvm_intel/parameters/pml:Y
/sys/module/kvm_intel/parameters/preemption_timer:Y
/sys/module/kvm_intel/parameters/unrestricted_guest:Y
/sys/module/kvm_intel/parameters/vmentry_l1d_flush:cond
/sys/module/kvm_intel/parameters/vnmi:Y
/sys/module/kvm_intel/parameters/vpid:Y

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1886602

Title:
  Windows 10 very slow with OVMF

Status in QEMU:
  New

Bug description:
  Debian Buster

  Kernel 4.19.0-9-amd64
  qemu-kvm 1:3.1+dfsg-8+deb10u5
  ovmf 0~20181115.85588389-3+deb10u1

  Machine: Thinkpad T470, i7-7500u, 20GB RAM
  VM: 4 CPUs, 8GB RAM, Broadwell-noTSX CPU Model

  Windows 10, under this VM, seems to be exceedingly slow with all
  operations. This is a clean install with very few services running.
  Task Manager can take 30% CPU looking at an idle system.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1886602/+subscriptions

