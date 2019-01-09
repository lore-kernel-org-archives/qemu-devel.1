Received: from eggs.gnu.org ([209.51.188.92]:40932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghI5D-0002bh-96
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghI5C-0003Qn-Fs
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:56:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ghI5C-0003OH-64
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:56:02 -0500
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
	<20190109172023.GK4867@localhost.localdomain>
	<be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
Date: Wed, 9 Jan 2019 11:55:56 -0600
MIME-Version: 1.0
In-Reply-To: <be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DwNnWlAySjasdWlaqrTv6NYUwbfnGC51k"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, muriloo@linux.ibm.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DwNnWlAySjasdWlaqrTv6NYUwbfnGC51k
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-devel@nongnu.org, muriloo@linux.ibm.com, dgilbert@redhat.com
Message-ID: <40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use ID
 anymore
References: <20180906111107.30684-1-danielhb413@gmail.com>
 <47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
 <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
 <200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
 <20190109172023.GK4867@localhost.localdomain>
 <be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
In-Reply-To: <be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 1/9/19 11:38 AM, Max Reitz wrote:

>>>>> I do think it affects users of HMP, because right now you can delet=
e
>>>>> snapshots with their ID, and after this series you cannot.
>>>>

>> This. Is. HMP.
>>
>> Not a stable ABI, no deprecation period of two releases.
>=20
> Well, if you want to do it.
>=20
> This may be HMP, but this is also the only interface to savevm, so it's=

> not like users have a choice to use a more stable interface.  I know
> that was a conscious decision, more or less, but I don't see why we nee=
d
> to be so nasty when the hardest thing about doing a nice deprecation
> would be to remember to make it an error in half a year.

Indeed, and libvirt IS using 'savevm' via HMP via QMP's
human-monitor-command, since there is no QMP counterpart for internal
snapshot.  Even though lately we consistently tell people that internal
snapshots are underdeveloped and you should use external snapshots, it
does not get away from the fact that libvirt has been using 'savevm' to
drive internal snapshots for years now, and that we MUST consider
back-compat and/or add an introspectible QMP interface before making
changes that would break libvirt.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--DwNnWlAySjasdWlaqrTv6NYUwbfnGC51k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw2Na0ACgkQ3g5py3or
ov2ugQgAkf//zI5VS7TIS8XcZzEAR6o92HJCXbU5J3ZZfe3NAY8m8zBfCnbQq7iH
oM4lfoFMB8Xs3gJY86QEPr9oa9Y3VQGuE8fsXNhWPO/beVUuiqoPTcNdQ/BvkaB7
GmM3CdnBPZp5qe2xMV2wKljBx1K3cCgA2vKhph0FqefcZVwjud0w/ok0ApN+eO89
KhsYn3tfu6Wbi3opihTUmQghd+hPNHLOw/SyELklgX8XurFR1rTlcw1Qb/hhtAfI
doaJs0tQeEKQWVWxxau4zsR2idaytAemwQxhiDdIgC3oqnO4tbgcxWNizt1ZYlAY
dv+joJtAyaQTufF/XgYQod9LSHWeKw==
=bSuC
-----END PGP SIGNATURE-----

--DwNnWlAySjasdWlaqrTv6NYUwbfnGC51k--
