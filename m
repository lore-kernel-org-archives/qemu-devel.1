Received: from eggs.gnu.org ([2001:4830:134:3::10]:50209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fEcpF-00026q-EM
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fEcpC-0001mE-BE
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:40:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:43948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fEcpB-0001lP-SQ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:40:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fEcpA-00054D-Nv
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 15:40:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B237B2E8050
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 15:40:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 May 2018 15:31:54 -0000
From: =?utf-8?q?Fran=C3=A7ois_Guerraz?= <kubrick@fgv6.net>
Reply-To: Bug 1769189 <1769189@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152544791493.32626.6219738999075353422.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1769189] [NEW] Issue with qemu 2.12.0 + UEFI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

(first reported here: https://bugzilla.tianocore.org/show_bug.cgi?id=3D949
)

I had a Windows 10 VM running perfectly fine with OVMF UEFI, since I
upgraded to qemu 2.12, the guests hangs for a couple of minutes, works
for a few seconds, and hangs again, etc. By "hang" I mean it doesn't
freeze, but it looks like it's waiting on IO or something, I can move
the mouse but everything needing disk access is unresponsive.

What doesn't work: qemu 2.12 with OVMF
What works: using BIOS or downgrading qemu to 2.11.1.

Platform is arch linux 4.16.7 on skylake, I have attached the vm xml
file.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "libvirt vm description"
   https://bugs.launchpad.net/bugs/1769189/+attachment/5133839/+files/Win10=
.xml

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1769189

Title:
  Issue with qemu 2.12.0 + UEFI

Status in QEMU:
  New

Bug description:
  (first reported here:
  https://bugzilla.tianocore.org/show_bug.cgi?id=3D949 )

  I had a Windows 10 VM running perfectly fine with OVMF UEFI, since I
  upgraded to qemu 2.12, the guests hangs for a couple of minutes, works
  for a few seconds, and hangs again, etc. By "hang" I mean it doesn't
  freeze, but it looks like it's waiting on IO or something, I can move
  the mouse but everything needing disk access is unresponsive.

  What doesn't work: qemu 2.12 with OVMF
  What works: using BIOS or downgrading qemu to 2.11.1.

  Platform is arch linux 4.16.7 on skylake, I have attached the vm xml
  file.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1769189/+subscriptions
