Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC24C388F2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0444206E0
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0444206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbh7u-0007Wg-2T
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 04:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbh6j-0006an-Hm
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:35:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:56916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbh6g-0006Ud-Or
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:35:33 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kbh6f-0008Kg-Fg
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 09:35:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 500DC2E8133
 for <qemu-devel@nongnu.org>; Sun,  8 Nov 2020 09:35:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2020 09:27:40 -0000
From: Thomas Huth <1640073@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: arei-gonglei th-huth
X-Launchpad-Bug-Reporter: Gonglei (arei-gonglei)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20161108082844.20320.1024.malonedeb@soybean.canonical.com>
Message-Id: <160482766070.28304.13204781120809205307.malone@chaenomeles.canonical.com>
Subject: [Bug 1640073] Re: Guest pause because VMPTRLD failed in KVM
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 5c11715b27bb573a8b87f603fbacab9fb9dc7378
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
Reply-To: Bug 1640073 <1640073@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU project is currently considering to move its bug tracking to anoth=
er system. For this we need to know which bugs are still valid and which co=
uld be closed already. Thus we are setting all older bugs to
"Incomplete" now.
If you still think this bug report here is valid, then please switch the st=
ate back to "New" within the next 60 days, otherwise this report will be ma=
rked as "Expired". Thank you and sorry for the inconvenience.


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1640073

Title:
  Guest pause because VMPTRLD failed in KVM

Status in QEMU:
  Incomplete

Bug description:
  1) Qemu command:
  /usr/bin/qemu-kvm -name omu1 -S -machine pc-i440fx-2.3,accel=3Dkvm,usb=3D=
off -cpu host -m 15625 -realtime mlock=3Doff -smp 8,sockets=3D1,cores=3D8,t=
hreads=3D1 -uuid a2aacfff-6583-48b4-b6a4-e6830e519931 -no-user-config -node=
faults -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/omu1.m=
onitor,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol=
 -rtc base=3Dutc -no-shutdown -boot strict=3Don -device piix3-usb-uhci,id=
=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device virtio-serial-pci,id=3Dvirtio-ser=
ial0,bus=3Dpci.0,addr=3D0x5 -drive file=3D/home/env/guest1.qcow2,if=3Dnone,=
id=3Ddrive-virtio-disk0,format=3Dqcow2,cache=3Dnone,aio=3Dnative -device vi=
rtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x6,drive=3Ddrive-virtio-disk0,i=
d=3Dvirtio-disk0 -drive file=3D/home/env/guest_300G.img,if=3Dnone,id=3Ddriv=
e-virtio-disk1,format=3Draw,cache=3Dnone,aio=3Dnative -device virtio-blk-pc=
i,scsi=3Doff,bus=3Dpci.0,addr=3D0x7,drive=3Ddrive-virtio-disk1,id=3Dvirtio-=
disk1 -netdev tap,fd=3D25,id=3Dhostnet0,vhost=3Don,vhostfd=3D26 -device vir=
tio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D00:00:80:05:00:00,bus=3Dpci.0=
,addr=3D0x3 -netdev tap,fd=3D27,id=3Dhostnet1,vhost=3Don,vhostfd=3D28 -devi=
ce virtio-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3D00:00:80:05:00:01,bus=
=3Dpci.0,addr=3D0x4 -chardev pty,id=3Dcharserial0 -device isa-serial,charde=
v=3Dcharserial0,id=3Dserial0 -device usb-tablet,id=3Dinput0 -vnc 0.0.0.0:0 =
-device cirrus-vga,id=3Dvideo0,vgamem_mb=3D16,bus=3Dpci.0,addr=3D0x2 -devic=
e virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -msg timestamp=3D=
on

  2) Qemu log:
  KVM: entry failed, hardware error 0x4
  RAX=3D00000000ffffffed RBX=3Dffff8803fa2d7fd8 RCX=3D0100000000000000 RDX=
=3D0000000000000000
  RSI=3D0000000000000000 RDI=3D0000000000000046 RBP=3Dffff8803fa2d7e90 RSP=
=3Dffff8803fa2efe90
  R8 =3D0000000000000000 R9 =3D0000000000000000 R10=3D0000000000000000 R11=
=3D000000000000b69a
  R12=3D0000000000000001 R13=3Dffffffff81a25b40 R14=3D0000000000000000 R15=
=3Dffff8803fa2d7fd8
  RIP=3Dffffffff81053e16 RFL=3D00000286 [--S--P-] CPL=3D0 II=3D0 A20=3D1 SM=
M=3D0 HLT=3D0
  ES =3D0000 0000000000000000 ffffffff 00c00000
  CS =3D0010 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
  SS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
  DS =3D0000 0000000000000000 ffffffff 00c00000
  FS =3D0000 0000000000000000 ffffffff 00c00000
  GS =3D0000 ffff88040f540000 ffffffff 00c00000
  LDT=3D0000 0000000000000000 ffffffff 00c00000
  TR =3D0040 ffff88040f550a40 00002087 00008b00 DPL=3D0 TSS64-busy
  GDT=3D     ffff88040f549000 0000007f
  IDT=3D     ffffffffff529000 00000fff
  CR0=3D80050033 CR2=3D00007f81ca0c5000 CR3=3D00000003f5081000 CR4=3D000407=
