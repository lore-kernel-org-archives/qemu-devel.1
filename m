Received: from eggs.gnu.org ([2001:4830:134:3::10]:48998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dqMQf-0002A0-7o
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dqMQY-00017L-Am
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:46:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:35881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dqMQY-00017C-4i
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:46:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dqMQX-0005ca-2R
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 16:46:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F02052E848A
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 16:46:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Sep 2017 16:35:40 -0000
From: Thomas Huth <1196426@bugs.launchpad.net>
Reply-To: Bug 1196426 <1196426@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130701072023.14468.74957.malonedeb@gac.canonical.com>
Message-Id: <150488854098.22536.14635617640236648205.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1196426] Re: Setup virtual serial connection for
 Windows VMs FAILS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1196426

Title:
  Setup virtual serial connection for Windows VMs FAILS

Status in QEMU:
  Incomplete

Bug description:
  Hi,

  To setup a virtual serial connections between two Windows 2008 R2(64-bit)=
 guest VMs, I am referring the link =

  http://www.linux-kvm.org/page/WindowsGuestDrivers/UpdatedGuestDebugging

  I started the host VM using the command
  # /usr/local/bin/qemu-system-x86_64 -smp 1 -enable-kvm -m 512 -boot c -ch=
ardev stdio,id=3Dmon0 -mon chardev=3Dmon0 -serial tcp::4445,server,nowait -=
hda /mnt/sda5/var/lib/libvirt/images/win2008host.img =


  To start a target VM, the link specifies the below command
  /usr/local/bin/qemu-system-x86_64 \--enable-kvm \-m 1024 \-drive file=3Dw=
in-target.img \-chardev stdio,id=3Dmon0 \-mdev=3Dmon0 \-serial tcp:127.0.0.=
1:4445.

  I am using the QEMU emulator version 0.15.1 (qemu-kvm-0.15.1). The
  command is lil bit changed and also doesn't have -mdev option. I
  executed the below command.

  # /usr/local/bin/qemu-system-x86_64 -enable-kvm -smp 1 -m 512 -boot c
  -chardev stdio,id=3Dmon0 -mon chardev=3Dmon0 -serial tcp:127.0.0.1:4455
  -hda /var/lib/libvirt/images/win2008target.img

  It through the error =

  inet_connect_opts: connect(ipv4,127.0.0.1,127.0.0.1,4455): Connection ref=
used
  chardev: opening backend "socket" failed: Connection refused
  qemu: could not open serial device 'tcp:127.0.0.1:4455': Connection refus=
ed

  Please let me know if any one knows how to fix issue.

  My Linux System Info:
  # cat /etc/redhat-release =

  Fedora release 12 (Constantine)

  # uname -a
  Linux petla 2.6.31.5-127.fc12.x86_64 #1 SMP Sat Nov 7 21:11:14 EST 2009 x=
86_64 x86_64 x86_64 GNU/Linux

  #cat /proc/cpuinfo
  processor	: 0
  vendor_id	: GenuineIntel
  cpu family	: 6
  model		: 44
  model name	: Intel(R) Xeon(R) CPU           E5645  @ 2.40GHz

  #/usr/local/bin/qemu-system-x86_64 --version
  QEMU emulator version 0.15.1 (qemu-kvm-0.15.1), Copyright (c) 2003-2008 F=
abrice Bellard

  Guest VMs(host and target): Windows Server 2008 R2 (64-bit)

  Thanks in Advance
  Venkatesh

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1196426/+subscriptions
