Received: from eggs.gnu.org ([2001:4830:134:3::10]:44343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYUQu-0004Nw-07
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYUQq-0004gF-21
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:45:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYUQp-0004fG-SX
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:45:43 -0400
References: <20180626143538.5390-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f085e4db-2409-ec41-b3b6-32ec1025d151@redhat.com>
Date: Thu, 28 Jun 2018 12:45:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180626143538.5390-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] blogposts: add post about the new
 check-tcg infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 26/06/2018 16:35, Alex Benn=C3=A9e wrote:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Pushed with a little bit of editing, thanks!

diff --git a/_posts/2018-06-21-tcg-testing.md b/_posts/2018-06-28-tcg-tes=
ting.md
similarity index 83%
rename from _posts/2018-06-21-tcg-testing.md
rename to _posts/2018-06-28-tcg-testing.md
index e61312e..026e726 100644
--- a/_posts/2018-06-21-tcg-testing.md
+++ b/_posts/2018-06-28-tcg-testing.md
@@ -7,39 +7,39 @@ author: Alex Benn=C3=83=C2=A9e
 categories: [testing, docker, compilation, tcg]
 ---
=20
-Ever since I started working on QEMU there was a small directory
-called tests/tcg that was in a perpetually broken state. It contains
+Ever since I started working on QEMU, a small directory
+called `tests/tcg` has been in a perpetually broken state. It contains
 tests that exercise QEMU's ability to work across architectures using
 the power of the Tiny Code Generator. However as these tests needed to
 be compiled for the *guest* architectures and not the *host*
-architecture - known as cross-compiling - most developers never ran
-them. As the tests were hardly ever built inevitably a certain amount
-of bit-rot set in.
+architecture&mdash;this is known as cross-compiling&mdash;most developer=
s
+never ran them. As the tests were hardly ever built inevitably a certain
+amount of bit-rot set in.
=20
 # Cross Compilers
=20
-In the old days cross-compilation setups were almost all hand-crafted
+In the old days, cross-compilation setups were almost all hand-crafted
 affairs which involved building versions of binutils, gcc and a basic
-libc. If you couldn't get someone to give you a pre-built tarball it
+libc. If you couldn't get someone to give you a pre-built tarball, it
 was something you laboured through once and hopefully never had to
 touch again. There were even dedicated scripts like crosstool-ng which
 attempted to make the process of patching and configuring your
 toolchain easier.
=20
 While the distributions have improved their support for cross
-compilers over the years there are still plenty of variations in how
+compilers over the years, there are still plenty of variations in how
 they are deployed. It is hard for a project like QEMU which has to
 build on a wide range of operating systems and architectures to
 seamlessly use any given distributions compiler setup. However for
-those with cross compilers to hand `configure` now accepts two
+those with cross compilers at hand `configure` now accepts two
 additional flags:
=20
     --cross-cc-$(ARCH)
     --cross-cc-flags-$(ARCH)
=20
 With a compiler specified for each guest architecture you want to test
-the build system can now build and run the tests. However for
-developers that don't have cross compilers around they can now take
+the build system can now build and run the tests. For
+developers that don't have cross compilers around, they can take
 advantage of QEMU's docker images.
=20
 # Enter Docker Containers
@@ -66,11 +66,11 @@ instead of tracking down a piece of ARM hardware to a=
ctually build on.
 Run `make docker` in your source tree to see the range of builds and
 tests it can support.
=20
-# make check-tcg
+# `make check-tcg`
=20
 With the latest work [merged into
 master](https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Dde44c044420d11=
39480fa50c2d5be19223391218) we can now
-take advantage of both hand configured and docker based cross
+take advantage of either hand-configured and Docker-based cross
 compilers to build test cases for TCG again. To run the TCG tests
 after you have built QEMU:
=20
@@ -79,16 +79,16 @@ after you have built QEMU:
 and the build system will build and run all the tests it can for your
 configured targets.
=20
-# Rules for tests/tcg
+# Rules for `tests/tcg`
=20
 So now we have the infrastructure in place to add new tests what rules
 need to be followed to add new tests?=20
=20
-Well the first thing to note is currently all the tests are for
-linux-user versions of QEMU. This means the tests are all currently
+Well the first thing to note is currently all the tests are for the
+`linux-user` variant of QEMU. This means the tests are all currently
 user-space tests that have access to the Linux syscall ABI.
=20
-Another thing to note is the tests are standalone from the rest of the
+Another thing to note is the tests are separate from the rest of the
 QEMU test infrastructure. To keep things simple they are compiled as
 standalone "static" binaries. As the cross-compilation setup can be
 quite rudimentary for some of the rarer architectures we only compile
@@ -99,10 +99,10 @@ glibc so shouldn't be a problem.
 Finally when writing new tests consider if it really is architecture
 specific or can be added to `tests/tcg/multiarch`. The multiarch tests
 are re-built for every supported architecture and should be the
-default place for anything explicitly testing syscalls and other
+default place for anything that tests syscalls or other
 common parts of the code base.
=20
-# What's Next
+# What's next
=20
 My hope with this work is we can start adding more tests to
 systematically defend functionality in linux-user. In fact I hope the
@@ -135,5 +135,3 @@ status over a simple serial link which will need to b=
e parsed and
 handled in custom versions of the
 [`run-%:`](https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dtests/tcg/Mak=
efile;h=3Dbf064153900a438e4ad8e2d79eaaac8a27d66062;hb=3DHEAD#l95)
 rule.
-
-
