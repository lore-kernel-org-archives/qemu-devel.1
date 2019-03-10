Received: from eggs.gnu.org ([209.51.188.92]:38308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2zOS-0004vF-32
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2zOR-0000Gc-B9
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:25:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:41126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1h2zOP-0000FU-IH
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:25:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1h2zOO-0000Qw-9k
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 14:25:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 46DCE2E8054
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 14:25:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Mar 2019 14:17:52 -0000
From: Tim Schuster <1819343@bugs.launchpad.net>
Reply-To: Bug 1819343 <1819343@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155222747303.16387.17760363757245891386.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1819343] [NEW] Qcow2 image stuck as locked after
 host crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

After a host crash, the qcow2 image of the VM, stored on a remote NFS
share, has become inaccessible. Libvirt/QEMU reports that 'failed to get
"write" lock\nIs another process using the image
[/path/nfs/image.qcow2]?'. No process is accessing the image from either
host or the network share side. There is no obvious way in qemu-img to
force unlocking the file or repair the image (attempting a qemu-img
check with -r all results in qemu-img complaining about the lock and
being unable to do force-share=3Don on anything but readonly images).

I'm currently attempting to fix this by converting the image via 'qemu-
img convert -U -f qcow2 -O qcow2 image.qcow2 image_2.gcow2', though this
will likely take some time.

Using QEMU 3.1.0

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1819343

Title:
  Qcow2 image stuck as locked after host crash

Status in QEMU:
  New

Bug description:
  After a host crash, the qcow2 image of the VM, stored on a remote NFS
  share, has become inaccessible. Libvirt/QEMU reports that 'failed to
  get "write" lock\nIs another process using the image
  [/path/nfs/image.qcow2]?'. No process is accessing the image from
  either host or the network share side. There is no obvious way in
  qemu-img to force unlocking the file or repair the image (attempting a
  qemu-img check with -r all results in qemu-img complaining about the
  lock and being unable to do force-share=3Don on anything but readonly
  images).

  I'm currently attempting to fix this by converting the image via
  'qemu-img convert -U -f qcow2 -O qcow2 image.qcow2 image_2.gcow2',
  though this will likely take some time.

  Using QEMU 3.1.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1819343/+subscriptions
