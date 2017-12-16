Received: from eggs.gnu.org ([2001:4830:134:3::10]:45559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQEQD-000622-Pm
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 10:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQEQ9-00057n-Re
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 10:30:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:38788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eQEQ9-00054t-LA
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 10:30:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eQEQ7-0000q6-N3
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 15:30:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ABBE52E80C7
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 15:30:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Dec 2017 15:25:23 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1738545 <1738545@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151343792336.25601.1495072942778945687.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1738545] [NEW] Go binaries panic with "mmap errno
 9" on qemu-user
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

Go binaries panic with "mmap errno 9" on qemu-user.

root@nofan:/# cat hello.go =

package main

import "fmt"

func main() {
    fmt.Println("hello world")
}
root@nofan:/# gccgo-7 hello.go -o hello
root@nofan:/# ./hello =

mmap errno 9
fatal error: mmap

runtime stack:
mmap errno 9
fatal error: mmap
panic during panic

runtime stack:
mmap errno 9
fatal error: mmap
stack trace unavailable
root@nofan:/#

Tested with qemu from git master with Debian unstable for armel.

Same binaries work fine on real hardware.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738545

Title:
  Go binaries panic with "mmap errno 9" on qemu-user

Status in QEMU:
  New

Bug description:
  Go binaries panic with "mmap errno 9" on qemu-user.

  root@nofan:/# cat hello.go =

  package main

  import "fmt"

  func main() {
      fmt.Println("hello world")
  }
  root@nofan:/# gccgo-7 hello.go -o hello
  root@nofan:/# ./hello =

  mmap errno 9
  fatal error: mmap

  runtime stack:
  mmap errno 9
  fatal error: mmap
  panic during panic

  runtime stack:
  mmap errno 9
  fatal error: mmap
  stack trace unavailable
  root@nofan:/#

  Tested with qemu from git master with Debian unstable for armel.

  Same binaries work fine on real hardware.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1738545/+subscriptions
