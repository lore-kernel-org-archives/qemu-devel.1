Received: from eggs.gnu.org ([2001:4830:134:3::10]:34513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5kvu-0007ns-UW
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5kvt-0004gs-Qx
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:31:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:53552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f5kvt-0004e2-JU
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:31:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f5kvr-00012w-0R
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 04:30:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E71042E80D9
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 04:30:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Apr 2018 04:17:38 -0000
From: Launchpad Bug Tracker <1196498@bugs.launchpad.net>
Reply-To: Bug 1196498 <1196498@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130701105345.29253.2188.malonedeb@wampee.canonical.com>
Message-Id: <152333385876.1655.12878249777657014186.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1196498] Re: Failed to create COM port in Windows
 Guest VM
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
https://bugs.launchpad.net/bugs/1196498

Title:
  Failed to create COM port in Windows Guest VM

Status in QEMU:
  Expired

Bug description:
  Hi,

  Tried to establish virtual serial connection between two Windows Guest
  VMs(Windows 2008 Server).

  As it mentioned under the link,
  http://www.linux-kvm.org/page/WindowsGuestDrivers/UpdatedGuestDebugging

  Started VM using the below command with serial device as TCP port.
  # qemu-system-x86_64 -smp 1 -enable-kvm -m 512 -boot c -serial tcp:127.0.=
0.1:50001,server,nowait -hda /mnt/sda5/var/lib/libvirt/images/win2008host.i=
mg

  And started WinDbg in the Windows VM, with serial port:COM1 and
  Baudrate:115200.

  It throws the error "Could not start kernel debugging using
  com:port:COM1,baudrate:115200 parameters, Win32 error 0n2. The system
  cannot find the file specified."

  Checked under Device Manager and there is no COM1 port.
  Does the -serial tcp:127.0.0.01:50001 creates COM1 port? I doubt.
  If no what are the parameters I should pass to WinDbg for serial port?

  Please help me how to solve this issue.

  Thanks
  Venkatesh

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1196498/+subscriptions
