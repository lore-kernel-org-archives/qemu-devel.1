Received: from eggs.gnu.org ([2001:4830:134:3::10]:60118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8W1D-0007Qo-Vt
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8W1A-0004eN-Ew
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:11:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8W1A-0004eD-8X
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:11:52 -0400
References: <AM3PR07MB273186AEFA49A506BFC2D28B3B30@AM3PR07MB273.eurprd07.prod.outlook.com>
	<152362403305.1857.2509619226545139975@71c20359a636>
	<AM3PR07MB273FE7C1A9E51037C029754B3B00@AM3PR07MB273.eurprd07.prod.outlook.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c06b13a1-e838-e86a-03f9-a5304080c888@redhat.com>
Date: Tue, 17 Apr 2018 14:11:40 -0500
MIME-Version: 1.0
In-Reply-To: <AM3PR07MB273FE7C1A9E51037C029754B3B00@AM3PR07MB273.eurprd07.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8hle6IGVDS7VXu2g8kge6eyCfTMMzPTDl"
Subject: Re: [Qemu-devel] [PATCH] Show values and description when using
 "qom-list"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Perez Blanco, Ricardo (Nokia - BE/Antwerp)" <ricardo.perez_blanco@nokia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "famz@redhat.com" <famz@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8hle6IGVDS7VXu2g8kge6eyCfTMMzPTDl
From: Eric Blake <eblake@redhat.com>
To: "Perez Blanco, Ricardo (Nokia - BE/Antwerp)"
 <ricardo.perez_blanco@nokia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "famz@redhat.com" <famz@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>
Message-ID: <c06b13a1-e838-e86a-03f9-a5304080c888@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Show values and description when using
 "qom-list"
References: <AM3PR07MB273186AEFA49A506BFC2D28B3B30@AM3PR07MB273.eurprd07.prod.outlook.com>
 <152362403305.1857.2509619226545139975@71c20359a636>
 <AM3PR07MB273FE7C1A9E51037C029754B3B00@AM3PR07MB273.eurprd07.prod.outlook.com>
In-Reply-To: <AM3PR07MB273FE7C1A9E51037C029754B3B00@AM3PR07MB273.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/16/2018 07:00 AM, Perez Blanco, Ricardo (Nokia - BE/Antwerp) wrote:=

> Hi,
>=20
> A new patch (to be rebase on top of my previous one).=20

A patch-to-a-patch doesn't work well.  Instead, run:

git rebase -i origin

then mark the second patch as 'squash' before closing the editor, and
git will merge the two patches into one.  Then resend things with 'v2'
in the subject line, by using 'git send-email -v2 ...'.

More patch submission hints at https://wiki.qemu.org/Contribute/SubmitAPa=
tch

>=20
> From 77f7217c07d5e3892f26082f220954678eb375b3 Mon Sep 17 00:00:00 2001
> From: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
> Date: Mon, 16 Apr 2018 13:51:42 +0200
> Subject: [PATCH] [PATCHv2] Show values and description when using "qom-=
list"
>=20
>     For debugging purposes it is very useful to:

This is not in 'git send-email' format, which makes it harder for our
automated tooling to evaluate your patch.

>      - See the description of the field. This information is already
>        filled
>        in but not shown in "qom-list" command.
>      - Display value of the field. So far, only well known types are
>        implemented (string, str, int, uint, bool).
>=20
> Signed-off-by: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
> ---
>  qmp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/qmp.c b/qmp.c
> index 750b5d0..5be9d8d 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -249,12 +249,14 @@ ObjectPropertyInfoList *qmp_qom_list(const char *=
path, Error **errp)
>          if (g_ascii_strncasecmp(entry->value->type, "int", 3) =3D=3D 0=
) {
>              Error **errp =3D NULL;
>              entry->value->value =3D g_strdup_printf("%ld",
> -                object_property_get_int(obj, entry->value->name, errp)=
);
> +                (long int) object_property_get_int(
> +                    obj, entry->value->name, errp));

This is wrong.  Casting 'int64_t' to 'long int' on a 32-bit platform
silently truncates the value.  You don't want the cast; instead, you
should be using "%"PRId64 in place of "%ld", so that your printf format
always matches the correct spelling corresponding to the 64-bit value
you will be printing.


> -----Original Message-----
> From: no-reply@patchew.org [mailto:no-reply@patchew.org]=20
> Sent: Friday, April 13, 2018 2:54 PM
> To: Perez Blanco, Ricardo (Nokia - BE/Antwerp) <ricardo.perez_blanco@no=
kia.com>
> Cc: famz@redhat.com; qemu-devel@nongnu.org; dgilbert@redhat.com; armbru=
@redhat.com
> Subject: Re: [Qemu-devel] [PATCH] Show values and description when usin=
g "qom-list"
>=20
> Hi,
>=20

Also, you are top-posting, which makes it hard to follow your
conversation.  On technical lists, it is better to reply inline instead
of top-posting, and to trim content that is not essential to your reply.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8hle6IGVDS7VXu2g8kge6eyCfTMMzPTDl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWRuwACgkQp6FrSiUn
Q2oLYAf+LIbzBfYwgsKMFa80LIPy9VhD37tywby2TGvZrzBzFRAoGsiTtZ2QkHb8
YXIMaCXS6J9Bj4YHOHSZajXioUBTfJ6xLSzJ/mhFOBt2R9HLflWUlcA2PHNNq4yV
XA4oAtyI++EJ0zOarHwHqOJnfQWki0olZEZgmKnukyNoW6Oo6/w1LM5mYckcQnNq
rXpsGhF3EZevR3N+1FbY7QMn8Cq4P620jc158HgDsTyCSck/hWFvxDeGet5I6sPH
NrXWsXSpO+XW2MdRVHdGNquSKGtv2mGN+qmzoR117DYabrrDgXHav24FOmNoyWBw
u6SD+JPtmbxyrwVoB09o8BdLh3/aVQ==
=alws
-----END PGP SIGNATURE-----

--8hle6IGVDS7VXu2g8kge6eyCfTMMzPTDl--
