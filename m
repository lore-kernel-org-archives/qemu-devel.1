Received: from eggs.gnu.org ([2001:4830:134:3::10]:38965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRLdl-00071z-F4
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRLdh-0007B4-Gg
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:20:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:59397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRLdh-0007Ap-6r
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:20:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRLdg-0007v2-3V
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 16:20:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F259F2E80C8
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 16:20:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 16:06:31 -0000
From: dcb <1655700@bugs.launchpad.net>
Reply-To: Bug 1655700 <1655700@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170111160632.21721.91751.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1655700] [NEW] disas/libvixl/vixl/invalset.h:
 possible dodgy code in binary search ?
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


[qemu/disas/libvixl/vixl/invalset.h:442]: (style) Array index 'low' is used=
 before limits check.

Source code is

    while (!IsValid(elements[low]) && (low < high)) ++low;

Also:

qemu/disas/libvixl/vixl/invalset.h:450]: (style) Array index 'middle' is
used before limits check.

The source code is

   while (!IsValid(elements[high]) && (low < high)) --high;

Mind you, these lines of code look similar but didn't get reported:

    while (!IsValid(elements[middle]) && (middle < high - 1)) ++middle;
    while (!IsValid(elements[middle]) && (low + 1 < middle)) --middle;

Given that binary search is notoriously tricky to get correct and a standar=
d C library routine
I am puzzled as to why the standard library routine didn't get used, with o=
f course a custom
comparison function.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1655700

Title:
  disas/libvixl/vixl/invalset.h: possible dodgy code in binary search ?

Status in QEMU:
  New

Bug description:
  =

  [qemu/disas/libvixl/vixl/invalset.h:442]: (style) Array index 'low' is us=
ed before limits check.

  Source code is

      while (!IsValid(elements[low]) && (low < high)) ++low;

  Also:

  qemu/disas/libvixl/vixl/invalset.h:450]: (style) Array index 'middle'
  is used before limits check.

  The source code is

     while (!IsValid(elements[high]) && (low < high)) --high;

  Mind you, these lines of code look similar but didn't get reported:

      while (!IsValid(elements[middle]) && (middle < high - 1)) ++middle;
      while (!IsValid(elements[middle]) && (low + 1 < middle)) --middle;

  Given that binary search is notoriously tricky to get correct and a stand=
ard C library routine
  I am puzzled as to why the standard library routine didn't get used, with=
 of course a custom
  comparison function.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1655700/+subscriptions
