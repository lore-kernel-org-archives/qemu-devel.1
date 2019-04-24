Received: from eggs.gnu.org ([209.51.188.92]:42777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAUb-0000qi-Ms
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAUZ-0004bq-Jm
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:30:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:36290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJAUZ-0004ak-BI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:30:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJAUY-0002pt-Ft
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:30:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 76E9E2E805D
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:30:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 05:22:17 -0000
From: Thomas Huth <1777252@bugs.launchpad.net>
Reply-To: Bug 1777252 <1777252@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152916202234.7686.15264921741576357687.malonedeb@wampee.canonical.com>
Message-Id: <155608333751.14159.15448744509590113955.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777252] Re: tests/Makefile.include trying to add
 linking library '-lutil' that break the build on Solaris
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Problem has been fixed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dd99e97e6912d90a55e9

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777252

Title:
  tests/Makefile.include trying to add linking library '-lutil' that
  break the build on Solaris

Status in QEMU:
  Fix Released

Bug description:
  Building script 'tests/Makefile.include' contains following code
  ```
  ifeq ($(CONFIG_POSIX),y)
  LIBS +=3D -lutil
  endif
  ```

  library -lutil is not available on Solaris, so the building will failed, =
like
  ```
  ld: fatal: library -lutil: not found
  make: *** [SOMEWHERE/src/qemu-2.12.0/rules.mak:121: qemu-nbd] Error 1
  ```

  Commenting those code out fixed the error.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777252/+subscriptions
