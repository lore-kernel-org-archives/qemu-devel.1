Received: from eggs.gnu.org ([2001:4830:134:3::10]:41984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5sg4-0002mK-7c
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5sg1-0007sg-1s
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:47:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52050 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5sg0-0007sP-Uj
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:47:09 -0400
Date: Tue, 10 Apr 2018 14:46:59 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180410124659.wwkgu3pd2zy7huh3@sirius.home.kraxel.org>
References: <20180410120222.31845-1-tournier.elie@gmail.com>
	<20180410120222.31845-3-tournier.elie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410120222.31845-3-tournier.elie@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] sdl: Allow OpenGL ES context
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Elie Tournier <tournier.elie@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Elie Tournier <elie.tournier@collabora.com>

On Tue, Apr 10, 2018 at 01:02:22PM +0100, Elie Tournier wrote:
> Signed-off-by: Elie Tournier <elie.tournier@collabora.com>
> ---
>  include/ui/sdl2.h |  1 +
>  qemu-options.hx   |  2 +-
>  ui/sdl2-gl.c      | 17 +++++++++++++++--
>  ui/sdl2.c         |  1 +
>  vl.c              |  4 ++++
>  5 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> index 51084e6320..8495795e48 100644
> --- a/include/ui/sdl2.h
> +++ b/include/ui/sdl2.h
> @@ -22,6 +22,7 @@ struct sdl2_console {
>      int x, y, w, h;
>      int hidden;
>      int opengl;
> +    DisplayGLMode gl_mode;

I'd suggest to move the "opts" global in sdl2.c to this struct instead,
then you can use scon->opts->gl.

cheers,
  Gerd
