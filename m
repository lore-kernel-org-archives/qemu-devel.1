Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCD5C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E06620651
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E06620651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsOnB-0000kF-HQ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 05:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36647)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hsOmc-0000KC-9k
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hsOma-0003F9-SQ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:51:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:47472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hsOma-0003El-MS
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:51:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hsOmX-0007ig-UJ
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 09:50:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0EF6E2E80D2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 09:50:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jul 2019 09:36:03 -0000
From: Roman Bolshakov <1818937@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: crash hvf macos
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bwibking cuser2 kisg roolebo
X-Launchpad-Bug-Reporter: Chen Zhang (cuser2)
X-Launchpad-Bug-Modifier: Roman Bolshakov (roolebo)
References: <155192472106.28960.15645485731508389788.malonedeb@chaenomeles.canonical.com>
Message-Id: <156447936384.17753.12319986519288026631.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 5723a7a8c50fe1fa14fb20c4972899ee1b5d2179
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1818937] Re: Crash with HV_ERROR on macOS host
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
Reply-To: Bug 1818937 <1818937@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's not possible to allocate MSR bitmap in userspace because it
requires a physical address to be stored in the VMCS field. However, the
bitmap page is already allocated inside kernel part of
Hypervisor.framework. The 4k bitmap region is aligned to page boundary.
It's worth to continue inspection of the checks (26.2 CHECKS ON VMX
CONTROLS AND HOST-STATE AREA).

The reason why MSR Bitmap Address has weird value is because it's not
necessarily the value of the VMCS field (albeit VMCS_CTRL_MSR_BITMAPS is
defined in hv_arch_vmx.h). HVF uses an internal lookup table that has a
limited set of VMCS fields exposed by Apple. The list is documented at
the reference page:
https://developer.apple.com/documentation/hypervisor/1469436-virtual_machin=
e_control_structur

It's likely that 0x3f is a field from the VMCS lookup table. Given the
signature of hv_vmx_vcpu_read_vmcs, I would expect an error (e.g.
HV_BAD_ARGUMENT) to be returned instead of the silent failure. I have
submitted FB6858948 to Apple to correct the behaviour.

So, Apple doesn't provide an explicit access to MSR Bitmap Address field
but allows to control the bitmap via hv_vcpu_enable_native_msr.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1818937

Title:
  Crash with HV_ERROR on macOS host

Status in QEMU:
  New

Bug description:
  On macOS host running Windows 10 guest, qemu crashed with error
  message: Error: HV_ERROR.

  Host: macOS Mojave 10.14.3 (18D109) Late 2014 Mac mini presumably Core i5=
 4278U.
  QEMU: git commit a3e3b0a7bd5de211a62cdf2d6c12b96d3c403560
  QEMU parameter: qemu-system-x86_64 -m 3000 -drive file=3Ddisk.img,if=3Dvi=
rtio,discard=3Dunmap -accel hvf -soundhw hda -smp 3

  thread list
  Process 56054 stopped
    thread #1: tid =3D 0x2ffec8, 0x00007fff48d0805a vImage`vLookupTable_Pla=
nar16 + 970, queue =3D 'com.apple.main-thread'
    thread #2: tid =3D 0x2ffecc, 0x00007fff79d6d7de libsystem_kernel.dylib`=
__psynch_cvwait + 10
    thread #3: tid =3D 0x2ffecd, 0x00007fff79d715aa libsystem_kernel.dylib`=
__select + 10
    thread #4: tid =3D 0x2ffece, 0x00007fff79d71d9a libsystem_kernel.dylib`=
__sigwait + 10
  * thread #6: tid =3D 0x2ffed0, 0x00007fff79d7023e libsystem_kernel.dylib`=
__pthread_kill + 10, stop reason =3D signal SIGABRT
    thread #7: tid =3D 0x2ffed1, 0x00007fff79d6d7de libsystem_kernel.dylib`=
__psynch_cvwait + 10
    thread #8: tid =3D 0x2ffed2, 0x00007fff79d6d7de libsystem_kernel.dylib`=
__psynch_cvwait + 10
    thread #11: tid =3D 0x2fff34, 0x00007fff79d6a17a libsystem_kernel.dylib=
`mach_msg_trap + 10, name =3D 'com.apple.NSEventThread'
    thread #30: tid =3D 0x300c04, 0x00007fff79e233f8 libsystem_pthread.dyli=
b`start_wqthread
    thread #31: tid =3D 0x300c16, 0x00007fff79e233f8 libsystem_pthread.dyli=
b`start_wqthread
    thread #32: tid =3D 0x300c17, 0x0000000000000000
    thread #33: tid =3D 0x300c93, 0x00007fff79d6d7de libsystem_kernel.dylib=
`__psynch_cvwait + 10

  =

  Crashed thread:

  * thread #6, stop reason =3D signal SIGABRT
    * frame #0: 0x00007fff79d7023e libsystem_kernel.dylib`__pthread_kill + =
10
      frame #1: 0x00007fff79e26c1c libsystem_pthread.dylib`pthread_kill + 2=
85
      frame #2: 0x00007fff79cd91c9 libsystem_c.dylib`abort + 127
      frame #3: 0x000000010baa476d qemu-system-x86_64`assert_hvf_ok(ret=3D<=
unavailable>) at hvf.c:106 [opt]
      frame #4: 0x000000010baa4c8f qemu-system-x86_64`hvf_vcpu_exec(cpu=3D0=
x00007f8e5283de00) at hvf.c:681 [opt]
      frame #5: 0x000000010b988423 qemu-system-x86_64`qemu_hvf_cpu_thread_f=
n(arg=3D0x00007f8e5283de00) at cpus.c:1636 [opt]
      frame #6: 0x000000010bd9dfce qemu-system-x86_64`qemu_thread_start(arg=
s=3D<unavailable>) at qemu-thread-posix.c:502 [opt]
      frame #7: 0x00007fff79e24305 libsystem_pthread.dylib`_pthread_body + =
126
      frame #8: 0x00007fff79e2726f libsystem_pthread.dylib`_pthread_start +=
 70
      frame #9: 0x00007fff79e23415 libsystem_pthread.dylib`thread_start + 13

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1818937/+subscriptions

