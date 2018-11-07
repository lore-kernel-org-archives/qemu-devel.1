Received: from eggs.gnu.org ([2001:4830:134:3::10]:41741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gKI9D-0003Nm-P5
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 02:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gKI9A-0002qW-AB
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 02:21:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:55950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gKI99-0002Tr-Qc
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 02:21:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gKI92-0004n0-IX
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 07:20:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9D6862E80CF
	for <qemu-devel@nongnu.org>; Wed,  7 Nov 2018 07:20:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Nov 2018 07:06:15 -0000
From: Berg Lloyd-Haig <berglh@gmail.com>
Reply-To: Bug 1794939 <1794939@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153812537329.31017.17111716065357847976.malonedeb@chaenomeles.canonical.com>
Message-Id: <154157437566.20032.7015190072098086241.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1794939] Re: QEMU does not build with vte v2.91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Bastian,

I got past this error by installing libvte-dev instead of
libvte-2.91-dev.

I'm not sure if it actually works however.

Cheers,
Berg

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1794939

Title:
  QEMU does not build with vte v2.91

Status in QEMU:
  New

Bug description:
  when I build qemu with vte support and vte-2.91 installed I get the
  following deprecation warning:

  error: =E2=80=98vte_terminal_set_encoding=E2=80=99 is deprecated [-Werror=
=3Ddeprecated-declarations]
       vte_terminal_set_encoding(VTE_TERMINAL(vc->vte.terminal), "UTF-8", N=
ULL);
       ^~~~~~~~~~~~~~~~~~~~~~~~~
  In file included from /usr/include/vte-2.91/vte/vte.h:35

  I looked for the commit in vte that deprecated the offending function
  (a17e714d), which led me to the thread:

  https://gitlab.gnome.org/GNOME/vte/issues/3

  It looks like from this version forward vte forces us to use utf-8,
  such that this function call becomes unnecessary in QEMU.

  Cheers,
  Bastian

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1794939/+subscriptions
