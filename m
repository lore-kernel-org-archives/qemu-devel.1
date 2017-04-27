Received: from eggs.gnu.org ([2001:4830:134:3::10]:39384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3lbH-00071f-0B
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3lbD-0002xq-Rb
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:44:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:59615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3lbD-0002xU-LV
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:44:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3lbC-0008HW-N7
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:44:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 990D92E8025
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 15:44:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Apr 2017 15:32:07 -0000
From: Thomas Huth <1090615@bugs.launchpad.net>
Reply-To: Bug 1090615 <1090615@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121215012237.26117.58146.malonedeb@gac.canonical.com>
Message-Id: <20170427153208.26349.11898.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1090615] Re: RFE: More info in qemu-img info/check
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
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1090615

Title:
   RFE: More info in qemu-img info/check

Status in QEMU:
  New

Bug description:
  Originally filed in Fedora bugzilla:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D861375

  """
  qemu-img info currently give me info like this:

  image: /home/alex/.local/share/gnome-boxes/images/Fedora 16
  file format: qcow2
  virtual size: 11G (11794287616 bytes)
  disk size: 4.5G
  cluster_size: 65536

  In order to figure out the "health" of an image there is some more
  information I would like:

  in-use disk size - I.e the subset of disk size that is not marked as
  unused due to e.g. TRIM operations

  amount of compressed clusters. I.e. "is it useful to re-compress the
  image".

  Fragmentation estimation.

  This would be useful to both sysadmins in general and for automated thing=
s like
  what we want to do in gnome-boxes:
  https://bugzilla.gnome.org/show_bug.cgi?id=3D685032
  """

  As mentioned in the original report, qemu-img check currently has
  fragmentation stats, but only for QED.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1090615/+subscriptions
