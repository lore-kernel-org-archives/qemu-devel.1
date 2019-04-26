Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DC3C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 07:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478FE2084F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 07:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478FE2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJvNW-0007va-Ie
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 03:34:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJvMD-0006wm-Hm
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJvA9-0005Hs-KP
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:20:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:55976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJvA3-0004xK-V1
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:20:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJvA2-0006gT-DX
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:20:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 609482E80CB
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Apr 2019 07:08:02 -0000
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
Message-Id: <155626248204.13844.2151474197903937040.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e52f928092ef4f3ef03de2937f1d8d0f949db7de
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
Message-ID: <20190426070802.nbmGCMKE_FfPPFwecaabTo1t9EiUO_OYGGvYHLzEk_E@z>

ok, so, if I understand correctly, the workaround is:

- set `x-no-kvm-intx=3Don` and enable MSI in the guest (via regedit or
module params)

which may lead to a performance regression (at least under certain
circumstances).

Is it therefore preferrable, performance and configuration-wise, to use
QEMU 3.1.0, if there are no 4.0.0 feature requirements, until this issue
is sorted out?

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

