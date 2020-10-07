Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C656DC4727E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12EA021707
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EA021707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQEi8-0006DK-19
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQEgG-0005D4-M0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 15:00:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:36836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQEgE-00049b-MH
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 15:00:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kQEgC-0005jg-Li
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 19:00:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9FC382E80EA
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 19:00:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2020 18:50:52 -0000
From: Thomas Huth <1716510@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jnsnow th-huth uzytkownik2
X-Launchpad-Bug-Reporter: Maciej Piechotka (uzytkownik2)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <150516743999.32018.10984089018227997839.malonedeb@soybean.canonical.com>
Message-Id: <160209665301.9959.2497535790725795074.malone@wampee.canonical.com>
Subject: [Bug 1716510] Re: qemu 2.10.0 cannot boot Windows 10 familly
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d50d1e75c500726862802414f880ee3e3bb759bf"; Instance="production"
X-Launchpad-Hash: 058f5b5236a0f38d35360fd7c91e5947a82ce104
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
Reply-To: Bug 1716510 <1716510@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since this seems to be fixed when using EDK, I'm marking this ticket as
Fix Released

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1716510

Title:
  qemu 2.10.0 cannot boot Windows 10 familly

Status in QEMU:
  Fix Released

Bug description:
  On qemu 2.10.0 Windows 10 and Windows Server 2016 hangs during boot.
  Below is setup of Windows Server 2016. Downgrading to 2.9 fixes the
  problem.

  /usr/bin/qemu-system-x86_64 -name guest=3D<name>,debug-threads=3Don -S
  -object
  secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-2=
-<name
  >/master-key.aes -machine pc-q35-2.8,accel=3Dkvm,usb=3Doff,dump-guest-
  core=3Doff -cpu
  host,nx=3Don,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1000,hv_vpindex,hv_runt=
ime,hv_synic,hv_reset,kvm=3Doff
  -drive file=3D/usr/local/share/edk2.git/ovmf-x64/OVMF-pure-
  efi.fd,if=3Dpflash,format=3Draw,unit=3D0 -drive
  file=3D/var/lib/libvirt/qemu/nvram/<name>_VARS.fd,if=3Dpflash,format=3Dra=
w,unit=3D1
  -m 4096 -realtime mlock=3Doff -smp 12,sockets=3D1,cores=3D6,threads=3D2
  -object iothread,id=3Diothread1 -object iothread,id=3Diothread2 -object
  iothread,id=3Diothread3 -object iothread,id=3Diothread4 -object
  iothread,id=3Diothread5 -object iothread,id=3Diothread6 -object
  iothread,id=3Diothread7 -object iothread,id=3Diothread8 -object
  iothread,id=3Diothread9 -object iothread,id=3Diothread10 -object
  iothread,id=3Diothread11 -object iothread,id=3Diothread12 -uuid <uuid>
  -no-user-config -nodefaults -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-2-<name>/moni=
tor.sock,server,nowait
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
  base=3Dlocaltime,clock=3Dvm,driftfix=3Dslew -no-shutdown -boot strict=3Don
  -device
  ioh3420,port=3D0x10,chassis=3D1,id=3Dpci.1,bus=3Dpcie.0,multifunction=3Do=
n,addr=3D0x2
  -device ioh3420,port=3D0x11,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,addr=3D0x=
2.0x1
  -device ioh3420,port=3D0x12,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,addr=3D0x=
2.0x2
  -device ioh3420,port=3D0x13,chassis=3D4,id=3Dpci.4,bus=3Dpcie.0,addr=3D0x=
2.0x3
  -device ioh3420,port=3D0x14,chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,addr=3D0x=
2.0x4
  -device ioh3420,port=3D0x15,chassis=3D6,id=3Dpci.6,bus=3Dpcie.0,addr=3D0x=
2.0x5
  -device nec-usb-xhci,id=3Dusb,bus=3Dpci.3,addr=3D0x0 -drive
  if=3Dnone,media=3Dcdrom,id=3Ddrive-sata0-0-0,readonly=3Don -device ide-
  cd,bus=3Dide.0,drive=3Ddrive-sata0-0-0,id=3Dsata0-0-0,bootindex=3D2 -drive
  if=3Dnone,media=3Dcdrom,id=3Ddrive-sata0-0-1,readonly=3Don -device ide-
  cd,bus=3Dide.1,drive=3Ddrive-sata0-0-1,id=3Dsata0-0-1,bootindex=3D1 -drive
  file=3D/dev/mapper/<boot disk>,format=3Draw,if=3Dnone,id=3Ddrive-sata0-0-2
  -device ide-hd,bus=3Dide.2,drive=3Ddrive-
  sata0-0-2,id=3Dsata0-0-2,bootindex=3D3 -netdev
  tap,fd=3D21,id=3Dhostnet0,vhost=3Don,vhostfd=3D23 -device virtio-net-
  pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D<mac>,bus=3Dpci.1,addr=3D0x0 -netdev
  tap,fd=3D24,id=3Dhostnet1,vhost=3Don,vhostfd=3D25 -device virtio-net-
  pci,netdev=3Dhostnet1,id=3Dnet1,mac=3D<mac>,bus=3Dpci.2,addr=3D0x0 -devic=
e usb-
  tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice
  unix,addr=3D/var/lib/libvirt/qemu/domain-2-<name>/spice.sock,disable-
  ticketing,image-compression=3Dauto_glz,seamless-migration=3Don -vnc
  127.0.0.1:0 -device qxl-
  vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D16777216,vram64_size_mb=
=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1
  -device vhost-scsi-
  pci,wwpn=3D<wwpn>,vhostfd=3D26,id=3Dhostdev0,bus=3Dpcie.0,addr=3D0x9 -dev=
ice
  virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.4,addr=3D0x0 -object rng-
  random,id=3Dobjrng0,filename=3D/dev/random -device virtio-rng-
  pci,rng=3Dobjrng0,id=3Drng0,max-bytes=3D1024,period=3D1000,bus=3Dpci.5,ad=
dr=3D0x0
  -msg timestamp=3Do

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1716510/+subscriptions

