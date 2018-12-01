Received: from eggs.gnu.org ([2001:4830:134:3::10]:42771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gSync-0007KH-BI
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 01:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gSynZ-0007R1-3w
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 01:30:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:59160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gSynY-0007Nb-UJ
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 01:30:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gSynX-0004bW-IO
	for <qemu-devel@nongnu.org>; Sat, 01 Dec 2018 06:30:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 503182E80CB
	for <qemu-devel@nongnu.org>; Sat,  1 Dec 2018 06:30:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Dec 2018 06:23:35 -0000
From: Anton Sharpaev <1805697@bugs.launchpad.net>
Reply-To: Bug 1805697 <1805697@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154343711336.10463.14315631936822945059.malonedeb@chaenomeles.canonical.com>
	<154349742000.10234.7500488610340706268.malone@chaenomeles.canonical.com>
Message-Id: <438634619.20181201092335@sharpaev.ru>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1805697] Re: egl-headless crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, Gerd.

   Thank you very match! It's work for me.

   Now,  I need to contact with libvirt developers. Libvirt isn't work
   with egl-headless. I'm trying last version (4.9.0)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1805697

Title:
  egl-headless crashes

Status in QEMU:
  New

Bug description:
  egl-headless crashes when it is trying change the resolution. After
  XFCE login, for example.

  I tryed it on 2.12, 3.0 and 3.1.0-rc2 versions.

  # qemu-system-x86_64 -enable-kvm -enable-kvm -M q35 -smp 8 -vga virtio
  -spice port=3D59011,addr=3D0.0.0.0,disable-ticketing -hda image.qcow2 -m
  4G -display egl-headless -chardev spicevmc,name=3Dvdagent,id=3Dvdagent

  main_channel_link: add main channel client
  main_channel_client_handle_pong: net test: latency 6.942000 ms, bitrate 8=
497925311 bps (8104.253112 Mbps)
  inputs_connect: inputs channel client create
  red_qxl_set_cursor_peer:
  gl_version 31 - compat profile
  qemu-system-x86_64: ui/egl-headless.c:128: egl_scanout_flush: Assertion `=
surface_width(edpy->ds) =3D=3D edpy->guest_fb.width' failed.
  Aborted (core dumped)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1805697/+subscriptions
