Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA92C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E54A22CF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E54A22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i55dS-0000DJ-Ji
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 06:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i55cP-0008Az-9P
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i55cN-0003bL-Q3
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:00:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:50876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i55cN-0003aL-KM
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:00:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i55cL-0001MH-LH
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 10:00:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9F8492E80C8
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 10:00:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Sep 2019 09:54:46 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided;
 assignee=philmd@redhat.com; 
X-Launchpad-Bug-Tags: arm raspi
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <156630611054.27013.17194308047826699430.malonedeb@soybean.canonical.com>
Message-Id: <156750448686.16492.5214260003024092504.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 819fdaaf4e956400990800e546a03fe5d07e455e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1840777] Re: raspi3 machine can not shutdown
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
Reply-To: Bug 1840777 <1840777@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm guessing from:

  bcm2835-pm: unimplemented device read (size 4, offset 0x20)
  bcm2835-pm: unimplemented device write (size 4, value 0x5a000555, offset =
0x20)
  bcm2835-pm: unimplemented device write (size 4, value 0x5a00000a, offset =
0x24)
  bcm2835-pm: unimplemented device read (size 4, offset 0x1c)
  bcm2835-pm: unimplemented device write (size 4, value 0x5a000020, offset =
0x1c)

That we don't implement the power control parts of the SoC and therefor
the kernel got to a bit it wasn't expecting.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1840777

Title:
  raspi3 machine can not shutdown

Status in QEMU:
  New

Bug description:
  tag v4.1.0

  Running "shutdown" within a raspi3 image leads to kernel panic:

           Starting Power-Off...
  [   39.719617] systemd-shutdow: 39 output lines suppressed due to ratelim=
iting
  [   39.922997] systemd-shutdown[1]: Syncing filesystems and block devices.
  [   39.962415] systemd-shutdown[1]: Sending SIGTERM to remaining processe=
s...
  [   40.006842] systemd-journald[186]: Received SIGTERM from PID 1 (system=
d-shutdow).
  [   40.060745] systemd-shutdown[1]: Sending SIGKILL to remaining processe=
s...
  [   40.098318] systemd-shutdown[1]: Unmounting file systems.
  [   40.108351] systemd-shutdown[455]: Remounting '/' read-only in with op=
tions 'data=3Dordered'.
  [   40.128919] EXT4-fs (mmcblk0p2): re-mounted. Opts: data=3Dordered
  [   40.152844] systemd-shutdown[1]: All filesystems unmounted.
  [   40.153239] systemd-shutdown[1]: Deactivating swaps.
  [   40.154701] systemd-shutdown[1]: All swaps deactivated.
  [   40.155062] systemd-shutdown[1]: Detaching loop devices.
  [   40.159792] systemd-shutdown[1]: All loop devices detached.
  [   40.201746] kvm: exiting hardware virtualization
  [   40.207628] reboot: Power down
  bcm2835-pm: unimplemented device read (size 4, offset 0x20)
  bcm2835-pm: unimplemented device write (size 4, value 0x5a000555, offset =
0x20)
  bcm2835-pm: unimplemented device write (size 4, value 0x5a00000a, offset =
0x24)
  bcm2835-pm: unimplemented device read (size 4, offset 0x1c)
  bcm2835-pm: unimplemented device write (size 4, value 0x5a000020, offset =
0x1c)
  [   40.229604] systemd-shutdow: 4 output lines suppressed due to ratelimi=
ting
  [   40.230849] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x00000000
  [   40.230849] =

  [   40.231781] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 4.14.0-3-a=
rm64 #1 Debian 4.14.12-2
  [   40.232470] Hardware name: Raspberry Pi 3 Model B (DT)
  [   40.233206] Call trace:
  [   40.234096] [<ffff00000808a708>] dump_backtrace+0x0/0x280
  [   40.234519] [<ffff00000808a9ac>] show_stack+0x24/0x30
  [   40.234972] [<ffff00000885bb7c>] dump_stack+0x9c/0xc0
  [   40.235378] [<ffff0000080d1bd4>] panic+0x138/0x2b4
  [   40.235805] [<ffff0000080d72d4>] do_exit+0xa04/0xa08
  [   40.236260] [<ffff0000080fa9d8>] SyS_reboot+0x178/0x260
  [   40.236915] Exception stack(0xffff00000802bec0 to 0xffff00000802c000)
  [   40.237487] bec0: fffffffffee1dead 0000000028121969 000000004321fedc a=
dc576109fd73c00
  [   40.237949] bee0: 0000000000000028 8080800000000000 0000ffffad2392f8 7=
f7f7f7f7f7f7f7f
  [   40.238376] bf00: 000000000000008e 0000000000000000 0000000000000069 0=
000000000000000
  [   40.238744] bf20: 0000000000000000 0000000000000020 0000000000000000 0=
000000000000000
  [   40.239101] bf40: 0000aaaabeb9bf10 0000ffffad3030a8 0000000000000001 0=
000000000000000
  [   40.239462] bf60: 0000000000000000 0000aaaaeb6e0040 0000aaaabeb8a008 0=
000fffff7ce8d30
  [   40.239802] bf80: 0000001b00000004 0000aaaabeb8a000 0000fffff7ce8fa8 0=
000000000000000
  [   40.240134] bfa0: 0000aaaabeb9b000 0000fffff7ce8ac0 0000aaaabeb8741c 0=
000fffff7ce8aa0
  [   40.240468] bfc0: 0000ffffad3030c4 0000000000000000 fffffffffee1dead 0=
00000000000008e
  [   40.240809] bfe0: 0000000000000000 0000000000000000 0000000000000000 0=
000000000000000
  [   40.241194] [<ffff0000080837b0>] el0_svc_naked+0x24/0x28
  [   40.241930] Kernel Offset: disabled
  [   40.242197] CPU features: 0x002004
  [   40.242450] Memory Limit: none
  [   40.243063] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x00000000
  [   40.243063] =

  qemu-system-aarch64: terminating on signal 2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1840777/+subscriptions

