Received: from eggs.gnu.org ([209.51.188.92]:36614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gx8Bj-0004lf-OQ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gx8Bi-0001Q9-LG
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:36:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:37468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gx8Bg-0000aI-MB
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:36:14 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gx8Aq-0001PS-50
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 10:35:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1EB3F2E80C8
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 10:35:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Feb 2019 10:24:41 -0000
From: Thomas Huth <1548166@bugs.launchpad.net>
Reply-To: Bug 1548166 <1548166@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160222033240.1894.82255.malonedeb@wampee.canonical.com>
Message-Id: <155083108191.30208.12654999108748188164.malone@chaenomeles.canonical.com>
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

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1548166

Title:
  QEMU crash after send data from Host through serial port

Status in QEMU:
  Incomplete

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
