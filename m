Received: from eggs.gnu.org ([2001:4830:134:3::10]:46760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4Bsb-0001hh-6F
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4Bsa-000089-2i
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:48:37 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-6-eblake@redhat.com>
	<90b7a5bf-259b-47ef-d0cf-b64fc93bba47@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d25e3cc9-361a-37ba-2d6b-b08319bff7b7@redhat.com>
Date: Fri, 28 Apr 2017 14:48:27 -0500
MIME-Version: 1.0
In-Reply-To: <90b7a5bf-259b-47ef-d0cf-b64fc93bba47@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BHufneXjAI8HLKmH7iI5kXtqFEdQ1BQDM"
Subject: Re: [Qemu-devel] [PATCH v10 05/17] iotests: Add test 179 to cover
 write zeroes with unmap
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
--BHufneXjAI8HLKmH7iI5kXtqFEdQ1BQDM
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <d25e3cc9-361a-37ba-2d6b-b08319bff7b7@redhat.com>
Subject: Re: [PATCH v10 05/17] iotests: Add test 179 to cover write zeroes
 with unmap
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-6-eblake@redhat.com>
 <90b7a5bf-259b-47ef-d0cf-b64fc93bba47@redhat.com>
In-Reply-To: <90b7a5bf-259b-47ef-d0cf-b64fc93bba47@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 02:28 PM, Max Reitz wrote:
> On 27.04.2017 03:46, Eric Blake wrote:
>> No tests were covering write zeroes with unmap.  Additionally,
>> I needed to prove that my previous patches for correct status
>> reporting and write zeroes optimizations actually had an impact.
>>
>> The test works for cluster_size between 8k and 2M (for smaller
>> sizes, it fails because our allocation patterns are not contiguous
>> with small clusters).
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v10: drop any changes to v2 files, rewrite test to work with updates
>> earlier in the series, add a blkdebug probe
>> v9: new patch
>> ---
>>  tests/qemu-iotests/179     | 123 ++++++++++++++++++++++++++++++++++++=
+++++++++
>>  tests/qemu-iotests/179.out |  90 +++++++++++++++++++++++++++++++++
>>  tests/qemu-iotests/group   |   1 +
>>  3 files changed, 214 insertions(+)
>>  create mode 100755 tests/qemu-iotests/179
>>  create mode 100644 tests/qemu-iotests/179.out
>=20
> Can I convince you to write this test in a different way? I really have=

> a hard time following all of the writes and building a mental image of
> how the qcow2 file should look in the end so I can compare it to the ma=
p
> output.
>=20
> I'd like it better if you would check the qcow2 file after each group o=
f
> write operations, maybe even creating a new image for every such group.=

> But even just having more qemu-img map calls (and changing nothing else=
)
> would help me a lot.

Will do.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BHufneXjAI8HLKmH7iI5kXtqFEdQ1BQDM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA5yLAAoJEKeha0olJ0NqjlgH/i1TQDJLaD85fqHUyaJgDMfr
8U5EWU/3S4HSi+aXsr9LSV67fyHx94JGHRfUuM0ifB1N9dG1dgYmvtBPtD6pgaDZ
WzgL5bEnfZAoE2rjMJM6hqyA2+EgoWdx0hbAgG7ePguHZ9gQ4D05LgjpukwSM05R
rsXZmae4QSXivtSw7lxU9IzncO9XEfIU/RQPoBwEwiJcJZU2DMc10YX2Nu3R7PgO
7YI1kMSNDaa+33EiW67G5l0AXY0rX3mr5O/U+U5q0LOdOGJRspvfL4k4FQNzEPvu
skAoEMuHQeneK1k/erSntc243O30Du/sVM/JNcIDliDGP+bW/XkkMxQ0p3nM2ak=
=hMCH
-----END PGP SIGNATURE-----

--BHufneXjAI8HLKmH7iI5kXtqFEdQ1BQDM--
