Received: from eggs.gnu.org ([2001:4830:134:3::10]:57929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQYI8-0007Cl-17
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQYI6-0007Ay-Gp
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:15:55 -0400
References: <20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm> <20180606114228.GH1455@redhat.com>
	<20180606114817.GC3064@redhat.com> <20180606120346.GC2661@work-vm>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <37164de6-6c41-7958-231b-d03983e41501@redhat.com>
Date: Wed, 6 Jun 2018 15:15:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180606120346.GC2661@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RSkV9zdh9jpavGWf6JpeljwBiMtgH867T"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RSkV9zdh9jpavGWf6JpeljwBiMtgH867T
From: Max Reitz <mreitz@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com
Message-ID: <37164de6-6c41-7958-231b-d03983e41501@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180528183833.GJ4580@localhost.localdomain>
 <20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
 <20180529064415.GA4756@localhost.localdomain>
 <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
 <20180605092159.GA2544@work-vm>
 <46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
 <20180606111406.GD2660@work-vm> <20180606114228.GH1455@redhat.com>
 <20180606114817.GC3064@redhat.com> <20180606120346.GC2661@work-vm>
In-Reply-To: <20180606120346.GC2661@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 14:03, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
>> On Wed, Jun 06, 2018 at 12:42:28PM +0100, Richard W.M. Jones wrote:
>>> On Wed, Jun 06, 2018 at 12:14:07PM +0100, Dr. David Alan Gilbert wrot=
e:
>>>> The problem with having a separate file is that you either have to c=
opy
>>>> it around with the image or have an archive.  If you have an archive=

>>>> you have to have an unpacking step which then copies, potentially a =
lot
>>>> of data taking some reasonable amount of time.  Storing a simple bit=

>>>> of data with the image avoids that.
>>>
>>> This isn't really true.  For OVA (ie. tar) we don't unpack them.
>>> Adding file.offset and file.size in qemu's raw driver was crucial to
>>> that optimization.
>>
>> Though that assumes you're only using the qcow2 file in read-only mode=
=2E
>> As soon as you need write access you need to unpack from the OVA so th=
at
>> the qcow2 file can grow its length when new sectors are allocated.
>=20
> And the person creating the OVA has to do that taring rather than just
> take the qcow2 they've just used in the VM.

Note that this again can be done efficiently.  You just overwrite the
beginning of the qcow2 file and move the overwritten clusters somewhere
else.

Max


--RSkV9zdh9jpavGWf6JpeljwBiMtgH867T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsX3nwACgkQ9AfbAGHV
z0CggAf9EtnDWOwRtjT72DYI5tW/yv6kJgPuFLg9U3gXAeIHQgiz2B4csKUD62A1
90xD+VMbdVnwDLJ+bM12lGjXsSRL5Fj6GyUV0+aSe5O4Ek2XCMxr6qVgV9Es9OU9
5IVLND4WN8Eo37ysE/PxZt6w03dydGZSnSGcWQiO1i3HrGtFIUGD5511G+YQJ30j
GQ0+yznsFZ5gUonvRjXxwKyUW/UiH8hQQwnHAnCLpLJGjIYxFqOW91YQlH2YPIxz
0z+cSoUjT6ic1+3x14coTN1j0PD355IOoP1A91H3v5q/+YqSriAsS9jaEmlnMFqX
3VTqD4cSBXS/HYM9owppU8T0epQC+g==
=PYGN
-----END PGP SIGNATURE-----

--RSkV9zdh9jpavGWf6JpeljwBiMtgH867T--
