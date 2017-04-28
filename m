Received: from eggs.gnu.org ([2001:4830:134:3::10]:48441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4C3T-0003mQ-5h
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4C3S-00058S-4G
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:59:51 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-8-eblake@redhat.com>
	<99e512ad-d73a-09dd-ee68-ee57dc4581af@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <03c4ac54-99fd-4316-1867-8d16e0703605@redhat.com>
Date: Fri, 28 Apr 2017 14:59:42 -0500
MIME-Version: 1.0
In-Reply-To: <99e512ad-d73a-09dd-ee68-ee57dc4581af@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0V7BkqsBJqTVDHFxJhssuclXsApfeXJ2c"
Subject: Re: [Qemu-devel] [PATCH v10 07/17] qemu-io: Switch 'alloc' command
 to byte-based length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0V7BkqsBJqTVDHFxJhssuclXsApfeXJ2c
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <03c4ac54-99fd-4316-1867-8d16e0703605@redhat.com>
Subject: Re: [PATCH v10 07/17] qemu-io: Switch 'alloc' command to byte-based
 length
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-8-eblake@redhat.com>
 <99e512ad-d73a-09dd-ee68-ee57dc4581af@redhat.com>
In-Reply-To: <99e512ad-d73a-09dd-ee68-ee57dc4581af@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 02:46 PM, Max Reitz wrote:
> On 27.04.2017 03:46, Eric Blake wrote:
>> For the 'alloc' command, accepting an offset in bytes but a length
>> in sectors, and reporting output in sectors, is confusing.  Do
>> everything in bytes, and adjust the expected output accordingly.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>

>>      }
>> +    if (!QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE)) {
>> +        printf("bytes %" PRId64 " is not sector aligned\n",
>=20
> This isn't real English. :-)

But, it's just copy-and-paste from the other instances you just reviewed
in 6/17!  [Translation - if I change this one, I also get to redo that on=
e]

Which of these various alternatives (if any) looks better:

bytes=3D511 is not sector-aligned
511 is not a sector-aligned value for 'bytes'
requested 'bytes' of 511 is not sector-aligned
alignment error: 511 bytes is not sector-aligned
'bytes' must be sector-aligned: 511
your clever entry here...

>=20
> With that fixed (somehow, you know better than me how to):

Re-reading my various alternatives, I do think that /sector
aligned/sector-aligned/ helps no matter what; and that the remaining
trick is to use quoting or '=3D' or some other lexical trick to make it
obvious that 'bytes' is a parameter name whose value 511 is invalid,
rather than part of the actual error of a value that is not properly
aligned.

>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>

If you state a preference for one of my variants, then the respin will
use that variant consistently and add your R-b.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0V7BkqsBJqTVDHFxJhssuclXsApfeXJ2c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA58uAAoJEKeha0olJ0NqKycH/3zIr8ovVWiznbfno5+uMSFw
8xHAJN7nN4TJzEAbat70LUeTyscqRp4p3YvN3/R49HC20j/wP/z2LZhKXpLbMqzl
AW/iXuvvMGLnMxneXOH8Zv7uvcMTtGEmQWYFkXISENkCSMkyhuI6CFjTvmoHfXWC
NjLHa2kIY4toSlXY+r96w7tY24kem9fXosJH8x1uB/7ygMUb1HmAMu3GLmbwQrDq
ORoFhAKzimVs9Van22HZrc9A2+QMoPr6WJECGDA+Col/1ch7wNEuQ1bByt2lB0Mx
rjRyfJSTfmPdEn34OrCahCMoU8NaES1wQ/VLmaBaD1RU74UIq0/ppErcbrhIqsw=
=CpAZ
-----END PGP SIGNATURE-----

--0V7BkqsBJqTVDHFxJhssuclXsApfeXJ2c--
