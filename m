Received: from eggs.gnu.org ([2001:4830:134:3::10]:56687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3NgF-0000uy-EZ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3NgB-0004Ou-DI
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:12:31 -0400
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-3-berrange@redhat.com>
	<48ac644a-441b-134a-7d4c-fb3239fb5e0f@redhat.com>
	<20170426135051.GY18933@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c9ba2963-41f6-3207-d4d4-c5a8f4171f77@redhat.com>
Date: Wed, 26 Apr 2017 09:12:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170426135051.GY18933@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d2lPGFvMgw9qBm6fKuFUfk6OQPTLSaln6"
Subject: Re: [Qemu-devel] [PATCH v6 02/18] block: add ability to set a
 prefix for opt names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d2lPGFvMgw9qBm6fKuFUfk6OQPTLSaln6
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <c9ba2963-41f6-3207-d4d4-c5a8f4171f77@redhat.com>
Subject: Re: [PATCH v6 02/18] block: add ability to set a prefix for opt names
References: <20170425153858.25660-1-berrange@redhat.com>
 <20170425153858.25660-3-berrange@redhat.com>
 <48ac644a-441b-134a-7d4c-fb3239fb5e0f@redhat.com>
 <20170426135051.GY18933@redhat.com>
In-Reply-To: <20170426135051.GY18933@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 08:50 AM, Daniel P. Berrange wrote:
> On Wed, Apr 26, 2017 at 08:28:04AM -0500, Eric Blake wrote:
>> On 04/25/2017 10:38 AM, Daniel P. Berrange wrote:
>>> When integrating the crypto support with qcow/qcow2, we don't
>>> want to use the bare LUKS option names "hash-alg", "key-secret",
>>> etc. We want to namespace them "luks-hash-alg", "luks-key-secret"
>>> so that they don't clash with any general qcow options at a later
>>> date.

>> Is this still needed, given your cover letter said you reworked things=

>> to use a nested struct?  I'm still not convinced we need the complexit=
y
>> of two different prefixes if we can instead reuse a common structure.
>=20
> Yes, we still need this at the QemuOpts level.  We have the general
> purpose luks driver that has opts directly in the top level QAPI block
> driver options, vs the qcow2 integration, which now has the encryption
> options in a nested struct/union, rather than having an option prefix
> in the QAPI member names.

Fair enough.

>=20
> At the QemuOpts level, this mean that the option names have changed
> from being 'luks-key-secret', 'aes-key-secret', to be "encrypt.key-secr=
et"

But you'll want to update the commit message to match your new planned
names ;)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--d2lPGFvMgw9qBm6fKuFUfk6OQPTLSaln6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAKq2AAoJEKeha0olJ0NqIocH/3SMtHQwqZUPzLZTnoSOFvl5
bJVbZNEaXzCv3u33yZt07kVBYfzC6795V/bboqt1rLpdfDPr85ihICwvMDhyQSMz
0cFtepP1hQRYmeeZLC5uCq4W/P9Ky0zZQyoDDfGssEVfm9SKP9JUTKfJzlVuplm9
48wxIx3RsobgglKNfa/v47f3Cg/ePTK5LPBiMDeZR4Dpm8Qkibitlcus9dYWdvnz
b5+R7TvmOiEzGieFa18DqQZg57PakRwj0IxzNO/xZVd/jIMHfc/26dwQtvp5K28n
06+ihuc731hy/lfH5jWxkqpSMFvod5W6wWRQWFw2BtgVN7TiiipDJNWaVVIgtLE=
=dfr3
-----END PGP SIGNATURE-----

--d2lPGFvMgw9qBm6fKuFUfk6OQPTLSaln6--
