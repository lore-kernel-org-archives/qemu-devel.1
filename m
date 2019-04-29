Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA43C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CAC720673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAC720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60074 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8sw-0001p2-Be
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 12:12:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hL8rl-0001BQ-Vw
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hL8rk-0003r3-HR
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:10:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:54294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hL8rk-0003pY-Bo
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:10:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hL8rj-0000ie-4c
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 16:10:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1BF2B2E80C0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 16:10:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Apr 2019 15:59:17 -0000
From: Saverio Miroddi <1826422@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alex-l-williamson saveriomiroddi
X-Launchpad-Bug-Reporter: Saverio Miroddi (saveriomiroddi)
X-Launchpad-Bug-Modifier: Saverio Miroddi (saveriomiroddi)
References: <155620554968.6380.13610580395862407350.malonedeb@chaenomeles.canonical.com>
Message-Id:
 <155655355758.13521.14088057509460114159.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 2e134f1d120829fe2d23a87e9e65b6e3efb0f047
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1826422] Re: Regression: QEMU 4.0 hangs the host
 (*bisect included*)
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
Reply-To: Bug 1826422 <1826422@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429155917.NilRKIdf5vgUrRACjaivMT2MIE4awcJrhfm-SAtWIig@z>

> The change in QEMU 4.0 is only a change in defaults of the machine
type, it can be entirely reverted in the VM config with
kernel_irqchip=3Don or <ioapic driver=3D'kvm'/> with libvirt. Using a
machine type prior to the q35 4.0 machine type would also avoid it.
There are no performance issues with these configurations that would
favor using 3.1 over 4.0.

Thanks for the detailed answer :-)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826422

Title:
  Regression: QEMU 4.0 hangs the host (*bisect included*)

Status in QEMU:
  New

Bug description:
  The commit b2fc91db84470a78f8e93f5b5f913c17188792c8 seemingly
  introduced a regression on my system.

  When I start QEMU, the guest and the host hang (I need a hard reset to
  get back to a working system), before anything shows on the guest.

  I use QEMU with GPU passthrough (which worked perfectly until the
  commit above). This is the command I use:

  ```
  /path/to/qemu-system-x86_64
    -drive if=3Dpflash,format=3Draw,readonly,file=3D/path/to/OVMF_CODE.fd
    -drive if=3Dpflash,format=3Draw,file=3D/tmp/OVMF_VARS.fd.tmp
    -enable-kvm
    -machine q35,accel=3Dkvm,mem-merge=3Doff
    -cpu host,kvm=3Doff,hv_vendor_id=3Dvgaptrocks,hv_relaxed,hv_spinlocks=
=3D0x1fff,hv_vapic,hv_time
    -smp 4,cores=3D4,sockets=3D1,threads=3D1
    -m 10240
    -vga none
    -rtc base=3Dlocaltime
    -serial none
    -parallel none
    -usb
    -device usb-tablet
    -device vfio-pci,host=3D01:00.0,multifunction=3Don
    -device vfio-pci,host=3D01:00.1
    -device usb-host,vendorid=3D<vid>,productid=3D<pid>
    -device usb-host,vendorid=3D<vid>,productid=3D<pid>
    -device usb-host,vendorid=3D<vid>,productid=3D<pid>
    -device usb-host,vendorid=3D<vid>,productid=3D<pid>
    -device usb-host,vendorid=3D<vid>,productid=3D<pid>
    -device usb-host,vendorid=3D<vid>,productid=3D<pid>
    -device virtio-scsi-pci,id=3Dscsi
    -drive file=3D/path/to/guest.img,id=3Dhdd1,format=3Dqcow2,if=3Dnone,cac=
he=3Dwriteback
    -device scsi-hd,drive=3Dhdd1
    -net nic,model=3Dvirtio
    -net user,smb=3D/path/to/shared
  ```

  If I run QEMU without GPU passthrough, it runs fine.

  Some details about my system:

  - O/S: Mint 19.1 x86-64 (it's based on Ubuntu 18.04)
  - Kernel: 4.15
  - `configure` options: `--target-list=3Dx86_64-softmmu --enable-gtk --ena=
ble-spice --audio-drv-list=3Dpa`
  - EDK2 version: 1a734ed85fda71630c795832e6d24ea560caf739 (20/Apr/2019)
  - CPU: i7-6700k
  - Motherboard: ASRock Z170 Gaming-ITX/ac
  - VGA: Gigabyte GTX 960 Mini-ITX

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826422/+subscriptions

