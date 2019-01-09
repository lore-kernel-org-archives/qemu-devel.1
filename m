Received: from eggs.gnu.org ([209.51.188.92]:58867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghJDL-0000RU-AU
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 14:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghJ7e-0007jQ-Qi
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 14:02:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ghJ7c-0007g3-Nm
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 14:02:38 -0500
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
	<20190109172023.GK4867@localhost.localdomain>
	<be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
	<40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
	<20190109185154.GL4867@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <56880d06-a214-2486-2e80-c565b33461b3@redhat.com>
Date: Wed, 9 Jan 2019 13:02:34 -0600
MIME-Version: 1.0
In-Reply-To: <20190109185154.GL4867@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="asvhtkiiczUXV3OKguL80zXlPR2bRHJB0"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, muriloo@linux.ibm.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--asvhtkiiczUXV3OKguL80zXlPR2bRHJB0
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, armbru@redhat.com,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 muriloo@linux.ibm.com, dgilbert@redhat.com
Message-ID: <56880d06-a214-2486-2e80-c565b33461b3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use ID
 anymore
References: <20180906111107.30684-1-danielhb413@gmail.com>
 <47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
 <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
 <200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
 <20190109172023.GK4867@localhost.localdomain>
 <be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
 <40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
 <20190109185154.GL4867@localhost.localdomain>
In-Reply-To: <20190109185154.GL4867@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 1/9/19 12:51 PM, Kevin Wolf wrote:

>> Indeed, and libvirt IS using 'savevm' via HMP via QMP's
>> human-monitor-command, since there is no QMP counterpart for internal
>> snapshot.  Even though lately we consistently tell people that interna=
l
>> snapshots are underdeveloped and you should use external snapshots, it=

>> does not get away from the fact that libvirt has been using 'savevm' t=
o
>> drive internal snapshots for years now, and that we MUST consider
>> back-compat and/or add an introspectible QMP interface before making
>> changes that would break libvirt.
>=20
> Okay, so what does libvirt do when you request a snapshot with a
> numerical name? Without having looked at the code, the best case I woul=
d
> expect that it forbids them, and more realistically I suspect that we
> may actually fix a bug for libvirt by changing the semantics.
>=20
> Or does libvirt really use snapshot IDs rather than names?

At the moment, libvirt does not place any restriction on internal
snapshot names, but passes the user's name through without thought of
whether it is an id or a name.

So yes, arguably tightening the semantics fixes a libvirt bug for
libvirt having allowed internal snapshots to get into an inconsistent
state.  But again, it falls in the category of "properly fixing this
requires a lot of auditing, time, mental power, and unit tests", which
makes it a rather daunting task to state for certain.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--asvhtkiiczUXV3OKguL80zXlPR2bRHJB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw2RUoACgkQ3g5py3or
ov3C4AgAioZffEAH/aiFtljvqh5Oculx7ddwOXjC7eSr5y1vy/UGOzHwscGMdsz7
HyGk8KjZzp+/w5sH0A3Ns+IRS7AUqAlSqOnhqeobTfNhxljyiL+BZR7BbXQwGING
gO9VphOZ0DjTT7Ao/H/RjVpq+Z88pfaYmjxw2SBpzKad0wGpzGBBSEYl7Otd/y4C
9ajV/2mN7ld+IV47fFBAZOA3FPxM0MS0gAB5WMLr9HLb3IUKvYOv6dT+7payprqm
m4HY0a9j1a6CLFTcmDitII+DWyjFfT0v/0ZoiZPMBweUKW3lIFYMfxHN9NxJQvLi
ibuZU/dXoFnK4ftzkkOxYv1jkjYM1A==
=FISw
-----END PGP SIGNATURE-----

--asvhtkiiczUXV3OKguL80zXlPR2bRHJB0--
