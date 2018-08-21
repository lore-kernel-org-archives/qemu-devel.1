Received: from eggs.gnu.org ([2001:4830:134:3::10]:60771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0nT-0001VO-9y
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0a6-00018m-JX
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:55:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:45408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fs0a6-00017y-Co
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:55:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fs0a5-0006vd-5O
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:55:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 25CFB2E851E
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:55:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Aug 2018 06:43:28 -0000
From: Thomas Huth <965867@bugs.launchpad.net>
Reply-To: Bug 965867 <965867@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120327015624.22022.30085.malonedeb@soybean.canonical.com>
Message-Id: <153483380923.17114.14331215135128188161.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 965867] Re: 9p virtual file system on qemu slow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu-kvm (Ubuntu)
       Status: Confirmed =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/965867

Title:
  9p virtual file system on qemu slow

Status in QEMU:
  Incomplete
Status in qemu-kvm package in Ubuntu:
  Incomplete

Bug description:
  Hi, =

  The 9p virtual file system is slow. Several examples below: =

  ---------------------------------------------------------
  Host for the first time: =

  $ time ls bam.unsorted/
  ...........................
  real    0m0.084s
  user    0m0.000s
  sys     0m0.028s
  --------------------------------------------------
  Host second and following: =


  real    0m0.009s
  user    0m0.000s
  sys     0m0.008s
  ------------------------------------------------------
  VM for the first time: =

  $ time ls bam.unsorted/
  ................................
  real    0m23.141s
  user    0m0.064s
  sys     0m2.156s
  ------------------------------------------------------
  VM for the second time
  real    0m3.643s
  user    0m0.024s
  sys     0m0.424s
  ----------------------------------------------------

  Copy on host: =

  $ time cp 5173T.root.bak test.tmp
  real    0m30.346s
  user    0m0.004s
  sys     0m5.324s

  $ ls -lahs test.tmp
  2.7G -rw------- 1 oneadmin cloud 2.7G Mar 26 21:47 test.tmp

  ---------------------------------------------------
  $ copy on VM for the same file

  time cp 5173T.root.bak test.tmp

  real    5m46.978s
  user    0m0.352s
  sys     1m38.962s

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/965867/+subscriptions
