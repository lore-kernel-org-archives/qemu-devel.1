Received: from eggs.gnu.org ([2001:4830:134:3::10]:37609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ddMDG-0005wm-CI
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 15:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ddMDD-0001Ie-Ha
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 15:55:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:55198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ddMDD-0001Hq-BT
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 15:55:15 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ddMDA-0004sk-NK
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 19:55:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A69712E80C7
	for <qemu-devel@nongnu.org>; Thu,  3 Aug 2017 19:55:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Aug 2017 19:41:53 -0000
From: Thomas Huth <1352130@bugs.launchpad.net>
Reply-To: Bug 1352130 <1352130@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140804043955.26029.21644.malonedeb@gac.canonical.com>
Message-Id: <150178931387.3952.7385132277439570772.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1352130] Re: Feature Request: Add OpenGL/3D
 acceleration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This should now be possible with virgl (see
https://www.kraxel.org/blog/tag/virgl/ for example for some more
details) =3D=3D> Closing this ticket.

** Changed in: qemu
       Status: New =3D> Fix Released

** Changed in: qemu
   Importance: Undecided =3D> Wishlist

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1352130

Title:
  Feature Request: Add OpenGL/3D acceleration support

Status in QEMU:
  Fix Released

Bug description:
  Hello,
  I would like to request that support for OpenGL and 3D acceleration be ad=
ded to QEMU. I am sure it has been discussed before, but at the dawn of a n=
ew century there are a number of possible solutions and I haven't seen anyt=
hing implemented into upstream.

  Options -

  1. VMGL
  http://www.cs.toronto.edu/~andreslc/xen-gl/

  2. Qemu-patch
  http://web.archive.org/web/20110721175015/http://qemu-forum.ipi.fi/viewto=
pic.php?t=3D2984

  3. Wine
  http://www.winehq.com

  3.a. WineD3D links: (Direct3D-on-OpenGL wrapper)
  http://www.virtualbox.org/ticket/3639
  http://www.nongnu.org/wined3d/

  4. DirectX OpenGL Wrapper
  http://sourceforge.net/projects/dxglwrap

  5. Transgaming SwiftShader
  This technology allows software rendering of many DirectX effects.

  6. VMware chose Gallium3D: (12.12.2009)
  http://vmware-svga.svn.sourceforge.net/viewvc/vmware-svga/trunk/doc/gpu-w=
iov.pdf?revision=3D1

  Thank you.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1352130/+subscriptions
