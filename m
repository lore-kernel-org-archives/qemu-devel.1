Received: from eggs.gnu.org ([209.51.188.92]:55643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghIxM-0005pi-Ew
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:52:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghIxL-0000GG-HV
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:52:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ghIxL-0000Ff-9a
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:51:59 -0500
Date: Wed, 9 Jan 2019 19:51:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190109185154.GL4867@localhost.localdomain>
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
	<20190109172023.GK4867@localhost.localdomain>
	<be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
	<40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Content-Disposition: inline
In-Reply-To: <40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, muriloo@linux.ibm.com, dgilbert@redhat.com


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.01.2019 um 18:55 hat Eric Blake geschrieben:
> On 1/9/19 11:38 AM, Max Reitz wrote:
>=20
> >>>>> I do think it affects users of HMP, because right now you can delete
> >>>>> snapshots with their ID, and after this series you cannot.
> >>>>
>=20
> >> This. Is. HMP.
> >>
> >> Not a stable ABI, no deprecation period of two releases.
> >=20
> > Well, if you want to do it.
> >=20
> > This may be HMP, but this is also the only interface to savevm, so it's
> > not like users have a choice to use a more stable interface.  I know
> > that was a conscious decision, more or less, but I don't see why we need
> > to be so nasty when the hardest thing about doing a nice deprecation
> > would be to remember to make it an error in half a year.
>=20
> Indeed, and libvirt IS using 'savevm' via HMP via QMP's
> human-monitor-command, since there is no QMP counterpart for internal
> snapshot.  Even though lately we consistently tell people that internal
> snapshots are underdeveloped and you should use external snapshots, it
> does not get away from the fact that libvirt has been using 'savevm' to
> drive internal snapshots for years now, and that we MUST consider
> back-compat and/or add an introspectible QMP interface before making
> changes that would break libvirt.

Okay, so what does libvirt do when you request a snapshot with a
numerical name? Without having looked at the code, the best case I would
expect that it forbids them, and more realistically I suspect that we
may actually fix a bug for libvirt by changing the semantics.

Or does libvirt really use snapshot IDs rather than names?

Kevin

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcNkLKAAoJEH8JsnLIjy/W+v8P/3gS8w/e672hhGUHUuTqE7sF
ll3ngwiOls5CGyXdyQiqALLL9VehUaI55bn7h4J/xgpaTb7TXJhBD6I3QZGkTvuy
EGp7vAFVQVaOa1kXAO+9+x7m2BpveGWJrwH9RdItq3cKXjou4Wbh5ZXKRiDQQqFu
5PvWfvfgA9EPxSJd75KZRBfMHwK/sKqTisAsMjXkjCdWmA84fzn+BxBLiX+J2sQE
5bLlauetQNPgnfM8xAneifPL1YUMn0nKz02M+7/4U4fAQTNrzIpBfCIkaLVaoZNC
xa1yUh/geVqiQ4f+dZuugWiXwR9IKoyDxeKmVZcCU4b7jTon1N1xh5jZtOsCEsFd
3k8tIJgHKUldmEqaerpYHBIRy57vJf5qufa+R+RcJZkNtwf2hdxTrTBhl1lkeRDQ
FaxZppFLZDomp993dPND+GZxI75y/qfjboizJ5lC+9VAstzZ/S+ldpnMHC2BnqqX
4op6ZfGU7XgkH28Epr+4fEfm4tB6zfITDp7wndjLecNF4ExsBsCm5d8zIm/5o9zE
SU4GH7aAFWVPn2G+U0HAvxcQX+hRSrVu6zFa3mE5Fxgbpei1eudcvTJaljJcG8Yb
4WLmoaAEV0Sbn95RzGy972UJWYfSd/F1S2vwhPEv8Lh/Jx7K/eP++JuT9PYxMKYT
T/lhGChIEgDfUmkZLaIE
=pQx7
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
