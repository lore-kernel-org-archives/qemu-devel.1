Received: from eggs.gnu.org ([2001:4830:134:3::10]:49006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elzsd-0002WN-P0
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1elzsa-0001Se-LI
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:25:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:50512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1elzsa-0001SC-Da
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:25:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1elzsZ-00015s-6o
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 16:25:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 17E612E8076
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 16:25:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2018 16:13:28 -0000
From: Thomas Huth <1280961@bugs.launchpad.net>
Reply-To: Bug 1280961 <1280961@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140217055059.2081.68353.malonedeb@gac.canonical.com>
Message-Id: <151862480843.1012.10469490566217323921.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1280961] Re: editing the file when mount the file
 system using 9pfs. it will report fsync failed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing, as this problem has been resolved according to the last
comment.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1280961

Title:
  editing the file when mount the file system using 9pfs. it will report
  fsync failed.

Status in QEMU:
  Fix Released

Bug description:
   I have get a fsync error when I use the 9pfs on the kvm guest. it
  appears when I use vi editor and sysbench. I have not  found the
  reason yet. can you tell something about it?  the attache is the
  picture. and there is no any log which I can provide.

   My qemu version is qemu-kvm-0.13.0, and my  host  linux distributions
  is 2.6.32-431.el6.x86_64 and the guest vm is the same version which
  enable 9pfs and 9pnet support. I use the string of "mount -t 9p -o
  trans=3Dvirtio test_mount /tmp/shared/ -oversion=3D9p2000.L,posixacl" to
  get the file system.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1280961/+subscriptions
