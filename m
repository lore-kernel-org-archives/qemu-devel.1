Received: from eggs.gnu.org ([2001:4830:134:3::10]:42633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHQsp-0003pE-UY
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHQsm-0005Md-SG
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:55:20 -0500
Received: from indium.canonical.com ([91.189.90.7]:60246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cHQsm-0005LV-Mz
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:55:16 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cHQsk-0005aG-4Z
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 07:55:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 133D02E80C1
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 07:55:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Dec 2016 07:45:10 -0000
From: Rowan Potgieter <rowan.potgieter@gmail.com>
Reply-To: Bug 1267520 <1267520@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140109160856.15157.6320.malonedeb@wampee.canonical.com>
Message-Id: <20161215074510.20636.65103.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1267520] Re: Keyboard input not working when the
 "-k en-us" argument is specified.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I can confirm that this issue is still present with:
QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.6)
Kernel: 4.4.0-53-generic

I am using Packer and the QEMU builder and only the \ key was working in
a Windows Guest. I had created folder called "common" to host all the
Windows Powershell scripts and this is causing the issue.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1267520

Title:
  Keyboard input not working when the "-k en-us" argument is specified.

Status in QEMU:
  New

Bug description:
  This bug occurs on qemu compiled with i386_softmmu and x86-64_softmmu on =
linux kernel 3.5.0 (64-bit). (Haven't confirmed this for other targets).
  Whenever I run qemu (both i386 and x86_64) to use the en-us language (eve=
n though it is the default), I get "Warning: no scancode found for keysym X=
" (X is an integer).
  In the disk image I need qemu to run, I had a shell set up.  The shell do=
esn't register keyboard input when the '-k en-us' command line argument is =
set to run qemu. I did not have this problem with earlier versions of qemu.

  Additional information:
  Setting keymaps directory on command line -L doesn't resolve this.
  Bug occurs with on both curses and sdl VGA output.
  I am running qemu on Ubuntu 12.04 and I have not been able see if the bug=
 is distribution-specific. However, I am also experiencing the bug on Kali-=
Linux; another debian based distribution.
  It turns out that all languages reproduce the bug, not just 'en-us'.

  Update: I have narrowed the bug to be attributable to versions later
  than qemu-1.1.2.

  Here's a listing of key being mapped:

  Setting keysym exclam (33) to 258
  Setting keysym at (64) to 259
  Setting keysym numbersign (35) to 260
  Setting keysym dollar (36) to 261
  Setting keysym percent (37) to 262
  Setting keysym asciicircum (94) to 263
  Setting keysym ampersand (38) to 264
  Setting keysym asterisk (42) to 265
  Setting keysym parenleft (40) to 266
  Setting keysym parenright (41) to 267
  Setting keysym minus (45) to 12
  Setting keysym underscore (95) to 268
  Setting keysym equal (61) to 13
  Setting keysym plus (43) to 269
  Setting keysym bracketleft (91) to 26
  Setting keysym braceleft (123) to 282
  Setting keysym bracketright (93) to 27
  Setting keysym braceright (125) to 283
  Setting keysym semicolon (59) to 39
  Setting keysym colon (58) to 295
  Setting keysym apostrophe (39) to 40
  Setting keysym quotedbl (34) to 296
  Setting keysym grave (96) to 41
  Setting keysym asciitilde (126) to 297
  Setting keysym backslash (92) to 43
  Setting keysym bar (124) to 299
  Setting keysym comma (44) to 51
  Setting keysym less (60) to 307
  Setting keysym period (46) to 52
  Setting keysym greater (62) to 308
  Setting keysym slash (47) to 53
  Setting keysym question (63) to 309

  As one can see, the pc-bios/keymaps/common, contaning the QWWERTY
  keys, is not processed in parse_init_keyboard at ui/keymaps.c even
  though the XKB map (keymaps/en-us) includes the file.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1267520/+subscriptions
