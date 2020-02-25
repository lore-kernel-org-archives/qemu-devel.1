Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B1BC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 19:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9794E2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 19:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9794E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=virtualroadside.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6fh0-00065T-P2
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 14:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j6fgA-0005cC-KZ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j6fg9-0000iy-2M
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:15:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:44544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j6fg8-0000g2-Rv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:15:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j6fg7-0002wL-6T
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 19:15:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2A4E22E80C3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 19:15:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Feb 2020 19:09:38 -0000
From: Dustin Spicuzza <dustin@virtualroadside.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dustin-virtualroadside
X-Launchpad-Bug-Reporter: Dustin Spicuzza (dustin-virtualroadside)
X-Launchpad-Bug-Modifier: Dustin Spicuzza (dustin-virtualroadside)
References: <158207050809.30858.5545792366181447140.malonedeb@wampee.canonical.com>
Message-Id: <158265777897.19007.10444433640166044587.malone@chaenomeles.canonical.com>
Subject: [Bug 1863819] Re: repeated KVM single step crashes leaks into SMP
 guest and crashes guest application
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="9eff1c37c1740693bdcba94d8f8c608164af5689";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 44b5926ffcda5fa0be43e8b648eba5aedea4520f
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
Reply-To: Bug 1863819 <1863819@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some experimentation with newer kernels indicate that this is most
likely a KVM bug.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863819

Title:
  repeated KVM single step crashes leaks into SMP guest and crashes
  guest application

Status in QEMU:
  Invalid

Bug description:
  Guest: Windows 7 x64
  Host: Ubuntu 18.04.4 (kernel 5.3.0-40-generic)
  QEMU: master 6c599282f8ab382fe59f03a6cae755b89561a7b3

  If I try to use GDB to repeatedly single-step a userspace process
  while running a KVM guest, the userspace process will eventually crash
  with a 0x80000004 exception (single step). This is easily reproducible
  on a Windows guest, I've not tried another guest type but I've been
  told it's the same there also.

  On a Ubuntu 16 host with an older kernel, this will hang the entire
  machine. However, it seems it may have been fixed by
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D5cc244a20b86090c087073c124284381cdf47234
  ?

  It's not clear to me whether this is a KVM or a QEMU bug. A TCG guest
  does not crash the userspace process in the same way, but it does hang
  the VM.

  I've tried a variety of QEMU versions (3.0, 4.2, master) and they all
  exhibit the same behavior. I'm happy to dig into this more if someone
  can point me in the right direction.

  Here's the outline for reproducing the bug:

  * Compile iloop.cpp (attached) as a 32-bit application using MSVC
  * Start Windows 7 x64 guest under GDB
    * Pass '-enable-kvm -smp 4,cores=3D2 -gdb tcp::4567' to QEMU along with=
 other typical options

  (need to get CR3 to ensure we're in the right application context -- if t=
here's an easier way to do this I'd love to hear it!)
  * Install WinDBG on guest
  * Copy SysInternals LiveKD to guest
  * Start iloop.exe in guest, note loop address
  * Run LiveKD from administrative prompt
    * livekd64.exe -w
  * In WinDBG:
    * !process 0 0
    * Search for iloop.exe, note DirBase (this is CR3)

  In GDB:
  * Execute 'target remote tcp::4567'
  * Execute 'c'
  * Hit CTRL-C to pause the VM
  * Execute 'p/x $cr3'
    .. continue if not equal to DirBase in WinDBG, keep stopping until it i=
s equal
  * Once $cr3 is correct value, if you 'stepi' a few times you'll note the =
process going in a loop, it should keep hitting the address echoed to the c=
onsole by iloop.exe

  Crash the process from GDB:
  * Execute 'stepi 100000000'
  * Watch the process, eventually it'll die with an 0x80000004 error

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863819/+subscriptions

