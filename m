Received: from eggs.gnu.org ([2001:4830:134:3::10]:46327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0osg-0006Nn-Bb
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0osf-00036L-Ia
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 08:38:46 -0400
References: <20170413203401.3213-1-mreitz@redhat.com>
	<20170413203401.3213-4-mreitz@redhat.com>
	<25e5ee1f-3bc7-d657-59db-c4e59baf8e28@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <23949686-9e74-6eb7-6f8c-c129f83d8faf@redhat.com>
Date: Wed, 19 Apr 2017 14:38:36 +0200
MIME-Version: 1.0
In-Reply-To: <25e5ee1f-3bc7-d657-59db-c4e59baf8e28@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xjLAdGavRXVi7hP2J3tCE1chr13aJGalQ"
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] qemu-img/convert: Move bs_n >
 1 && -B check down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xjLAdGavRXVi7hP2J3tCE1chr13aJGalQ
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <23949686-9e74-6eb7-6f8c-c129f83d8faf@redhat.com>
Subject: Re: [PATCH for-2.10 3/3] qemu-img/convert: Move bs_n > 1 && -B check
 down
References: <20170413203401.3213-1-mreitz@redhat.com>
 <20170413203401.3213-4-mreitz@redhat.com>
 <25e5ee1f-3bc7-d657-59db-c4e59baf8e28@redhat.com>
In-Reply-To: <25e5ee1f-3bc7-d657-59db-c4e59baf8e28@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.04.2017 23:17, Eric Blake wrote:
> On 04/13/2017 03:34 PM, Max Reitz wrote:
>> It does not make much sense to use a backing image for the target when=

>> you concatenate multiple images (because then there is no corresponden=
ce
>> between the source images' backing files and the target's); but it was=

>> still possible to give one by using -o backing_file=3DX instead of -B =
X.
>>
>> Fix this by moving the check.
>>
>> (Also, change the error message because -B is not the only way to
>>  specify the backing file, evidently.)
>=20
> For that matter, 'create -B' is intentionally? undocumented in the
> qemu-img --help and man page.  (Personally, I don't know why we don't
> want it documented - is it because it it not a universal option because=

> not all formats support backing files?)

(I suppose you mean convert instead of create)

Well, the man page at least documents that you can use backing_file for
the destination and what it will do. So documenting would probably be
just "Oh, you can also use -B, by the way."

I won't promise to write a patch to fix that, but I do hope I will. :-)

>> Cc: qemu-stable <qemu-stable@nongnu.org>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qemu-img.c                 | 14 +++++++-------
>>  tests/qemu-iotests/122.out |  4 ++--
>>  2 files changed, 9 insertions(+), 9 deletions(-)
>>
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks, as always!

Max

> Having a backing file for the destination may still make sense for some=

> convoluted workflow, but you can get that with a followup qemu-img reba=
se.


--xjLAdGavRXVi7hP2J3tCE1chr13aJGalQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlj3WkwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A/n0IAJB/25QpO4/+kAgJq2Iy8YqbUW+3BKXo
UTwj9OZ8ZTw6lXGMSqKd32if7HnhQCCh30SRZ8dZhxokF8btUTtq0v2tA25UQwi+
i/v/erCzLSK0ZUgAXOMmNBB0Vw4IjMAhHqG2uUNc+b7KdjpdIO5sV2LkPgtJau6+
RIvIAPevlrYpbe8VB6pGqiNu8ivBJZU+j60u2bD7VKILQsNl0+8aH37DwLIPTgIV
iueUXughXhEfXq3hnMo6ZPnY4ZfZHxQlm0vJAGB+Kqi+h6z6C/ndpY2LW4UB2G0I
FW3ZpXhtvYL7viQFQkcZp8d9YZdbSn0TR4X+b+VE8ajPPjvDgeZyBC4=
=n+lV
-----END PGP SIGNATURE-----

--xjLAdGavRXVi7hP2J3tCE1chr13aJGalQ--
