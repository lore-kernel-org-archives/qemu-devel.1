Received: from eggs.gnu.org ([2001:4830:134:3::10]:36973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cfkX4-0000Nw-Jb
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cfkX0-0002eP-K7
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:45:22 -0500
Received: from indium.canonical.com ([91.189.90.7]:45999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cfkX0-0002e8-EX
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:45:18 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cfkWz-0000ln-Cj
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:45:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5A3B42E80C2
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:45:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Feb 2017 09:25:56 -0000
From: Thomas Huth <1278166@bugs.launchpad.net>
Reply-To: Bug 1278166 <1278166@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140209195952.1859.2806.malonedeb@soybean.canonical.com>
Message-Id: <20170220092556.5488.11276.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1278166] Re: Last commit to exec.c causes BSOD
 installing WinXP on i386-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this issue with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1278166

Title:
  Last commit to exec.c causes BSOD installing WinXP on i386-softmmu

Status in QEMU:
  Incomplete

Bug description:
  The last commit to exec.c (360e607b88a23d378f6efaa769c76d26f538234d),
  causes a BSOD when trying to install a 32bit Windows XP SP-3 image
  using the pure emulation version of i386-softmmu. A checkout of the
  previous version of the file (commited in
  0169c511554cb0014a00290b0d3d26c31a49818f) solves the problem.
  Nevertheless, this last commit was intented to solve a BSOD when Xen
  was used as a hypervisor.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1278166/+subscriptions
