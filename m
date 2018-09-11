Received: from eggs.gnu.org ([2001:4830:134:3::10]:39165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzo3d-0004HY-8y
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 15:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fznxA-0008Tp-SK
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 15:04:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fznx6-0008Pw-5B
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 15:03:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id 20-v6so27136351wrb.12
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 12:03:52 -0700 (PDT)
References: <153660698641.24944.17107147595708483311.malonedeb@gac.canonical.com>
	<153668006744.31966.11333457437734513810.malone@soybean.canonical.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <153668006744.31966.11333457437734513810.malone@soybean.canonical.com>
Date: Tue, 11 Sep 2018 20:03:50 +0100
Message-ID: <87r2hzc0vd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1791796] Re: unimplemented thread syscalls in
 nios2 user-mode emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1791796 <1791796@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


Sandra Loosemore <1791796@bugs.launchpad.net> writes:

> If you need a Nios II GNU/Linux toolchain, I think the most recent
> CodeBench Lite release will work:
>
> https://sourcery.mentor.com/GNUToolchain/subscription42545

Hmm I tried automating that but it seems the installer has GTK
dependencies!?

  Setup:
  GTK+ Version Check
  Setup:
  An error has occurred. See the log file
  /root/.mentor/logs/20180911185933/.metadata/.log.
  root@0ef91b5e50f2:/opt# cat /root/.mentor/logs/20180911185933/.metadata/.=
log
  !SESSION 2018-09-11 18:59:36.197 ----------------------------------------=
-------
  eclipse.buildId=3Dunknown
  java.version=3D1.8.0_102
  java.vendor=3DOracle Corporation
  BootLoader constants: OS=3Dlinux, ARCH=3Dx86, WS=3Dgtk, NL=3Den_US
  Framework arguments:  -install.once -install.data=3D/root/.mentor
  Command-line arguments:  -os linux -ws gtk -arch x86 -install.once -insta=
ll.data=3D/root/.mentor -data /root/.mentor/logs/20180911185933

  !ENTRY org.eclipse.osgi 4 0 2018-09-11 18:59:37.407
  !MESSAGE Application error
  !STACK 1
  java.lang.UnsatisfiedLinkError: Could not load SWT library. Reasons:
          /tmp/sourceryg++-2018.05-5-nios2-linux-gnu.bin_sfx.f9eaefb7/insta=
ller/configuration/org.eclipse.osgi/148/0/.cp/libswt-pi-gtk-4530.so: libgtk=
-x11-2.0.so.0: cannot open shared object file: No such file or directory
          no swt-pi-gtk in java.library.path
          Can't load library: /root/.swt/lib/linux/x86/libswt-pi-gtk-4530.so
          Can't load library: /root/.swt/lib/linux/x86/libswt-pi-gtk.so
          /root/.swt/lib/linux/x86/libswt-pi-gtk-4530.so: libgtk-x11-2.0.so=
.0: cannot open shared object file: No such file or directory

Should I just try the tarball approach?

> We're planning on adding user-mode QEMU to the upcoming 2018.11
> release....  that's actually what I've been testing it for.  Results on
> the GCC testsuite actually don't look too bad,

OK - I'm a little surprised given the failures I saw in our own
test/tcg/multiarch but it's totally possible that:

  - the buildroot toolchain if foobar
  - the (ancient) tests need tweaking

but it would be nice if we get to a point that QEMU's internal
linux-user tests also pass.

> but I have a patch I
> haven't submitted yet that's required to make the GDB stub work, and
> there are a lot of GDB test failures I haven't triaged yet.

When you do post the gdb patch feel free to CC me as I've poked around
in that before.

--
Alex Benn=C3=A9e
