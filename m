Received: from eggs.gnu.org ([209.51.188.92]:57343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmgjU-0001TY-Dj
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmgjO-0003cc-Uz
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:15:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmgjO-0003bk-Op
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:15:50 -0500
Date: Thu, 24 Jan 2019 16:15:47 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190124151547.unnnxez3z3wysjvc@sirius.home.kraxel.org>
References: <ab7146dc-4b21-4193-8f3b-109723fbd877@me.com>
	<1A3D7D5F-8D33-4917-B9E5-81B9E215FC43@me.com>
	<20190124120752.prg7lqmrvnzlqsuc@sirius.home.kraxel.org>
	<F7CD54FC-DD59-4224-8FE0-48296D4892CE@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7CD54FC-DD59-4224-8FE0-48296D4892CE@me.com>
Subject: Re: [Qemu-devel] [PATCH]gtk-egl: Blend cursor buffer within a
 scaled viewport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Zhang <tgfbeta@me.com>
Cc: qemu-devel@nongnu.org

On Thu, Jan 24, 2019 at 10:11:24PM +0800, Chen Zhang wrote:
> Hi,
> 
> > On Jan 24, 2019, at 8:07 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > 
> >> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> >> index 3fc656a..63ffc2d 100644
> >> --- a/include/ui/egl-helpers.h
> >> +++ b/include/ui/egl-helpers.h
> >> @@ -28,6 +28,8 @@ void egl_fb_read(void *dst, egl_fb *src);
> >> void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip);
> >> void egl_texture_blend(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip,
> >>                        int x, int y);
> >> +void egl_texture_blend2(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip,
> >> +                        int x, int y, int w, int h);
> > 
> > Why do you add egl_texture_blend2()?
> > How about adding scale_{x,y} parameters to egl_texture_blend() instead?
> It is valid to augment parameter list of egl_texture_blend(), however, there are 
> two other callers: namely, spicy-display and egl-headless, neither of which
> seems to scale any underlying viewports. In that case, default scales (1.0, 1.0) 
> shall be provided.

Yes, these callers can simply set scale_x and scale_y to 1.

cheers,
  Gerd
