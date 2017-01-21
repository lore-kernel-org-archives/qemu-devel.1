Received: from eggs.gnu.org ([2001:4830:134:3::10]:44179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUnJg-0001di-R8
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 23:30:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUnJd-0003iS-JB
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 23:30:16 -0500
Received: from indium.canonical.com ([91.189.90.7]:47153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUnJd-0003iF-De
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 23:30:13 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUnJc-00005L-6N
	for <qemu-devel@nongnu.org>; Sat, 21 Jan 2017 04:30:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2E9C22E80C7
	for <qemu-devel@nongnu.org>; Sat, 21 Jan 2017 04:30:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Jan 2017 04:17:34 -0000
From: Launchpad Bug Tracker <1484925@bugs.launchpad.net>
Reply-To: Bug 1484925 <1484925@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150814122340.5606.46979.malonedeb@gac.canonical.com>
Message-Id: <20170121041734.20915.27899.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1484925] Re: Segfault with custom vnc client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1484925

Title:
  Segfault with custom vnc client

Status in QEMU:
  Expired

Bug description:
  Hey,

  I'm using Citrix XenServer 6.5. I worte a script that uses noVNC to
  connect to the rfb console via xapi. When I use GRML and try to boot
  it, the QEMU process segfaults and kills my VM. This happens when the
  screen resizes and the kernel is loading:

  recvfrom(3, "\3\1\0\0\0\0\2\200\1\220\3\0\2\200\0\0\0P\1\220", 4096, 0, N=
ULL, NULL) =3D 20
  --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3DSEGV_MAPERR, si_addr=3D0xb2800=
0} ---

  I can see in the child process the following message, right before the pa=
rent Segfaults:
  read(4, "cirrus: blanking the screen line_offset=3D0 height=3D480\n", 53)=
 =3D 53

  This issue only happens, when I have my custom php/novnc-client
  connected. I also tried the nodejs/novnc package from xen-orchestra -
  same result. Using the stock client from Citrix XenCenter it works
  just fine. So I think it is related to noVNC. I hope this is just a
  bug and not exploitable to force a VM to crash or execute code.

  XenServer launches the qemu with the following command line:

  qemu-dm-25 --syslog -d 25 -m 2048 -boot dc -serial pty -vcpus 1
  -videoram 4 -vncunused -k en-us -vnc 127.0.0.1:1 -usb -usbdevice
  tablet -net nic,vlan=3D0,macaddr=3D8a:43:e2:b1:57:df,model=3Drtl8139 -net
  tap,vlan=3D0,bridge=3Dxenbr0,ifname=3Dtap25.0 -acpi -monitor pty

  XenServer 6.5 is using the following version:
  # /usr/lib64/xen/bin/qemu-dm -help
  QEMU PC emulator version 0.10.2, Copyright (c) 2003-2008 Fabrice Bellard

  Greetings
  Uli St=C3=A4rk

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1484925/+subscriptions
