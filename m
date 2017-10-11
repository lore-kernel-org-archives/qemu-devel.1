Received: from eggs.gnu.org ([2001:4830:134:3::10]:56227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2FQg-0002pZ-2y
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 07:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2FQf-0005AU-7f
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 07:44:02 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-6-mreitz@redhat.com>
	<20171010091420.GD4177@dhcp-200-186.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3ecdb2b4-735d-ac96-f1b8-e48ffa63e476@redhat.com>
Date: Wed, 11 Oct 2017 13:43:44 +0200
MIME-Version: 1.0
In-Reply-To: <20171010091420.GD4177@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5mO7mj1HjCRRVIVEVe1RETHAufSM3HLpb"
Subject: Re: [Qemu-devel] [PATCH 05/18] block/mirror: Convert to coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5mO7mj1HjCRRVIVEVe1RETHAufSM3HLpb
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng
 <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <3ecdb2b4-735d-ac96-f1b8-e48ffa63e476@redhat.com>
Subject: Re: [PATCH 05/18] block/mirror: Convert to coroutines
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-6-mreitz@redhat.com>
 <20171010091420.GD4177@dhcp-200-186.str.redhat.com>
In-Reply-To: <20171010091420.GD4177@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-10 11:14, Kevin Wolf wrote:
> Am 13.09.2017 um 20:18 hat Max Reitz geschrieben:
>> In order to talk to the source BDS (and maybe in the future to the
>> target BDS as well) directly, we need to convert our existing AIO
>> requests into coroutine I/O requests.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Please follow through with it and add a few patches that turn it into
> natural coroutine code rather than just any coroutine code. I know I di=
d
> the same kind of half-assed conversion in qed, but mirror is code that
> is actually used and that people look at for more than just a bad
> example.
>=20
> You'll probably notice more things when you do this, but the obvious
> things would be changing mirror_co_read() into a mirror_co_copy() with
> the former callbacks inlined; keeping op on the stack instead of
> mallocing it in mirror_perform() and free it deep inside the nested
> functions that used to be callbacks; and probably also cleaning up the
> random calls to aio_context_acquire/release() that will now appear in
> the middle of the function.
>=20
> Anyway, that's for follow-up patches (though ideally in the same
> series), so for this one you can have:
>=20
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Phew. :-)

I think I'll write the patches (while working on v2), but I'll send them
as a follow-up.

Max


--5mO7mj1HjCRRVIVEVe1RETHAufSM3HLpb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlneA/ESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AfyQH/3PX2hczZI1IK2J2obwy/VSKuZ+gEqy5
cNkRsSP2HHg10XqkWRcVGnnctNIYM3hYk80hnKLb1R0FomPp09rceYDG3C3rp6d0
mc4rM9kIfRrPQ85OcFHMMe6JlQgj94Z5cWJ5o0R9bX4tAwDnaYrLlIeaOH+TLOCN
q8EiAmZ0rxFVsb55xX81nq5MWO1jrQvamG8VuP6S0bDquPwNOXk+Yh5ScJiY1tnO
FhKt63wTfINywp3R2ieCbhftD7PyVRRlMXzRSa+oxVqFvd3e7cc17p6j4zi4gAG2
QDOdNIXSUAIAFPidw+PJyqfp8/yJ5DE417Qv1gyNOUKkqjPYPH+nlIs=
=xJNg
-----END PGP SIGNATURE-----

--5mO7mj1HjCRRVIVEVe1RETHAufSM3HLpb--
