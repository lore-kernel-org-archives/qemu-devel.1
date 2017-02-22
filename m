Received: from eggs.gnu.org ([2001:4830:134:3::10]:34364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgaSI-0005E1-Qg
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:11:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgaSH-0008Oz-QJ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:11:54 -0500
References: <20170221024248.11027-1-eblake@redhat.com>
	<20170221024248.11027-8-eblake@redhat.com>
	<ecab92ba-94d4-7b1d-c854-fa2ff9b93acc@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5d651e79-bfdf-fb10-472f-89aef48afaf7@redhat.com>
Date: Wed, 22 Feb 2017 11:11:47 -0600
MIME-Version: 1.0
In-Reply-To: <ecab92ba-94d4-7b1d-c854-fa2ff9b93acc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GcdM7fiOhUXpEFWmNQiNBWE2qrcpSjGKa"
Subject: Re: [Qemu-devel] [PATCH v4 7/8] nbd: Implement NBD_INFO_BLOCK_SIZE
 on server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GcdM7fiOhUXpEFWmNQiNBWE2qrcpSjGKa
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, den@virtuozzo.com
Message-ID: <5d651e79-bfdf-fb10-472f-89aef48afaf7@redhat.com>
Subject: Re: [PATCH v4 7/8] nbd: Implement NBD_INFO_BLOCK_SIZE on server
References: <20170221024248.11027-1-eblake@redhat.com>
 <20170221024248.11027-8-eblake@redhat.com>
 <ecab92ba-94d4-7b1d-c854-fa2ff9b93acc@redhat.com>
In-Reply-To: <ecab92ba-94d4-7b1d-c854-fa2ff9b93acc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2017 10:51 AM, Paolo Bonzini wrote:
>=20
>=20
> On 21/02/2017 03:42, Eric Blake wrote:
>> +    /* Send NBD_INFO_BLOCK_SIZE always, but tweak the minimum size
>> +     * according to whether the client requested it, and according to=

>> +     * whether this is OPT_INFO or OPT_GO. */
>> +    /* minimum - 1 for back-compat, or 512 if client is new enough.
>> +     * TODO: consult blk_bs(blk)->request_align? */
>> +    sizes[0] =3D (opt =3D=3D NBD_OPT_INFO || blocksize) ? BDRV_SECTOR=
_SIZE : 1;
>> +    /* preferred - At least 4096, but larger as appropriate. */
>> +    sizes[1] =3D MAX(blk_get_opt_transfer(exp->blk), 4096);
>=20
> Can we just say zero if the preferred transfer size is unknown?

The NBD specification requires a non-zero power-of-2 number if the
server transmits the block size at all; 1 is the ideal number, followed
by whatever actual size we learn from the request_align of the device.


I added blk_get_opt_transfer() in 3/8; maybe I should just respin the
series to also add blk_get_request_align() as well and get rid of the
TODO here.  In other words, my TODO is probably the result of me not
remembering to complete my rebase (since v3 of the series was posted so
many months ago).

>=20
> Apart from this, it looks good.

Thanks; I'll get a respin out soon, with R-b added where they make
sense, and with the TODO removed.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--GcdM7fiOhUXpEFWmNQiNBWE2qrcpSjGKa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrcZTAAoJEKeha0olJ0Nq6H4H/A4v07XnmsimHXWYEAc3Pm7i
DJ/ZlSBzMf42J2McHF2qMB7bwMPP2c1YTk+6VrjBtiRe0AM9kGjWXnpk9PF6if3W
fcDUPjD9ebhnDk0X2QVOlA359RTT04RNHV5XhB5O/3f6hQ0COj8JLS55pryVq9GP
0N/QmxR3FuNRxRQhD0B72CTx8u+7Zco+AFC6KKLSoWKBBHRVEsy6KurdhtyiZ5v9
TxSRw0PGtO3rFiEmuymtPVAd1Z/bTH+vPWPVHr8WZbxRR8FzmISx6ByrY/CYVfuU
F1Lr0E43PBUaL/OYmrWohrtpMJ20zH7MK3jfvUc5z6ODNknDfQMdHKvPd7OSMZY=
=/BWA
-----END PGP SIGNATURE-----

--GcdM7fiOhUXpEFWmNQiNBWE2qrcpSjGKa--
