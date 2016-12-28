Received: from eggs.gnu.org ([2001:4830:134:3::10]:55296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cM5sL-0003PW-U4
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 23:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cM5sI-0003lF-EF
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 23:30:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:43254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cM5sI-0003kn-9F
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 23:30:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cM5sD-0001MU-Il
	for <qemu-devel@nongnu.org>; Wed, 28 Dec 2016 04:29:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BC05D2E80CE
	for <qemu-devel@nongnu.org>; Wed, 28 Dec 2016 04:29:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Dec 2016 04:17:28 -0000
From: Launchpad Bug Tracker <712337@bugs.launchpad.net>
Reply-To: Bug 712337 <712337@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110203094452.31746.13322.malonedeb@wampee.canonical.com>
Message-Id: <20161228041729.17184.86557.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 712337] Re: connecthon basic test5 failed with
 qemu 0.14 on Virtfs path in guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/712337

Title:
  connecthon basic test5 failed with qemu 0.14 on Virtfs path in guest

Status in QEMU:
  Expired

Bug description:
  connecthon basic test named test5 is failing with bigfile write failed
  bad address on .L passthru and .L mapped Virtfs path in guest. with
  fedora12

  Bug is with latest qemu-0.14.0-rc0

  connecthon tarball /root/project_CI/client/tests/connecthon/cthon04.tgz
  02/03 08:55:09 INFO |kvm_subpro:0880| 11:55:08 ERROR| [stderr] 	./test5: =
(/root/mount3/test2011-02-0311:55) 'bigfile' write failed : Bad address
  02/03 08:55:09 INFO |kvm_subpro:0880| 11:55:08 ERROR| Test failed: Comman=
d <./runtests -N 100 -b -t /root/mount3/test2011-02-0311:55> failed, rc=3D1=
, Command returned non-zero exit status
  02/03 08:55:09 INFO |kvm_subpro:0880| * Command: =

  02/03 08:55:09 INFO |kvm_subpro:0880|     ./runtests -N 100 -b -t /root/m=
ount3/test2011-02-0311:55
  02/03 08:55:09 INFO |kvm_subpro:0880| Exit status: 1
  02/03 08:55:09 INFO |kvm_subpro:0880| Duration: 0
  02/03 08:55:09 INFO |kvm_subpro:0880| =

  02/03 08:55:09 INFO |kvm_subpro:0880| stdout:
  02/03 08:55:09 INFO |kvm_subpro:0880| ... Pass 1 ...
  02/03 08:55:09 INFO |kvm_subpro:0880| =

  02/03 08:55:09 INFO |kvm_subpro:0880| Starting BASIC tests: test director=
y /root/mount3/test2011-02-0311:55 (arg: -t)
  02/03 08:55:09 INFO |kvm_subpro:0880| =

  02/03 08:55:09 INFO |kvm_subpro:0880| ./test1: File and directory creatio=
n test
  02/03 08:55:09 INFO |kvm_subpro:0880| 	created 155 files 62 directories 5=
 levels deep in 0.6  seconds
  02/03 08:55:09 INFO |kvm_subpro:0880| 	./test1 ok.
  02/03 08:55:09 INFO |kvm_subpro:0880| =

  02/03 08:55:09 INFO |kvm_subpro:0880| ./test2: File and directory removal=
 test
  02/03 08:55:09 INFO |kvm_subpro:0880| 	removed 155 files 62 directories 5=
 levels deep in 0.4  seconds
  02/03 08:55:09 INFO |kvm_subpro:0880| 	./test2 ok.
  02/03 08:55:09 INFO |kvm_subpro:0880| =

  02/03 08:55:09 INFO |kvm_subpro:0880| ./test3: lookups across mount point
  02/03 08:55:09 INFO |kvm_subpro:0880| 	500 getcwd and stat calls in 0.0  =
seconds
  02/03 08:55:09 INFO |kvm_subpro:0880| 	./test3 ok.
  02/03 08:55:09 INFO |kvm_subpro:0880| =

  02/03 08:55:09 INFO |kvm_subpro:0880| ./test4: setattr, getattr, and look=
up
  02/03 08:55:09 INFO |kvm_subpro:0880| 	1000 chmods and stats on 10 files =
in 0.24 seconds
  02/03 08:55:09 INFO |kvm_subpro:0880| 	./test4 ok.
  02/03 08:55:09 INFO |kvm_subpro:0880| =

  02/03 08:55:09 INFO |kvm_subpro:0880| ./test5: read and write
  02/03 08:55:09 INFO |kvm_subpro:0880| basic tests failed
  02/03 08:55:09 INFO |kvm_subpro:0880| stderr:
  02/03 08:55:09 INFO |kvm_subpro:0880| 	./test5: (/root/mount3/test2011-02=
-0311:55) 'bigfile' write failed : Bad address
  02/03 08:55:09 INFO |kvm_subpro:0880| 11:55:08 INFO | Test finished after=
 1 iterations.
  02/03 08:55:10 INFO |kvm_subpro:0880| 11:55:09 ERROR| child process failed
  02/03 08:55:10 INFO |kvm_subpro:0880| 11:55:09 INFO | 		FAIL	connecthon.i=
tera-pass-dotl-100-test-bt	connecthon.itera-pass-dotl-100-test-bt	timestamp=
=3D1296752109

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/712337/+subscriptions
