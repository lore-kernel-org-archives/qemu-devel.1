Received: from eggs.gnu.org ([2001:4830:134:3::10]:58557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv1ea-0006wf-Mu
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv1eX-0001wZ-HC
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:04:16 -0400
References: <20170331170512.10381-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c38b9069-a2e9-961a-6201-c44b25a5c906@redhat.com>
Date: Mon, 3 Apr 2017 15:03:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170331170512.10381-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QrEKjglNbaOimQPtgbo8druFvrroBVusK"
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/parallels: Avoid overflows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QrEKjglNbaOimQPtgbo8druFvrroBVusK
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c38b9069-a2e9-961a-6201-c44b25a5c906@redhat.com>
Subject: Re: [PATCH for-2.9] block/parallels: Avoid overflows
References: <20170331170512.10381-1-mreitz@redhat.com>
In-Reply-To: <20170331170512.10381-1-mreitz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.03.2017 19:05, Max Reitz wrote:
> Change the types of variables in allocate_clusters() to int64_t so we d=
o
> not have to worry about potential overflows.
>=20
> Add an assertion that our accesses to s->bat[] do not result in a buffe=
r
> overflow and that the implicit conversion performed when invoking
> bat_entry_off() does not result in an integer overflow.
>=20
> Coverity-id: 1307776
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> This supercedes Peter's patch "block/parallels.c: avoid integer overflo=
w
> in allocate_clusters()".
> ---
>  block/parallels.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Thanks for reviewing, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--QrEKjglNbaOimQPtgbo8druFvrroBVusK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljiSCwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A34wH/3O2LzhinzV7zV1NnwM3O7l5pQEOB7Fs
zcUGkEXzM7rYhQGWfzyboXPevYdLzUqYwMW+f4zwe4vUtkFdbppWKN3VarwH+oIu
slAU1OHRYzMQGIqBlSYqCfMo4QBzppDoR9KyQLnQiWUfTeAz6lGL0ZPm2vGDPcHo
a20bD7x5uSBqJeB4vys75PFX+wWpDKrRioJbXZzwXjVbh22MOaTcWfEVCgZd2sa5
g42TdEBl2lHG5MOcZcIRia0OodpxHe+EO2RnPoeOwwnxKXjm0iIOvC1aCtTylhax
++Qu9N1BHDnjUTY7r7XdosSkRxPTJ8vUOI3SHbp788fl9BlGgZ1z4AM=
=pn1x
-----END PGP SIGNATURE-----

--QrEKjglNbaOimQPtgbo8druFvrroBVusK--
