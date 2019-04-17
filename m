Received: from eggs.gnu.org ([209.51.188.92]:33477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGoDC-0004Yw-Ji
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGoDB-0006K4-QU
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:19:06 -0400
References: <20190417171101.1254-1-eblake@redhat.com>
	<20190417171101.1254-2-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <06319948-8ce3-7fdc-9398-7a9fab36c4c6@redhat.com>
Date: Wed, 17 Apr 2019 19:18:59 +0200
MIME-Version: 1.0
In-Reply-To: <20190417171101.1254-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F8mA5E6nf5NFa0SlcYMsTcY3FQpYXQs8v"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] cutils: Fix size_to_str() on 32-bit
 platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F8mA5E6nf5NFa0SlcYMsTcY3FQpYXQs8v
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org
Message-ID: <06319948-8ce3-7fdc-9398-7a9fab36c4c6@redhat.com>
Subject: Re: [PATCH v3 1/2] cutils: Fix size_to_str() on 32-bit platforms
References: <20190417171101.1254-1-eblake@redhat.com>
 <20190417171101.1254-2-eblake@redhat.com>
In-Reply-To: <20190417171101.1254-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.04.19 19:11, Eric Blake wrote:
> When extracting a human-readable size formatter, we changed 'uint64_t
> div' pre-patch to 'unsigned long div' post-patch. Which breaks on
> 32-bit platforms, resulting in 'inf' instead of intended values larger
> than 999GB.
>=20
> Fixes: 22951aaa
> CC: qemu-stable@nongnu.org
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  util/cutils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--F8mA5E6nf5NFa0SlcYMsTcY3FQpYXQs8v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAly3YAQACgkQ9AfbAGHV
z0DyyQf9FcMrvk/ZfqX8sXOAOsNwh6KVl7MzLayTCk1G3+8E+NPNxwfPT85k2jWJ
6zZLy12EkcZkJX+8wVRw5ZuGvj1LGRmINYE50mFFSre3V484IhxeOxjUeV/5pcx+
GL2JlPWlCsFyrX1eZGjrhwVeovzAVvuoJgslvOiIi0aOQhrs6pP1z71SP7BIdgKW
zyjjnwsDniv3Yjhr9sxd72qphJc5W61vdyBLByyHxgBIHucMBQdciHvLUSrcvYEV
HrpCldenkH+VNcvlXyk85I5UwddRu/RYHVK+sovItBi2Qh1OPalAB2xd8ibReriF
6gXGiDN63IaRj+RHnfttmsKkUv6kiA==
=ocNo
-----END PGP SIGNATURE-----

--F8mA5E6nf5NFa0SlcYMsTcY3FQpYXQs8v--
