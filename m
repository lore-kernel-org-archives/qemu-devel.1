Received: from eggs.gnu.org ([2001:4830:134:3::10]:42470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCodo-0002mv-PW
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCodl-0006NP-K5
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:21:16 -0500
Received: from indium.canonical.com ([91.189.90.7]:51516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eCodl-0006LY-DT
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:21:13 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eCodh-00026l-KG
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 15:21:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 56C202E82A7
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 15:11:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Nov 2017 15:03:54 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1731277 <1731277@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151023792928.3447.3728561425384648409.malonedeb@gac.canonical.com>
Message-Id: <151023983493.31277.13020700716287549724.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1731277] Re: Provide target specific qemu man
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

I'm kind of hoping that moving to Sphinx for our docs toolchain will
allow us to for instance have the board specific information in doc
comments in each board source file, which could then be automatically
assembled into the right documentation. The current manpages are
autobuilt from the monolithic qemu-doc.texi, which is woefully out of
date in many areas...

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
