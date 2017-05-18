Received: from eggs.gnu.org ([2001:4830:134:3::10]:57545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBMH1-00065b-7v
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBMGy-0001QW-0l
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:19:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dBMGx-0001QH-Ni
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:19:23 -0400
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
	<149399503288.29022.13904385823492355197.stgit@bahia.lan>
	<093d42d3-a4a5-94bd-3a7a-b2a2f867ae89@redhat.com>
	<20170509111258.4c4f3de9@bahia> <20170518104106.39639439@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c4dd5d65-49d9-60f0-4ff6-793166f22c32@redhat.com>
Date: Thu, 18 May 2017 09:19:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170518104106.39639439@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DI2qm3prOWuHDMBTjAxBRcfFeXifpwbxT"
Subject: Re: [Qemu-devel] [PATCH 2/5] 9pfs: local: resolve special
 directories in paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?Q?L=c3=a9o_Gaspard?= <leo@gaspard.io>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DI2qm3prOWuHDMBTjAxBRcfFeXifpwbxT
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?Q?L=c3=a9o_Gaspard?= <leo@gaspard.io>, qemu-devel@nongnu.org
Message-ID: <c4dd5d65-49d9-60f0-4ff6-793166f22c32@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] 9pfs: local: resolve special directories
 in paths
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
 <149399503288.29022.13904385823492355197.stgit@bahia.lan>
 <093d42d3-a4a5-94bd-3a7a-b2a2f867ae89@redhat.com>
 <20170509111258.4c4f3de9@bahia> <20170518104106.39639439@bahia.lan>
In-Reply-To: <20170518104106.39639439@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/18/2017 03:41 AM, Greg Kurz wrote:
> [...]
>>>> +        } else if (!strcmp(name, "..")) {
>>>> +            if (!strcmp(dir_path->data, ".")) {
>>>> +                /* ".." relative to the root is "." */
>>>> +                v9fs_path_sprintf(target, ".");
>>>> +            } else {
>>>> +                char *tmp =3D g_path_get_dirname(dir_path->data);
>>>> +                /* ".." relative to "foo/bar" is equivalent to "foo=
" */   =20
>>>
>>> True only if bar is not a symlink to some other directory.  What
>>> guarantees do you have that you are not going to be inadvertently
>>> skipping a traversal through symlinks and thereby picking the wrong
>>> location for '..'?
>>>  =20
>>
>> My understanding is that symlinks are supposed to be resolved by the c=
lient,
>> and we shouldn't follow them in the server.
>>
>=20
> Eric,
>=20
> Do you have any comment further comment or can I go on with this change=
 ?

I'd update the comment to mention that the equivalency between
"foo/bar/.." and "foo" is _because_ the client has already resolved
symlinks, and then I think you're good to go.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DI2qm3prOWuHDMBTjAxBRcfFeXifpwbxT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHa1oAAoJEKeha0olJ0NqlyEH+wUmoFNXeMPCBjyEFaF8FQ42
U4ARBS1o08ILdUBCVK/a8ZOUgT/iE8xSfRYRIfbWatBMFPFjkXllJ8W25rlxWxDs
0NwIa+CBxVkg9aHCB5avNHy4zqN1mYH3rxz1zIzrNm9v64BqgJo2ObiE8ePPcSIC
82qKOpXvs58RTsNGYQnrmR2O1tsFrWbmQf7Kx+fO8zDndrkH035u8ySsL7BUuGqO
FpB6GMDqxdfsh8JJRtQ4ZpPmjm0OXbSKbxkuS4+fSlICAYAkqlOZ6apFRUiPojzO
li42MntC8FYD/4TgwrLWIaTfKOySYSK8rSKRVsZU+JVFBfmXIstkSEVhdP8NUH8=
=GFGP
-----END PGP SIGNATURE-----

--DI2qm3prOWuHDMBTjAxBRcfFeXifpwbxT--
