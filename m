Received: from eggs.gnu.org ([2001:4830:134:3::10]:34635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRFpn-0000ib-EY
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRFpk-0002i3-9q
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:45:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:48478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fRFpk-0002hp-1L
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:45:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fRFpj-0006l5-1h
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 11:45:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 00B8B2E80C9
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 11:45:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Jun 2018 11:31:41 -0000
From: Thomas Huth <1467240@bugs.launchpad.net>
Reply-To: Bug 1467240 <1467240@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150621112608.24532.97250.malonedeb@gac.canonical.com>
Message-Id: <152845750167.20327.10198078513155275296.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1467240] Re: Regression - bridged networking
 broken for Mac OS X guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Patch had been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D5df6a1855b62dc6535

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1467240

Title:
  Regression - bridged networking broken for Mac OS X guest

Status in QEMU:
  Fix Released

Bug description:
  Using the instructions at
  http://www.contrib.andrew.cmu.edu/~somlo/OSXKVM/ for running Mac OS X
  Snow Leopard under QEMU, bridged networking is broken when using QEMU
  git. The result is that Mac OS X is unable to obtain an IP address
  using DHCP. It works in the latest stable release - QEMU 2.3.0.

  Replace "-netdev user,id=3Dhub0port0" with "-netdev
  bridge,br=3Dbr0,id=3Dhub0port0" when testing bridged networking.

  Bisecting the git repository shows the following bad commit:
  commit a90a7425cf592a3afeff3eaf32f543b83050ee5c
  Author: Fam Zheng <famz@redhat.com>
  Date:   Thu Jun 4 14:45:17 2015 +0800

      tap: Drop tap_can_send

      This callback is called by main loop before polling s->fd, if it retu=
rns
      false, the fd will not be polled in this iteration.

      This is redundant with checks inside read callback. After this patch,
      the data will be sent to peer when it arrives. If the device can't
      receive, it will be queued to incoming_queue, and when the device sta=
tus
      changes, this queue will be flushed.

      Signed-off-by: Fam Zheng <famz@redhat.com>
      Message-id: 1433400324-7358-7-git-send-email-famz@redhat.com
      Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1467240/+subscriptions
