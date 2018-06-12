Received: from eggs.gnu.org ([2001:4830:134:3::10]:36757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fSjSa-00062a-45
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fSjSV-0002vB-Px
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:35:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:54482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fSjSV-0002td-K9
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:35:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fSjSS-0002LB-In
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 13:35:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 564D22E819A
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 13:35:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Jun 2018 13:29:16 -0000
From: Jonathan Marler <1776486@bugs.launchpad.net>
Reply-To: Bug 1776486 <1776486@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152881015650.27433.14455383509623030686.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1776486] [NEW] detect error when kernel and
 initrd images exceed ram size
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

I was unable to figure out why my VM wasn't booting when I added a
"-initrd" image.  I would launch qemu and get no output, and no error
message, it would just spin.

Turns out my initrd image was around 270 MB but I wasn't giving an
explicit ram size to qemu.  I was told the default memory size was
around 120 MB so this was definitely a problem.  I think that the qemu
"pseudo-bootloader" should detect when the kernel image and initrd image
sizes exceed the size of ram and print a nice error to the user,
something like:

Error: the total size of the given boot images (342M) exceeds the size
allocated for memory (120M)

** Affects: qemu
     Importance: Undecided
         Status: Confirmed


** Tags: arm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776486

Title:
  detect error when kernel and initrd images exceed ram size

Status in QEMU:
  Confirmed

Bug description:
  I was unable to figure out why my VM wasn't booting when I added a
  "-initrd" image.  I would launch qemu and get no output, and no error
  message, it would just spin.

  Turns out my initrd image was around 270 MB but I wasn't giving an
  explicit ram size to qemu.  I was told the default memory size was
  around 120 MB so this was definitely a problem.  I think that the qemu
  "pseudo-bootloader" should detect when the kernel image and initrd
  image sizes exceed the size of ram and print a nice error to the user,
  something like:

  Error: the total size of the given boot images (342M) exceeds the size
  allocated for memory (120M)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776486/+subscriptions
