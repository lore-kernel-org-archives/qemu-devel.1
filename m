Received: from eggs.gnu.org ([2001:4830:134:3::10]:60654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsEqf-0007cQ-Dc
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsEqe-0007B5-B2
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:05:29 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <013cde59-86fe-e796-5d80-5bb6843fed65@redhat.com>
Date: Wed, 13 Sep 2017 16:05:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2mU4phmR43N4440qeUIHlnTIuGDbFOdrm"
Subject: Re: [Qemu-devel] [PATCH v4 00/23] make bdrv_get_block_status
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2mU4phmR43N4440qeUIHlnTIuGDbFOdrm
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org
Message-ID: <013cde59-86fe-e796-5d80-5bb6843fed65@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/23] make bdrv_get_block_status
 byte-based
References: <20170913160333.23622-1-eblake@redhat.com>
In-Reply-To: <20170913160333.23622-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/13/2017 11:03 AM, Eric Blake wrote:
> There are patches floating around to add NBD_CMD_BLOCK_STATUS,
> but NBD wants to report status on byte granularity (even if the
> reporting will probably be naturally aligned to sectors or even
> much higher levels).  I've therefore started the task of
> converting our block status code to report at a byte granularity
> rather than sectors.
>=20
> Now that 2.11 is open, I'm rebasing/reposting the remaining patches.
>=20
> The overall conversion currently looks like:
> part 1: bdrv_is_allocated (merged, commit 51b0a488)
> part 2: dirty-bitmap (v7 is posted [1], mostly reviewed)
> part 3: bdrv_get_block_status (this series, v3 at [2])
> part 4: .bdrv_co_block_status (v2 is posted [3], but needs a rebase)
>=20
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-status-v4
>=20
> Based-on: <20170912203119.24166-1-eblake@redhat.com>
> ([PATCH v7 00/20] make dirty-bitmap byte-based)

Also,

Based-on: <20170913210343.19078-1-eblake@redhat.com>
(osdep: Fix ROUND_UP(64-bit, 32-bit))

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2mU4phmR43N4440qeUIHlnTIuGDbFOdrm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm5nYwACgkQp6FrSiUn
Q2qmlwgAhT6rIIhHpmTFbHIl/B/RTxRRudNkgmplsUmC9WQfzr71DoibbVkigMc9
j9ELY7kVb1to5/mKve6ptG0iIZ5rYE/osiMCh/BPZAfWvPdnlYP1Vs0GGOKBBSvH
1/0vmj8QgTQNbfPvuISD8fNUXY0bFP/moOVkzZ60Cl7wyhOpuRzADX+ThGkoodjw
S4GYQe4yj7eTHm0RE7wQYtR+ixMMaoQHScTvu788erso2eBzoJcq2h+7HBt45EUX
R/7C9VvqaG7hw+ORAw00uNh5H/jpaFZ9VRt7kEa0Ni1hwbemHpGrMFBzf2mGOp18
z/BMDRceRJtbcn+9jJtbHFKDZYMV8Q==
=yBaw
-----END PGP SIGNATURE-----

--2mU4phmR43N4440qeUIHlnTIuGDbFOdrm--
