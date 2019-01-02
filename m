Received: from eggs.gnu.org ([208.118.235.92]:35223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gepLt-0001G3-5V
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 17:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gepLk-0001Va-Qf
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 17:51:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:58730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gepLk-0001Jw-JZ
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 17:50:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gepLS-0007wS-De
	for <qemu-devel@nongnu.org>; Wed, 02 Jan 2019 22:50:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 65FC32E80D3
	for <qemu-devel@nongnu.org>; Wed,  2 Jan 2019 22:50:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Jan 2019 22:37:34 -0000
From: Michael <1810343@bugs.launchpad.net>
Reply-To: Bug 1810343 <1810343@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154646865471.19335.9147642402365656970.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1810343] [NEW] qemu-nbd -l and -s options don't
 work together
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

When using qemu-nbd with -l to load a snapshot along with -s to create
new active layer the tool fails to find the snapshot specified on the
command line:

For example the following does not work:
  sudo qemu-nbd -s --load-snapshot=3Dfiles  --connect /dev/nbd0 rootfs.qcow=
2                                   =

  Failed to load snapshot: Can't find snapshot

However, the following option works
  sudo qemu-nbd -s --connect /dev/nbd0 rootfs.qcow2
and so does
  sudo qemu-nbd --load-snapshot=3Dfiles  --connect /dev/nbd0 rootfs.qcow2

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1810343

Title:
  qemu-nbd -l and -s options don't work together

Status in QEMU:
  New

Bug description:
  When using qemu-nbd with -l to load a snapshot along with -s to create
  new active layer the tool fails to find the snapshot specified on the
  command line:

  For example the following does not work:
    sudo qemu-nbd -s --load-snapshot=3Dfiles  --connect /dev/nbd0 rootfs.qc=
ow2                                   =

    Failed to load snapshot: Can't find snapshot

  However, the following option works
    sudo qemu-nbd -s --connect /dev/nbd0 rootfs.qcow2
  and so does
    sudo qemu-nbd --load-snapshot=3Dfiles  --connect /dev/nbd0 rootfs.qcow2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1810343/+subscriptions
