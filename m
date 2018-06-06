Received: from eggs.gnu.org ([2001:4830:134:3::10]:36070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQX0T-0007Ij-7H
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQX0S-0004jW-Cy
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:53:37 -0400
References: <20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm> <20180606114228.GH1455@redhat.com>
	<20180606114817.GC3064@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ae6e0d35-690a-41c7-59aa-3d2517ff95ea@redhat.com>
Date: Wed, 6 Jun 2018 13:53:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180606114817.GC3064@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3dtDjy1nXg3AZ5lAtgfhnbVyj4HLeD2af"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3dtDjy1nXg3AZ5lAtgfhnbVyj4HLeD2af
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 armbru@redhat.com, stefanha@redhat.com
Message-ID: <ae6e0d35-690a-41c7-59aa-3d2517ff95ea@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180528183058.GG2209@redhat.com>
 <20180528183833.GJ4580@localhost.localdomain>
 <20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
 <20180529064415.GA4756@localhost.localdomain>
 <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
 <20180605092159.GA2544@work-vm>
 <46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
 <20180606111406.GD2660@work-vm> <20180606114228.GH1455@redhat.com>
 <20180606114817.GC3064@redhat.com>
In-Reply-To: <20180606114817.GC3064@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 13:48, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jun 06, 2018 at 12:42:28PM +0100, Richard W.M. Jones wrote:
>> On Wed, Jun 06, 2018 at 12:14:07PM +0100, Dr. David Alan Gilbert wrote=
:
>>> The problem with having a separate file is that you either have to co=
py
>>> it around with the image or have an archive.  If you have an archive
>>> you have to have an unpacking step which then copies, potentially a l=
ot
>>> of data taking some reasonable amount of time.  Storing a simple bit
>>> of data with the image avoids that.
>>
>> This isn't really true.  For OVA (ie. tar) we don't unpack them.
>> Adding file.offset and file.size in qemu's raw driver was crucial to
>> that optimization.
>=20
> Though that assumes you're only using the qcow2 file in read-only mode.=

> As soon as you need write access you need to unpack from the OVA so tha=
t
> the qcow2 file can grow its length when new sectors are allocated.

Except if the qcow2 file is at the end of the archive.  Then all you
need to do is adjust the length field of the tar file header.

Max


--3dtDjy1nXg3AZ5lAtgfhnbVyj4HLeD2af
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsXyzgACgkQ9AfbAGHV
z0DqYQgAnadwiG8H79CKbqCeGIp5vHZsujhUGxch0q16CDCcrJo+BP2WTfcE9xK8
Vp6Q0RHEJpIyEr6N/tSm1WyYeU9g+ZwNYzfTGsDxhOEAcSU28cdYAf0GoN82kst4
2Ur1MlfC1DMmK6lNSNVu+hOa4jkqB5i6mL8zmSumf++wslSMwF303YgQPNbPt0Y6
natwzjmAUH/cVWBIcTzFzyQ9ADphkDds3Jf70Hmg0atzwFebm66T8LBVt+SegRWU
ZQiOW+DdEufS4n+Pku6CMgDCt+/uNi1nj2woJzTWI8JlxRp8V0I4ArK9m+vlgKwI
rAt2XwkDe7SFMjEcH3nYA274k8Yntg==
=R/Tq
-----END PGP SIGNATURE-----

--3dtDjy1nXg3AZ5lAtgfhnbVyj4HLeD2af--
