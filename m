Received: from eggs.gnu.org ([209.51.188.92]:47694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGMln-0007Rz-VW
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGMlm-0008UJ-NX
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:00:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:38070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGMll-0008Tu-M6
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:00:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGMlk-0001dI-J1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 12:00:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 863122E806D
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 12:00:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2019 11:47:33 -0000
From: =?utf-8?q?J=C3=B6rg_Vehlow?= <1423124@bugs.launchpad.net>
Reply-To: Bug 1423124 <1423124@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150218112959.10810.54623.malonedeb@chaenomeles.canonical.com>
Message-Id: <155541525337.13876.7738948035284335852.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1423124] Re: QEMU crash after sending data on
 host serial port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looks like the bug still exists. Sending eg "CTRL+D" or Arrow up/down
makes qemu hang indefinitely

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1423124

Title:
  QEMU crash after sending data on host serial port

Status in QEMU:
  Fix Released

Bug description:
  Good morning,

  I'm using QEMU for Windows last version.
  The host system is Windows 7 64bits.
  I'm excuting the following statment :

  qemu-system-x86_64w.exe -hda debian.img -m 256 -net nic -net
  tap,ifname=3DTAP32 -soundhw all -serial COM9

  Qemu starts the emulated Debian and it runs correctly.

  If I try to send data from Windows using COM9 to QEMU (both "real" or emu=
lated by the COM0COM driver), QEMU crashes. Windows dump available if requi=
red.
  If I try to send data to /dev/ttyS0 (that should be the Linux side of COM=
9) from Debian, again, the wirtual machine crashes.

  More details if necessary
  Best regards
  U.Poddine

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1423124/+subscriptions
