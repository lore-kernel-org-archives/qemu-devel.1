Received: from eggs.gnu.org ([2001:4830:134:3::10]:42117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3MsL-0003AC-D7
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3MsH-000892-9X
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:20:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:59149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3MsG-00088t-TW
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:20:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3MsE-00059Q-Tc
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 13:20:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7A5952E80D7
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 13:20:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Apr 2017 13:12:51 -0000
From: leon <lyan@suse.com>
Reply-To: Bug 1686390 <1686390@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170426131252.6340.68549.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1686390] [NEW] vnc server closed socket after
 arrow "down" keyevent
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

This is a rewrite for https://bugs.launchpad.net/qemu/+bug/1670377

QEMU 2.6 or later
tigervncviwer 1.6  =


Once get into grub boot interface(choose boot os, or recovery mode),
keep pressing arrow down button for couple times, qemu will close the
connection, vnc used zrle mode.

Interesting place:
1. when stopped at grub interface, only arrow up and down key could trigger=
 it, =

2.  only in zrle or tight mode, could work well in raw mode
2. it only triggered by remote connection, not happen if local vncviewer an=
d vnc server


A trace is attached.

Thanks

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "qemu trace file"
   https://bugs.launchpad.net/bugs/1686390/+attachment/4868238/+files/trace=
.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1686390

Title:
  vnc server closed socket after arrow "down" keyevent

Status in QEMU:
  New

Bug description:
  This is a rewrite for https://bugs.launchpad.net/qemu/+bug/1670377

  QEMU 2.6 or later
  tigervncviwer 1.6  =


  Once get into grub boot interface(choose boot os, or recovery mode),
  keep pressing arrow down button for couple times, qemu will close the
  connection, vnc used zrle mode.

  Interesting place:
  1. when stopped at grub interface, only arrow up and down key could trigg=
er it, =

  2.  only in zrle or tight mode, could work well in raw mode
  2. it only triggered by remote connection, not happen if local vncviewer =
and vnc server

  =

  A trace is attached.

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1686390/+subscriptions
