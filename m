Received: from eggs.gnu.org ([2001:4830:134:3::10]:35878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjrx7-0005R8-De
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjrx6-0005j9-Iw
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:29:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjrx6-0005i8-A0
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:29:16 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6558CC057FA4
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 18:29:16 +0000 (UTC)
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-7-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a0b8822-aa82-64e6-68f8-d0e63436ab76@redhat.com>
Date: Fri, 3 Mar 2017 12:29:13 -0600
MIME-Version: 1.0
In-Reply-To: <1488544368-30622-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XLCSpTWM2Rf5h9GOVoawSAU6A6axtVGij"
Subject: Re: [Qemu-devel] [PATCH v4 06/28] qapi-introspect: Mangle --prefix
 argument properly for C
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XLCSpTWM2Rf5h9GOVoawSAU6A6axtVGij
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <6a0b8822-aa82-64e6-68f8-d0e63436ab76@redhat.com>
Subject: Re: [PATCH v4 06/28] qapi-introspect: Mangle --prefix argument
 properly for C
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
 <1488544368-30622-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1488544368-30622-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 06:32 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi-introspect.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

I'm guessing we haven't seen a use of a prefix that matters yet, but
that an upcoming patch triggered a compilation failure without this fix.
 Mentioning that in the commit message wouldn't hurt.

>=20
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index 541644e..fb72c61 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -64,7 +64,7 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaVisito=
r):
>          # generate C
>          # TODO can generate awfully long lines
>          jsons.extend(self._jsons)
> -        name =3D prefix + 'qmp_schema_json'
> +        name =3D c_name(prefix, protect=3DFalse) + 'qmp_schema_json'
>          self.decl =3D mcgen('''
>  extern const char %(c_name)s[];
>  ''',
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XLCSpTWM2Rf5h9GOVoawSAU6A6axtVGij
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYubX5AAoJEKeha0olJ0NqYyAIAJBqo5HOl0QnbZ90SHPQqeUW
bJGsBV5SKDl1uj8CIxisj/EzCj62R9ohPQiWMRlP/F1Px4Io7j+gKFMDYIxcV6Jf
6o1MnxUxwpoGstWSfZAW8QzEn1QwLoH7Bs/ntUwJyUTfywodJXUC0pmjQRSI/4dd
HUtWK6ZPEWYDr7Slhh78/7Z2HnF6z5XDetswSzDVxIFUAVIcuAJeIqbVYSZPrjuZ
wlvPn/lsWHSPjEXGSuO865JoVJTv8dbTyMjtpfKqWDi64qJW54f6901/MnvuJHrK
f0Yoo938dWdneUYEs2u5sOKh31J455FNmyB41QqySiAXug1YsIZpZXkfpKRMfsI=
=WrGz
-----END PGP SIGNATURE-----

--XLCSpTWM2Rf5h9GOVoawSAU6A6axtVGij--
