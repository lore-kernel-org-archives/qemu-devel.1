Received: from eggs.gnu.org ([209.51.188.92]:38399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghysG-0001Bt-4w
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghysD-0004RY-Dt
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:37:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ghysD-0004Q6-4f
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:37:29 -0500
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
	<20190111063732.10484-2-xiaoguangrong@tencent.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb4db77c-0cee-0f3b-d81a-0cc88d7f5406@redhat.com>
Date: Fri, 11 Jan 2019 09:37:16 -0600
MIME-Version: 1.0
In-Reply-To: <20190111063732.10484-2-xiaoguangrong@tencent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RHTvSvPHyAkCpOt4S0LsNyOMcugPwr3Od"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] migration: introduce
 pages-per-second
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RHTvSvPHyAkCpOt4S0LsNyOMcugPwr3Od
From: Eric Blake <eblake@redhat.com>
To: guangrong.xiao@gmail.com, pbonzini@redhat.com, mst@redhat.com,
 mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com,
 peterx@redhat.com, wei.w.wang@intel.com, quintela@redhat.com,
 cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>
Message-ID: <fb4db77c-0cee-0f3b-d81a-0cc88d7f5406@redhat.com>
Subject: Re: [PATCH v2 1/3] migration: introduce pages-per-second
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
 <20190111063732.10484-2-xiaoguangrong@tencent.com>
In-Reply-To: <20190111063732.10484-2-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 12:37 AM, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>=20
> It introduces a new statistic, pages-per-second, as bandwidth or mbps i=
s
> not enough to measure the performance of posting pages out as we have
> compression, xbzrle, which can significantly reduce the amount of the
> data size, instead, pages-per-second is the one we want
>=20
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  hmp.c                 |  2 ++

> +++ b/migration/migration.h
> @@ -126,6 +126,12 @@ struct MigrationState
>       */
>      QemuSemaphore rate_limit_sem;
> =20
> +    /* pages already send at the beggining of current interation */

beginning, iteration

> +    uint64_t iteration_initial_pages;
> +
> +    /* pages transferred per second */
> +    double pages_per_second;
> +
>      /* bytes already send at the beggining of current interation */

although you copied the existing typos

> +++ b/qapi/migration.json
> @@ -41,6 +41,9 @@
>  #
>  # @multifd-bytes: The number of bytes sent through multifd (since 3.0)=

>  #
> +# @pages-per-second: the number of memory pages transferred per second=

> +#        (Since 3.2)
> +#

3.2 was last year; you'll need to update your series to use 4.0 on all
new stuff

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--RHTvSvPHyAkCpOt4S0LsNyOMcugPwr3Od
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw4uCwACgkQp6FrSiUn
Q2pF2Qf/XYDNU9b71Oc5S4KZXPL3juoCc89gvBqTFWmCZBtO3CyUTVbAmYjtEf5j
RxO3copvcScQwvLQwqxRcCzhCevcD5bx7QS56BJQRvhq99lLeMTXkvnC67NSlOn3
APYTooNSzKjSmTMUqXkNSYeYnDVBAx4l1lCZHjqQSZJNYNfgTVRDW+fxum62BTrj
U+EH/g6zQQP4t0g06ey5kMDrHe5VE1NefrXaiC0sJisxKkkB9heKgJycExEbqVmd
LKTPKyuMAmYsTI2SgGuxirTKgV0zu45nAWtF/cntQoxFgiaY7u7m4u2VBoMCS61v
1p++8zNXID8WwFpxm+2bp8fzc8Ebhg==
=Q3HT
-----END PGP SIGNATURE-----

--RHTvSvPHyAkCpOt4S0LsNyOMcugPwr3Od--
