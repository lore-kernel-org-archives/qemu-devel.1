Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD62FC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB79320739
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB79320739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCkm-0001IX-Q3
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQCj9-0008IK-48
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:55:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:40884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQCj2-0003bL-7E
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:55:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kQCj0-0007WR-2k
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 16:55:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 09C262E80EA
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 16:55:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2020 16:48:09 -0000
From: Olivier Robert <1898490@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ethannij novhak
X-Launchpad-Bug-Reporter: Ethan (ethannij)
X-Launchpad-Bug-Modifier: Olivier Robert (novhak)
References: <160185589302.24503.10461684970761806737.malonedeb@chaenomeles.canonical.com>
Message-Id: <160208928993.24197.8454251269568238324.malone@chaenomeles.canonical.com>
Subject: [Bug 1898490] Re: gtk with virtio and opengl black screen
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d50d1e75c500726862802414f880ee3e3bb759bf"; Instance="production"
X-Launchpad-Hash: 395d57848a5fc1d67787518424660d8fc7ee1e59
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 12:55:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1898490 <1898490@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Christian,

I should have pointed that the log is from the Android system, not Qemu
or my host system=E2=80=AF!

I got the failure message running the following command in an Android
shell=C2=A0:

logcat '*:F'

(which means display log entries from all facilities (*), with the Fatal
(F) severity)

It seems indeed that Fosshub has a hosting problem with the Android-x86
images, I'll have to report this to the project maintainer.

You seem to experience the same crash as I do. Bootloader OK, the GUI is
responsive at the beginning, and it crashes after a variable amount of
time.

You're right, the bug #1898490 looks like it could be related, I don't
see the virgl=3Don option, but I suppose it's on by default.

I normally have those messages on my Qemu instance=C2=A0:
gl_version 45 - core profile enabled
GLSL feature level 430
virtio_input_hid_handle_status: unknown type 20
virtio_input_hid_handle_status: unknown type 20

The virtio_input_hid messages don't seem to be a problem, and certainly
unrelated to the Android 9.0 crashing problem since at the time I tried
with other, non-virtio input devices, I didn't have that message but it
was still crashing the same way.

It happens that I have that "stale GL error" from time to time, that
almost always corresponds to an app not displaying properly in Android.
Generally, quitting and restarting the app solves the problem, but not
always, there are cases and Android apps that never worked correctly
with virglrenderer, such as Armello.

So, virglrenderer seems less stable with Android (or is it virtio-vga
?). In particular, switching from the surfaceflinger OpenGL display to a
VGA, non-OpenGL console display (Alt+F1) never worked correctly (Alt+F7
to go back to the surfaceflinger display).

However, as I said before, it seems to me it shouldn't behave
differently depending on which display, GTK or SDL, is used.

Concerning other frontends, I'm not familiar with those since my setup
isn't headless=C2=A0: I'm not a server guy, I run the emulator on my laptop,
so apart from GTK and SDL, it's not clear to me if I could run something
else that would give me 3D acceleration. Moreover, my hardware is more
than 6 years old now, and lacks some virtualisation capabilities that
could serve as an alternative to virglrenderer.

Anyway virglrenderer is still pre 1.0 so I guess it's the prime suspect
after all.

I will upgrade to Groovy next month, I'll keep you informed on that (I
may even try Qemu 5.0 before upgrading).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1898490

Title:
  gtk with virtio and opengl black screen

Status in QEMU:
  New

Bug description:
  qemu-system-x86_64 -name manjaro -enable-kvm -cpu host -smp
  cores=3D4,threads=3D1 -M q35 -m 8G -cdrom /mnt/Storage/ISO/manjaro-
  gnome-20.0.3-minimal-200606-linux56.iso -machine type=3Dpc,accel=3Dkvm
  -vga virtio -display sdl,gl=3Don Boots properly and has working 3d
  acceleration with virgl.

  Running qemu-system-x86_64 -name manjaro -enable-kvm -cpu host -smp
  cores=3D4,threads=3D1 -M q35 -m 8G -cdrom /mnt/Storage/ISO/manjaro-
  gnome-20.0.3-minimal-200606-linux56.iso -machine type=3Dpc,accel=3Dkvm
  -vga virtio -display gtk,gl=3Don however, (difference being gtk instead
  of sdl), the screen is black, and the vm still starts.

  System Specs
  Gentoo Linux 64bit
  Gentoo-Sources 5.8.13 Kernel
  Qemu 5.10.0-r1 compiled with USE=3D"aio bzip2 caps curl fdt filecaps gtk =
jpeg ncurses nls opengl oss pin-upstream-blobs png pulseaudio sdl seccomp s=
lirp spice usb usbredir vhost-net virgl vnc xattr xkb" PYTHON_TARGETS=3D"py=
thon3_7" QEMU_SOFTMMU_TARGETS=3D"x86_64" QEMU_USER_TARGETS=3D"x86_64"

  Ryzen 7 2700x
  Nvidia 1070ti GPU

  I can confirm the same issue when using libvirt with opengl.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1898490/+subscriptions

