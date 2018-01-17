Received: from eggs.gnu.org ([2001:4830:134:3::10]:58019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1ebp4i-0001Hd-8n
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1ebp4h-0002D9-2F
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:52:24 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tournier.elie@gmail.com>)
	id 1ebp4g-0002Bq-R1
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:52:22 -0500
Received: by mail-wm0-x244.google.com with SMTP id i11so16190195wmf.4
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 06:52:22 -0800 (PST)
From: Elie Tournier <tournier.elie@gmail.com>
Date: Wed, 17 Jan 2018 14:50:27 +0000
Message-Id: <20180117145029.28736-1-tournier.elie@gmail.com>
Subject: [Qemu-devel] [RFC 0/2] Use SDL to create an OpenGL ES context for
 virglrenderer.
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

At Collabora, we are working on adding an OpenGL ES backend on virglrenderer [1].
I submit these patches as an RFC because our work didn't land in virglrenderer yet.
Currently, we support OpenGL ES 2.0 on the guest side and OpenGL ES 3.0 on the host side.
Our plan is to increase the guest support to OpenGL ES 3.0.
Thanks to this work, we are able to run QEMU on system that only support OpenGL ES.

In order to use this feature, we need to create a gles context.
This series add an option (`-display sdl,gles=on`) in the SDL display to create that context.

The source code is available on our gitlab instance.
For virglrenderer [2] and qemu [3].

Feel free to review/comment the series.

Have a nice day,
Elie

[1] https://cgit.freedesktop.org/virglrenderer
[2] https://gitlab.collabora.com/jakob/virglrenderer-gles/tree/hacks
[3] https://gitlab.collabora.com/elie/qemu/tree/gles-option

Elie Tournier (2):
  sdl2: Add gles options
  sdl2: gles option will create a gles context

 include/sysemu/sysemu.h |  1 +
 include/ui/sdl2.h       |  1 +
 qemu-options.hx         |  5 ++++-
 ui/sdl2-gl.c            |  8 ++++++--
 ui/sdl2.c               |  8 ++++++++
 vl.c                    | 12 +++++++++++-
 6 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.15.1
