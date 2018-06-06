Received: from eggs.gnu.org ([2001:4830:134:3::10]:33569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQZxV-0001j1-Pz
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQZxR-0001EF-Qa
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:02:45 -0400
References: <20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606173140-mutt-send-email-mst@kernel.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <32e28841-1139-4a2b-1492-06776b18a41f@redhat.com>
Date: Wed, 6 Jun 2018 17:02:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180606173140-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vZGzWCUinF3zWi36w9RxevTQ0iMB5TVqf"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vZGzWCUinF3zWi36w9RxevTQ0iMB5TVqf
From: Max Reitz <mreitz@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
Message-ID: <32e28841-1139-4a2b-1492-06776b18a41f@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180524113251.GB4660@redhat.com>
 <d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
 <20180528183058.GG2209@redhat.com>
 <20180528183833.GJ4580@localhost.localdomain>
 <20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
 <20180529064415.GA4756@localhost.localdomain>
 <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
 <20180606123237.2235ae4a@kitsune.suse.cz>
 <bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
 <20180606173140-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180606173140-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 16:43, Michael S. Tsirkin wrote:
> On Wed, Jun 06, 2018 at 01:02:53PM +0200, Max Reitz wrote:
>> Yeah, but why make qcow2 that format?  That's what I completely fail t=
o
>> understand.
>=20
> Because why not? It's cheap to add it there and is much easier
> than teaching people about a new container format.

"new" container format?  qcow2 is not a container format, so that would
be teaching people something new anyway.

> Eric Blake put it very well I think.  There are several things that
> several people would like to see addressed:
>=20
> (1) A sensible list of guest visible aspects of the VM
>   preserving which across VM restarts we deem critical enough to suppor=
t
>   starting guests.
>   At this point this includes at least architecture and machine type.

If you use a whole management layer, that is trivial anyway (and that
seems to be Dave's assumption), because that management layer can store
its configuration somewhere.  Dave's issue was about downloading foreign
images, not about restarts.

> (2) A compact file format for serializing list (1)

OK.

> (3) Ability to store file (2) in a qcow2 image

I see that people are asking this, yes, although I don't quite get the
point.

> You are asking why store (2) in qcow2 image specifically. The answer is=

> it's just one place where we can store it. The answer is we don't need
> to involve qemu-block at all for storing it in other places.
>=20
> But for many people it will be handy to have it in the same file, and
> qcow2 is popular enough that many people will be well served if it's
> there.

Note that I'm also asking why it needs to be a single file.
Furthermore, I'm asking what the final scope is intended to be.  I don't
believe qcow2 to be the correct format for a whole appliance, but I do
believe that assuming that people want to provide just a qcow2 file
without anything else means already accepting it *is* an appliance.  But
Dave seems to reject that idea.

Max


--vZGzWCUinF3zWi36w9RxevTQ0iMB5TVqf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsX94IACgkQ9AfbAGHV
z0DwHQf+PfwZLm9t6pAqjLgG0PA+dnoXvfhqg0tacU6C/fwa153Hghzw1wYrddvE
nHDQ3sSo4QKlGK8XbwW2cTg5y43Zmu9+SKvjW3xr3ulrMtgH4ZzlTQBUrkWCVlZw
MFdT05imCm1l+B7mHNNuXHw5G1vOWzLRF2U7BcC9bcB6fn7GSsVO5zNuEd0ExFR+
ot8g/01WVUmTY5ngbNDcUTFmMP49nkjGpqji74iF110YPIg2HjUbroowfygtrefx
/e/QJfWI8I4Ld6VEBCSTpkmz0q8MoXgWXbso3ojqcG+ITz67S8exoV6zX040iuNn
2e1MthE+cBT6e8wOagF0qxSb7mdzqw==
=hW+i
-----END PGP SIGNATURE-----

--vZGzWCUinF3zWi36w9RxevTQ0iMB5TVqf--
