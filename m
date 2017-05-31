Received: from eggs.gnu.org ([2001:4830:134:3::10]:47883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG5ON-000533-Ma
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG5OM-00006A-GB
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:18:35 -0400
References: <20170531094330.1808-1-pbonzini@redhat.com>
	<20170531094330.1808-2-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <886dcc50-9f5f-da6b-502e-81fb94f42fa2@redhat.com>
Date: Wed, 31 May 2017 10:18:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170531094330.1808-2-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P61F0TPcADt9lSfmk7i0oDXXi5NJbismx"
Subject: Re: [Qemu-devel] [PATCH 01/11] qcow2: call CoQueue APIs under
 CoMutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P61F0TPcADt9lSfmk7i0oDXXi5NJbismx
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <886dcc50-9f5f-da6b-502e-81fb94f42fa2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/11] qcow2: call CoQueue APIs under CoMutex
References: <20170531094330.1808-1-pbonzini@redhat.com>
 <20170531094330.1808-2-pbonzini@redhat.com>
In-Reply-To: <20170531094330.1808-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 04:43 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/qcow2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 1c2697732b..c9193603b9 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1696,8 +1696,6 @@ static coroutine_fn int qcow2_co_pwritev(BlockDri=
verState *bs, uint64_t offset,
>      ret =3D 0;
> =20
>  fail:
> -    qemu_co_mutex_unlock(&s->lock);
> -
>      while (l2meta !=3D NULL) {
>          QCowL2Meta *next;
> =20
> @@ -1711,6 +1709,8 @@ fail:
>          l2meta =3D next;
>      }
> =20
> +    qemu_co_mutex_unlock(&s->lock);
> +
>      qemu_iovec_destroy(&hd_qiov);
>      qemu_vfree(cluster_data);
>      trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--P61F0TPcADt9lSfmk7i0oDXXi5NJbismx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLt7AAAoJEKeha0olJ0Nq+2gH/jvy1/YISObhmC3tpgaJ9oQ1
bWyBQ4cQiuYA7Gkxo/7zDYari9AsnmnzrhuBNpJsIfAeKPvq5qjaSarnVCSdCvY8
gre2wePLtv0ksFNGWcCn0A06sFTWHkCLnIQzmIy7xZHWegAA35zpcFr7DEICHNw3
5ePHIQoR+Xrm5HLwxJ5b902v+lk4mtrse4sqiFcnaxinCcWzSGDM3NYYyOmCHgo3
TGAGPlQGN7OVcL+uBjH8irSp4oZNT7+Nv3wJ8ghjlH5Vrp1uJAZ4jxLfDgJ+rRt+
nSF0040pi49ejtdnBiKBc72xMiWxtJKoXxjvLolSV+qbdR3ZqVU/Zj3/7DJ6WRE=
=DFPb
-----END PGP SIGNATURE-----

--P61F0TPcADt9lSfmk7i0oDXXi5NJbismx--
