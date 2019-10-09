Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68857C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39900206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39900206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJGt-0007BS-0M
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iII3e-0005lR-0G
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iII3b-0006Q4-UH
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:55:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:46626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iII3b-0006PN-Hp
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:55:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iII3a-0008S8-BN
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 19:55:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3BC8E2E80CB
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 19:55:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Oct 2019 19:48:38 -0000
From: Andrew Randrianasulu <1847525@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: andrew-randrianasulu
X-Launchpad-Bug-Reporter: Andrew Randrianasulu (andrew-randrianasulu)
X-Launchpad-Bug-Modifier: Andrew Randrianasulu (andrew-randrianasulu)
References: <157065019192.22617.14242881910317034171.malonedeb@gac.canonical.com>
Message-Id: <157065051847.22468.13644841711647169251.malone@gac.canonical.com>
Subject: [Bug 1847525] Re: qemu-system-i386 eats a lot of cpu after just few
 hours, with sdl, gl=on
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="af2eefe214bd95389a09b7c956720881bab16807";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7aac556b8317139cf0b8138b72ae0dd94f41cc96
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1847525 <1847525@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Illustration for this bug (link  to screenshot):

https://www.imgbin.net/z/9W9eVVvbll.png

as you hopefully can see, just after less than 6 hrs of guest uptime
HOST cpu is eaten at 70% by qemu-system-i386 task .. up from just 50%
two hours ago! By this rate it will not survive even day of uptime....

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1847525

Title:
  qemu-system-i386 eats a lot of cpu after just few hours,  with
  sdl,gl=3Don

Status in QEMU:
  New

Bug description:
  I already send this email to qemu-discuss@nongnu.org , but I can't see
  it arriving in archives, so here  is copy.

  Hello, all!

  I use qemu-system-i386/qemu-system_x86_64 for rebuilding Slax-like live c=
d/dvd.
  Usually guests (with various self-compiled kernels and X stack with kde3 =
on top of them)
  boot up normally, but if I left them to run in GUI mode for few hours - q=
emu process on host
  started to eat more and more cpu for itself - more notiecable if I set ho=
st cpu to lowest possible
  frequency via trayfreq applet (1400Mhz in my case).

  Boot line a bit complicated, but I really prefer to have sound and usb in=
side VM.
  qemu-system-i386 -cdrom /dev/shm/CDROM-4.4.194_5.iso -m 1.9G -enable-kvm =
-soundhw es1370 -smp 2 -display sdl,gl=3Don -usb -cpu host -rtc clock=3Dvm

  rtc clock=3Dvm was taken from https://bugs.launchpad.net/qemu/+bug/117465=
4 but apparently not helping.
  After just 3 hours of uptime (copied line from 'top' on host)

  31943 guest     20   0 2412m 791m  38m R   51  6.7  66:36.51 qemu-
  system-i38

  I use Xorg 1.19.7 on host, with mesa git/nouveau as GL driver. But my car=
d has not very big amount of VRAM - only 384Mb.
  May be this limitation is playing some role .. but 'end-user' result was =
after 1-2 day of guest uptime I run into completely frozen guest =

  (may be when qemu was hitting 100 one core usage on host some internal ti=
mer just made guest kernel too upset/froze?
   I was sleeping or doing other things on host  for all this time, with VM=
 just supposedly running at another virtual desktop - =

  in KDE3 + built-in compositor ....)

  I wonder if more mainstream desktop users (on GNOME, Xfce, etc) and/or us=
ers of other distros (I use self-re-compiled Slackware)
  actually can see same problem?

  qemu-system-i386 --version
  QEMU emulator version 4.1.50 (v4.1.0-1188-gc6f5012ba5-dirty)
  but I saw same behavior for quite some time .. just never reported it in =
hope it will go away.

  cat /proc/cpuinfo
  processor       : 0
  vendor_id       : AuthenticAMD
  cpu family      : 21
  model           : 2
  model name      : AMD FX(tm)-4300 Quad-Core Processor
  stepping        : 0
  microcode       : 0x6000852
  cpu MHz         : 1399.977
  cache size      : 2048 KB
  physical id     : 0
  siblings        : 4
  core id         : 0
  cpu cores       : 2
  apicid          : 16
  initial apicid  : 0
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 13
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pd=
pe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid ap=
erfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes xsav=
e avx f16c lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse =
3dnowprefetch osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext p=
erfctr_core perfctr_nb cpb hw_pstate ssbd vmmcall bmi1 arat npt lbrv svm_lo=
ck nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pft=
hreshold
  bugs            : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre=
_v2 spec_store_bypass
  bogomips        : 7600.06
  TLB size        : 1536 4K pages
  clflush size    : 64
  cache_alignment : 64
  address sizes   : 48 bits physical, 48 bits virtual
  power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

  [and 3x more of the same, for 3 remaining cores]

  Gcc is Slackware 14.2's gcc 5.5.0, but I saw this with 4.9.2 too.
  This might be 32-bit host problem. But may be just no-one tried to run qe=
mu with GUI guest for literaly days?

  Host kernel is
   uname -a
  Linux slax 5.1.12-x64 #1 SMP PREEMPT Wed Jun 19 12:31:05 MSK 2019 x86_64 =
AMD FX(tm)-4300 Quad-Core Processor AuthenticAMD GNU/Linux

  I was trying newish 5.3.2 but my compilation was not as stable as this on=
e =

  (I tend to change few things, like max cpu count, preemption mode, numa s=
upport .... =

  for more distribution-like, yet most stable  and performant for me kernel)

  Kernel world is moving fast, so I'll try to recompile new 5.3.x too
  ....

  =

  I guess I  should provide perf/profiler output, but for  this I need to r=
ecompile qemu. =

  I'll try to come back with more details soon.

  Thanks for your attention and possible feedback!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1847525/+subscriptions

