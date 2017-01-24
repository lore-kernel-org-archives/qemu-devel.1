Received: from eggs.gnu.org ([2001:4830:134:3::10]:37405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVsWT-0004hE-V1
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 23:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVsWO-0004vd-VZ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 23:15:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:55947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cVsWO-0004vR-Pf
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 23:15:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cVsWN-00087h-SJ
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 04:15:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C023D2E80C3
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 04:15:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Jan 2017 04:04:51 -0000
From: Kai Cong <1658634@bugs.launchpad.net>
Reply-To: Bug 1658634 <1658634@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170123095738.20994.7212.malonedeb@gac.canonical.com>
	<20170123125039.14311.37116.malone@soybean.canonical.com>
Message-Id: <CAFskaerut+CJgmrY_QXT8zw+mm-vQ5Bg0f6ZVM5UCR3DgusH0Q@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1658634] Re: Can't get correct display with
 latest QEMU and OVMF BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Splash screen and UEFI shell were displayed correctly. Grub2 menu and
Ubuntu login screen also appeared, however the display didn't seem right. I
got very blurry output.

[image: Inline image 1]

With QEMU 2.7.0 and the same OVMF.fd, everything works well.

Please let me know if anything is not clear.

Thanks,
Kai

On Mon, Jan 23, 2017 at 4:50 AM, Laszlo Ersek (Red Hat) <lersek@redhat.com>
wrote:

> (1) What phase of the guest do you get invalid video output in? Do you
> see the TianoCore splash screen? Does the grub2 menu appear?
>
> (2) I cannot reproduce the issue (with a different guest OS anyway); I
> just tried QEMU (at d1c82f7cc344) and OVMF (built from edk2 at
> 7cf59c854f35), with stdvga; this combo works fine.
>
> (3) Can you bisect QEMU from 2.7 through 2.8, using the same OVMF
> binary?
>
> (4) Side point: please *never* use "-bios OVMF.fd"; use two pflash chips
> instead. Libvirt (strongly recommended) will do this for you.
>
> Thanks.
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1658634
>
> Title:
>   Can't get correct display with latest QEMU and OVMF BIOS
>
> Status in QEMU:
>   New
>
> Bug description:
>   I tried to install a Ubuntu 16.04.1 Desktop 64bits with latest QEMU and
> OVMF UEFI BIOS, however I can't get correct display output with default v=
ga
> configuration (-vga std). However, qemu works with a couple of different
> configurations:
>   1. "-vga cirrus" + "-bios OVMF.fd": works
>   2. "-vga std" + non-UEFI bios: works
>
>   The same error with QEMU 2.8.0 release. Everything works well on
>   2.7.0/1.
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1658634/+subscriptions
>


** Attachment added: "image.png"
   https://bugs.launchpad.net/bugs/1658634/+attachment/4808338/+files/image=
.png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1658634

Title:
  Can't get correct display with latest QEMU and OVMF BIOS

Status in QEMU:
  New

Bug description:
  I tried to install a Ubuntu 16.04.1 Desktop 64bits with latest QEMU and O=
VMF UEFI BIOS, however I can't get correct display output with default vga =
configuration (-vga std). However, qemu works with a couple of different co=
nfigurations:
  1. "-vga cirrus" + "-bios OVMF.fd": works
  2. "-vga std" + non-UEFI bios: works

  The same error with QEMU 2.8.0 release. Everything works well on
  2.7.0/1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1658634/+subscriptions
