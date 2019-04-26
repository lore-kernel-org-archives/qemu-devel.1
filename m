Received: from eggs.gnu.org ([209.51.188.92]:59743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK5Vd-0007Nl-1v
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK5Vb-0007KP-Ly
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:23:40 -0400
References: <20190415144948.78568-1-vsementsov@virtuozzo.com>
	<20190415144948.78568-5-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <40713c93-f362-edc1-5aef-fa0d88a280af@redhat.com>
Date: Fri, 26 Apr 2019 20:18:22 +0200
MIME-Version: 1.0
In-Reply-To: <20190415144948.78568-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GLp6wIg6SPpwI8NaOLngEhZGaCGiKLgFE"
Subject: Re: [Qemu-devel] [PATCH v6 4/5] block/backup: unify different modes
 code path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GLp6wIg6SPpwI8NaOLngEhZGaCGiKLgFE
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <40713c93-f362-edc1-5aef-fa0d88a280af@redhat.com>
Subject: Re: [PATCH v6 4/5] block/backup: unify different modes code path
References: <20190415144948.78568-1-vsementsov@virtuozzo.com>
 <20190415144948.78568-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190415144948.78568-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.04.19 16:49, Vladimir Sementsov-Ogievskiy wrote:
> Do full, top and incremental mode copying all in one place. This
> unifies the code path and helps further improvements.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 43 ++++++++++---------------------------------
>  1 file changed, 10 insertions(+), 33 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--GLp6wIg6SPpwI8NaOLngEhZGaCGiKLgFE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzDS28ACgkQ9AfbAGHV
z0CsGggAgc2kNMyzwYolWPZ8QHgTNMqUM1Zby1h/Xxk2R2jW9oOfAwouP8d2gXai
ACpT2WsHmRfZegBiBbxoustGyjh033IX8yEd+/ya32rJXtAD/Ujr244E1iJvePEf
3u8I7mPTZ7HzPPwDQYZLOC05f9cV/NoC+w7Ge81mNBWHAD7sqBh1Hl+dZX+NU3GB
in4/yCP8XCif636ywq8gcQPowM1t55YuQIif2sE6816Q8ygxdWcvDr2S7gEmaSjS
5pnFBBx+/SpnbyHfoTFbev/uhBVhRedD/uNc/UDWt4QmoKBiNlYQXW3isNG3Q58P
atY9qyGX5ByRgeb+eAJhjYHeQ1dZiA==
=Imjv
-----END PGP SIGNATURE-----

--GLp6wIg6SPpwI8NaOLngEhZGaCGiKLgFE--
