Received: from eggs.gnu.org ([2001:4830:134:3::10]:53331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDsE2-0004KI-7D
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDsE1-000751-EZ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:50:46 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:32892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dDsE1-00074r-5L
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:50:45 -0400
Received: by mail-lf0-x244.google.com with SMTP id m18so13241225lfj.0
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 05:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20170510202006.31737-1-jjongsma@redhat.com>
In-Reply-To: <20170510202006.31737-1-jjongsma@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 25 May 2017 12:50:32 +0000
Message-ID: <CAJ+F1C+Tr_yK6FzpG4Xiwe=8gtUSc02T1oREc7Ba939y14pDFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spice: Use proper enum type for kbd led
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jonathon Jongsma <jjongsma@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On Thu, May 11, 2017 at 6:16 AM Jonathon Jongsma <jjongsma@redhat.com>
wrote:

> Although the Qemu and spice flags currently have the same value, it
> seems more correct to pass the spice flag values to
> spice_server_kbd_leds(), especially considering that this function
> already makes an effort to convert between the QEMU_*_LED and
> SPICE_KEYBOARD_MODIFIER_* values.
>
> Signed-off-by: Jonathon Jongsma <jjongsma@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  ui/spice-input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/spice-input.c b/ui/spice-input.c
> index 8eeebdb..7fd283b 100644
> --- a/ui/spice-input.c
> +++ b/ui/spice-input.c
> @@ -87,7 +87,7 @@ static void kbd_leds(void *opaque, int ledstate)
>      if (ledstate & QEMU_CAPS_LOCK_LED) {
>          kbd->ledstate |=3D SPICE_KEYBOARD_MODIFIER_FLAGS_CAPS_LOCK;
>      }
> -    spice_server_kbd_leds(&kbd->sin, ledstate);
> +    spice_server_kbd_leds(&kbd->sin, kbd->ledstate);
>  }
>
>  /* mouse bits */
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
