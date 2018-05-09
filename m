Received: from eggs.gnu.org ([2001:4830:134:3::10]:49301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGTKT-0006YZ-Tv
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGTKS-0007AQ-Rw
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:56:42 -0400
References: <20180509154949.8206-1-mreitz@redhat.com>
	<20180509154949.8206-2-mreitz@redhat.com>
	<1ae9cbd6-d5c9-6e67-a713-d22c34ac206f@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <049e64c8-67f4-35ff-9aa3-41814bbd3a5b@redhat.com>
Date: Wed, 9 May 2018 19:56:31 +0200
MIME-Version: 1.0
In-Reply-To: <1ae9cbd6-d5c9-6e67-a713-d22c34ac206f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TfA188huKjaLjLEYHEdUTlFlxdsFUBsG7"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] qemu-img: Resolve
 relative backing paths in rebase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TfA188huKjaLjLEYHEdUTlFlxdsFUBsG7
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <049e64c8-67f4-35ff-9aa3-41814bbd3a5b@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PATCH 1/2] qemu-img: Resolve relative
 backing paths in rebase
References: <20180509154949.8206-1-mreitz@redhat.com>
 <20180509154949.8206-2-mreitz@redhat.com>
 <1ae9cbd6-d5c9-6e67-a713-d22c34ac206f@redhat.com>
In-Reply-To: <1ae9cbd6-d5c9-6e67-a713-d22c34ac206f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 19:20, Eric Blake wrote:
> On 05/09/2018 10:49 AM, Max Reitz wrote:
>> Currently, rebase interprets a relative path for the new backing image=

>> as follows:
>> (1) Open the new backing image with the given relative path (thus
>> relative to
>> =C2=A0=C2=A0=C2=A0=C2=A0 qemu-img's working directory).
>> (2) Write it directly into the overlay's backing path field (thus
>> =C2=A0=C2=A0=C2=A0=C2=A0 relative to the overlay).
>>
>> If the overlay is not in qemu-img's working directory, both will be
>> different interpretations, which may either lead to an error somewhere=

>> (either rebase fails because it cannot open the new backing image, or
>> =C2=A0 your overlay becomes unusable because its backing path does not=
 point
>> =C2=A0 to a file), or, even worse, it may result in your rebase being
>> performed for a different backing file than what your overlay will poi=
nt
>> to after the rebase.
>>
>> Fix this by interpreting the target backing path as relative to the
>> overlay, like qemu-img does everywhere else.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1569835
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bl=
k_new_backing =3D blk_new_open(out_baseimg, NULL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ov=
erlay_filename =3D bs->exact_filename[0] ?
>> bs->exact_filename
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 : bs->filename;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ou=
t_real_path =3D g_malloc(PATH_MAX);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> bdrv_get_full_backing_filename_from_filename(overlay_filename,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out_baseimg,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out_real_path,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PATH_MAX,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (local_err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_reportf_err(local_err,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Could not resolve=
 backing
>> filename: ");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
>=20
> Leaks out_real_path.

Well, =E2=80=9Cleaks=E2=80=9D is relative, considering that out: will eff=
ectively exit
the process immediately, but I can=E2=80=99t claim it was on purpose. O:-=
)

(I should have trusted my gut feeling that the single g_free() can=E2=80=99=
t
possibly be enough...)

Max

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bl=
k_new_backing =3D blk_new_open(out_real_path, NULL,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 options, src_flags,
>> &local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_=
free(out_real_path);
>=20
> Otherwise looks good.
>=20



--TfA188huKjaLjLEYHEdUTlFlxdsFUBsG7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrzNk8ACgkQ9AfbAGHV
z0BynggAhn/KjaMj2mfwuZt7tTKxgb0Soh5KN5K3LOgsXRcRcqSj81fgzMmbVzHs
wlOOB2TfRPrhJOvBzncLaK+6HBJ9iYcvtKW7vSVq9xbKMmXAe5zD9m3aQWvdzIjj
hjuAYbx8HVYMDk/meiBMnbnI65y4nwyOmFW+Qo8QTbCBG00N8yL0UYWY/55cWs48
3/QqVNplTWcKRF6U0yYKb1lCcyad6zMe78iGtD6aIVOo32I6XmbZ1xHaz+M+h7mV
PwXOBbRQNAMY9jl7Kze0XFQlJdmEPtRdWprC6wQwqTaoZCPIX9l4JJ9dO+88SY/z
ImlgPkdMOYbQCV4wrZ7jT56IotXQVQ==
=mq8T
-----END PGP SIGNATURE-----

--TfA188huKjaLjLEYHEdUTlFlxdsFUBsG7--
