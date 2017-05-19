Received: from eggs.gnu.org ([2001:4830:134:3::10]:37573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBoAs-0007dy-AL
	for qemu-devel@nongnu.org; Fri, 19 May 2017 16:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBoAp-00075l-4k
	for qemu-devel@nongnu.org; Fri, 19 May 2017 16:06:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:60581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dBoAo-00075b-W3
	for qemu-devel@nongnu.org; Fri, 19 May 2017 16:06:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dBoAn-0008Up-T7
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 20:06:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D86F02E8050
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 20:06:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 May 2017 19:47:17 -0000
From: Thomas Huth <917824@bugs.launchpad.net>
Reply-To: Bug 917824 <917824@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120117193053.13476.91530.malonedeb@chaenomeles.canonical.com>
Message-Id: <149522323863.6737.8224365453356880799.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 917824] Re: qemu loops/hangs on extending
 qcow2-diskspace
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
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/917824

Title:
  qemu loops/hangs on extending qcow2-diskspace

Status in QEMU:
  Invalid
Status in qemu-kvm package in Ubuntu:
  Invalid

Bug description:
  system is ubuntu 11-10 with qemu-kvm 0.14.1 (standard dpkg)

  while trying to install a software in a winXP-guest on a nearly empty
  disk within a qcow2-file, qemu stops answering console and vnc.

  gdb on original binary shows, that it doesn't really hang, but seems
  to endless loop

  recompiling the binary with debugging-symbols shows following problem:

  in block/qcow2-cluster.c:777 there's a loop over an allocation-list, but =
instead of stopping somewhere, the "next" points to the current one.
   QLIST_FOREACH(old_alloc, &s->cluster_allocs, next_in_flight) { ... }

  because I'm not firm with qemu-development, I don't know, which
  behaviour would be correct, but simply break this loop doesn't seem to
  work: a few moments later the process is again at this point (tried so
  by setting the register for comparison to 0)

  this situation is continuosly reproducible, but it always take at
  least 10-15min to get there, so please, if you have suggestion which I
  should try and report, try to give as much suggestions as possible in
  one action.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/917824/+subscriptions
