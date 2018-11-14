Received: from eggs.gnu.org ([2001:4830:134:3::10]:32956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMvtR-0005PV-S4
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMvtN-0007gp-2e
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:11:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMvtM-0007g7-TW
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:11:41 -0500
Date: Wed, 14 Nov 2018 14:11:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181114141134.GG19298@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-36-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114123643.24091-36-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 35/41] slirp: NULL is defined by
 glib (at least)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

NULL is defined in stddef.h for at least 15 years AFAICT, so
even glib shouldn't bother to define it :-)  So I'd suggest
changing $subject to just defer to stddef.h

On Wed, Nov 14, 2018 at 04:36:37PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  slirp/slirp.h | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

>=20
> diff --git a/slirp/slirp.h b/slirp/slirp.h
> index 4356b2f427..2a61a85995 100644
> --- a/slirp/slirp.h
> +++ b/slirp/slirp.h
> @@ -199,10 +199,6 @@ struct Slirp {
>      void *opaque;
>  };
> =20
> -#ifndef NULL
> -#define NULL (void *)0
> -#endif
> -
>  void if_start(Slirp *);
> =20
>  int get_dns_addr(struct in_addr *pdns_addr);
> --=20
> 2.19.1.708.g4ede3d42df
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
