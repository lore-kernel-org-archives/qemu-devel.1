Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3D8C282CE
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 04:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9867E20644
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 04:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9867E20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36109 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUOKr-00071p-OL
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 00:31:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hUOJl-0006QG-5c
	for qemu-devel@nongnu.org; Sat, 25 May 2019 00:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hUOJj-0000Vp-W5
	for qemu-devel@nongnu.org; Sat, 25 May 2019 00:30:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:55682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hUOJj-0000VU-Qh
	for qemu-devel@nongnu.org; Sat, 25 May 2019 00:29:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hUOJi-0003j1-QS
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 04:29:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C3B542E8083
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 04:29:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 May 2019 04:17:26 -0000
From: Launchpad Bug Tracker <1617114@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor je-vv jnsnow th-huth
X-Launchpad-Bug-Reporter: je-vv (je-vv)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20160826013950.26404.19900.malonedeb@gac.canonical.com>
Message-Id: <155875784655.26936.9888219887751007173.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 8506db1a1727f7587f6554e36b333e5c37e5c015
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1617114] Re: Qemu 2.6.0 freezes with windows
 guests
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1617114 <1617114@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1617114

Title:
  Qemu 2.6.0 freezes with windows guests

Status in QEMU:
  Expired

Bug description:
  When launching qemu with the same command line as before 2.6.0, with
  SDL display, with virtio, for a win-10 guest:

  qemu-system-x86_64 -enable-kvm -name win-10 -machine type=3Dpc,accel=3Dkvm
  -cpu host -smp cores=3D1,threads=3D2,sockets=3D1 -m 2.7G -balloon virtio
  -drive
  file=3D/home/<username>/.qemu/imgs/win10-coe.qcow2,index=3D0,media=3Ddisk=
,if=3Dvirtio
  -drive file=3D/usr/share/virtio/virtio-win.iso,index=3D1,media=3Dcdrom
  -drive file=3D/usr/share/spice-guest-tools/spice-guest-
  tools.iso,index=3D2,media=3Dcdrom -net nic,model=3Dvirtio -net
  tap,ifname=3Dtap0,script=3Dno,downscript=3Dno,vhost=3Don -usbdevice tablet
  -usb -display sdl -vga qxl -soundhw ac97 -rtc base=3Dlocaltime
  -usbdevice host:0b0e:0032 -usbdevice host:0b0e:0348 -usbdevice
  host:0b0e:0410

  Qemu at some point just freezes with no error message at all with
  newer version 2.6.0-1.

  Reverting to prior version 2.5.1-1, things go back to normal.

  A simple way to accelerate the freeze is to have qemu launch in a
  workspace/desktop, and then move to a different workspace/desktop, and
  then move back to the qemu workspace/desktop, and you'll find out it's
  frozen.

  BTW, there's no way to get into qemu monitor mode terminal at all once
  frozen. The monitor terminal shows up, but does nothing...

  Perhaps it's useful to notice that I have up to date win-10 virtio
  drivers for ethernet, scsi/storage, qxl-dod, balloon, and serial
  interface drivers. The ISO version used is 0.1.118.1 (virtio-win AUR
  package).

  Using the standard (std) qemu video driver, rather than the qxl-dod
  one makes no difference BTW.

  Just in case, running on up to date x86-64 Arch, plain qemu command
  line.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1617114/+subscriptions

