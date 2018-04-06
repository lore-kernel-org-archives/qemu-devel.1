Received: from eggs.gnu.org ([2001:4830:134:3::10]:49437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f4KW9-0000K8-Ir
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 02:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f4KW6-0004IT-D3
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 02:06:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:60118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f4KW6-0004I7-6L
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 02:06:30 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f4KW5-0002jS-CP
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 06:06:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 55EB22E806B
	for <qemu-devel@nongnu.org>; Fri,  6 Apr 2018 06:06:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Apr 2018 05:53:44 -0000
From: Bug Watch Updater <1245703@bugs.launchpad.net>
Reply-To: Bug 1245703 <1245703@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131028231528.17025.5795.malonedeb@chaenomeles.canonical.com>
Message-Id: <152299402506.12149.16281095181244604105.launchpad@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1245703] Re: LD_PREFIX option reads directories
 recursively in an endless loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu (Debian)
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1245703

Title:
  LD_PREFIX option reads directories recursively in an endless loop

Status in QEMU:
  Confirmed
Status in qemu package in Debian:
  Fix Released

Bug description:
  If I run qemu user emulation with -L /path/to/my/sysroot/ in which
  also the proc and dev filesystem is mounted QEMU eats my memory until
  it gets killed by the kernel.

  According to the strace output it follows the symbolic links in the
  proc filesystem running forever in a recursive loop.

  The easiest solution would be to add in the function "add_dir_maybe"
  in the file util/path.c an additional check for symbolic links that it
  don't follow them.

  Also I don't really understand the need of doing this. A lot of
  ressources are wasted everytime QEMU-user is started just by having
  the directory structure in memory. In my case this are more than 20000
  entries which QEMU is loading every time.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1245703/+subscriptions
