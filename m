Received: from eggs.gnu.org ([2001:4830:134:3::10]:34690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9Vz2-0008S3-Ce
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9Vz1-00005a-J8
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:21:48 -0400
References: <20180416165849.28864-1-mreitz@redhat.com>
	<20180416165849.28864-2-mreitz@redhat.com>
	<20180420083138.GK15181@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c22e1481-9a9f-71af-938c-f3f5254959d4@redhat.com>
Date: Fri, 20 Apr 2018 15:21:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180420083138.GK15181@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fNur6Oh8nJvTjvZFjqX9vOoiWm0h4fEju"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/9] block: Add COR filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fNur6Oh8nJvTjvZFjqX9vOoiWm0h4fEju
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <c22e1481-9a9f-71af-938c-f3f5254959d4@redhat.com>
Subject: Re: [Qemu-block] [PATCH 1/9] block: Add COR filter driver
References: <20180416165849.28864-1-mreitz@redhat.com>
 <20180416165849.28864-2-mreitz@redhat.com>
 <20180420083138.GK15181@stefanha-x1.localdomain>
In-Reply-To: <20180420083138.GK15181@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-04-20 10:31, Stefan Hajnoczi wrote:
> On Mon, Apr 16, 2018 at 06:58:41PM +0200, Max Reitz wrote:
>>  { 'enum': 'BlockdevDriver',
>> -  'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop',
>> +  'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop', 'cor',
>=20
> "copy-on-read" would be clearer than "cor" for the QMP API and the
> block/cor.c source file.  Is there a need to make the name very short?

There definitely is no need.  I decided I'd prefer to type less in the
test cases, so I went for the shorter name.  (I thought blockdev-add was
sufficiently verbose as it is.)

But I don't mind un-abbreviating it either.  (Probably better
considering that blockdev-add is already verbose, so there is no point
in making parts of it artificially dense.)


Thanks for reviewing!

Max


--fNur6Oh8nJvTjvZFjqX9vOoiWm0h4fEju
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrZ6VwACgkQ9AfbAGHV
z0DmlwgAsgeN6IzD9A5uXg4p7omTmXfgaANsAAcs1l0WExZ245HIYtT7N8c4hkfI
4KvEbe88xImvCKx0pGgqV2hvcu3kFwCeaatNn0HW5oLFUD6hrosd3ZufmmPOi4Tz
kGuxj2IxH3Ahothm8mh8CNxd5gE517FwP412avpasigpCTLXK/dd2PtKjdrdqKpf
Y7AVGqf5Z0/YPRcD2NF6xS5ClxacEufQI20lz8vmj1n5WCxRJW81gEbLNS20Iv5x
oDY9T0gVKzpwF0RWrO2QI0QbduWtIRSBzbomdlpZZLKT7/z/SSh6/+j4qdl2xMST
96gAfEDkHUHzqEL0+JsTcO+/zKwvfw==
=zXPz
-----END PGP SIGNATURE-----

--fNur6Oh8nJvTjvZFjqX9vOoiWm0h4fEju--
