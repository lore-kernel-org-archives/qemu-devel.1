Received: from eggs.gnu.org ([2001:4830:134:3::10]:43631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f0nRP-0004nj-Sz
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f0nRM-0001GR-N1
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:11:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:60748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f0nRM-0001CU-H3
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:11:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f0nRK-0005kV-QY
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 12:10:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 949092E80CD
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 12:10:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Mar 2018 12:00:17 -0000
From: Fabiano Rosas <1726733@bugs.launchpad.net>
Reply-To: Bug 1726733 <1726733@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150883054273.17842.2005412492234406727.malonedeb@chaenomeles.canonical.com>
Message-Id: <152215201796.22185.3687546366333162315.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] =?utf-8?b?W0J1ZyAxNzI2NzMzXSBSZTog4oCYcWVtdS1pbWcg?=
 =?utf-8?q?info_replication=3A=E2=80=99_causes_segfault?=
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
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1726733

Title:
  =E2=80=98qemu-img info replication:=E2=80=99 causes segfault

Status in QEMU:
  Fix Committed

Bug description:
  Typing the literal command =E2=80=98qemu-img info replication:=E2=80=99 c=
auses a
  segfault.  Note that =E2=80=98replication:=E2=80=99 is not a filename.

  $ ./qemu-img info replication:
  qemu-img: block.c:2609: bdrv_open_inherit: Assertion `!!(flags & BDRV_O_P=
ROTOCOL) =3D=3D !!drv->bdrv_file_open' failed.
  Aborted (core dumped)

  This was originally found by Han Han and reported in Fedora:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1505652

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1726733/+subscriptions
