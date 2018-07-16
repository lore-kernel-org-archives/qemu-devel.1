Received: from eggs.gnu.org ([2001:4830:134:3::10]:33004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ff5eM-0007iG-V9
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ff5eI-0004K3-1n
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:42:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:57716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ff5eH-0004JG-RD
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:42:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ff5eD-0004CB-NF
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 15:42:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 47A7C2E80E6
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 15:42:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jul 2018 15:26:40 -0000
From: =?utf-8?q?Leonardo_M=C3=BCller?= <leozinho29_eu@hotmail.com>
Reply-To: Bug 1755912 <1755912@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152106105315.14602.6749093724412548748.malonedeb@chaenomeles.canonical.com>
Message-Id: <153175480029.23210.7090422054337554731.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1755912] Re: qemu-system-x86_64 crashed with
 SIGABRT when using option -vga qxl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Unfortunately it did not work, the error is still the same although it
used the GTK interface this time. The command I used was:

$ qemu-system-x86_64 -vga qxl -enable-kvm -cpu host -smp
cores=3D2,threads=3D2 -m 2048 -cdrom xubuntu-18.04-desktop-amd64.iso

I have noticed Ubuntu's QEMU and this QEMU don't have the OpenGL option
enabled, may this be related to the issue?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1755912

Title:
  qemu-system-x86_64 crashed with SIGABRT when using option -vga qxl

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  When using qemu-system-x86_64 with the option -vga qxl, it crashes.
  The easiest way to crash it is by trying to change the guest's
  resolution. However, the system may randomly crash too, not happening
  only when changing resolution. Here is the terminal output of one of
  these random crashes:

  --------

  $ qemu-system-x86_64 -hda /dev/sdb -m 2048 -enable-kvm -cpu host -vga qxl=
 -nodefaults -netdev user,id=3Dhostnet0 -device virtio-net-pci,id=3Dnet0,ne=
tdev=3Dhostnet0
  WARNING: Image format was not specified for '/dev/sdb' and probing guesse=
d raw.
           Automatically detecting the format is dangerous for raw images, =
write operations on block 0 will be restricted.
           Specify the 'raw' format explicitly to remove the restrictions.

  (process:21313): Spice-WARNING **: 16:01:45.759: display-
  channel.c:2431:display_channel_validate_surface: canvas address is
  0x7f8eb948ab18 for 0 (and is NULL)

  =

  (process:21313): Spice-WARNING **: 16:01:45.759: display-channel.c:2432:d=
isplay_channel_validate_surface: failed on 0

  (process:21313): Spice-CRITICAL **: 16:01:45.759: display-channel.c:2035:=
display_channel_update: condition `display_channel_validate_surface(display=
, surface_id)' failed
  Abortado (imagem do n=C3=BAcleo gravada)

  --------

  I was running QEMU as a normal user which is on the groups kvm and
  disk. Initially I supposed the problem was because I was running QEMU
  as root, but as a normal user this happens too.

  I have tested with guests with different Ubuntu version: 18.04, 17.10
  and 16.04. It is happening with them all.

  ProblemType: Crash
  DistroRelease: Ubuntu 18.04
  Package: qemu-system-x86 1:2.11+dfsg-1ubuntu4
  ProcVersionSignature: Ubuntu 4.15.0-10.11-generic 4.15.3
  Uname: Linux 4.15.0-10-generic x86_64
  ApportVersion: 2.20.8-0ubuntu10
  Architecture: amd64
  CurrentDesktop: XFCE
  Date: Wed Mar 14 17:13:52 2018
  ExecutablePath: /usr/bin/qemu-system-x86_64
  InstallationDate: Installed on 2017-06-13 (273 days ago)
  InstallationMedia: Xubuntu 17.04 "Zesty Zapus" - Release amd64 (20170412)
  KvmCmdLine: COMMAND         STAT  EUID  RUID   PID  PPID %CPU COMMAND
  MachineType: LENOVO 80UG
  ProcCmdline: qemu-system-x86_64 -hda /dev/sdb -smp cpus=3D2 -m 512 -enabl=
e-kvm -cpu host -vga qxl -nodefaults -netdev user,id=3Dhostnet0 -device vir=
tio-net-pci,id=3Dnet0,netdev=3Dhostnet0
  ProcKernelCmdLine: BOOT_IMAGE=3D/boot/vmlinuz-4.15.0-10-generic.efi.signe=
d root=3DUUID=3D6b4ae5c0-c78c-49a6-a1ba-029192618a7a ro quiet
  Signal: 6
  SourcePackage: qemu
  StacktraceTop:
   () at /usr/lib/x86_64-linux-gnu/libspice-server.so.1
   () at /usr/lib/x86_64-linux-gnu/libspice-server.so.1
   () at /usr/lib/x86_64-linux-gnu/libspice-server.so.1
   () at /usr/lib/x86_64-linux-gnu/libspice-server.so.1
   () at /usr/lib/x86_64-linux-gnu/libspice-server.so.1
  Title: qemu-system-x86_64 crashed with SIGABRT
  UpgradeStatus: Upgraded to bionic on 2017-10-20 (145 days ago)
  UserGroups: adm bluetooth cdrom dialout dip disk kvm libvirt lpadmin netd=
ev plugdev sambashare sudo
  dmi.bios.date: 07/10/2017
  dmi.bios.vendor: LENOVO
  dmi.bios.version: 0XCN43WW
  dmi.board.asset.tag: NO Asset Tag
  dmi.board.name: Toronto 4A2
  dmi.board.vendor: LENOVO
  dmi.board.version: SDK0J40679 WIN
  dmi.chassis.asset.tag: NO Asset Tag
  dmi.chassis.type: 10
  dmi.chassis.vendor: LENOVO
  dmi.chassis.version: Lenovo ideapad 310-14ISK
  dmi.modalias: dmi:bvnLENOVO:bvr0XCN43WW:bd07/10/2017:svnLENOVO:pn80UG:pvr=
Lenovoideapad310-14ISK:rvnLENOVO:rnToronto4A2:rvrSDK0J40679WIN:cvnLENOVO:ct=
10:cvrLenovoideapad310-14ISK:
  dmi.product.family: IDEAPAD
  dmi.product.name: 80UG
  dmi.product.version: Lenovo ideapad 310-14ISK
  dmi.sys.vendor: LENOVO

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1755912/+subscriptions
