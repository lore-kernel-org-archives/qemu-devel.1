Received: from eggs.gnu.org ([2001:4830:134:3::10]:50318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gT8n4-0001be-Ot
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 12:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gT8n1-0006GL-Hq
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 12:10:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:45760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gT8n1-0006Fy-CQ
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 12:10:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gT8n0-0000Zy-2o
	for <qemu-devel@nongnu.org>; Sat, 01 Dec 2018 17:10:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 132372E80C8
	for <qemu-devel@nongnu.org>; Sat,  1 Dec 2018 17:10:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Dec 2018 16:57:16 -0000
From: =?utf-8?b?0JrQvtGA0LXQvdCx0LXRgNCzINCc0LDRgNC6?=
	<1806196@bugs.launchpad.net>
Reply-To: Bug 1806196 <1806196@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154368343637.32200.15942853285785778925.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1806196] [NEW] qed leaked clusters
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

There are examples of two QED files which AFAIK does not have any errors
both. But `qemu-img check` says that one of them has 1 leaked cluster.

I wrote my own tool and it does not find any error. Both files attached,
as well as debug output from my program.

Both files are about 4G in size after unpacking. Unpack with `tar -S` to
handle sparse files.

And also, I know, that QED is deprecated, but anyway, seems qemu-img has
bug.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "Example of files"
   https://bugs.launchpad.net/bugs/1806196/+attachment/5217981/+files/bugs.=
tbz2

** Description changed:

- There are example of two QED files which AFAIK does not have errors
+ There are examples of two QED files which AFAIK does not have errors
  both. But qemu-img check say that one of them has 1 leaked cluster.
  =

  I wrote my own tool and it does not find any error. Both files attached,
  as well as debug output from my program.
  =

  Both files are about 4G in size after unpacking. Unpack with tar -S to
  handle sparse files.
  =

  And also, I know, that QED is deprecated, but anyway, seems qemu-img has
  bug.

** Description changed:

- There are examples of two QED files which AFAIK does not have errors
+ There are examples of two QED files which AFAIK does not have any errors
  both. But qemu-img check say that one of them has 1 leaked cluster.
  =

  I wrote my own tool and it does not find any error. Both files attached,
  as well as debug output from my program.
  =

  Both files are about 4G in size after unpacking. Unpack with tar -S to
  handle sparse files.
  =

  And also, I know, that QED is deprecated, but anyway, seems qemu-img has
  bug.

** Description changed:

  There are examples of two QED files which AFAIK does not have any errors
- both. But qemu-img check say that one of them has 1 leaked cluster.
+ both. But `qemu-img check` says that one of them has 1 leaked cluster.
  =

  I wrote my own tool and it does not find any error. Both files attached,
  as well as debug output from my program.
  =

- Both files are about 4G in size after unpacking. Unpack with tar -S to
+ Both files are about 4G in size after unpacking. Unpack with `tar -S` to
  handle sparse files.
  =

  And also, I know, that QED is deprecated, but anyway, seems qemu-img has
  bug.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1806196

Title:
  qed leaked clusters

Status in QEMU:
  New

Bug description:
  There are examples of two QED files which AFAIK does not have any
  errors both. But `qemu-img check` says that one of them has 1 leaked
  cluster.

  I wrote my own tool and it does not find any error. Both files
  attached, as well as debug output from my program.

  Both files are about 4G in size after unpacking. Unpack with `tar -S`
  to handle sparse files.

  And also, I know, that QED is deprecated, but anyway, seems qemu-img
  has bug.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1806196/+subscriptions
