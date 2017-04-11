Received: from eggs.gnu.org ([2001:4830:134:3::10]:56131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy3NQ-0001Pp-Cx
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 17:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy3NM-0002dc-94
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 17:31:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cy3NM-0002cB-0Y
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 17:31:00 -0400
References: <BM1PR01MB0722EAF9BB6F0804187CF81984000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ced60264-e022-7880-cba5-97afe7976c0e@redhat.com>
Date: Tue, 11 Apr 2017 16:30:55 -0500
MIME-Version: 1.0
In-Reply-To: <BM1PR01MB0722EAF9BB6F0804187CF81984000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hDEoMvw9n65N5BK8GkEb837j5uXa2F3Sb"
Subject: Re: [Qemu-devel] [PATCH] Changed malloc and free to g_malloc and
 g_free in util/envlist.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prerna Garg <Prerna.Garg@live.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hDEoMvw9n65N5BK8GkEb837j5uXa2F3Sb
From: Eric Blake <eblake@redhat.com>
To: Prerna Garg <Prerna.Garg@live.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <ced60264-e022-7880-cba5-97afe7976c0e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Changed malloc and free to g_malloc and
 g_free in util/envlist.c
References: <BM1PR01MB0722EAF9BB6F0804187CF81984000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <BM1PR01MB0722EAF9BB6F0804187CF81984000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2017 03:41 PM, Prerna Garg wrote:
>=20

[Nothing - it was all in the attachment]

> 0003-Changed-malloc-and-free-to-g_malloc-and-g_free-respe.patch
>=20

While attachments are probably okay for a one-shot contribution, if your
intent is to become an active contributor for Outreachy, you'll
definitely want to fix your outgoing mail setup to work with inline
patches sent directly from 'git send-email' rather than forcing everyone
else to deal with your unusual workflow.

>=20
> From f3ee3cf9b69aca86c78ec26468a0b4533744cdad Mon Sep 17 00:00:00 2001
> From: Prerna Garg <prerna.garg@live.com>
> Date: Wed, 12 Apr 2017 02:04:36 +0530
> Subject: [PATCH 3/3] Changed malloc and free to g_malloc and g_free
>  respectively in util/envlist.c file

Is there a patch 1/3 and 2/3 (and if so, where's the cover letter 0/3)?
Or did you mean for this to be a single-patch series, at version 3?
Given that the content has gone by before, I suspect the latter; to
achieve that, use 'git send-email -v3'.

You're also missing a category, and patches should generally favor
imperative tense (think "[apply this patch to] do this") rather than
past tense ("[this patch] did this").  Also, you want the subject line
to be a short how; the commit body can be used for further explanations.
So a better commit message might be:

util: Switch malloc to g_malloc in envlist.c

Also switch matching free to g_free.
Done as one of the suggested bite sized tasks

>=20
> Signed-off-by: Prerna Garg <prerna.garg@live.com>
> ---
>  util/envlist.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/util/envlist.c b/util/envlist.c
> index e86857e..0324fe2 100644
> --- a/util/envlist.c
> +++ b/util/envlist.c
> @@ -25,7 +25,7 @@ envlist_create(void)
>  {
>  	envlist_t *envlist;
> =20
> -	if ((envlist =3D malloc(sizeof (*envlist))) =3D=3D NULL)
> +	if ((envlist =3D g_malloc(sizeof (*envlist))) =3D=3D NULL)
>  		return (NULL);

g_malloc() can't fail (rather, it fails by exit()ing), so any code
checking for NULL is now dead code, and should be cleaned up as part of
the same conversion patch.

> =20
>  	QLIST_INIT(&envlist->el_entries);
> @@ -48,10 +48,10 @@ envlist_free(envlist_t *envlist)
>  		entry =3D envlist->el_entries.lh_first;
>  		QLIST_REMOVE(entry, ev_link);
> =20
> -		free((char *)entry->ev_var);
> -		free(entry);
> +		g_free((char *)entry->ev_var);

Is the cast still necessary?  Are we casting away const?  It's useful to
mention why a cast is present, if it is necessary; otherwise omit it as
part of cleaning up the code.


> @@ -225,7 +225,7 @@ envlist_to_environ(const envlist_t *envlist, size_t=
 *count)
>  	struct envlist_entry *entry;
>  	char **env, **penv;
> =20
> -	penv =3D env =3D malloc((envlist->el_count + 1) * sizeof (char *));
> +	penv =3D env =3D g_malloc((envlist->el_count + 1) * sizeof (char *));=


g_new() is better than g_malloc() if you are going to multiply two
values, to make sure you don't overflow the multiplication.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hDEoMvw9n65N5BK8GkEb837j5uXa2F3Sb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7UsPAAoJEKeha0olJ0Nqv/0H/1aN4NdgT3d6PJ67EbwCurpg
qyq5y0TL0Fp1DsEDvgqsbagaoafMoHW+sYevynzbJo9Znic+tHXGd9r6XpPuhCcJ
ILEExAk0ZReHo5o4Ewk8HoU4xTLSycjv8QUw9aGc2ZPUMk0FN3ixF8baN0Pzkgoh
6LqU5KdmFmBhTJE6uzURQrliDnbxp/EY8TtJqaZDEWjN84H1bXE2BQJuBZ0mNkFW
xLKPEO9+XFFBeHGT1oIhzKLHTtluqNivBVC6mi/pMrBR6dsEu+FuCnZI5cmu3Hjn
RcY/K0DRpZJ11xU3ZNXLBjeTlb30GgoioXQoDP4XWmTjutXFGzXFRjjusHgq9mc=
=WI5J
-----END PGP SIGNATURE-----

--hDEoMvw9n65N5BK8GkEb837j5uXa2F3Sb--
