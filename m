Received: from eggs.gnu.org ([2001:4830:134:3::10]:54931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eANlA-0001KM-6m
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 18:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eANl9-0001AM-9m
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 18:14:48 -0400
References: <20171012034720.11947-1-eblake@redhat.com>
	<20171020164515.GC31112@localhost.localdomain>
	<4f961b41-e75b-5517-63fa-0c1ecd58605e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <698eb206-8bb5-e841-c82c-ceda7e56fc55@redhat.com>
Date: Thu, 2 Nov 2017 17:14:34 -0500
MIME-Version: 1.0
In-Reply-To: <4f961b41-e75b-5517-63fa-0c1ecd58605e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TmHj3TXmpvG4R5vhPVCoeh7f6GaCGHmm9"
Subject: Re: [Qemu-devel] [PATCH v6 00/24] make bdrv_get_block_status
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TmHj3TXmpvG4R5vhPVCoeh7f6GaCGHmm9
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <698eb206-8bb5-e841-c82c-ceda7e56fc55@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/24] make bdrv_get_block_status
 byte-based
References: <20171012034720.11947-1-eblake@redhat.com>
 <20171020164515.GC31112@localhost.localdomain>
 <4f961b41-e75b-5517-63fa-0c1ecd58605e@redhat.com>
In-Reply-To: <4f961b41-e75b-5517-63fa-0c1ecd58605e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/02/2017 04:01 PM, John Snow wrote:

>>> The overall conversion currently looks like:
>>> part 1: bdrv_is_allocated (merged, commit 51b0a488)
>>> part 2: dirty-bitmap (merged, commit ca759622)
>>> part 3: bdrv_get_block_status (this series, v5 at [1])
>>> part 4: .bdrv_co_block_status (v3 is posted [2], mostly reviewed, but=
 needs rebase)
>>
>> Thanks, applied to the block branch.
>>
>> Kevin
>>
>=20
> Thanks;
>=20
> Eric: does this just leave part four?

Yes; the latest version of part four is v4:
https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg02940.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TmHj3TXmpvG4R5vhPVCoeh7f6GaCGHmm9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln7mMoACgkQp6FrSiUn
Q2qClQf8Cqwx3buzc6LrkWjSMbdMWOH3FueZqWH1Ln1P8179Dn33/pwT4oL4tvjI
2K+sabQntBwrNS6Cqi+62apu5qRNt2AWqjop2waaLye1P871iiQTcGjxRn8H2v7y
NRriqt7kXazFy1JWjbHnJu8M/mc7bGjJW3PuQJMYRFPO7sSAc/uMKcrHG5oinzt2
jm0r2JmnvDgti9aSjrjuBxyWVlF2Yw5F5Ixla+9li52ENMJs7tdAbvS2EhKRFFOW
uz4ABnTcIMKRK8tsUjumQlhGOiGuQfOMoFbuOWU3M2kzdU9Yide+6U8booZVKde8
+iXsy1Ne2OssFSGAGmX8WYUR/80o5Q==
=M/ht
-----END PGP SIGNATURE-----

--TmHj3TXmpvG4R5vhPVCoeh7f6GaCGHmm9--
