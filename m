Received: from eggs.gnu.org ([2001:4830:134:3::10]:58760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1empRa-0001YA-8Q
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 18:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1empRX-0000y5-KX
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 18:29:30 -0500
Received: from indium.canonical.com ([91.189.90.7]:59362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1empRX-0000xT-EV
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 18:29:27 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1empRW-00038C-FI
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 23:29:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6F67E2E80C8
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 23:29:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2018 23:16:35 -0000
From: Thomas Huth <589315@bugs.launchpad.net>
Reply-To: Bug 589315 <589315@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100603181944.2106.17684.malonedeb@soybean.canonical.com>
Message-Id: <151882299631.16149.2555660512478266799.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 589315] Re: qemu: Improve error reporting when
 migration can't connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: In Progress =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/589315

Title:
  qemu: Improve error reporting when migration can't connect

Status in QEMU:
  Fix Released

Bug description:
  Tested with upstream qemu as of Jun 3 2010

  If the source qemu instance can't connect to the migration destination (s=
ay
  there is no listening QEMU instance, or port is blocked by a firewall), a=
ll we
  get is info migrate -> Migration status: failed. This is all we have to r=
eport
  back to libvirt users if their firewall is misconfigured, which is crappy.

  Ideally, if we can't connect, migration would fail immediately with a rel=
evant
  message and strerror(). More info from 'info migrate' would be nice too, =
no
  idea how this will play with QMP though.

  As a slightly related issue, try entering

  migrate tcp:127.0.0.0:6000

  We get a 'migration failed' error, and then the monitor hangs!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/589315/+subscriptions
