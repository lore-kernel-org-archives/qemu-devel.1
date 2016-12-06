Received: from eggs.gnu.org ([2001:4830:134:3::10]:45462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEO4t-0000Kh-4h
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEO4s-0004Jf-6z
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:19:11 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-3-eblake@redhat.com>
	<42b3c9e3-7c0d-4ec2-4257-1331f16d2c04@redhat.com>
	<50585dad-8418-f52c-8e19-418d8a064131@redhat.com>
	<110c4d8c-c87c-a8b5-04e0-985672e24337@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <227dbbb5-0486-281b-6668-1dc88cfb6d91@redhat.com>
Date: Tue, 6 Dec 2016 16:18:59 -0600
MIME-Version: 1.0
In-Reply-To: <110c4d8c-c87c-a8b5-04e0-985672e24337@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o2SAUP17M2R1x1SFElQ2JxULOTHHNf2QV"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] blkdebug: Add pass-through
 write_zero and discard support
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
--o2SAUP17M2R1x1SFElQ2JxULOTHHNf2QV
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <227dbbb5-0486-281b-6668-1dc88cfb6d91@redhat.com>
Subject: Re: [PATCH v3 2/5] blkdebug: Add pass-through write_zero and discard
 support
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-3-eblake@redhat.com>
 <42b3c9e3-7c0d-4ec2-4257-1331f16d2c04@redhat.com>
 <50585dad-8418-f52c-8e19-418d8a064131@redhat.com>
 <110c4d8c-c87c-a8b5-04e0-985672e24337@redhat.com>
In-Reply-To: <110c4d8c-c87c-a8b5-04e0-985672e24337@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2016 04:14 PM, Max Reitz wrote:
> On 06.12.2016 23:12, Eric Blake wrote:
>> On 12/06/2016 04:00 PM, Max Reitz wrote:
>>
>>>> Tested by setting up an NBD server with export 'foo', then invoking:=

>>>> $ ./qemu-io
>>>> qemu-io> open -o driver=3Dblkdebug blkdebug::nbd://localhost:10809/f=
oo
>>
>> By the way, I'd LOVE to know if there is a way to write a qemu-io
>> command line that would do this connection automatically (so that I ca=
n
>> batch commands up front and benefit from the shell's history) rather
>> than having to issue an 'open' after the fact.  I tried various
>> incantations with --object and --image-opts, but got stumped.
>=20
> Can't you just do qemu-io -c 'open'?

I suppose that would get command-line history.  But I still want
interactive mode.  The moment you use -c, ALL commands get run
back-to-back without stopping, so I'd have to add additional -c
'read'/'write' commands up front. I like interactive mode (open
pre-connected, now let me explore the image at will).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--o2SAUP17M2R1x1SFElQ2JxULOTHHNf2QV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRzlTAAoJEKeha0olJ0Nqw/MIAICsXuGY7xuGvQ1iMFthbqoB
KqOzHn1bxpKtBgTicvyknlQdfUUYPIXq4pU/t9uQcNgejtyV03Jznls6MC909Z7V
IMoedVBMy/Rkze/gn6vUdkjDU2wzS3sUnO/TeCyNAxN/4HL0rqx1CjUYnXxug2kS
WRmi3T4rIXfRWEEvsDew/epWf2ByphS7QxlHs+dGRUZX5Gdt3iHnHOFMvG34FFzU
Gcv5MyZSjSFajXrwDgE9zo0quYZIF5VpPN9ueHXhVm9m+OQByp5IDi2ICNpGzhxq
eyFLoVavAxdQ29Gpw2L/Uf568q0fgOrfLGxcopcoqOm9OK3hfNDCbjXQ2t+AhSY=
=NYuO
-----END PGP SIGNATURE-----

--o2SAUP17M2R1x1SFElQ2JxULOTHHNf2QV--