e0
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000 =

  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  EFER=3D0000000000000d01
  Code=3D?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? <??> ?=
? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?=
? ?? ?? ??

  3) Demsg
  [347315.028339] kvm: vmptrld ffff8817ec5f0000/17ec5f0000 failed
  klogd 1.4.1, ---------- state change ----------
  [347315.039506] kvm: vmptrld ffff8817ec5f0000/17ec5f0000 failed
  [347315.051728] kvm: vmptrld ffff8817ec5f0000/17ec5f0000 failed
  [347315.057472] vmwrite error: reg 6c0a value ffff88307e66e480 (err 21206=
72384)
  [347315.064567] Pid: 69523, comm: qemu-kvm Tainted: GF           X 3.0.93=
-0.8-default #1
  [347315.064569] Call Trace:
  [347315.064587]  [<ffffffff810049d5>] dump_trace+0x75/0x300
  [347315.064595]  [<ffffffff8145e3e3>] dump_stack+0x69/0x6f
  [347315.064617]  [<ffffffffa03738de>] vmx_vcpu_load+0x11e/0x1d0 [kvm_inte=
l]
  [347315.064647]  [<ffffffffa029a204>] kvm_arch_vcpu_load+0x44/0x1d0 [kvm]
  [347315.064669]  [<ffffffff81054ee1>] finish_task_switch+0x81/0xe0
  [347315.064676]  [<ffffffff8145f0b4>] thread_return+0x3b/0x2a7
  [347315.064687]  [<ffffffffa028d9b5>] kvm_vcpu_block+0x65/0xa0 [kvm]
  [347315.064703]  [<ffffffffa02a16d1>] __vcpu_run+0xd1/0x260 [kvm]
  [347315.064732]  [<ffffffffa02a2418>] kvm_arch_vcpu_ioctl_run+0x68/0x1a0 =
[kvm]
  [347315.064759]  [<ffffffffa028ecee>] kvm_vcpu_ioctl+0x38e/0x580 [kvm]
  [347315.064771]  [<ffffffff8116bdfb>] do_vfs_ioctl+0x8b/0x3b0
  [347315.064776]  [<ffffffff8116c1c1>] sys_ioctl+0xa1/0xb0
  [347315.064783]  [<ffffffff81469272>] system_call_fastpath+0x16/0x1b
  [347315.064797]  [<00007fee51969ce7>] 0x7fee51969ce6
  [347315.064799] vmwrite error: reg 6c0c value ffff88307e664000 (err 21206=
30272)
  [347315.064802] Pid: 69523, comm: qemu-kvm Tainted: GF           X 3.0.93=
-0.8-default #1
  [347315.064803] Call Trace:
  [347315.064807]  [<ffffffff810049d5>] dump_trace+0x75/0x300
  [347315.064811]  [<ffffffff8145e3e3>] dump_stack+0x69/0x6f
  [347315.064817]  [<ffffffffa03738ec>] vmx_vcpu_load+0x12c/0x1d0 [kvm_inte=
l]
  [347315.064832]  [<ffffffffa029a204>] kvm_arch_vcpu_load+0x44/0x1d0 [kvm]
  [347315.064851]  [<ffffffff81054ee1>] finish_task_switch+0x81/0xe0
  [347315.064855]  [<ffffffff8145f0b4>] thread_return+0x3b/0x2a7
  [347315.064865]  [<ffffffffa028d9b5>] kvm_vcpu_block+0x65/0xa0 [kvm]
  [347315.064880]  [<ffffffffa02a16d1>] __vcpu_run+0xd1/0x260 [kvm]
  [347315.064907]  [<ffffffffa02a2418>] kvm_arch_vcpu_ioctl_run+0x68/0x1a0 =
[kvm]
  [347315.064933]  [<ffffffffa028ecee>] kvm_vcpu_ioctl+0x38e/0x580 [kvm]
  [347315.064943]  [<ffffffff8116bdfb>] do_vfs_ioctl+0x8b/0x3b0
  [347315.064947]  [<ffffffff8116c1c1>] sys_ioctl+0xa1/0xb0
  [347315.064951]  [<ffffffff81469272>] system_call_fastpath+0x16/0x1b
  [347315.064957]  [<00007fee51969ce7>] 0x7fee51969ce6
  [347315.064959] vmwrite error: reg 6c10 value 0 (err 0)

  4) The isssue can't be reporduced. I search the Intel VMX sepc about reas=
eons of vmptrld failure:
  The instruction fails if its operand is not properly aligned, sets unsupp=
orted physical-address bits, or is equal to the VMXON
  pointer. In addition, the instruction fails if the 32 bits in memory refe=
renced by the operand do not match the VMCS
  revision identifier supported by this processor.

  But I can't find any cues from the KVM source code. It seems each
  error condition is impossible. :(

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1640073/+subscriptions

