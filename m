Received: from eggs.gnu.org ([2001:4830:134:3::10]:52281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fFmJK-0006rL-JH
	for qemu-devel@nongnu.org; Mon, 07 May 2018 16:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fFmJH-0007T7-N2
	for qemu-devel@nongnu.org; Mon, 07 May 2018 16:00:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:46270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fFmJH-0007SQ-GC
	for qemu-devel@nongnu.org; Mon, 07 May 2018 16:00:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fFmJG-00044d-Im
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 20:00:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 896762E8052
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 20:00:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 May 2018 19:47:44 -0000
From: Thomas Huth <1450891@bugs.launchpad.net>
Reply-To: Bug 1450891 <1450891@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150501192402.29629.66945.malonedeb@wampee.canonical.com>
Message-Id: <152572246507.22033.1802736368743565878.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1450891] Re: VM will not resume on GlusterFS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Marking as "Won't Fix" according to the last comment.

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1450891

Title:
  VM will not resume on GlusterFS

Status in QEMU:
  Won't Fix

Bug description:
  oVirt uses libvirt to run QEMU.
  Images are passed to QEMU as files, not file descriptors.
  When running images from a GlusterFS, the file descriptors may get invali=
dated because of network problems or the glusterfs process being restarted.
  In this case, the VM goes into paused state.
  When trying to resume the VM ('cont' command), QEMU uses the same invalid=
ated file descriptors throwing a:
  "block I/O error in device 'drive-virtio-disk0': Transport endpoint is no=
t connected (107)".

  Please check file-descriptors and reopen image file on 'cont' event in QE=
MU.
  Thanks.

  References:

  [1] http://lists.nongnu.org/archive/html/qemu-devel/2015-03/msg01269.html
  [2] https://bugzilla.redhat.com/show_bug.cgi?id=3D1058300

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1450891/+subscriptions
