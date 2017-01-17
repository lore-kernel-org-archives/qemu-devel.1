Received: from eggs.gnu.org ([2001:4830:134:3::10]:42934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTYkb-0000IM-VC
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTYkY-0001Ue-Sl
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:44:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:45722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTYkY-0001Tt-MS
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:44:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTYkW-00070U-4i
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:44:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 039C82E80AE
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:44:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 18:30:59 -0000
From: Thomas Huth <1555076@bugs.launchpad.net>
Reply-To: Bug 1555076 <1555076@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160309125301.32371.57906.malonedeb@gac.canonical.com>
Message-Id: <20170117183100.14126.94750.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1555076] Re: Qemu 2.5 dont start with sdl,
 gl=on or gtk, gl=on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Released with version 2.7

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1555076

Title:
  Qemu 2.5 dont start with sdl,gl=3Don or gtk,gl=3Don

Status in QEMU:
  Fix Released

Bug description:
  with this config line =

   qemu-system-i386 -m 2047 -hda /dev/sda3 -display sdl,gl=3Don -sdl -vga v=
irtio -cdrom xenial-desktop-i386.iso =


  =

  i have this exit

  ERROR:ui/console-gl.c:95:surface_gl_create_texture: code should not be
  reached

  same is i use this:

  qemu-system-i386 -m 2047 -hda /dev/sda3 -display gtk,gl=3Don -sdl -vga vi=
rtio -cdrom xenial-desktop-i386.iso =

  ERROR:ui/console-gl.c:95:surface_gl_create_texture: code should not be re=
ached

  =

  My Os i Debian Jessie  on P5020 PPC64 4GB ram GPU RadeonHD .
  Configure gave me gl ok, sdl ok , Virtio and Virgl OK .

  My Mesa are the 11.3 dev ... the same issue was found on oldest and
  stable release of mesa .

  OpenGL vendor string: X.Org
  OpenGL renderer string: Gallium 0.4 on AMD TURKS (DRM 2.43.0)
  OpenGL version string: 2.1 Mesa 11.3.0-devel (git-3146014)
  OpenGL shading language version string: 1.30

  =

  OpenGL ES profile version string: OpenGL ES 2.0 Mesa 11.3.0-devel (git-31=
46014)
  OpenGL ES profile shading language version string: OpenGL ES GLSL ES 1.0.=
16

  =

  Thanks =

  Luigi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1555076/+subscriptions
