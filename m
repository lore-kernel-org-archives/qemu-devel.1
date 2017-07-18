Received: from eggs.gnu.org ([2001:4830:134:3::10]:34230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXTbf-0000ER-0p
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXTbd-0002jt-VN
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:36:11 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d0832cf-34c8-9c21-f6fd-104738331f14@redhat.com>
Date: Tue, 18 Jul 2017 09:36:02 -0500
MIME-Version: 1.0
In-Reply-To: <1500385286-21142-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qxrq0F5HbJjptewRvb65VKgUlv4r4io29"
Subject: Re: [Qemu-devel] [PATCH for-2.10 02/10] qapi: Use QNull for a more
 regular visit_type_null()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qxrq0F5HbJjptewRvb65VKgUlv4r4io29
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com
Message-ID: <7d0832cf-34c8-9c21-f6fd-104738331f14@redhat.com>
Subject: Re: [PATCH for-2.10 02/10] qapi: Use QNull for a more regular
 visit_type_null()
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1500385286-21142-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 08:41 AM, Markus Armbruster wrote:
> Make visit_type_null() take an @obj argument like its buddies.  This
> helps keeing the next commit simple.

s/keeing/keep/

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/qapi/qobject-output-visitor.c
> @@ -187,7 +187,8 @@ static void qobject_output_type_any(Visitor *v, con=
st char *name,
>      qobject_output_add_obj(qov, name, *obj);
>  }
> =20
> -static void qobject_output_type_null(Visitor *v, const char *name, Err=
or **errp)
> +static void qobject_output_type_null(Visitor *v, const char *name,
> +                                     QNull **obj, Error **errp)
>  {
>      QObjectOutputVisitor *qov =3D to_qov(v);
>      qobject_output_add(qov, name, qnull());

would it be any better to call qobject_output_add(qov, name,
QINCREF(*obj)) here, to ensure we are indeed passing in an appropriate
QNull reference?  But your patch is at least self-consistent in stating
we ignore obj in output visitors.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qxrq0F5HbJjptewRvb65VKgUlv4r4io29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluHNIACgkQp6FrSiUn
Q2rNpQgAkfQcQAMx5kMYMgrzNamC7qG51tw3RpkXZsiRdQS1dsr2E5FI1oprqQrd
p3ZAhYzSIaPcO9glfNUbCQn9x1uuPctSqQI8rLsKKDL3Jo1zhvRhfBkqOf2qg9V9
Q8mP3rE8CJGO5PtJMckSIe5nMEVfHPbGx0zhL9yUTqJYpYQLk6gEF4APMxrBhcGm
DeWcfLTKQl5n2DLNC+gIIV866n7eLoGNatbXAtHPpCJIbvr4VbtLuzvBFqFnRPpi
8HcJrbleCgtW938fOIWTEPSJvBddMj01QOjZDKBoHUh97agx1t2I3PQqDqjRBkG3
ySxmn4vgfI9J3IJqI6s8xFk3xaMsKg==
=F4Mj
-----END PGP SIGNATURE-----

--qxrq0F5HbJjptewRvb65VKgUlv4r4io29--
