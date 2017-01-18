Received: from eggs.gnu.org ([2001:4830:134:3::10]:59663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTmsS-0004Vd-99
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:50:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTmsP-0001vZ-7m
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:50:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:57662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTmsO-0001vD-Vq
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:49:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTmsO-0001aS-0T
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 09:49:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 007B02E80C7
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 09:49:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Jan 2017 09:31:34 -0000
From: Thomas Huth <735752@bugs.launchpad.net>
Reply-To: Bug 735752 <735752@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110315212854.22582.99189.malonedeb@wampee.canonical.com>
Message-Id: <20170118093134.27020.19296.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 735752] Re: qemu squeeze crashes "BUG: unable to
 handle kernel NULL pointer dereference at (null)"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sounds like this was a kernel bug ... you should report those to the
right kernel mailing lists instead. Anyway, closing this ticket now
since there hasn't been any activity since a long time.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/735752

Title:
  qemu squeeze crashes "BUG: unable to handle kernel NULL pointer
  dereference at           (null)"

Status in QEMU:
  Invalid

Bug description:
  my virtual machine server (qemu+libvirt) regularly breaks down with such =
a record in the logs
  I can not even ping the guest, but i can ping host, but can not do someth=
ing with it (cannot ssh login for example)
  And I dont know how to reproduce the problem :(

  Mar 15 17:58:04 mainhost kernel: [65866.976982] BUG: unable to handle ker=
nel NULL pointer dereference at           (null)                           =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.977422] IP: [<ffffffff8100efbe>] =
0xffffffff8100efbe                                                         =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.977663] PGD 7387b7067 PUD 81b7230=
67 PMD 0.                                                                  =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.977902] Oops: 0000 [#1] SMP.     =
                                                                           =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.978128] last sysfs file: /sys/dev=
ices/system/cpu/cpu3/topology/thread_siblings                              =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.978572] CPU 1.                   =
                                                                           =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.978577] Modules linked in: nfs lo=
ckd nfs_acl auth_rpcgss sunrpc ebtable_nat ebtables coretemp bridge stp llc=
 xt_state
  Mar 15 17:58:04 mainhost kernel: [65866.979737].                         =
                                                                           =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.979959] Pid: 3369, comm: qemu-sys=
tem-x86 Not tainted 2.6.37-gentoo-r2 #2 Intel S5000VSA/S5000VSA            =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] RIP: 0010:[<ffffffff8100e=
fbe>]  [<ffffffff8100efbe>] 0xffffffff8100efbe                             =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] RSP: 0018:ffff880738767a4=
8  EFLAGS: 00010246                                                        =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] RAX: 0000000000000000 RBX=
: fffffffffffff001 RCX: ffff88081cbeb948                                   =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] RDX: 0000000000000022 RSI=
: fffffffffffff001 RDI: ffff88081cbeb000                                   =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] RBP: 0000000000000001 R08=
: 00000000000fee01 R09: 0000000000000022                                   =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] R10: 0000008000000000 R11=
: ffffea0000000000 R12: ffff880818d83490                                   =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] R13: 00000000155e5000 R14=
: 0000000000000000 R15: 0000000000000100                                   =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] FS:  00007f5f25e4e700(000=
0) GS:ffff88009f680000(0000) knlGS:fffff80001175000                        =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] CS:  0010 DS: 002b ES: 00=
2b CR0: 000000008005003b                                                   =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] CR2: 0000000000000000 CR3=
: 0000000806be9000 CR4: 00000000000426e0                                   =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] DR0: 0000000000000045 DR1=
: 0000000000000000 DR2: 0000000000000000                                   =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] DR3: 0000000000000005 DR6=
: 00000000ffff0ff0 DR7: 0000000000000400                                   =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] Process qemu-system-x86 (=
pid: 3369, threadinfo ffff880738766000, task ffff8808203ac360)             =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] Stack:                   =
                                                                           =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  0000000000000000 ffff880=
6a30f3ff8 ffff880753980000 ffffffff8100f06f                                =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  0000000000000ff8 ffff880=
7705d6b40 0000000000000ff8 ffffffff810123f0                                =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  0000000000000000 0000000=
000000000 0000000000000000 0000000000000000                                =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] Call Trace:              =
                                                                           =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  [<ffffffff8100f06f>] ? 0=
