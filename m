Received: from eggs.gnu.org ([2001:4830:134:3::10]:56850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCo0r-0004Ga-0c
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCo0n-0001zz-Ut
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:41:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:46212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eCo0n-0001z5-OO
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:40:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eCo0m-0006VT-L4
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 14:40:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 89DF82E80D4
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 14:40:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Nov 2017 14:32:08 -0000
From: David Hildenbrand <1731277@bugs.launchpad.net>
Reply-To: Bug 1731277 <1731277@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151023792928.3447.3728561425384648409.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1731277] [NEW] Provide target specific qemu man
 pages
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

Right now, all qemu target binaries (qemu-system-...) share the same man
page.

The current man page is primarily focused on x86, and therefore the
information given is entirely wrong for e.g. arm, powerpc or s390x.

NAME
       qemu-doc - QEMU Emulator User Documentation

SYNOPSIS
       qemu-system-i386 [options] [disk_image]

DESCRIPTION
       The QEMU PC System emulator simulates the following peripherals:

       -   i440FX host PCI bridge and PIIX3 PCI to ISA bridge

       -   Cirrus CLGD 5446 PCI VGA card or dummy VGA card with Bochs VESA =
extensions (hardware level, including all non
           standard modes).

       -   PS/2 mouse and keyboard

       -   2 PCI IDE interfaces with hard disk and CD-ROM support

       -   Floppy disk

...

We should have target specific man pages, with the common
options/settings factored out, so they are included in all target
specific man pages.

"man qemu-system-s390x" should give s390x specific (+common) information
and "man qemu-system-x86_64" should contain x86 specific (+common)
information.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1731277

Title:
  Provide target specific qemu man pages

Status in QEMU:
  New

Bug description:
  Right now, all qemu target binaries (qemu-system-...) share the same
  man page.

  The current man page is primarily focused on x86, and therefore the
  information given is entirely wrong for e.g. arm, powerpc or s390x.

  NAME
         qemu-doc - QEMU Emulator User Documentation

  SYNOPSIS
         qemu-system-i386 [options] [disk_image]

  DESCRIPTION
         The QEMU PC System emulator simulates the following peripherals:

         -   i440FX host PCI bridge and PIIX3 PCI to ISA bridge

         -   Cirrus CLGD 5446 PCI VGA card or dummy VGA card with Bochs VES=
A extensions (hardware level, including all non
             standard modes).

         -   PS/2 mouse and keyboard

         -   2 PCI IDE interfaces with hard disk and CD-ROM support

         -   Floppy disk

  ...

  We should have target specific man pages, with the common
  options/settings factored out, so they are included in all target
  specific man pages.

  "man qemu-system-s390x" should give s390x specific (+common)
  information and "man qemu-system-x86_64" should contain x86 specific
  (+common) information.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1731277/+subscriptions
