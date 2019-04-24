Received: from eggs.gnu.org ([209.51.188.92]:59154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJ9dE-0002IL-N4
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJ9Yw-00031F-0X
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:31:15 -0400
Received: from indium.canonical.com ([91.189.90.7]:59726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJ9Yu-0002xD-35
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:31:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJ9Yq-0007cl-7k
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 04:31:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 314DB2E806F
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 04:31:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 04:17:33 -0000
From: Launchpad Bug Tracker <1548166@bugs.launchpad.net>
Reply-To: Bug 1548166 <1548166@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160222033240.1894.82255.malonedeb@wampee.canonical.com>
Message-Id: <155607945409.22348.8935329774832677919.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1548166] Re: QEMU crash after send data from Host
 through serial port
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
https://bugs.launchpad.net/bugs/1548166

Title:
  QEMU crash after send data from Host through serial port

Status in QEMU:
  Expired

Bug description:
  Hi All

  I have two computer, one is Win7 32 another is Win7 64, Both computer mee=
t this issue.
  My QEMU version is qemu-w32-setup-20160215

  I want used EDK2 OVMF with Intel UDK Debugger tools to do source level de=
bug
  I had install com0com Virtual Com Port, and set COM3 connect to COM4

  Intel UDK Debugger tools used COM3
  QEMU run OVMF used COM4

  First execute Intel UDK Debugger tools, then launch QEMU
  C:\Program Files\qemu\qemu-system-x86_64.exe -bios "C:\EDK2\Build\OvmfX64=
\DEBUG_VS2010\FV\OVMF.fd" -serial COM4
  Then QEMU crashes on stratup

  I have do some experiment
  Execute terminal tool Tera Term and used COM3
  launch QEMU and used COM4
  C:\Program Files\qemu\qemu-system-x86_64.exe -bios "C:\EDK2\Build\OvmfX64=
\DEBUG_VS2010\FV\OVMF.fd" -serial COM4
  This is fine and i can see OVMF trace log on terminal
  But if i press "Down" key on terminal, then QEMU crashe
  It's caused by terminal send data("Down" key) to QEMU

  Have somebody can share some information about this?

  Thanks a lot.
  Sugar

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1548166/+subscriptions
