Received: from eggs.gnu.org ([2001:4830:134:3::10]:35969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ettDE-0003T8-1V
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ettDB-0005oZ-06
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:55:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:42704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ettDA-0005mn-PV
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:55:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ettD8-0004VW-Q7
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 10:55:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6D4212E80D6
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 10:55:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Mar 2018 10:42:56 -0000
From: Evangelos Foutras <evangelos@foutrelis.com>
Reply-To: Bug 1754295 <1754295@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152050577611.7417.5009498133217351253.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1754295] [NEW] Incorrect en-us keymap in QEMU 2.11
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

I'm using the latest Arch Linux installation ISO as a live system and
start QEMU with the following command:

$ qemu-system-x86_64 -enable-kvm -boot d -cdrom
~/isos/archlinux-2018.03.01-x86_64.iso -m 512 -vnc :0 -k en-us

Then I use Vinagre to connect to the guest system, boot the default
bootloader option, and type the character '<' at the command prompt. The
guest prints the character '>' instead of the '<' I typed.

I believe this is caused by the updated en-us keymap in QEMU 2.11. [1]

If I start QEMU with `-k en-gb` (or without the -k switch at all), I can
type '<' and get the same character to appear on the guest's command
line. The issue happens with the updated en-us keymap. It is also fixed
if I replace /usr/share/qemu/keymaps/en-us with the old keymap file
(before commit a7815faf).

This problem was originally reported against Packer because we were
seeing '>' characters in place of '<' when using it with the QEMU
builder. [2]

[1] https://github.com/qemu/qemu/commit/a7815faffb2bd594b92aa3542d7b799cc89=
c5414
[2] https://github.com/hashicorp/packer/issues/5769

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1754295

Title:
  Incorrect en-us keymap in QEMU 2.11

Status in QEMU:
  New

Bug description:
  I'm using the latest Arch Linux installation ISO as a live system and
  start QEMU with the following command:

  $ qemu-system-x86_64 -enable-kvm -boot d -cdrom
  ~/isos/archlinux-2018.03.01-x86_64.iso -m 512 -vnc :0 -k en-us

  Then I use Vinagre to connect to the guest system, boot the default
  bootloader option, and type the character '<' at the command prompt.
  The guest prints the character '>' instead of the '<' I typed.

  I believe this is caused by the updated en-us keymap in QEMU 2.11. [1]

  If I start QEMU with `-k en-gb` (or without the -k switch at all), I
  can type '<' and get the same character to appear on the guest's
  command line. The issue happens with the updated en-us keymap. It is
  also fixed if I replace /usr/share/qemu/keymaps/en-us with the old
  keymap file (before commit a7815faf).

  This problem was originally reported against Packer because we were
  seeing '>' characters in place of '<' when using it with the QEMU
  builder. [2]

  [1] https://github.com/qemu/qemu/commit/a7815faffb2bd594b92aa3542d7b799cc=
89c5414
  [2] https://github.com/hashicorp/packer/issues/5769

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1754295/+subscriptions
