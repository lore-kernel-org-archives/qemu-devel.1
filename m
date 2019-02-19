Received: from eggs.gnu.org ([209.51.188.92]:54866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw52c-0005Rn-Mn
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw52O-0005Ue-JN
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:02:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gw52M-0005RW-VQ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:02:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7ED2C11DB94
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 13:02:12 +0000 (UTC)
Date: Tue, 19 Feb 2019 13:01:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190219130154.GI7154@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190219124257.3001-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219124257.3001-1-kraxel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] audio: don't build alsa and sdl by
 default on linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, david@redhat.com

On Tue, Feb 19, 2019 at 01:42:57PM +0100, Gerd Hoffmann wrote:
> In case no sound hardware is present both alsa and sdl drivers
> initialize successfully and throw errors later on, i.e. effectively
> the automatic probing doesn't work.  Drop them from the list of
> default audio drivers for linux because of that.
>=20
> Fixes: 6a48541873 audio: probe audio drivers by default
> Buglink: https://bugs.launchpad.net/qemu/+bug/1816052
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index fbd0825488..651b4f7514 100755
> --- a/configure
> +++ b/configure
> @@ -877,7 +877,7 @@ Haiku)
>    LIBS=3D"-lposix_error_mapper -lnetwork $LIBS"
>  ;;
>  Linux)
> -  audio_drv_list=3D"try-pa try-alsa try-sdl oss"
> +  audio_drv_list=3D"try-pa oss"
>    audio_possible_drivers=3D"oss alsa sdl pa"
>    linux=3D"yes"
>    linux_user=3D"yes"

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
