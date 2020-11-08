Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE695C55178
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E4B206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E4B206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbglh-0005g4-Pi
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 04:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbgj2-0002Br-Gy
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:11:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:54196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbgj0-0006YB-Co
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:11:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kbgiz-0006W0-8z
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 09:11:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 42D792E800F
 for <qemu-devel@nongnu.org>; Sun,  8 Nov 2020 09:11:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2020 09:02:57 -0000
From: Thomas Huth <1648726@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: uas uasp usb usb-host xhci
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jscinoz th-huth
X-Launchpad-Bug-Reporter: Jack Coulter (jscinoz)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20161209080958.23373.14363.malonedeb@chaenomeles.canonical.com>
Message-Id: <160482617790.27956.15765796758704785616.malone@chaenomeles.canonical.com>
Subject: [Bug 1648726] Re: [usb-host] Passthrough of UAS devices fails with
 Windows (10) guests
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 5465df68abb3deb7b55cf6cf6d66aab3e50f0386
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 04:10:58
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
Reply-To: Bug 1648726 <1648726@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU project is currently considering to move its bug tracking to anoth=
er system. For this we need to know which bugs are still valid and which co=
uld be closed already. Thus we are setting all older bugs to "Incomplete" n=
ow.
If you still think this bug report here is valid, then please switch the st=
ate back to "New" within the next 60 days, otherwise this report will be ma=
rked as "Expired". Thank you and sorry for the
inconvenience.

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1648726

Title:
  [usb-host] Passthrough of UAS devices fails with Windows (10) guests

Status in QEMU:
  Incomplete

Bug description:
  Split off from https://bugs.launchpad.net/qemu/+bug/1579306 as this is
  a distinct issue.

  Physical USB storage devices that support the UAS protocol do not work
  correctly when passed through to Windows guests (I've only tested this
  with Windows 10 x64, build 1607).

  Passing through such a device results in the older BOT/MSC protocol
  being used:

  <See attachment win10-uas-fail.png>

  Using the same domain configuration with a Linux guest (tested with
  SystemRescueCD 4.8.0) works correctly:

  /: Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/4p, 5000M
  =C2=A0=C2=A0=C2=A0=C2=A0|__ Port 1: Dev 2, If 0, Class=3DMass Storage, Dr=
iver=3Duas, 5000M
  /: Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/4p, 480M

  In both cases, the VM was launched via libvirt, which generated the
  following command line:

  /usr/bin/qemu-system-x86_64 -name guest=3DWin10-Edge-IE11,debug-
  threads=3Don -S -object
  secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-1=
3-Win10
  -Edge-IE11/master-key.aes -machine
  pc-q35-2.7,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-guest-core=3Doff -cpu
  host,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff -m 4096 -realtime
  mlock=3Doff -smp 8,sockets=3D1,cores=3D4,threads=3D2 -uuid 47c39707-088c-=
4edc-
  8b6a-a7856e09f43d -no-user-config -nodefaults -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-13-Win10-Edge-
  IE11/monitor.sock,server,nowait -mon
  chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
  base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddisca=
rd
  -no-hpet -no-shutdown -global ICH9-LPC.disable_s3=3D1 -global
  ICH9-LPC.disable_s4=3D1 -boot strict=3Don -device
  i82801b11-bridge,id=3Dpci.1,bus=3Dpcie.0,addr=3D0x1e -device pci-
  bridge,chassis_nr=3D2,id=3Dpci.2,bus=3Dpci.1,addr=3D0x0 -device nec-usb-
  xhci,id=3Dusb,bus=3Dpci.2,addr=3D0x6 -device virtio-scsi-
  pci,id=3Dscsi0,bus=3Dpci.2,addr=3D0x3 -device virtio-serial-pci,id=3Dvirt=
io-
  serial0,bus=3Dpci.2,addr=3D0x4 -drive file=3D/home/jack/IMG/Win10-Edge-
  IE11.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0,discard=3Dunmap
  -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddri=
ve-
  scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1 -drive if=3Dnone,id=3Ddrive-
  scsi0-0-0-1,readonly=3Don -device scsi-cd,bus=3Dscsi0.0,channel=3D0,scsi-
  id=3D0,lun=3D1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1 -netdev
  tap,fd=3D22,id=3Dhostnet0,vhost=3Don,vhostfd=3D24 -device virtio-net-
  pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:27:94:5d,bus=3Dpci.2,addr=
=3D0x1
  -chardev pty,id=3Dcharserial0 -device isa-
  serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
  spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,bus
  =3Dvirtio-
  serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.s=
pice.0
  -device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D2 -spice
  port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-compression=3Doff
  ,seamless-migration=3Don -device qxl-
  vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=
=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1
  -device intel-hda,id=3Dsound0,bus=3Dpci.2,addr=3D0x2 -device hda-
  duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev
  spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D3 -chardev
  spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D4 -device usb-
  host,hostbus=3D4,hostaddr=3D4,id=3Dhostdev0,bus=3Dusb.0,port=3D1 -device =
virtio-
  balloon-pci,id=3Dballoon0,bus=3Dpci.2,addr=3D0x5 -msg timestamp=3Don

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1648726/+subscriptions

