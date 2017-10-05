Received: from eggs.gnu.org ([2001:4830:134:3::10]:56070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0BZj-0006Zh-Sg
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0BZg-0003SN-Jd
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:12:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e0BZg-0003Qm-9o
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:12:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 707A7128B
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 19:12:47 +0000 (UTC)
References: <20171005190725.18712-1-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <68e4ca68-75de-6e02-01e0-5e52e8a79742@redhat.com>
Date: Thu, 5 Oct 2017 14:12:45 -0500
MIME-Version: 1.0
In-Reply-To: <20171005190725.18712-1-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mDPB5oxXHLPP3lTWTc9sj47E5LaK8p8lK"
Subject: Re: [Qemu-devel] [PATCH] qemu_opt_print: Remove shadowing opt decl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mDPB5oxXHLPP3lTWTc9sj47E5LaK8p8lK
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com
Message-ID: <68e4ca68-75de-6e02-01e0-5e52e8a79742@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu_opt_print: Remove shadowing opt decl
References: <20171005190725.18712-1-dgilbert@redhat.com>
In-Reply-To: <20171005190725.18712-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/05/2017 02:07 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> opt was declared as a separate local inside the last loop,
> shadowing the local at the top of the function.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  util/qemu-option.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 9b1dc8093b..877c5b4d67 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -766,7 +766,7 @@ void qemu_opts_print(QemuOpts *opts, const char *se=
parator)
>      }
>      for (; desc && desc->name; desc++) {
>          const char *value;
> -        QemuOpt *opt =3D qemu_opt_find(opts, desc->name);
> +        opt =3D qemu_opt_find(opts, desc->name);
> =20
>          value =3D opt ? opt->str : desc->def_value_str;
>          if (!value) {
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mDPB5oxXHLPP3lTWTc9sj47E5LaK8p8lK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnWhC4ACgkQp6FrSiUn
Q2qG2gf+MSTjApUXcXFgrTojbb1ZsImvA8rbJueduSjjqlU5HKmy2p7yGJKFpKVm
xr7OAG6DIzv0kX/xfRHIeJZmBtM8oGex1dbewnhmXW+ApHXY45W76UJ38G+byXZe
400RWZNmXY5hgetn+yuRsNmwWJqcuCunMGfmdrs6VcfFF3XyYcW+lfzV23TFMc3F
WV/ax2jsiClAdUFI3+UCjitr3ftYS1pZ2g2GaSOWv2TQSmxHfIsj2M7YFrN6PkUh
TCAsv5i3hz3UCQpzpUec0OL9D+Nv+roM+u8BdIn3xjl/AIOp67M8a7m6bYfq6XbU
kumvYN2AnvW3xYgkeGASoGvXI5UN8w==
=gPVf
-----END PGP SIGNATURE-----

--mDPB5oxXHLPP3lTWTc9sj47E5LaK8p8lK--
