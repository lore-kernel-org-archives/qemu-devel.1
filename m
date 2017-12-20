Received: from eggs.gnu.org ([2001:4830:134:3::10]:56798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRnov-00017l-33
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 18:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRnor-0004Mm-Go
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 18:30:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:38936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eRnor-0004MA-Am
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 18:30:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eRnop-00018z-D3
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 23:30:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 46D162E806B
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 23:30:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Dec 2017 23:22:42 -0000
From: Adam Williamson <awilliam@redhat.com>
Reply-To: Bug 1738283 <1738283@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151328724563.26325.11755910452939969450.malonedeb@wampee.canonical.com>
Message-Id: <151381216217.11206.14039217629588873109.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1738283] Re: 'Less than' (<), 'more than' (>),
 and 'pipe' (|) can't be typed via VNC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I found something interesting using showkey in the VM. This is all
assuming en-US everywhere, note. On a US keyboard, "<" is a shifted
comma (shift-,), ">" is a shifted period (shift-.), and "|" is a shifted
backslash (shift-\).

If I run showkey and try the affected characters in virt-manager, the
results are kinda what I'd expect. It reports keycode 42 for the shift
key, keycode 51 for comma key, keycode 52 for period key, and keycode 43
for backslash key. If I do shift-, (to get a <), it shows keycode 42
down, keycode 51 down, keycode 51 up, keycode 42 up - just what you'd
expect. Ditto for > and |: it shows 42d/52d/52u/42u and 42d/43d/43u/42u
in those cases.

But if I do this while typing in tigervnc, it reports something quite
different. Just pressing the keys alone gives the right codes - 51, 52,
43. But when I try the shifted combinations, it reports keycode *86* for
all three keys. That is, so long as shift is held down, pressing the
comma, period or backslash key reports keycode 86 - not 51, 52 or 43.
Somehow this results in the generation of a > character, not sure how.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738283

Title:
  'Less than' (<), 'more than' (>), and 'pipe' (|) can't be typed via
  VNC

Status in QEMU:
  New

Bug description:
  If I start QEMU 2.11 (from
  https://build.opensuse.org/package/show/Virtualization/qemu) VM with
  VNC, I am unable to type following three characters: 'less than' (<),
  'more than' (>), and 'pipe' (|) on en_US QWERTY keyboard. Other
  characters work fine. QEMu version 2.10.1 worked fine.

  /usr/bin/qemu-kvm -m 2048 -cpu kvm64 -drive
  media=3Dcdrom,if=3Dnone,id=3Dcd0,format=3Draw,file=3DOI-hipster-
  minimal-20171031.iso -device ide-cd,drive=3Dcd0 -boot once=3Dd,menu=3Don
  ,splash-time=3D5000 -device usb-ehci -device usb-tablet -smp 1 -enable-
  kvm -vnc :91,share=3Dforce-shared

  The ISO can be downloaded here: https://www.openindiana.org/download/

  Also tried Fedora-Server-dvd-x86_64-25-1.3.iso and it's the same
  situation.

  If I run the same command without '-vnc :91,share=3Dforce-shared',
  everything works just fine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1738283/+subscriptions
