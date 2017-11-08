Received: from eggs.gnu.org ([2001:4830:134:3::10]:60229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCMbX-0002oq-Qy
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCMbS-0000Ae-OB
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:25:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:46800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eCMbS-0000AI-HL
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:24:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eCMbQ-00074x-Kw
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 09:24:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9305C2E8069
	for <qemu-devel@nongnu.org>; Wed,  8 Nov 2017 09:24:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Nov 2017 09:12:42 -0000
From: Richard Henderson <rth@twiddle.net>
Reply-To: Bug 1245703 <1245703@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131028231528.17025.5795.malonedeb@chaenomeles.canonical.com>
Message-Id: <151013236304.5027.16752924388694972885.malone@chaenomeles.canonical.com>
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

I posted a patch a while back that would fix this:

https://patchwork.kernel.org/patch/9512083/

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1245703

Title:
  LD_PREFIX option reads directories recursively in an endless loop

Status in QEMU:
  Confirmed
Status in qemu package in Debian:
  Confirmed

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
