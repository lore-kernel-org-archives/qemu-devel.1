Received: from eggs.gnu.org ([2001:4830:134:3::10]:50344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciUVj-0004RN-I1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:15:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciUVi-0003C7-K0
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:15:19 -0500
References: <cover.1488220970.git.jcody@redhat.com>
	<fa6a26e1642ad7e593f3a0776a4a021997493f24.1488220970.git.jcody@redhat.com>
	<4b9a328b-5537-d06d-3510-d2d4038347a3@redhat.com>
	<20170227225631.GM25637@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d7f7e312-0f58-d7b2-8756-249bc66361f8@redhat.com>
Date: Mon, 27 Feb 2017 17:15:08 -0600
MIME-Version: 1.0
In-Reply-To: <20170227225631.GM25637@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ol83qVguirae7fLRbbKh6IgDjxKlfoVs3"
Subject: Re: [Qemu-devel] [PATCH v2 3/5] block/rbd: parse all options via
 bdrv_parse_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ol83qVguirae7fLRbbKh6IgDjxKlfoVs3
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 berrange@redhat.com
Message-ID: <d7f7e312-0f58-d7b2-8756-249bc66361f8@redhat.com>
Subject: Re: [PATCH v2 3/5] block/rbd: parse all options via
 bdrv_parse_filename
References: <cover.1488220970.git.jcody@redhat.com>
 <fa6a26e1642ad7e593f3a0776a4a021997493f24.1488220970.git.jcody@redhat.com>
 <4b9a328b-5537-d06d-3510-d2d4038347a3@redhat.com>
 <20170227225631.GM25637@localhost.localdomain>
In-Reply-To: <20170227225631.GM25637@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 04:56 PM, Jeff Cody wrote:

>>>  static BlockDriver bdrv_rbd =3D {
>=20
>>> -    .instance_size      =3D sizeof(BDRVRBDState),
>>> -    .bdrv_needs_filename =3D true,
>>> -    .bdrv_file_open     =3D qemu_rbd_open,
>>> -    .bdrv_close         =3D qemu_rbd_close,
>>> -    .bdrv_create        =3D qemu_rbd_create,
>>> -    .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
>>> -    .bdrv_get_info      =3D qemu_rbd_getinfo,
>>> -    .create_opts        =3D &qemu_rbd_create_opts,
>>> -    .bdrv_getlength     =3D qemu_rbd_getlength,
>>> -    .bdrv_truncate      =3D qemu_rbd_truncate,
>>> -    .protocol_name      =3D "rbd",
>>> +    .format_name            =3D "rbd",
>>> +    .instance_size          =3D sizeof(BDRVRBDState),
>>> +    .bdrv_parse_filename    =3D qemu_rbd_parse_filename,
>>> +    .bdrv_file_open         =3D qemu_rbd_open,
>>> +    .bdrv_close             =3D qemu_rbd_close,
>>> +    .bdrv_create            =3D qemu_rbd_create,
>>> +    .bdrv_has_zero_init     =3D bdrv_has_zero_init_1,
>>> +    .bdrv_get_info          =3D qemu_rbd_getinfo,
>>> +    .create_opts            =3D &qemu_rbd_create_opts,
>>
>> Pointless &; might as well remove it for consistency while touching it=
=2E
>>
>=20
> I'm not sure I understand - we need the '&' here for the .create_opts
> initializer, unless I am overlooking something.

Nope, I'm overlooking. I assumed that everything here was a function
pointer, but you are right that .create_opts takes an object (not a
function) pointer, so the & is necessary.  Maybe I need to take a short
break from reviewing...

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Ol83qVguirae7fLRbbKh6IgDjxKlfoVs3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtLL8AAoJEKeha0olJ0NqXnwH/jjOnFDNiwVpgw7DW9reVCH+
u6OZVWC7WJD/pPtFi3Xp9yLEnXi3wEjWPrhfq8bKSAaH2rucDxn/v//Ihuhhywp8
/iPrgaZ4uK6Kt0vrxy6I5nppDJxExucSuEWU/y9pAjmSEGm6wUCIdFOwz0Kt9EA6
OShUcnAtsnX0xhQur0jrUuR/KGBMA+AGTSlDan6AtKzlpdyT5Zxdg0m5d35YWCC4
JGkqbaOzHlSgOOs1YFwOnZEBYMayKPjofjwhzkH0NtoZ5Ct7flwBSLxUxU5+GK6p
bw2L+y+W4nm8YI2LuNAQ1+21DT6o91GB/YIsgxFFeykFV9afUyw01xUG4g3arQc=
=OEUN
-----END PGP SIGNATURE-----

--Ol83qVguirae7fLRbbKh6IgDjxKlfoVs3--
