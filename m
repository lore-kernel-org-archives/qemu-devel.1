Received: from eggs.gnu.org ([2001:4830:134:3::10]:39914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etbPm-0003jK-OH
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etbPi-0007iq-Rs
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:55:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46552 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etbPi-0007hg-KP
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:55:34 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8512338375
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 15:55:30 +0000 (UTC)
Date: Wed, 7 Mar 2018 15:55:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180307155524.GN20201@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180307154258.9313-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307154258.9313-1-kraxel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sdl: workaround bug in sdl 2.0.8 headers
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

On Wed, Mar 07, 2018 at 04:42:57PM +0100, Gerd Hoffmann wrote:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D892087
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


>=20
> diff --git a/configure b/configure
> index 6f3921c02a..86240f97ac 100755
> --- a/configure
> +++ b/configure
> @@ -2874,6 +2874,7 @@ if test "$sdl" !=3D "no" ; then
>  int main( void ) { return SDL_Init (SDL_INIT_VIDEO); }
>  EOF
>    sdl_cflags=3D$($sdlconfig --cflags 2>/dev/null)
> +  sdl_cflags=3D"$sdl_cflags -Wno-undef"  # workaround 2.0.8 bug
>    if test "$static" =3D "yes" ; then
>      if $pkg_config $sdlname --exists; then
>        sdl_libs=3D$($pkg_config $sdlname --static --libs 2>/dev/null)
> --=20
> 2.9.3
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
