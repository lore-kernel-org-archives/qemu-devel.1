Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFC8C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24A320759
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24A320759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kadHK-00016A-Qx
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 06:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kadAk-0002h5-GL
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:11:18 -0500
Received: from indium.canonical.com ([91.189.90.7]:41024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kadAi-00027V-Gg
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:11:18 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kadAh-0008I6-CX
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 11:11:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5BCFD2E80AB
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 11:11:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2020 10:59:29 -0000
From: Peter Maydell <1779017@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell th-otto xrobau
X-Launchpad-Bug-Reporter: Thorsten Otto (th-otto)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <153014968219.17704.367188786620032253.malonedeb@chaenomeles.canonical.com>
Message-Id: <160457397004.17771.14807613554467776737.malone@soybean.canonical.com>
Subject: [Bug 1779017] Re: qemu-system-arm: crashes raspian kernels with
 divide-by-zero
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 3adb5d56ec87f7b3777e79942f285f0d28f96ac3
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 04:11:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1779017 <1779017@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This should be fixed for the 5.2 release, as we now have a model of the
cprman clock control module.


** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1779017

Title:
  qemu-system-arm: crashes raspian kernels with divide-by-zero

Status in QEMU:
  Fix Committed

Bug description:
  While trying to boot a arm kernel for a raspi2 machine (kernel7-4.9.41-st=
retch.img in my case, but applies to other versions, too) the kernel crash =
with a division by zero. The output on the sreial console is:
  [   10.022377] [<8011d344>] (__warn) from [<8011d42c>] (warn_slowpath_nul=
l+0x30/0x38)
  [   10.024726] [<8011d42c>] (warn_slowpath_null) from [<804da378>] (uart_=
get_baud_rate+0xf8/0x160)

  ...

  [   10.094933] Hardware name: BCM2835
  [   10.101507] [<8010fb3c>] (unwind_backtrace) from [<8010c058>] (show_st=
ack+0x20/0x24)
  [   10.105413] [<8010c058>] (show_stack) from [<80455f84>] (dump_stack+0x=
d4/0x118)
  [   10.140268] [<80455f84>] (dump_stack) from [<8010bed4>] (__div0+0x24/0=
x28)
  [   10.143065] [<8010bed4>] (__div0) from [<8045498c>] (Ldiv0+0x8/0x14)
  [   10.145553] [<8045498c>] (Ldiv0) from [<804e5538>] (pl011_set_termios+=
0x9c/0x37c)
  [   10.148017] [<804e5538>] (pl011_set_termios) from [<804da954>] (uart_c=
hange_speed+0x40/0xfc)
  [   10.185887] [<804da954>] (uart_change_speed) from [<804ddedc>] (uart_s=
tartup.part.3+0xa4/0x13c)
  [   10.222187] [<804ddedc>] (uart_startup.part.3) from [<804ddfcc>] (uart=
_port_activate+0x58/0x64)
  [   10.226014] [<804ddfcc>] (uart_port_activate) from [<804c93b8>] (tty_p=
ort_open+0xa0/0xe0)
  [   10.228398] [<804c93b8>] (tty_port_open) from [<804dce64>] (uart_open+=
0x40/0x48)
  [   10.264254] [<804dce64>] (uart_open) from [<804c1d70>] (tty_open+0xc0/=
0x678)
  [   10.266697] [<804c1d70>] (tty_open) from [<802753f0>] (chrdev_open+0xe=
0/0x1a0)
  [   10.269049] [<802753f0>] (chrdev_open) from [<8026d964>] (do_dentry_op=
en+0x1f4/0x314)
  [   10.271620] [<8026d964>] (do_dentry_open) from [<8026ec00>] (vfs_open+=
0x60/0x8c)
  [   10.275245] [<8026ec00>] (vfs_open) from [<8027f39c>] (path_openat+0x2=
bc/0x1040)
  [   10.312827] [<8027f39c>] (path_openat) from [<80281040>] (do_filp_open=
+0x70/0xd4)
  [   10.317860] [<80281040>] (do_filp_open) from [<8026efd8>] (do_sys_open=
+0x120/0x1d0)
  [   10.320370] [<8026efd8>] (do_sys_open) from [<8026f0b4>] (SyS_open+0x2=
c/0x30)
  [   10.357033] [<8026f0b4>] (SyS_open) from [<801080c0>] (ret_fast_syscal=
l+0x0/0x1c)

  Tracking that down in the linux kernel source, it looks like somehow
  uart_get_baud_rate() returns 0.

  The same kernel could be booted without problem with qemu version 2.11.
  Trying to bisecting the issue revealed commit @d9f8bbd8eb4e95db97cf02bd03=
af86a3d606f4f1 as the culprit.

  Commandline to run was:
  qemu-system-arm -M raspi2 \
  	-kernel "$KERNEL" \
  	-m 1024 \
  	-d guest_errors,unimp \
  	-dtb bcm2709-rpi-2-b.dtb \
  	-drive file=3D"$IMG,if=3Dsd,format=3Draw"

  Distribution is SuSE tumbleweed (x86_64, kernel 4.17.2), but same
  problem also happens with a freshly compiled qemu from git repository.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1779017/+subscriptions

