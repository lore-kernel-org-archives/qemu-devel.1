Received: from eggs.gnu.org ([2001:4830:134:3::10]:48475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gX05A-0003A4-V2
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:41:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gX056-0005JZ-Ux
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:41:28 -0500
Received: from indium.canonical.com ([91.189.90.7]:38844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gX056-0005Iu-Oq
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:41:24 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gX055-0005Zu-Ae
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 08:41:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4F68F2E8019
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 08:41:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Dec 2018 08:33:36 -0000
From: Thomas Huth <1794939@bugs.launchpad.net>
Reply-To: Bug 1794939 <1794939@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153812537329.31017.17111716065357847976.malonedeb@chaenomeles.canonical.com>
Message-Id: <154460361683.8781.177727076155882517.malone@gac.canonical.com>
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

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D6415994ffcc6d22b3f5a

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1794939

Title:
  QEMU does not build with vte v2.91

Status in QEMU:
  Fix Released

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
