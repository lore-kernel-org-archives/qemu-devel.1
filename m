Return-Path: <SRS0=P1lm=VZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB19EC433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 00:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951772086D
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 00:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951772086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrWm3-0007nE-Sz
	for qemu-devel@archiver.kernel.org; Sat, 27 Jul 2019 20:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57191)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hrWls-0007Ow-Pg
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 20:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hrWlr-0000OG-6P
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 20:10:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:51884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hrWlq-0000NR-Uw
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 20:10:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hrWlp-00076p-0I
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2019 00:10:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EF2A62E8070
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2019 00:10:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jul 2019 00:02:40 -0000
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
Message-Id: <156427216074.23482.17611101785807665637.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: f1e50ff6629d031737ad5d35b1dd4f4c4a9b5031
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

My guess is that RFLAGS.ZF =3D=3D 1 and one or a few of the checks on VMX c=
ontrols have failed. So far I have verified the following checks (26-2 and =
26-3 in Intel SDM Vol. 3C):
* Reserved bits in Pin-based VM execution controls are set according to ass=
ociated capabilities MSR =

* Reserved bits in Primary Proc-based VM execution controls are set accordi=
ng to associated capabilities MSR =

* Reserved bits in Secondary Proc-based VM execution controls are set accor=
ding to associated capabilities MSR =

* CR-3 target count is not greater than 4. (the count is 0)
* Use I/O bitmaps check is not applicable because "use I/O bitmaps" VM-exec=
ution control is 0.
* Reserved bits in VM-exit controls are set according to associated capabil=
ities MSR =

* Reserved bits in VM-entry controls are set according to associated capabi=
lities MSR =


However, the MSR-bitmap Address check might fail:
"If the =E2=80=9Cuse MSR bitmaps=E2=80=9D VM-execution control is 1, bits 1=
1:0 of the MSR-bitmap address must be 0. The address should not set any bit=
s beyond the processor=E2=80=99s physical-address width."

Bit 28 in Pin-based VM execution controls is set to 1 while the MSR
address has bits 5:1 set to 1 (0x3f). There's no way to disable the "use
MSR bitmaps" execution control so I'll try to make a patch that sets 4k-
page aligned MSR bitmap address.

Updated log lines show the VMX capabilities for the control fields and VMCS=
 fields related to the failure:
qemu-system-x86_64: hv_vcpu_run failed
qemu-system-x86_64: exit reason:            0x0000000000000030
qemu-system-x86_64: exit qualification:     0x0000000000000083
qemu-system-x86_64: instruction error:      0x0000000000000007
qemu-system-x86_64: VM-EXECUTION CONTROL FIELDS
qemu-system-x86_64: Pin-Based VM-Execution Controls
qemu-system-x86_64: pin based ctls:         0x000000000000003f
qemu-system-x86_64: pin based caps:         0x0000007f0000003f
qemu-system-x86_64: Processor-Based VM-Execution Controls
qemu-system-x86_64: pri proc based ctls:    0x0000000095206dfa
qemu-system-x86_64: pri proc based caps:    0xfdf9fffe9500697a
qemu-system-x86_64: sec proc based ctls:    0x00000000000000a3
qemu-system-x86_64: sec proc based caps:    0x00011cef000000a2
qemu-system-x86_64: CR3-Target Controls
qemu-system-x86_64: cr3 target count:       0x0000000000000000
qemu-system-x86_64: MSR-Bitmap Address:     0x000000000000003f
qemu-system-x86_64: VM-EXIT CONTROL FIELDS
qemu-system-x86_64: VM-Exit Controls
qemu-system-x86_64: vm exit ctls:           0x0000000000236fff
qemu-system-x86_64: vm exit caps:           0x00636fff00236fff
qemu-system-x86_64: VM-ENTRY CONTROL FIELDS
qemu-system-x86_64: VM-Entry Controls
qemu-system-x86_64: vm entry ctls:          0x00000000000093ff
qemu-system-x86_64: vm entry caps:          0x000093ff000091ff
qemu-system-x86_64: Error: HV_ERROR

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

