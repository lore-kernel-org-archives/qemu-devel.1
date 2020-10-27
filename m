Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5677C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A5A2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EkkPU07w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A5A2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXEOD-0000oe-AM
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 22:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXEKw-0005sv-Ij; Mon, 26 Oct 2020 22:03:46 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40163)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXEKr-0001Vw-66; Mon, 26 Oct 2020 22:03:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CKw3V5vKsz9sT6; Tue, 27 Oct 2020 13:03:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603764214;
 bh=oPIe4JLJ5Duv9K5uU5kWvlMQ3/YZmV1t4Hq/X4MA7kU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EkkPU07wGS1PCiZALraVETOpEZ66tTnVpdVbeqerVWPX6GSt41+KRgz+0BvBZFTQ6
 m0RRlrCkOGA3owXsNtMroJNvNGcOYrwurFw6YVpQV8BTTW1m/JlRIv5GAZOMSKNlXi
 mxdOaJc5BSanPbagtDwRLoa8Kqi+ivUWFYtMdUc0=
Date: Tue, 27 Oct 2020 13:00:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 3/4] target/ppc: Fix kvmppc_load_htab_chunk() error
 reporting
Message-ID: <20201027020016.GD4671@yekko.fritz.box>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
 <160371604713.305923.5264900354159029580.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline
In-Reply-To: <160371604713.305923.5264900354159029580.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 01:40:47PM +0100, Greg Kurz wrote:
> If kvmppc_load_htab_chunk() fails, its return value is propagated up
> to vmstate_load(). It should thus be a negative errno, not -1 (which
> maps to EPERM and would lure the user into thinking that the problem
> is necessarily related to a lack of privilege).
>=20
> Return the error reported by KVM or ENOSPC in case of short write.
> While here, propagate the error message through an @errp argument
> and have the caller to print it with error_report_err() instead
> of relying on fprintf().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c       |    4 +++-
>  target/ppc/kvm.c     |   11 +++++------
>  target/ppc/kvm_ppc.h |    5 +++--
>  3 files changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f51b663f7dcb..ff7de7da2875 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2341,8 +2341,10 @@ static int htab_load(QEMUFile *f, void *opaque, in=
t version_id)
> =20
>              assert(fd >=3D 0);
> =20
> -            rc =3D kvmppc_load_htab_chunk(f, fd, index, n_valid, n_inval=
id);
> +            rc =3D kvmppc_load_htab_chunk(f, fd, index, n_valid, n_inval=
id,
> +                                        &local_err);
>              if (rc < 0) {
> +                error_report_err(local_err);
>                  return rc;
>              }
>          }
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index d85ba8ffe00b..0223b93ea561 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2683,7 +2683,7 @@ int kvmppc_save_htab(QEMUFile *f, int fd, size_t bu=
fsize, int64_t max_ns)
>  }
> =20
>  int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
> -                           uint16_t n_valid, uint16_t n_invalid)
> +                           uint16_t n_valid, uint16_t n_invalid, Error *=
*errp)
>  {
>      struct kvm_get_htab_header *buf;
>      size_t chunksize =3D sizeof(*buf) + n_valid * HASH_PTE_SIZE_64;
> @@ -2698,14 +2698,13 @@ int kvmppc_load_htab_chunk(QEMUFile *f, int fd, u=
int32_t index,
> =20
>      rc =3D write(fd, buf, chunksize);
>      if (rc < 0) {
> -        fprintf(stderr, "Error writing KVM hash table: %s\n",
> -                strerror(errno));
> -        return rc;
> +        error_setg_errno(errp, errno, "Error writing the KVM hash table"=
);
> +        return -errno;
>      }
>      if (rc !=3D chunksize) {
>          /* We should never get a short write on a single chunk */
> -        fprintf(stderr, "Short write, restoring KVM hash table\n");
> -        return -1;
> +        error_setg(errp, "Short write while restoring the KVM hash table=
");
> +        return -ENOSPC;

I'm not entirely sure -ENOSPC is the right choice here - this
indicates that the kernel interface is not behaving as we expect.  But
I can't immediately think of what's a better choice, so, applied to
ppc-for-5.2.


>      }
>      return 0;
>  }
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 72e05f1cd2fc..73ce2bc95114 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -56,7 +56,7 @@ int kvmppc_define_rtas_kernel_token(uint32_t token, con=
st char *function);
>  int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp);
>  int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns=
);
>  int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
> -                           uint16_t n_valid, uint16_t n_invalid);
> +                           uint16_t n_valid, uint16_t n_invalid, Error *=
*errp);
>  void kvmppc_read_hptes(ppc_hash_pte64_t *hptes, hwaddr ptex, int n);
>  void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1);
>  bool kvmppc_has_cap_fixup_hcalls(void);
> @@ -316,7 +316,8 @@ static inline int kvmppc_save_htab(QEMUFile *f, int f=
d, size_t bufsize,
>  }
> =20
>  static inline int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t i=
ndex,
> -                                         uint16_t n_valid, uint16_t n_in=
valid)
> +                                         uint16_t n_valid, uint16_t n_in=
valid,
> +                                         Error **errp)
>  {
>      abort();
>  }
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+XfzAACgkQbDjKyiDZ
s5L6DBAAwk5WQ/L4o3Zd8sTWrzpZbnSds+ntt51RMkxASZUQJEOI6mhdVEeJlyru
yFpRK6DVFejtuWsC8d/AXvnx+UEpwMneM8D2l/b6hVPwPcLjLln7evK/D0R6P0cc
Pjw6agGQkMGkoQEUHxjou/Ze38Cxm9aumThxXKnKp7OGkaQdYasJZu2dGX0lL/OI
OdZQJtsSbaqYeVvAQtwUGfsTYMERgHdHZJVBdWaDGL2K9k+FJrZTTvHYcnQaIV+7
LWsUm8iOyokEjHB/KcW2LYt+2IEVIYBjwPrVsuN26/f18LOijZojo8jUp/glu5um
wCugUiYmXq9DWhH2H2kpamOpb8RvJl1MiLpEB27gXnbH8PSiPdr9+9GH1uCcHIPJ
vbKGx7Z8sRKQvi9UHuRW2x7gqRFjLpWFbdwM5sjYNThSXH3xwKSxErXEIlEF/yvh
Y1HQfP9QhZFZrLQE66DF1gV9/bgNoL+YdYUdmcd1U9NaxhnrvD/15WIC/hQWhasJ
XSnAxUa7V8oS1+3sIulSQ1/m+oAOmIpyeQuzTVbHarhCaxNJtpnGnKPwAtaH8b+k
ofW/iK/+9zAxGMVt18rfrC0LBtLqu2hcaBbqDNZz8vvY9B5ioax0jzERWHvkhJBE
XzjvVwg2bpSFTP29umVr3ZlPWNS5Qf6FbFbcX/kqTu2mJ69gHug=
=l50o
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--

