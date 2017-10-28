Received: from eggs.gnu.org ([2001:4830:134:3::10]:60082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8Tm0-0004ax-2q
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 12:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8Tlw-0007eq-2q
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 12:15:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:47520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8Tlv-0007cs-Sp
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 12:15:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8Tlu-0007RO-Vz
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 16:15:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F0AE02E80C7
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 16:15:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 16:07:44 -0000
From: =?utf-8?q?W=C3=BCstengecko?= <1728256@bugs.launchpad.net>
Reply-To: Bug 1728256 <1728256@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150920686502.20214.12572544661418580428.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1728256] [NEW] (Regression) Memory corruption in
 Windows 10 guest / amd64
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

I have a Win 10 Pro x64 guest inside a qemu/kvm running on an Arch x86_64 h=
ost. The VM has a physical GPU passed through, as well as the physical USB =
controllers, as well as a dedicated SSD attached via SATA; you can find the=
 complete libvirt xml here: https://pastebin.com/U1ZAXBNg
I built qemu from source using the qemu-minimal-git AUR package; you can fi=
nd the build script here: https://aur.archlinux.org/cgit/aur.git/tree/PKGBU=
ILD?h=3Dqemu-minimal-git (if you aren't familiar with Arch, this is essenti=
ally a bash script where build() and package() are run to build the files, =
and then install them into the $pkgdir to later tar them up.)

Starting with qemu v2.10.0, Windows crashes randomly with a bluescreen
about CRITICAL_STRUCTURE_CORRUPTION. I also tested the git heads
f90ea7ba7c, 861cd431c9 and e822e81e35, before I went back to v2.9.0,
which is running stable for over 50 hours right now.

During my tests I found that locking the memory pages alleviates the
problem somewhat, but never completely avoids it. However, with the
crashes occuring randomly, that could as well be false conclusions; I
had crashes within minutes after boot with that too.

I will now start `git bisect`ing; if you have any other suggestions on
what I could try or possible patches feel free to leave them with me.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1728256

Title:
  (Regression) Memory corruption in Windows 10 guest / amd64

Status in QEMU:
  New

Bug description:
  I have a Win 10 Pro x64 guest inside a qemu/kvm running on an Arch x86_64=
 host. The VM has a physical GPU passed through, as well as the physical US=
B controllers, as well as a dedicated SSD attached via SATA; you can find t=
he complete libvirt xml here: https://pastebin.com/U1ZAXBNg
  I built qemu from source using the qemu-minimal-git AUR package; you can =
find the build script here: https://aur.archlinux.org/cgit/aur.git/tree/PKG=
BUILD?h=3Dqemu-minimal-git (if you aren't familiar with Arch, this is essen=
tially a bash script where build() and package() are run to build the files=
, and then install them into the $pkgdir to later tar them up.)

  Starting with qemu v2.10.0, Windows crashes randomly with a bluescreen
  about CRITICAL_STRUCTURE_CORRUPTION. I also tested the git heads
  f90ea7ba7c, 861cd431c9 and e822e81e35, before I went back to v2.9.0,
  which is running stable for over 50 hours right now.

  During my tests I found that locking the memory pages alleviates the
  problem somewhat, but never completely avoids it. However, with the
  crashes occuring randomly, that could as well be false conclusions; I
  had crashes within minutes after boot with that too.

  I will now start `git bisect`ing; if you have any other suggestions on
  what I could try or possible patches feel free to leave them with me.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1728256/+subscriptions
