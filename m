Received: from eggs.gnu.org ([2001:4830:134:3::10]:52890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f5s4Z-0001l1-KP
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f5s4U-0004U7-PC
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:08:27 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tournier.elie@gmail.com>)
	id 1f5s4U-0004TS-JV
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:08:22 -0400
Received: by mail-wr0-x244.google.com with SMTP id z73so12572642wrb.0
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 05:08:22 -0700 (PDT)
From: Elie Tournier <tournier.elie@gmail.com>
Date: Tue, 10 Apr 2018 13:02:20 +0100
Message-Id: <20180410120222.31845-1-tournier.elie@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Use SDL to create an OpenGL ES context
 for virglrenderer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kraxel@redhat.com, Elie Tournier <tournier.elie@gmail.com>

Hello everyone,

I submitted the v1 of this series before kraxel's display system rework.

Currently, virglrenderer [1] support OpenGL ES 2.0 on the guest side
and OpenGL ES 3.0 on the host side.
Thanks to this work, we are able to run QEMU on system that only support OpenGL ES.

The support of OpenGL ES 3.0 on the guest is limited.
We are working on it, so stay tune!
For the most curious of you, the development branch is available on
our gitlab instance [2].

In order to use this feature in QEMU, we need to create an OpenGL ES context.
This is possible thanks to the following option `-display sdl,gl=es`.

Have a nice day,
Elie

[1] https://cgit.freedesktop.org/virglrenderer
[2] https://gitlab.collabora.com/virgl-es/virglrenderer-gles/tree/hacks

Elie Tournier (2):
  qapi: Parameter gl of DisplayType now accept an enum
  sdl: Allow OpenGL ES context creation

 include/ui/sdl2.h |  1 +
 qapi/ui.json      | 21 ++++++++++++++++++++-
 qemu-options.hx   |  2 +-
 ui/sdl2-gl.c      | 17 +++++++++++++++--
 ui/sdl2.c         |  1 +
 vl.c              | 14 +++++++++-----
 6 files changed, 47 insertions(+), 9 deletions(-)

-- 
2.17.0
