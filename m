Received: from eggs.gnu.org ([2001:4830:134:3::10]:38385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gGvbt-0000Su-IK
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 20:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gGvbq-0008QJ-81
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 20:40:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:54180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gGvbp-0008Pf-V7
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 20:40:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gGvbo-0004ys-GC
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 00:40:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 778892E805B
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 00:40:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Oct 2018 00:32:11 -0000
From: Nicholas Vinson <1800401@bugs.launchpad.net>
Reply-To: Bug 1800401 <1800401@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154077313146.29068.467827083588404194.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1800401] [NEW] efifb on Linux guest fails to load
 when using VGA passthrough
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

The EFI framebuffer fails to load when booting a Gentoo guest using ovmf
+ vga_passthrough.  I retested using they system rescue CD and saw the
same issue, but also noticed that when a second framebuffer loads,
nouveaufb in my case, the terminal appears.  I have also verified that
the Gentoo min CD is not hanging at boot as I can type 'poweroff' after
waiting a few minutes and the system responds by powering off.  I am
unable to reproduce with seabios as I have been unable to get vga
passthrough to work with that BIOS.

Steps to Reproduce:
    1. Install qemu and ovmf
    2. Download systemrescuecd-x86-5.3.1.iso
    3. Run qemu using one of the configurations below
    4. Select first boot option in GRUB menu
    5. Wait 30 seconds
    6. Press enter # System rescue is prompting for the keymap between step=
s 5 and 6
    7. Wait 2 minutes
    8. Observe fb console
    9. Note lack of output until very late in boot process
   10. Check dmesg
   11. Note efifb failed to load (invalid address)
   12. Note nouveaufb started late in boot process =


Expected Results:
   The EFI FB to load and display output to monitor.  This is the behavior =
I see when booting the host system via UEFI.

Actual Results:
   The EFI FB fails to load and display output.  System fails to display an=
y output until nouveaufb loads.  When booting using the Gentoo minCD, this =
makes the system largely unusable.

Additional information:

Tested using Gentoo's app-emulation/qemu-3.0.0 version.  Bug report:
https://bugs.gentoo.org/669880

I also tested qemu at git commit
179f9ac887973c818b2578bd79fa3ed2522657d4.  Configuration log for the
build will be attached.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "configuraton log for qemu build at git commit 179f9ac=
887973c818b2578bd79fa3ed2522657d4"
   https://bugs.launchpad.net/bugs/1800401/+attachment/5206599/+files/confi=
g.log

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1800401

Title:
  efifb on Linux guest fails to load when using VGA passthrough

Status in QEMU:
  New

Bug description:
  The EFI framebuffer fails to load when booting a Gentoo guest using
  ovmf + vga_passthrough.  I retested using they system rescue CD and
  saw the same issue, but also noticed that when a second framebuffer
  loads, nouveaufb in my case, the terminal appears.  I have also
  verified that the Gentoo min CD is not hanging at boot as I can type
  'poweroff' after waiting a few minutes and the system responds by
  powering off.  I am unable to reproduce with seabios as I have been
  unable to get vga passthrough to work with that BIOS.

  Steps to Reproduce:
      1. Install qemu and ovmf
      2. Download systemrescuecd-x86-5.3.1.iso
      3. Run qemu using one of the configurations below
      4. Select first boot option in GRUB menu
      5. Wait 30 seconds
      6. Press enter # System rescue is prompting for the keymap between st=
eps 5 and 6
      7. Wait 2 minutes
      8. Observe fb console
      9. Note lack of output until very late in boot process
     10. Check dmesg
     11. Note efifb failed to load (invalid address)
     12. Note nouveaufb started late in boot process =


  Expected Results:
     The EFI FB to load and display output to monitor.  This is the behavio=
r I see when booting the host system via UEFI.

  Actual Results:
     The EFI FB fails to load and display output.  System fails to display =
any output until nouveaufb loads.  When booting using the Gentoo minCD, thi=
s makes the system largely unusable.

  Additional information:

  Tested using Gentoo's app-emulation/qemu-3.0.0 version.  Bug report:
  https://bugs.gentoo.org/669880

  I also tested qemu at git commit
  179f9ac887973c818b2578bd79fa3ed2522657d4.  Configuration log for the
  build will be attached.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1800401/+subscriptions
