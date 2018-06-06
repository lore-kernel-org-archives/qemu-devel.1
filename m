Received: from eggs.gnu.org ([2001:4830:134:3::10]:59983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQZsd-0004cV-Rm
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQZsd-0006Cy-1N
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:57:43 -0400
References: <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606113720.GA2661@work-vm>
	<2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
	<20180606134233.GQ7451@localhost.localdomain>
	<20180606174635-mutt-send-email-mst@kernel.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6dd60ae2-36b6-96ca-fe65-77c7d05957cc@redhat.com>
Date: Wed, 6 Jun 2018 16:57:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180606174635-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kOHf9bZUlbMRVVvDZ3ly0gXKlg4U5pOxr"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kOHf9bZUlbMRVVvDZ3ly0gXKlg4U5pOxr
From: Max Reitz <mreitz@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <6dd60ae2-36b6-96ca-fe65-77c7d05957cc@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
References: <20180528212510.GC4660@redhat.com>
 <20180529064415.GA4756@localhost.localdomain>
 <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
 <20180606123237.2235ae4a@kitsune.suse.cz>
 <bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
 <20180606131929.44d0fd6b@kitsune.suse.cz>
 <93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
 <20180606113720.GA2661@work-vm>
 <2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
 <20180606134233.GQ7451@localhost.localdomain>
 <20180606174635-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180606174635-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 16:55, Michael S. Tsirkin wrote:
> On Wed, Jun 06, 2018 at 10:42:33AM -0300, Eduardo Habkost wrote:
>>> If we want a grand vision where a single file stores the whole VM, wh=
y
>>> not invest the work and make it right from the start?
>>
>> We don't want a grand vision where a single file stores the whole
>> VM.  This is exactly what I would like to avoid, by not inventing
>> a whole different appliance file format.
>=20
> Besides, trying to get a grand vision from the start is a sure
> way to never have the design leave the drawing board.

Yes, but with our own non-qcow2 format we could easily start with
something simple and start over later.

> What we are asking for at this point is a way to stick a named blob in
> an image that people can use with qemu without jumping through hoops.
>=20
> It seems like a generic enough addition that it seems highly likely
> to be useful down the road and harmless enough that maintaining
> it won't become a burden.

Yes.  Its genericity is a big part of what's bothering me.

> Can we agree on that as a first step, so we can build that foundation
> and move on to actually building ways to use it?

No, because I don't want to agree on putting anything inside qcow2
before I know its scope.

Max


--kOHf9bZUlbMRVVvDZ3ly0gXKlg4U5pOxr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsX9lcACgkQ9AfbAGHV
z0AYGwgAoVgX43pF1sLqlHU8Xb5YyMpsBgFaaFkAI/yLwiuEC3OXQO/1mD+hCpoe
W/xPTmDcMGRo4+jjx5dvjBRrgZPui8+c4/sIcqeBkkJlVgUM7QCN5/aSP/6lTYBK
9m0V3+7vpPwZiFRsXBdr6Rh9MAcwLAvfrG/8uMwCikr2ERP8jO2ciK16vwIRaFMK
UZBsxoPXUEIH04jg6CVoKCLW7GfzLLt0khh6uGrUtbsGsL5ijZF1caYC5JdLxhBf
WlyuDagOBerjA7pnsurv4mzDA2Y22r4qE7KsU/k3fRr1hCZIClETDz3/SY+HnTpz
p8AvU41LZqq3fBWd6TjVW8CHn+EUuA==
=BZ6w
-----END PGP SIGNATURE-----

--kOHf9bZUlbMRVVvDZ3ly0gXKlg4U5pOxr--
