Received: from eggs.gnu.org ([2001:4830:134:3::10]:34993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1epsx3-0005FV-Fu
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 04:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1epsx2-0004Sj-Is
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 04:50:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:51280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1epsx2-0004Rk-BH
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 04:50:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1epsx1-0005IL-55
	for <qemu-devel@nongnu.org>; Sun, 25 Feb 2018 09:50:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 24E7F2E80CB
	for <qemu-devel@nongnu.org>; Sun, 25 Feb 2018 09:50:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Feb 2018 09:43:48 -0000
From: Thomas Huth <1688231@bugs.launchpad.net>
Reply-To: Bug 1688231 <1688231@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170504110626.10123.22333.malonedeb@gac.canonical.com>
Message-Id: <151955183000.6409.6963719927327251726.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1688231] Re: [Qemu-ppc] sendkey is not working
 for any of the keystrokes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1688231

Title:
  [Qemu-ppc] sendkey is not working for any of the keystrokes

Status in QEMU:
  Won't Fix

Bug description:
  sendkey option is not working for any of the keystrokes in ppc64le,

  Qemu version:
  # qemu-img --version
  qemu-img version 2.9.50 (v2.9.0-303-g81b2d5c-dirty)

  Qemu command line:
  # qemu-system-ppc64 --enable-kvm --nographic -vga none -machine pseries -=
m 4G,slots=3D32,maxmem=3D32G -smp 16,maxcpus=3D32 -device virtio-blk-pci,dr=
ive=3Drootdisk -drive file=3D/var/lib/libvirt/images/f25-upstream-ppc64le.q=
cow2,if=3Dnone,cache=3Dnone,format=3Dqcow2,id=3Drootdisk -monitor telnet:12=
7.0.0.1:1234,server,nowait -net nic,model=3Dvirtio -net user -redir tcp:200=
0::22

  Guest booted successfully and logged in
  Fedora 25 (Twenty Five)
  Kernel 4.11.0-rc4 on an ppc64le (hvc0)

  atest-guest login: updatedb (5582) used greatest stack depth: 9568 bytes =
left
  root
  Password: =

  Last login: Mon Mar 27 01:57:51 on hvc0
  [root@atest-guest ~]# =


  Qemu monitor:
  # telnet 127.0.0.1 1234
  Trying 127.0.0.1...
  Connected to 127.0.0.1.
  Escape character is '^]'.
  QEMU 2.9.50 monitor - type 'help' for more information
  (qemu) sendkey a
  (qemu) sendkey ret

  But from the console, I couldn't observe the keystroke a or return.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1688231/+subscriptions
