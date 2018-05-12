Received: from eggs.gnu.org ([2001:4830:134:3::10]:57597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fHWYd-0001qm-0x
	for qemu-devel@nongnu.org; Sat, 12 May 2018 11:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fHWYZ-0001FL-UA
	for qemu-devel@nongnu.org; Sat, 12 May 2018 11:35:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:59762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fHWYZ-0001EY-OY
	for qemu-devel@nongnu.org; Sat, 12 May 2018 11:35:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fHWYW-0007zy-SB
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 15:35:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D30DC2E8F43
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 15:35:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 May 2018 15:26:02 -0000
From: =?utf-8?b?0JrQvtGA0LXQvdCx0LXRgNCzINCc0LDRgNC6?=
	<1770859@bugs.launchpad.net>
Reply-To: Bug 1770859 <1770859@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152613876246.1025.17904458639014473926.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1770859] [NEW] qemu-img compare -m option is
 missing
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

Comparing images using multiple streams (like qemu-img convert) maybe
effectively sped up when one of the images (or both) is RBD. qemu-img
convert does it's job perfectly while converting. Please implement the
same for image comparison. Since operations are read-only, -W is
useless, but may be introduced as well for debugging/performance
purposes.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1770859

Title:
  qemu-img compare -m option is missing

Status in QEMU:
  New

Bug description:
  Comparing images using multiple streams (like qemu-img convert) maybe
  effectively sped up when one of the images (or both) is RBD. qemu-img
  convert does it's job perfectly while converting. Please implement the
  same for image comparison. Since operations are read-only, -W is
  useless, but may be introduced as well for debugging/performance
  purposes.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1770859/+subscriptions
