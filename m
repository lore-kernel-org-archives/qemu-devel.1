Received: from eggs.gnu.org ([2001:4830:134:3::10]:44268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fUGz1-0003X0-TK
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 15:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fUGyx-0000ZF-Tf
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 15:35:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:51946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fUGyx-0000Z6-NP
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 15:35:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fUGyw-0008D2-Kl
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 19:35:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9C16D2E80C7
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 19:35:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Jun 2018 19:29:00 -0000
From: Thomas Huth <1777252@bugs.launchpad.net>
Reply-To: Bug 1777252 <1777252@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152916202234.7686.15264921741576357687.malonedeb@wampee.canonical.com>
Message-Id: <152917734027.26681.6190895101387091472.malone@gac.canonical.com>
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

I'm sorry, but Solaris is currently unsupported and might get removed in
a future release, see:

 https://wiki.qemu.org/ChangeLog/2.12#Warning:_unsupported_host_systems

So it would be great if you could contribute patches, or find someone
who's willing to maintain QEMU on Solaris.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777252

Title:
  tests/Makefile.include trying to add linking library '-lutil' that
  break the build on Solaris

Status in QEMU:
  New

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
