Received: from eggs.gnu.org ([2001:4830:134:3::10]:50740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f9SVh-0000uw-KG
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f9SVc-0002Kb-Ri
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:39:17 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:42752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tournier.elie@gmail.com>)
	id 1f9SVc-0002JK-Kp
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:39:12 -0400
Received: by mail-wr0-x244.google.com with SMTP id s18-v6so21222613wrg.9
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 02:39:12 -0700 (PDT)
Date: Fri, 20 Apr 2018 10:32:53 +0100
From: Elie Tournier <tournier.elie@gmail.com>
Message-ID: <20180420093253.GA16234@Nikki.localdomain>
References: <20180413135842.21325-1-tournier.elie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413135842.21325-1-tournier.elie@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Use SDL to create an OpenGL ES
 context for virglrenderer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kraxel@redhat.com

On Fri, Apr 13, 2018 at 02:58:39PM +0100, Elie Tournier wrote:
> Hi,
> 
Hello,

Humble ping.
This series is unreviewed.

BR,
Elie

> v2: Rebase on top of master
> v3: Fix the json format (Eric Blake)
>     Move DisplayOptions from ui/sdl2.c to include/ui/sdl2.h (Gerd Hoffmann)
>     Fix a comparison issue (Gerd Hoffmann)
> 
> Currently, virglrenderer [1] support OpenGL ES 2.0 on the guest side
> and OpenGL ES 3.0 on the host side.
> Thanks to this work, we are able to run QEMU on system that only support OpenGL ES.
> 
> The support of OpenGL ES 3.0 on the guest is limited.
> We are working on it, so stay tune!
> For the most curious of you, the development branch is available on
> our gitlab instance [2].
> 
> In order to use this feature in QEMU, we need to create an OpenGL ES context.
> This is possible thanks to the following option `-display sdl,gl=es`.
> 
> Have a nice day,
> Elie
> 
> [1] https://cgit.freedesktop.org/virglrenderer
> [2] https://gitlab.collabora.com/virgl-es/virglrenderer-gles/tree/hacks
> 
> Elie Tournier (3):
>   qapi: Parameter gl of DisplayType now accept an enum
>   sdl: Move DisplayOptions global to sdl2_console
>   sdl: Allow OpenGL ES context creation
> 
>  include/ui/sdl2.h |  1 +
>  qapi/ui.json      | 20 +++++++++++++++++++-
>  qemu-options.hx   |  2 +-
>  ui/sdl2-gl.c      | 19 +++++++++++++++++--
>  ui/sdl2.c         | 10 +++++-----
>  vl.c              | 14 +++++++++-----
>  6 files changed, 52 insertions(+), 14 deletions(-)
> 
> -- 
> 2.17.0
> 
