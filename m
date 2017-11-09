Received: from eggs.gnu.org ([2001:4830:134:3::10]:45174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCtwN-0003c6-JW
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 16:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCtwM-000141-Q9
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 16:00:47 -0500
References: <20171109203025.27493-1-mreitz@redhat.com>
	<20171109203025.27493-5-mreitz@redhat.com>
	<73d1bcb3-aeaf-24d1-5cf0-359c58de0283@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f13d3d95-0a46-88c9-2acc-95dfdd6d8486@redhat.com>
Date: Thu, 9 Nov 2017 22:00:34 +0100
MIME-Version: 1.0
In-Reply-To: <73d1bcb3-aeaf-24d1-5cf0-359c58de0283@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oEGfNluLdBG8dVv1xUxQb8lCreklvxRHw"
Subject: Re: [Qemu-devel] [PATCH v2 4/5] iotests: Make 083 less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oEGfNluLdBG8dVv1xUxQb8lCreklvxRHw
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <f13d3d95-0a46-88c9-2acc-95dfdd6d8486@redhat.com>
Subject: Re: [PATCH v2 4/5] iotests: Make 083 less flaky
References: <20171109203025.27493-1-mreitz@redhat.com>
 <20171109203025.27493-5-mreitz@redhat.com>
 <73d1bcb3-aeaf-24d1-5cf0-359c58de0283@redhat.com>
In-Reply-To: <73d1bcb3-aeaf-24d1-5cf0-359c58de0283@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-09 21:58, Eric Blake wrote:
> On 11/09/2017 02:30 PM, Max Reitz wrote:
>> 083 has (at least) two issues:
>>
>> 1. By launching the nbd-fault-injector in background, it may not be
>>    scheduled until the first grep on its output file is executed.
>>    However, until then, that file may not have been created yet -- so =
it
>>    either does not exist yet (thus making the grep emit an error), or =
it
>>    does exist but contains stale data (thus making the rest of the tes=
t
>>    case work connect to a wrong address).
>>    Fix this by explicitly overwriting the output file before executing=

>>    nbd-fault-injector.
>>
>> 2. The nbd-fault-injector prints things other than "Listening on...".
>>    It also prints a "Closing connection" message from time to time.  W=
e
>>    currently invoke sed on the whole file in the hope of it only
>>    containing the "Listening on..." line yet.  That hope is sometimes
>>    shattered by the brutal reality of race conditions, so invoke grep
>>    before sed.
>=20
> Comment is now stale; s/invoke grep before sed/make the sed script more=

> robust/

*sigh*

It appears my hope of easily fixing patches is often shattered by the
brutal reality, too.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!  I'll fix the sentence when applying the series.

Max


--oEGfNluLdBG8dVv1xUxQb8lCreklvxRHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloEwfMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AWuoH/ivOJCGO5asbrmDXwMyhuNyw3/+Uv3C+
cr5tpJcpJMiQPioYTYRynTjMVDUfBFctz61ZTt0j4qwYm9FkyZ3OnFbUhLHwu1DC
f0HtdX6yU+p/K/Uy+W3q8qsyAyEJvRaRAQGwBTbmguFK5mY5CDnY3CZpP0imfBob
N8l8bxGQhRYWDabvZl7QELAS9qH6sLoCOYkAdRuvTzmtE0OVDiIe/EefCW4wpESS
Sl7c5AWImLtDuTS6GZCo5VfzRB5mxaUaIrwUPN9eK+3WrL97z2P4C7uw6vuI3ZEN
GEeJ+TkiEW450rtyl0+7/leWb43GmC35rxOY/sqq++fodiS4S9ojI5U=
=R5bo
-----END PGP SIGNATURE-----

--oEGfNluLdBG8dVv1xUxQb8lCreklvxRHw--
