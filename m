Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAF4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE9B207D4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE9B207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jedTJ-0000wo-Dz
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 07:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jedSN-0008V3-Vo
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:45:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:46938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jedSM-0000wV-Ag
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:45:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jedSH-0006J2-PX
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 11:45:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BD7B22E8111
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 11:45:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2020 11:39:09 -0000
From: a <1872790@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jnsnow sxtf
X-Launchpad-Bug-Reporter: a (sxtf)
X-Launchpad-Bug-Modifier: a (sxtf)
References: <158688621326.6027.1278663333852888209.malonedeb@chaenomeles.canonical.com>
Message-Id: <159075234914.13135.13261135257737046699.malone@gac.canonical.com>
Subject: [Bug 1872790] Re: empty qcow2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a7bd6ff1abdf04f245a76a912f3f02ca889d5cb7
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 02:40:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1872790 <1872790@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

WDM claims it to be a MBR

Linux 5.6.14

QEMU 5.0.0-6

`nobody     19023  109 21.1 7151512 3462300 ?     Sl   13:18   0:32
/usr/bin/qemu-system-x86_64 -name guest=3Dwin10machine,debug-threads=3Don -S
-object
secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-4-w=
in10machine
/master-key.aes -machine pc-q35-4.2,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-
guest-core=3Doff -cpu Haswell-
noTSX,vme=3Don,ss=3Don,vmx=3Don,f16c=3Don,rdrand=3Don,hypervisor=3Don,arat=
=3Don,tsc-
adjust=3Don,umip=3Don,arch-capabilities=3Don,xsaveopt=3Don,pdpe1gb=3Don,abm=
=3Don
,skip-l1dfl-vmentry=3Don,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=3D0x1fff
-m 4096 -overcommit mem-lock=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1
-uuid db88f5fc-47f0-439c-9192-a5991df2d8f8 -no-user-config -nodefaults
-chardev socket,id=3Dcharmonitor,fd=3D34,server,nowait -mon
chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -=
no-
hpet -no-shutdown -global ICH9-LPC.disable_s3=3D1 -global
ICH9-LPC.disable_s4=3D1 -boot strict=3Don -device pcie-root-
port,port=3D0x10,chassis=3D1,id=3Dpci.1,bus=3Dpcie.0,multifunction=3Don,add=
r=3D0x2
-device pcie-root-
port,port=3D0x11,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,addr=3D0x2.0x1 -device=
 pcie-
root-port,port=3D0x12,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,addr=3D0x2.0x2 -d=
evice
pcie-root-port,port=3D0x13,chassis=3D4,id=3Dpci.4,bus=3Dpcie.0,addr=3D0x2.0=
x3
-device pcie-root-
port,port=3D0x14,chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,addr=3D0x2.0x4 -device=
 qemu-
xhci,p2=3D15,p3=3D15,id=3Dusb,bus=3Dpci.2,addr=3D0x0 -device virtio-serial-=
pci,id
=3Dvirtio-serial0,bus=3Dpci.3,addr=3D0x0 -blockdev
{"driver":"file","filename":"/home/user/nvme0n1/p1/win10.qcow2","node-
name":"libvirt-3-storage","auto-read-only":true,"discard":"unmap"}
-blockdev {"node-name":"libvirt-3-format","read-
only":false,"driver":"qcow2","file":"libvirt-3-storage","backing":null}
-device ide-hd,bus=3Dide.0,drive=3Dlibvirt-3-format,id=3Dsata0-0-0,bootinde=
x=3D1
-blockdev {"driver":"file","filename":"/home/user/nvme0n1/p1/dump1.qcow2
","node-name":"libvirt-2-storage","auto-read-
only":true,"discard":"unmap"} -blockdev {"node-name":"libvirt-2-format
","read-
only":false,"driver":"qcow2","file":"libvirt-2-storage","backing":null}
-device ide-hd,bus=3Dide.1,drive=3Dlibvirt-2-format,id=3Dsata0-0-1 -blockdev
{"driver":"file","filename":"/home/user/nvme0n1/p1/dump2.qcow2","node-
name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}
-blockdev {"node-name":"libvirt-1-format","read-
only":false,"driver":"qcow2","file":"libvirt-1-storage","backing":null}
-device ide-hd,bus=3Dide.2,drive=3Dlibvirt-1-format,id=3Dsata0-0-2 -netdev
tap,fd=3D36,id=3Dhostnet0 -device
e1000e,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:b5:3a:ca,bus=3Dpci.1,addr=
=3D0x0
-chardev pty,id=3Dcharserial0 -device isa-
serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,bus=3Dvirt=
io-
serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.spi=
ce.0
-device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice
port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-compression=3Doff
,seamless-migration=3Don -device qxl-
vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0=
,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1
-device ich9-intel-hda,id=3Dsound0,bus=3Dpcie.0,addr=3D0x1b -device hda-
duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev
spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-
redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev
spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-
redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virtio-
balloon-pci,id=3Dballoon0,bus=3Dpci.4,addr=3D0x0 -sandbox
on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3D=
deny
-msg timestamp=3Don`

The qcow2 of the guest was created in VMM and the qcow2 that I can't
manipulate was created with (if I remember well) something like `qemu-
img convert /dev/sda2 -O image.qcow2` from a Windows physical machine

Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false

W10

All the managers that i've tried were the same, but you can try for
example MiniTool or EaseUS

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1872790

Title:
  empty qcow2

Status in QEMU:
  Incomplete

Bug description:
  I plugged multiple qcow2 to a Windows guest. On the Windows disk
  manager all disks are listed perfectly, with their data, their real
  space, I even can explore all files on the Explorer, all cool

  On third party disk manager (all of them), I only have the C:\ HDD who
  act normally, all the other plugged qcow2 are seen as fully
  unallocated, so I can't manipulate them

  I want to move some partitions, create others, but on Windows disk
  manager I can't extend or create partition and on third party I didn't
  see the partitions at all

  Even guestfs doesn't recognize any partition table `libguestfs: error:
  inspect_os: /dev/sda: not a partitioned device`

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1872790/+subscriptions

