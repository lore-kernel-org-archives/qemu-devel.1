Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40D3C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A82D20708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A82D20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Ylf-0006rB-Pt
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 11:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j1Yl1-0006Hz-Ow
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:51:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j1Yl0-0003kW-FA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:51:31 -0500
Received: from indium.canonical.com ([91.189.90.7]:56232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j1Yl0-0003k3-9z
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:51:30 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j1Yky-0004WE-DQ
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 16:51:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1BA962E80D4
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 16:51:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Feb 2020 16:37:25 -0000
From: Thomas Huth <1661386@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bonzini dgilbert-h matwey-kornilov th-huth
X-Launchpad-Bug-Reporter: Matwey V. Kornilov (matwey-kornilov)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20170202204510.26617.69309.malonedeb@wampee.canonical.com>
Message-Id: <158143904664.29547.417848089163174657.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1661386] Re: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 37316a12f5284e932e6c9e4fe294762f107f6c75
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1661386 <1661386@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1661386

Title:
  Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed

Status in QEMU:
  Fix Released

Bug description:
  Hello,

  =

  I see the following when try to run qemu from master as the following:

  # ./x86_64-softmmu/qemu-system-x86_64 --version
  QEMU emulator version 2.8.50 (v2.8.0-1006-g4e9f524)
  Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
  # ./x86_64-softmmu/qemu-system-x86_64 -machine accel=3Dkvm -nodefaults
  -no-reboot -nographic -cpu host -vga none  -kernel .build.kernel.kvm
  -initrd .build.initrd.kvm -append 'panic=3D1 no-kvmclock console=3DttyS0
  loglevel=3D7' -m 1024 -serial stdio
  qemu-system-x86_64: /home/matwey/lab/qemu/target/i386/kvm.c:1849:
  kvm_put_msrs: Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.

  First broken commit has been bisected:

  commit 48e1a45c3166d659f781171a47dabf4a187ed7a5
  Author: Paolo Bonzini <pbonzini@redhat.com>
  Date:   Wed Mar 30 22:55:29 2016 +0200

      target-i386: assert that KVM_GET/SET_MSRS can set all requested MSRs
      =

      This would have caught the bug in the previous patch.
      =

      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

  My cpuinfo is the following:

  processor       : 0
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 44
  model name      : Intel(R) Xeon(R) CPU           X5675  @ 3.07GHz
  stepping        : 2
  microcode       : 0x14
  cpu MHz         : 3066.775
  cache size      : 12288 KB
  physical id     : 0
  siblings        : 2
  core id         : 0
  cpu cores       : 2
  apicid          : 0
  initial apicid  : 0
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 11
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a cmov pat pse36 clflush dts mmx fxsr sse sse2 ss ht syscall nx rdtscp lm c=
onstant_tsc arch_perfmon pebs bts nopl xtopology tsc_reliable nonstop_tsc a=
perfmperf pni pclmulqdq vmx ssse3 cx16 sse4_1 sse4_2 popcnt aes hypervisor =
lahf_lm ida arat epb dtherm tpr_shadow vnmi ept vpid
  bugs            :
  bogomips        : 6133.55
  clflush size    : 64
  cache_alignment : 64
  address sizes   : 40 bits physical, 48 bits virtual
  power management:

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1661386/+subscriptions

