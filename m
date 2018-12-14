Received: from eggs.gnu.org ([2001:4830:134:3::10]:48453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gXrlj-0000RJ-9B
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gXrle-0005im-9U
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:00:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:49544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gXrle-0005gz-1w
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:00:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gXrlb-0006tE-C1
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 18:00:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5443B2E8078
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 18:00:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Dec 2018 17:51:43 -0000
From: Alan Jones <1808565@bugs.launchpad.net>
Reply-To: Bug 1808565 <1808565@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154480990326.22999.12064081216456974155.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1808565] [NEW] Reading /proc/self/task/<pid>/maps
 is not remapped to the target
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

Seeing this in qemu-user 3.1.0

The code in is_proc_myself which supports remapping of /proc/self/maps
and /proc/<pid>/maps does not support remapping of
/proc/self/task/<pid>/maps or /proc/<pid>/task/<pid>/maps. Extending
is_proc_myself to cover these cases causes the maps to be rewritten
correctly.

These are useful in multithreaded programs to avoid freezing the entire
program to capture the maps for a single tid.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1808565

Title:
  Reading /proc/self/task/<pid>/maps is not remapped to the target

Status in QEMU:
  New

Bug description:
  Seeing this in qemu-user 3.1.0

  The code in is_proc_myself which supports remapping of /proc/self/maps
  and /proc/<pid>/maps does not support remapping of
  /proc/self/task/<pid>/maps or /proc/<pid>/task/<pid>/maps. Extending
  is_proc_myself to cover these cases causes the maps to be rewritten
  correctly.

  These are useful in multithreaded programs to avoid freezing the
  entire program to capture the maps for a single tid.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1808565/+subscriptions
