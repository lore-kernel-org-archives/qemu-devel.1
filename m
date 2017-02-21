Received: from eggs.gnu.org ([2001:4830:134:3::10]:37721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cgAcL-0006mH-BX
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cgAcK-0002Mu-Do
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:36:33 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cgAcK-0002MX-2R
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:36:32 -0500
Received: by mail-lf0-x244.google.com with SMTP id 90so3641856lfr.3
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 05:36:31 -0800 (PST)
MIME-Version: 1.0
References: <1487682332-29154-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487682332-29154-1-git-send-email-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Feb 2017 13:36:19 +0000
Message-ID: <CAJ+F1C+djF=11xOhrSgYB9b41d0ARN1f7qDj673imMz8KM-2sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: fix double free issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Tue, Feb 21, 2017 at 5:34 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Reported by Coverity: CID 1371242, 1371243, 1371244.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


---
>  ui/vnc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 62e85ed..51f4b30 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3181,6 +3181,7 @@ static void vnc_display_close(VncDisplay *vd)
>      g_free(vd->lsock);
>      g_free(vd->lsock_tag);
>      vd->lsock =3D NULL;
> +    vd->lsock_tag =3D NULL;
>      vd->nlsock =3D 0;
>
>      for (i =3D 0; i < vd->nlwebsock; i++) {
> @@ -3192,6 +3193,7 @@ static void vnc_display_close(VncDisplay *vd)
>      g_free(vd->lwebsock);
>      g_free(vd->lwebsock_tag);
>      vd->lwebsock =3D NULL;
> +    vd->lwebsock_tag =3D NULL;
>      vd->nlwebsock =3D 0;
>
>      vd->auth =3D VNC_AUTH_INVALID;
> @@ -3204,6 +3206,7 @@ static void vnc_display_close(VncDisplay *vd)
>      vd->tlsaclname =3D NULL;
>      if (vd->lock_key_sync) {
>          qemu_remove_led_event_handler(vd->led);
> +        vd->led =3D NULL;
>      }
>  }
>
> --
> 1.8.3.1
>
>
> --
Marc-Andr=C3=A9 Lureau
