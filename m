Received: from eggs.gnu.org ([2001:4830:134:3::10]:47982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDHaT-0006Ys-Ev
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDHaS-0006OD-Hx
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:15:45 -0500
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-6-mreitz@redhat.com>
	<0d714dcf-f15c-c229-fa30-1d42002a2438@redhat.com>
	<3eb16582-87e8-61f0-f880-dea9cec0e25f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd517fe7-8104-407d-17a9-e1fc0f9e8174@redhat.com>
Date: Fri, 10 Nov 2017 16:15:34 -0600
MIME-Version: 1.0
In-Reply-To: <3eb16582-87e8-61f0-f880-dea9cec0e25f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Jxr5O3Gbl5WGuHRLgI9MRCx6mHuU6f5aq"
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/5] qcow2: Refuse to get
 unaligned offsets from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jxr5O3Gbl5WGuHRLgI9MRCx6mHuU6f5aq
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Message-ID: <bd517fe7-8104-407d-17a9-e1fc0f9e8174@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/5] qcow2: Refuse to get unaligned
 offsets from cache
References: <20171110203111.7666-1-mreitz@redhat.com>
 <20171110203111.7666-6-mreitz@redhat.com>
 <0d714dcf-f15c-c229-fa30-1d42002a2438@redhat.com>
 <3eb16582-87e8-61f0-f880-dea9cec0e25f@redhat.com>
In-Reply-To: <3eb16582-87e8-61f0-f880-dea9cec0e25f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 04:00 PM, Max Reitz wrote:
>> Trying to understand this: we have a double corruption, because we
>> encountered a refblock that points outside of the image, but fixing th=
e
>> refblock in turn encounters a second refblock that points within the
>> image but to an unaligned area.
>=20
> No, it's the very same.  As far as I've seen it, the repair function
> tries to fix the "refblock is outside image" error by resizing the imag=
e
> so the refblock is inside the image.  However, the subsequent
> bdrv_truncate() detects the alignment corruption, too, and thus marks
> the image corrupt.

Is resizing the image to be larger always a wise thing compared to just
rebuilding the refcount?  If I stick a large enough out-of-image value
in the table, can I cause a denial-of-service by making qemu try to
allocate petabytes of storage just to bring it into range?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Jxr5O3Gbl5WGuHRLgI9MRCx6mHuU6f5aq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloGJQYACgkQp6FrSiUn
Q2otEQf9FL4Anu925VPOwrnjI3gHi713wfT/OhdnoUnqjLYJMiYUzTw+x4c0d8Al
D6YI21zdKWHLUe/g5J5FGGQKyo+vPAYCcFPj5h+mk3PkTpsZtO7DPhWmGFxsiONu
67aD1Zajl9GHQz8v/CA6x9rpQT39CuO3M5UyuyGQUmCCRfjEAdpeKPGh/k7RV6u0
w48R9rPt5ZJ1De0DmtvrTmyjb1JSN1Py3XGzeiJoOnczexTxbM8wKUhuS03h0mZ/
j2TSQSpAWmP9YpQVzlnfPFKDgc18E1xs78ufXtTHmAxbEPwwIZoEBinHSQs7ruhP
0avg6hrFIzPyb0PjNOj5nUHfhC6NCg==
=1++u
-----END PGP SIGNATURE-----

--Jxr5O3Gbl5WGuHRLgI9MRCx6mHuU6f5aq--
