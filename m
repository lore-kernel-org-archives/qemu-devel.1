Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A09C4363C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 00:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A259B206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 00:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A259B206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPE22-0005pH-Gf
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 20:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kPE0b-0004sg-HH
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 20:05:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:40348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kPE0Z-0005QL-4j
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 20:05:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kPE0X-00043e-0M
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 00:05:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EC52C2E80DB
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2020 00:05:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2020 23:58:12 -0000
From: Ethan <1898490@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ethannij
X-Launchpad-Bug-Reporter: Ethan (ethannij)
X-Launchpad-Bug-Modifier: Ethan (ethannij)
Message-Id: <160185589302.24503.10461684970761806737.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1898490] [NEW] gtk with virtio and opengl black screen
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d50d1e75c500726862802414f880ee3e3bb759bf"; Instance="production"
X-Launchpad-Hash: ca410b457250d153a718c16c886b351282bac4a7
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/04 20:05:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1898490 <1898490@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

qemu-system-x86_64 -name manjaro -enable-kvm -cpu host -smp
cores=3D4,threads=3D1 -M q35 -m 8G -cdrom /mnt/Storage/ISO/manjaro-
gnome-20.0.3-minimal-200606-linux56.iso -machine type=3Dpc,accel=3Dkvm -vga
virtio -display sdl,gl=3Don Boots properly and has working 3d acceleration
with virgl.

Running qemu-system-x86_64 -name manjaro -enable-kvm -cpu host -smp
cores=3D4,threads=3D1 -M q35 -m 8G -cdrom /mnt/Storage/ISO/manjaro-
gnome-20.0.3-minimal-200606-linux56.iso -machine type=3Dpc,accel=3Dkvm -vga
virtio -display gtk,gl=3Don however, (difference being gtk instead of
sdl), the screen is black, and the vm still starts.

System Specs
Gentoo Linux 64bit
Gentoo-Sources 5.8.13 Kernel
Qemu 5.10.0-r1 compiled with USE=3D"aio bzip2 caps curl fdt filecaps gtk jp=
eg ncurses nls opengl oss pin-upstream-blobs png pulseaudio sdl seccomp sli=
rp spice usb usbredir vhost-net virgl vnc xattr xkb" PYTHON_TARGETS=3D"pyth=
on3_7" QEMU_SOFTMMU_TARGETS=3D"x86_64" QEMU_USER_TARGETS=3D"x86_64"

Ryzen 7 2700x
Nvidia 1070ti GPU

I can confirm the same issue when using libvirt with opengl.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "When launching with GTK instead of sdl, the screen re=
mains black."
   https://bugs.launchpad.net/bugs/1898490/+attachment/5417624/+files/2020-=
10-04_16-57.png

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

