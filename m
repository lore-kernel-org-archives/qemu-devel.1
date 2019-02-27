Received: from eggs.gnu.org ([209.51.188.92]:44627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyz9k-0007Gn-5f
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyz9j-00088f-99
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:21:52 -0500
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
	<20181214134240.217870-2-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <47142765-94bf-8786-f8e1-d1cf4b6c81e4@redhat.com>
Date: Wed, 27 Feb 2019 13:02:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181214134240.217870-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ndsaseegW37JEEpVGf9bs4gBfyX4klorD"
Subject: Re: [Qemu-devel] [PATCH v4 1/5] qcow2-refcount: fix
 check_oflag_copied
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ndsaseegW37JEEpVGf9bs4gBfyX4klorD
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org
Message-ID: <47142765-94bf-8786-f8e1-d1cf4b6c81e4@redhat.com>
Subject: Re: [PATCH v4 1/5] qcow2-refcount: fix check_oflag_copied
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
 <20181214134240.217870-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181214134240.217870-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.12.18 14:42, Vladimir Sementsov-Ogievskiy wrote:
> Increase corruptions_fixed only after successful fix.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ndsaseegW37JEEpVGf9bs4gBfyX4klorD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlx2fHMACgkQ9AfbAGHV
z0CoVQf8C2C89TpTl8eCPytosU+fKAR8oxBX6H87bwlwCwAX9jFm6w+ygf6RvVU0
dN8PzebpcY9T3KAlYTemkS7vrsR0H07mzjCeIiyd6NMHPmoIQrinLuOfjM/tfEk6
yOVrtcAC//VfXMkFJrNwVtaul5pyYu1auScu0uokRYo97p88xD757K8NbBiqgzPc
9VMTmKhezNPpZMMPsAjgiB6Wurojbyw16DjlAalaMK4/w1CAg5kCh0BcwL4dKywL
I5t/yCgpE+WxZD8sUpIsd6HRHhi4aobVIDIrjgP/JYOckU2Wall/17cOfcEPM7/R
b2OYW9En+ez0e8vnxLQmymJwNC6OLQ==
=iAsr
-----END PGP SIGNATURE-----

--ndsaseegW37JEEpVGf9bs4gBfyX4klorD--
