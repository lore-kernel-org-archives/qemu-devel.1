Received: from eggs.gnu.org ([2001:4830:134:3::10]:60686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fo66V-00057p-4O
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fo66Q-0000La-7Y
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:01:15 -0400
Received: from indium.canonical.com ([91.189.90.7]:52796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fo66Q-0000KW-0y
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:01:10 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fo66N-0007UM-74
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:01:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 29F892E851F
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:01:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Aug 2018 11:52:01 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1768246 <1768246@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152518111080.22177.382728353135880212.malonedeb@soybean.canonical.com>
Message-Id: <153390192129.24330.712803583296920879.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1768246] Re: cpu-exec.c:648: cpu_loop_exec_tb:
 Assertion `use_icount' failed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Still present on git master:

/usr/bin/make -f src/server/CMakeFiles/KF5WaylandServer_autogen.dir/build.m=
ake src/server/CMakeFiles/KF5WaylandServer_autogen.dir/build
make[3]: Entering directory '/<<PKGBUILDDIR>>/obj-sh4-linux-gnu'
make[3]: Entering directory '/<<PKGBUILDDIR>>/obj-sh4-linux-gnu'
[  0%] Automatic MOC for target surfaceExtensionHelper
[  0%] Generating src/KF5Wayland.qch, src/KF5Wayland.tags
cd /<<PKGBUILDDIR>>/obj-sh4-linux-gnu/autotests/server && /usr/bin/cmake -E=
 cmake_autogen /<<PKGBUILDDIR>>/obj-sh4-linux-gnu/autotests/server/CMakeFil=
es/surfaceExtensionHelper_autogen.dir/AutogenInfo.cmake Debian
cd /<<PKGBUILDDIR>>/obj-sh4-linux-gnu/src && cmake -E remove_directory "/<<=
PKGBUILDDIR>>/obj-sh4-linux-gnu/src/KF5Wayland_ECMQchDoxygen"
[  0%] Automatic MOC for target KF5WaylandClient
[  0%] Automatic MOC for target kwaylandScanner
cd /<<PKGBUILDDIR>>/obj-sh4-linux-gnu/src/tools && /usr/bin/cmake -E cmake_=
autogen /<<PKGBUILDDIR>>/obj-sh4-linux-gnu/src/tools/CMakeFiles/kwaylandSca=
nner_autogen.dir/AutogenInfo.cmake Debian
cd /<<PKGBUILDDIR>>/obj-sh4-linux-gnu/src/client && /usr/bin/cmake -E cmake=
_autogen /<<PKGBUILDDIR>>/obj-sh4-linux-gnu/src/client/CMakeFiles/KF5Waylan=
dClient_autogen.dir/AutogenInfo.cmake Debian
[  0%] Automatic MOC for target KF5WaylandServer
cd /<<PKGBUILDDIR>>/obj-sh4-linux-gnu/src/server && /usr/bin/cmake -E cmake=
_autogen /<<PKGBUILDDIR>>/obj-sh4-linux-gnu/src/server/CMakeFiles/KF5Waylan=
dServer_autogen.dir/AutogenInfo.cmake Debian
cd /<<PKGBUILDDIR>>/obj-sh4-linux-gnu/src && cmake -E make_directory "/<<PK=
GBUILDDIR>>/obj-sh4-linux-gnu/src/KF5Wayland_ECMQchDoxygen"
qemu-sh4-static: /root/qemu/accel/tcg/cpu-exec.c:634: cpu_loop_exec_tb: Ass=
ertion `use_icount' failed.
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault
make[3]: *** [autotests/server/CMakeFiles/surfaceExtensionHelper_autogen.di=
r/build.make:61: autotests/server/CMakeFiles/surfaceExtensionHelper_autogen=
] Error 139
make[3]: Leaving directory '/<<PKGBUILDDIR>>/obj-sh4-linux-gnu'
make[2]: *** [CMakeFiles/Makefile2:3729: autotests/server/CMakeFiles/surfac=
eExtensionHelper_autogen.dir/all] Error 2
make[2]: *** Waiting for unfinished jobs....
qemu-sh4-static: /root/qemu/accel/tcg/cpu-exec.c:634: cpu_loop_exec_tb: Ass=
ertion `use_icount' failed.
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault
make[3]: *** [src/client/CMakeFiles/KF5WaylandClient_autogen.dir/build.make=
:61: src/client/CMakeFiles/KF5WaylandClient_autogen] Error 139
make[3]: Leaving directory '/<<PKGBUILDDIR>>/obj-sh4-linux-gnu'
make[2]: *** [CMakeFiles/Makefile2:259: src/client/CMakeFiles/KF5WaylandCli=
ent_autogen.dir/all] Error 2
cd /<<PKGBUILDDIR>>/obj-sh4-linux-gnu/src && /usr/bin/doxygen /<<PKGBUILDDI=
R>>/obj-sh4-linux-gnu/src/KF5Wayland_ECMQchDoxygen.config
qemu-sh4-static: /root/qemu/accel/tcg/cpu-exec.c:634: cpu_loop_exec_tb: Ass=
ertion `use_icount' failed.
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault
make[3]: *** [src/tools/CMakeFiles/kwaylandScanner_autogen.dir/build.make:6=
1: src/tools/CMakeFiles/kwaylandScanner_autogen] Error 139
make[3]: Leaving directory '/<<PKGBUILDDIR>>/obj-sh4-linux-gnu'
make[2]: *** [CMakeFiles/Makefile2:437: src/tools/CMakeFiles/kwaylandScanne=
r_autogen.dir/all] Error 2
qemu-sh4-static: /root/qemu/accel/tcg/cpu-exec.c:634: cpu_loop_exec_tb: Ass=
ertion `use_icount' failed.
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault
make[3]: *** [src/server/CMakeFiles/KF5WaylandServer_autogen.dir/build.make=
:61: src/server/CMakeFiles/KF5WaylandServer_autogen] Error 139
make[3]: Leaving directory '/<<PKGBUILDDIR>>/obj-sh4-linux-gnu'
make[2]: *** [CMakeFiles/Makefile2:347: src/server/CMakeFiles/KF5WaylandSer=
ver_autogen.dir/all] Error 2
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-glaubi=
tz'
Building up file structure...
Insert custom filters...
Insert help data for filter section (1 of 1)...
Insert files...
Warning: The file /<<PKGBUILDDIR>>/obj-sh4-linux-gnu/src/KF5Wayland_ECMQchD=
oxygen/html/dynsections.js does not exist, skipping it...
Insert contents...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1768246

Title:
  cpu-exec.c:648: cpu_loop_exec_tb: Assertion `use_icount' failed.

Status in QEMU:
  New

Bug description:
  OpenJDK no longer works on qemu-sh4, it previously did after #1735384
  was fixed.

  Crash indicates an assertion failure:

  (sid-sh4-sbuild)root@nofan:/# java --version
  qemu-sh4-static: /root/qemu/accel/tcg/cpu-exec.c:648: cpu_loop_exec_tb: A=
ssertion `use_icount' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  Aborted
  (sid-sh4-sbuild)root@nofan:/#

  Haven't bi-sected the issue yet, but will do so later.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1768246/+subscriptions
