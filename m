Received: from eggs.gnu.org ([209.51.188.92]:39918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1gmfjL-00039J-Oy
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1gmfjL-0005MZ-2T
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:11:43 -0500
Received: from pv50p00im-tydg10011801.me.com ([17.58.6.52]:46066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1gmfjK-0005LR-SW
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:11:43 -0500
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
From: Chen Zhang <tgfbeta@me.com>
In-Reply-To: <20190124120752.prg7lqmrvnzlqsuc@sirius.home.kraxel.org>
Date: Thu, 24 Jan 2019 22:11:24 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <F7CD54FC-DD59-4224-8FE0-48296D4892CE@me.com>
References: <ab7146dc-4b21-4193-8f3b-109723fbd877@me.com>
	<1A3D7D5F-8D33-4917-B9E5-81B9E215FC43@me.com>
	<20190124120752.prg7lqmrvnzlqsuc@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Hi,

> On Jan 24, 2019, at 8:07 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
>> index 3fc656a..63ffc2d 100644
>> --- a/include/ui/egl-helpers.h
>> +++ b/include/ui/egl-helpers.h
>> @@ -28,6 +28,8 @@ void egl_fb_read(void *dst, egl_fb *src);
>> void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, =
bool flip);
>> void egl_texture_blend(QemuGLShader *gls, egl_fb *dst, egl_fb *src, =
bool flip,
>>                        int x, int y);
>> +void egl_texture_blend2(QemuGLShader *gls, egl_fb *dst, egl_fb *src, =
bool flip,
>> +                        int x, int y, int w, int h);
>=20
> Why do you add egl_texture_blend2()?
> How about adding scale_{x,y} parameters to egl_texture_blend() =
instead?
It is valid to augment parameter list of egl_texture_blend(), however, =
there are=20
two other callers: namely, spicy-display and egl-headless, neither of =
which
seems to scale any underlying viewports. In that case, default scales =
(1.0, 1.0)=20
shall be provided.
>=20
>> +                           vc->gfx.scale_x * =
vc->gfx.cursor_fb.width,
>> +                           vc->gfx.scale_x * =
vc->gfx.cursor_fb.height);
>                                            ^ this should be y I guess =
?
Sorry for this typo.
>=20
> cheers,
>  Gerd
>=20
Best regards,=
