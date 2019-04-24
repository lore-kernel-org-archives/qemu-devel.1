Received: from eggs.gnu.org ([209.51.188.92]:34349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hJIMV-0000Pz-8i
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hJI7K-00064r-R4
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:39:19 -0400
References: <20180713111424.23670-1-mreitz@redhat.com>
	<20180713111424.23670-2-mreitz@redhat.com>
	<a36f26f1-61b3-799f-5cee-281257cba123@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3c983edf-047f-c463-90f2-f1b542d9f3dd@redhat.com>
Date: Wed, 24 Apr 2019 15:38:54 +0200
MIME-Version: 1.0
In-Reply-To: <a36f26f1-61b3-799f-5cee-281257cba123@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LN3Ni5ZNrpgspsOQUB9OvNNpCFS8e9Rkw"
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu-img: Allow rebase with no input
 base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LN3Ni5ZNrpgspsOQUB9OvNNpCFS8e9Rkw
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3c983edf-047f-c463-90f2-f1b542d9f3dd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu-img: Allow rebase with no input
 base
References: <20180713111424.23670-1-mreitz@redhat.com>
 <20180713111424.23670-2-mreitz@redhat.com>
 <a36f26f1-61b3-799f-5cee-281257cba123@redhat.com>
In-Reply-To: <a36f26f1-61b3-799f-5cee-281257cba123@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.04.19 20:55, Eric Blake wrote:
> On 7/13/18 6:14 AM, Max Reitz wrote:
>> Currently, you cannot add a backing file to an image when it currently=

>> has none.  It is really simple to allow this, though (effectively by
>> setting old_backing_size to 0), so this patch does just that.
>=20
> Can't you do that with 'rebase -u'? I guess the point of this patch is
> to make 'rebase' without -u also able to add a backing file?  A bit mor=
e
> clarity in the commit message, such as a sample command line (and
> possibly even the error it issued pre-patch) would help.

Yes, this is about normal rebase without -u.

There is an example in the cover letter, but I can add it to this patch
here, too, yes.

>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qemu-img.c | 61 ++++++++++++++++++++++++++++++-----------------------=
-
>>  1 file changed, 34 insertions(+), 27 deletions(-)
>=20
> At any rate, the code looks fine, even if the diff is harder to read
> because of added indentation.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Max


--LN3Ni5ZNrpgspsOQUB9OvNNpCFS8e9Rkw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzAZu4ACgkQ9AfbAGHV
z0Cruwf+Pd0xQD119UktAbODprzQYu4GvTGgKB2Hw7W+CME+fQ9sxR/zkERpHe6h
aUyXME4v+/2EI8eEMWPpxK6sP0nLCnMAJ3RmFVG2Ud8xloLOeXiXK/V5KF92VVDJ
aNHPfKlAMGZ8RE2GAMc0SQDFYMqAbVh36FFN6KfGtUuF16ZuGMTT40zxVhlnOwj/
IdvnemV11ovHCuUDy3v+9mGUdx1gb/5UcotNnhxQs+VUP3VPjqsjAfgbUDcggqjR
t9dPyBwap5omCyVcAmw5R+M42PHOKBgvh0xLZjrgBke/Rq6lEUybjACt0WL3WMbe
+ZGH1mMKIXLtjpwoWRFBrJpWH6xEHw==
=EpZE
-----END PGP SIGNATURE-----

--LN3Ni5ZNrpgspsOQUB9OvNNpCFS8e9Rkw--
