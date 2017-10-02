Received: from eggs.gnu.org ([2001:4830:134:3::10]:56295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzAZs-0001r5-D7
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 19:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzAZr-0000wW-7i
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 19:56:48 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-24-eblake@redhat.com>
	<ae5bcf8e-57de-68c2-8a1a-6599f0e5c9ea@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <47998e8d-69fa-9fa9-7647-efca89c3b98d@redhat.com>
Date: Mon, 2 Oct 2017 18:56:33 -0500
MIME-Version: 1.0
In-Reply-To: <ae5bcf8e-57de-68c2-8a1a-6599f0e5c9ea@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8tgkd8l0Q9su90gVp1LhjG6ka6vCuLeTE"
Subject: Re: [Qemu-devel] [PATCH v4 23/23] qemu-io: Relax 'alloc' now that
 block-status doesn't assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8tgkd8l0Q9su90gVp1LhjG6ka6vCuLeTE
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <47998e8d-69fa-9fa9-7647-efca89c3b98d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 23/23] qemu-io: Relax 'alloc' now that
 block-status doesn't assert
References: <20170913160333.23622-1-eblake@redhat.com>
 <20170913160333.23622-24-eblake@redhat.com>
 <ae5bcf8e-57de-68c2-8a1a-6599f0e5c9ea@redhat.com>
In-Reply-To: <ae5bcf8e-57de-68c2-8a1a-6599f0e5c9ea@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 04:27 PM, John Snow wrote:
>=20
>=20
> On 09/13/2017 12:03 PM, Eric Blake wrote:
>> Previously, the alloc command required that input parameters be
>> sector-aligned and clamped to 32 bits, because the underlying
>> bdrv_is_allocated used a 32-bit parameter and asserted aligned
>> inputs.  But now that we have fixed block status to report a
>> 64-bit bytes value, and to properly round requests on behalf of
>> guests, we can pass any values, and can use qemu-io to add
>> coverage that our rounding is correct regardless of the guest
>> alignment constraints.
>>
>> Update iotest 177 to intentionally probe block status at
>> unaligned boundaries as well as with a bytes value that does not
>> map to 32-bit sectors, which also required tweaking the image
>> prep to leave an unallocated portion to the image under test.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>>  echo
>> +echo "=3D=3D block status smaller than alignment =3D=3D"
>> +limits=3Dalign=3D4k
>> +$QEMU_IO -c "open -o $options,$limits blkdebug::$TEST_IMG" \
>> +	 -c "alloc 1 1" -c "alloc 0x6dffff0 1000" -c "alloc 127m 5P" \
>> +	 -c map | _filter_qemu_io
>> +

>=20
> aaand I'll hold off on this one until the respin so I don't have to
> review the test twice.

Fair enough; thanks for the reviews.

By the way, it's operations like the above additions where you can step
through bdrv_co_block_status in gdb to see all the rounding/alignment
steps in action, so I do feel pretty confident that my changes in 21/23
were fairly well covered.

>=20
> I'll say I'm done for v4 for now :)

I'll try to get v5 posted in the next day or two.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8tgkd8l0Q9su90gVp1LhjG6ka6vCuLeTE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnS0jEACgkQp6FrSiUn
Q2oZGQf/RN69IRUv/aP7tJykCZnp6oW7QsEm9WZo/Etvm1z1OGQKNFFJAWTp7jvO
aZNeadI5BeTQ4jY6ZN/RHwSDD9OzrsJfG6c91ssTET6qRAexYBGN/M7fCW5hQgzn
4PfINsfxVmE/ueI87/KlECW30NgVFXDFBUGNfoVeLrPJIHt57ACKrOsURkfQVPiq
8AZyDwHlWkYEl7j6Z3EuBFAEPa8CfiVGaBV59698lUfKEqjV2Kpt4L/w+sKMoNTk
6Cwg8VhPlPHpzowLQhcbOA1iHOriJxWmgrckymhsOG+lWvdUPwjBiLaeRT5GHxAj
9D1VEUmN43zNfc5/jY0c017q6zrjIQ==
=gPB+
-----END PGP SIGNATURE-----

--8tgkd8l0Q9su90gVp1LhjG6ka6vCuLeTE--
