Received: from eggs.gnu.org ([2001:4830:134:3::10]:55182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dtlaV-0000o3-PP
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 22:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dtlaU-0005GA-Is
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 22:15:07 -0400
Date: Mon, 18 Sep 2017 10:11:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170918001126.GA15823@umbus>
References: <150548133297.5945.7401220081077343726.stgit@bahia.lan>
	<150548135159.5945.17545667206379508322.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <150548135159.5945.17545667206379508322.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/4] ppc/kvm: drop kvmppc_has_cap_htab_fd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2017 at 03:15:51PM +0200, Greg Kurz wrote:
> It never got used since its introduction (commit 7c43bca004af).
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11, thanks.

> ---
>  target/ppc/kvm.c     |    5 -----
>  target/ppc/kvm_ppc.h |    6 ------
>  2 files changed, 11 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 1deaf106d2b9..00d7029b8d7a 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2448,11 +2448,6 @@ bool kvmppc_has_cap_epr(void)
>      return cap_epr;
>  }
> =20
> -bool kvmppc_has_cap_htab_fd(void)
> -{
> -    return cap_htab_fd;
> -}
> -
>  bool kvmppc_has_cap_fixup_hcalls(void)
>  {
>      return cap_fixup_hcalls;
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index f780e6ec7b72..08aab46c5a56 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -51,7 +51,6 @@ uint64_t kvmppc_rma_size(uint64_t current_size, unsigne=
d int hash_shift);
>  #endif /* !CONFIG_USER_ONLY */
>  bool kvmppc_has_cap_epr(void);
>  int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function=
);
> -bool kvmppc_has_cap_htab_fd(void);
>  int kvmppc_get_htab_fd(bool write);
>  int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns=
);
>  int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
> @@ -246,11 +245,6 @@ static inline int kvmppc_define_rtas_kernel_token(ui=
nt32_t token,
>      return -1;
>  }
> =20
> -static inline bool kvmppc_has_cap_htab_fd(void)
> -{
> -    return false;
> -}
> -
>  static inline int kvmppc_get_htab_fd(bool write)
>  {
>      return -1;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm/DysACgkQbDjKyiDZ
s5KyPBAAsMhoqzTVEz3o25icBGpEAeYMnhs73SeKTMUsFppQi0cyqo0rOPcnyYJZ
/ekXi1fW24Z+mwx9GpRPuRXNzEkHRpQsDSkez9Nxt2/rb15JzMo28cKLd2UwFNRE
9fbwZcBEJGMr9lavsNlmVQPrV8ecwl2SMjuZ9kA+UwtoM3ZWHvWCcCEwPtQ26Doo
lwhbTkNQ8cfne5tXR1PoorA4cmRFRNc9MUIccvbeFzEyO0Cpzj5Tu+AvcgWLVfiS
ibfVgTRR0Xy7IpIhLLS56QM8xbrd7+Bm2sXAFXOMHTqYkaoPAvAGk6CUkSpPUEvu
f3V+vhPhWG1Pebaha2KHoPulyceEjd5BSOl1v9VYCQeo9PkFQDUZcKvuoLd5ugQ2
KG0qrzTJFqJgEA/Ie6f0xlUf27q/JU09RbsLLN6Q5XlWtVmuPiOr7N1DItEpGfaG
PXJ/YRzJcW+a7W0/vL1lv+Y5mWeRTYCniwI/G9XFCePoF8WMVCYrshfdO2L5T0/z
XpyO0/WJR8ZmoPIIS8PZQd23MnZ29MlpYFVz/ik3KQxuF9DqYQcZHijrflukfpSc
FViNfCjao9uKiFU9E3eZWTrKCkzNcUZ8JhLep5kE/HwYvAV/NEfYLpvh3+m3zIa4
WIa09DlJRft5wLD8A8goNPBltgWjHfDJb1towEPo7rt1jGaPHtg=
=8uUm
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
