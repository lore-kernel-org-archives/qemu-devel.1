Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2EFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA018207C3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA018207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZKnE-000270-Tj
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 16:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kZKXj-0003Y4-QK
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:05:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:57214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kZKXh-0005if-AN
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:05:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kZKXf-0005yp-Bx
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2020 21:05:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4B4842E8131
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2020 21:05:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2020 20:57:25 -0000
From: Luis <1902451@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: cpuid
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: qubasa
X-Launchpad-Bug-Reporter: Luis (qubasa)
X-Launchpad-Bug-Modifier: Luis (qubasa)
References: <160426338728.14730.2439588061093712843.malonedeb@wampee.canonical.com>
Message-Id: <160426424638.30466.11447725847272436753.launchpad@gac.canonical.com>
Subject: [Bug 1902451] Re: incorrect cpuid feature detection
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="96ff31b88b65a0d0ea73b89333fe7c4a2669d8fb"; Instance="production"
X-Launchpad-Hash: 67e307a84fe9f048439e60759e5ec4777e9014bb
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 15:50:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Reply-To: Bug 1902451 <1902451@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Tags added: cpuid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1902451

Title:
  incorrect cpuid feature detection

Status in QEMU:
  New

Bug description:
  Hello,

  I am currently developing a x64 kernel and I wanted to check through
  cpuid if some features are available in the guest. When I try to
  enable cpu features like vmcb_clean or constant_tsc qemu is saying
  that my host doesn't support the requested features. However cat
  /proc/cpuinfo tells a different story:

  model name:  AMD Ryzen 5 3500U
  flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdt=
scp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf =
pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave a=
vx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalign=
sse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext=
 perfctr_llc mwaitx cpb hw_pstate sme pti ssbd sev ibpb vmmcall fsgsbase bm=
i1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1=
 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale=
 vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave=
_vmload vgif overflow_recov succor smca

  I also checked it myself by running cpuid and check the bits as in the
  AMD Manual. Everything checks out but qemu still fails.

  QEMU version: QEMU emulator version 4.2.0

  $ qemu-system-x86_64 -cpu host,+vmcb_clean,enforce -enable-kvm -drive for=
mat=3Draw,file=3Dtarget/x86_64-os/debug/bootimage-my_kernel.bin -serial std=
io -display none
  qemu-system-x86_64: warning: host doesn't support requested feature: CPUI=
D.8000000AH:EDX.vmcb-clean [bit 5]
  qemu-system-x86_64: Host doesn't support requested features

  or

  $ qemu-system-x86_64 -cpu host,+constant_tsc,enforce -enable-kvm -drive f=
ormat=3Draw,file=3Dtarget/x86_64-os/debug/bootimage-my_kernel.bin -serial s=
tdio -display none
  qemu-system-x86_64: Property '.constant_tsc' not found

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1902451/+subscriptions

