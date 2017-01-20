Received: from eggs.gnu.org ([2001:4830:134:3::10]:55842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUb9L-0006Sw-H9
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUb9G-0002eG-Gi
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:30:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:41621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUb9G-0002dv-Ak
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:30:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUb9F-00084J-9N
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 15:30:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 35F2C2E80C7
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 15:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Jan 2017 15:21:41 -0000
From: Bilal Amarni <1658120@bugs.launchpad.net>
Reply-To: Bug 1658120 <1658120@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170120152141.14276.42073.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1658120] [NEW] building with gcc-aarch64-linux-gnu
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

Hi, while trying to build qemu v2.8.0 with gcc-aarch64-linux-gnu cross-
compiler I'm getting the following :


In file included from /usr/include/x86_64-linux-gnu/sys/syscall.h:31:0,
                 from /root/qemu/util/compatfd.c:21:
/root/qemu/util/compatfd.c: In function 'qemu_signalfd':
/root/qemu/util/compatfd.c:103:19: error: '__NR_signalfd' undeclared (first=
 use in this function)
     ret =3D syscall(SYS_signalfd, -1, mask, _NSIG / 8);
                   ^
/root/qemu/util/compatfd.c:103:19: note: each undeclared identifier is repo=
rted only once for each function it appears in
/root/qemu/rules.mak:59: recipe for target 'util/compatfd.o' failed
make: *** [util/compatfd.o] Error 1


I had configured it with :

../configure --target-list=3Dx86_64-linux-user --static --cpu=3Daarch64

And I'm on :

Linux ubuntu-512mb-fra1-01 4.4.0-59-generic #80-Ubuntu SMP Fri Jan 6
17:47:47 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux

Thanks

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1658120

Title:
  building with gcc-aarch64-linux-gnu

Status in QEMU:
  New

Bug description:
  Hi, while trying to build qemu v2.8.0 with gcc-aarch64-linux-gnu
  cross-compiler I'm getting the following :

  =

  In file included from /usr/include/x86_64-linux-gnu/sys/syscall.h:31:0,
                   from /root/qemu/util/compatfd.c:21:
  /root/qemu/util/compatfd.c: In function 'qemu_signalfd':
  /root/qemu/util/compatfd.c:103:19: error: '__NR_signalfd' undeclared (fir=
st use in this function)
       ret =3D syscall(SYS_signalfd, -1, mask, _NSIG / 8);
                     ^
  /root/qemu/util/compatfd.c:103:19: note: each undeclared identifier is re=
ported only once for each function it appears in
  /root/qemu/rules.mak:59: recipe for target 'util/compatfd.o' failed
  make: *** [util/compatfd.o] Error 1

  =

  I had configured it with :

  ../configure --target-list=3Dx86_64-linux-user --static --cpu=3Daarch64

  And I'm on :

  Linux ubuntu-512mb-fra1-01 4.4.0-59-generic #80-Ubuntu SMP Fri Jan 6
  17:47:47 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1658120/+subscriptions