xffffffff8100f06f                                                          =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  [<ffffffff810123f0>] ? 0=
xffffffff810123f0                                                          =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  [<ffffffff8100f744>] ? 0=
xffffffff8100f744                                                          =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  [<ffffffff8100ffaf>] ? 0=
xffffffff8100ffaf                                                          =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  [<ffffffff810011f1>] ? 0=
xffffffff810011f1                                                          =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  [<ffffffff810142fc>] ? 0=
xffffffff810142fc                                                          =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  [<ffffffff8100834d>] ? 0=
xffffffff8100834d                                                          =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  [<ffffffff81011af6>] ? 0=
xffffffff81011af6                                                          =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  [<ffffffff8100c5a7>] ? 0=
xffffffff8100c5a7                                                          =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  [<ffffffff81003a85>] ? 0=
xffffffff81003a85                                                          =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  [<ffffffff810e19b0>] ? 0=
xffffffff810e19b0                                                          =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  [<ffffffff81078cd8>] ? 0=
xffffffff81078cd8                                                          =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  [<ffffffff810e1a39>] ? 0=
xffffffff810e1a39                                                          =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  [<ffffffff810267fb>] ? 0=
xffffffff810267fb                                                          =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] Code: 8b 47 50 8d 50 01 8=
5 c0 89 57 50 75 07 41 58 e9 32 ff ff ff 5f c3 55 89 d5 53 48 89 f3 48 83 e=
c 08 e8 d
  Mar 15 17:58:04 mainhost kernel: [65866.980085] RIP  [<ffffffff8100efbe>]=
 0xffffffff8100efbe                                                        =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085]  RSP <ffff880738767a48>  =
                                                                           =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.980085] CR2: 0000000000000000    =
                                                                           =
         =

  Mar 15 17:58:04 mainhost kernel: [65866.990753] ---[ end trace d147f74976=
c2654d ]---

  Linux mainhost 2.6.37-gentoo-r2 #2 SMP Mon Mar 14 22:53:20 MSK 2011
  x86_64 Intel(R) Xeon(R) CPU E5405 @ 2.00GHz GenuineIntel GNU/Linux

  app-emulation/qemu-kvm-0.13.0-r2
  app-emulation/libvirt-0.8.8-r1

  mainhost log # ps ax|grep qemu
   2957 ?        Sl    12:28 /usr/bin/qemu-system-x86_64 --enable-kvm -S -M=
 pc-0.13 -enable-kvm -m 512 -smp 1,sockets=3D1,cores=3D1,threads=3D1 -name =
dc1 -uuid f090bfc9-1cab-e4e9-51ea-80c9cc775bff -nodefconfig -nodefaults -ch=
ardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/dc1.monitor,serv=
er,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=
=3Dlocaltime -boot order=3Dc,menu=3Doff -drive file=3D/dev/vm-storage/dc1,i=
f=3Dnone,id=3Ddrive-ide0-0-0,format=3Draw -device ide-drive,bus=3Dide.0,uni=
t=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0-0-0 -drive if=3Dnone,media=3Dcdrom,i=
d=3Ddrive-ide0-1-0,readonly=3Don,format=3Draw -device ide-drive,bus=3Dide.1=
,unit=3D0,drive=3Ddrive-ide0-1-0,id=3Dide0-1-0 -netdev tap,fd=3D13,id=3Dhos=
tnet0 -device rtl8139,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:7e:a1:a7,b=
us=3Dpci.0,addr=3D0x4 -usb -device usb-tablet,id=3Dinput0 -vnc 0.0.0.0:0,pa=
ssword -vga cirrus -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,add=
r=3D0x3
   2982 ?        Rl    10:34 /usr/bin/qemu-system-x86_64 --enable-kvm -S -M=
 pc-0.13 -enable-kvm -m 1024 -smp 1,sockets=3D1,cores=3D1,threads=3D1 -name=
 transarchive -uuid b96a3481-1ad6-9329-387e-a1504a17d0ee -nodefconfig -node=
faults -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/transa=
rchive.monitor,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=
=3Dcontrol -rtc base=3Dlocaltime -boot order=3Dc,menu=3Doff -drive file=3D/=
dev/vm-storage/transarchive,if=3Dnone,id=3Ddrive-ide0-0-0,format=3Draw -dev=
ice ide-drive,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0-0-0 -dr=
ive if=3Dnone,media=3Dcdrom,id=3Ddrive-ide0-1-0,readonly=3Don,format=3Draw =
-device ide-drive,bus=3Dide.1,unit=3D0,drive=3Ddrive-ide0-1-0,id=3Dide0-1-0=
 -netdev tap,fd=3D13,id=3Dhostnet0,vhost=3Don,vhostfd=3D17 -device virtio-n=
et-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:a9:f8:06,bus=3Dpci.0,addr=
=3D0x3 -usb -device usb-tablet,id=3Dinput0 -vnc 0.0.0.0:3,password -vga std=
 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x4

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/735752/+subscriptions
