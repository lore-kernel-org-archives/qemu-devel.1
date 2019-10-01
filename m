Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3167DC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C982133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C982133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPya-0007yF-QM
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iFPk2-0000Ew-Bx
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 17:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iFPk0-0004tv-WD
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 17:31:30 -0400
Received: from indium.canonical.com ([91.189.90.7]:33654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iFPk0-0004sV-PX
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 17:31:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iFPjy-000611-Bt
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 21:31:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 31ACD2E80D8
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 21:31:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Oct 2019 21:25:22 -0000
From: Saverio Miroddi <1714331@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: chrisu lersek pmdj saveriomiroddi stefanha
X-Launchpad-Bug-Reporter: Saverio Miroddi (saveriomiroddi)
X-Launchpad-Bug-Modifier: Saverio Miroddi (saveriomiroddi)
References: <150420685550.8035.5310753798215250364.malonedeb@soybean.canonical.com>
Message-Id: <156996512355.21009.1626452635528410149.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1714331] Re: Virtual machines not working anymore on 2.10
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19066";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 760add5a6ebf59f4d0aaea93d37ff65cf8971ff6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1714331 <1714331@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1714331

Title:
  Virtual machines not working anymore on 2.10

Status in QEMU:
  Invalid

Bug description:
  Using 2.10, my virtual machine(s) don't work anymore. This happens
  100% of the times.

  -----

  I use QEMU compiling it from source, on Ubuntu 16.04 amd64. This is
  the configure command:

      configure --target-list=3Dx86_64-softmmu --enable-debug --enable-gtk
  --enable-spice --audio-drv-list=3Dpa

  I have one virtual disk, with a Windows 10 64-bit, which I launch in
  two different ways; both work perfectly on 2.9 (and used to do on 2.8,
  but I haven't used it for a long time).

  This is the first way:

      qemu-system-x86_64
        -drive if=3Dpflash,format=3Draw,readonly,file=3D/path/to/OVMF_CODE.=
fd
        -drive if=3Dpflash,format=3Draw,file=3D/tmp/OVMF_VARS.fd.tmp
        -enable-kvm
        -machine q35,accel=3Dkvm,mem-merge=3Doff
        -cpu host,kvm=3Doff,hv_vendor_id=3Dvgaptrocks,hv_relaxed,hv_spinloc=
ks=3D0x1fff,hv_vapic,hv_time
        -smp 4,cores=3D4,sockets=3D1,threads=3D1
        -m 4096
        -display gtk
        -vga qxl
        -rtc base=3Dlocaltime
        -serial none
        -parallel none
        -usb
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device virtio-scsi-pci,id=3Dscsi
        -drive file=3D/path/to/image-diff.img,id=3Dhdd1,format=3Dqcow2,if=
=3Dnone,cache=3Dwriteback
        -device scsi-hd,drive=3Dhdd1
        -net nic,model=3Dvirtio
        -net user

  On QEMU 2.10, I get the `Recovery - Your PC/Device needs to be
  repaired` windows screen; on 2.9, it boots regularly.

  This is the second way:

      qemu-system-x86_64
        -drive if=3Dpflash,format=3Draw,readonly,file=3D/path/to/OVMF_CODE.=
fd
        -drive if=3Dpflash,format=3Draw,file=3D/tmp/OVMF_VARS.fd.tmp
        -enable-kvm
        -machine q35,accel=3Dkvm,mem-merge=3Doff
        -cpu host,kvm=3Doff,hv_vendor_id=3Dvgaptrocks,hv_relaxed,hv_spinloc=
ks=3D0x1fff,hv_vapic,hv_time
        -smp 4,cores=3D4,sockets=3D1,threads=3D1
        -m 10240
        -vga none
        -rtc base=3Dlocaltime
        -serial none
        -parallel none
        -usb
        -device vfio-pci,host=3D01:00.0,multifunction=3Don
        -device vfio-pci,host=3D01:00.1
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device virtio-scsi-pci,id=3Dscsi
        -drive file=3D/path/to/image-diff.img,id=3Dhdd1,format=3Dqcow2,if=
=3Dnone,cache=3Dwriteback
        -device scsi-hd,drive=3Dhdd1
        -net nic,model=3Dvirtio
        -net user

  On QEMU 2.10, I get the debug window on the linux monitor, and blank scre=
en on VFIO one (no BIOS screen at all); after 10/20 seconds, QEMU crashes w=
ithout any message.
  On 2.9, this works perfectly.

  -----

  I am able to perform a git bisect, if that helps, but if this is the
  case, I'd need this issue to be reviewed, since bisecting is going to
  take me a lot of time.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1714331/+subscriptions

