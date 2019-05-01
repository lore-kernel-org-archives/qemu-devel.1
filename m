Received: from eggs.gnu.org ([209.51.188.92]:34846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hLeWo-0005LQ-7J
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hLeWl-0005jM-5Q
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:59:22 -0400
Date: Wed, 1 May 2019 11:39:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190501013910.GA13618@umbus.fritz.box>
References: <20190430172842.27369-1-liboxuan@connect.hku.hk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20190430172842.27369-1-liboxuan@connect.hku.hk>
Subject: Re: [Qemu-devel] [PATCH] target/ppc/kvm: Fix trace typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Boxuan Li <liboxuan@connect.hku.hk>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "open list:PowerPC" <qemu-ppc@nongnu.org>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2019 at 01:28:42AM +0800, Boxuan Li wrote:
> Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>

Applied to ppc-for-4.1, thanks.

> ---
>  target/ppc/kvm.c        | 2 +-
>  target/ppc/trace-events | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 02e22e2017..1a9caf8f40 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1721,7 +1721,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_r=
un *run)
>              trace_kvm_handle_dcr_write();
>              ret =3D kvmppc_handle_dcr_write(env, run->dcr.dcrn, run->dcr=
=2Edata);
>          } else {
> -            trace_kvm_handle_drc_read();
> +            trace_kvm_handle_dcr_read();
>              ret =3D kvmppc_handle_dcr_read(env, run->dcr.dcrn, &run->dcr=
=2Edata);
>          }
>          break;
> diff --git a/target/ppc/trace-events b/target/ppc/trace-events
> index 7b3cfe11fd..3dc6740706 100644
> --- a/target/ppc/trace-events
> +++ b/target/ppc/trace-events
> @@ -22,7 +22,7 @@ kvm_failed_put_vpa(void) "Warning: Unable to set VPA in=
formation to KVM"
>  kvm_failed_get_vpa(void) "Warning: Unable to get VPA information from KV=
M"
>  kvm_injected_interrupt(int irq) "injected interrupt %d"
>  kvm_handle_dcr_write(void) "handle dcr write"
> -kvm_handle_drc_read(void) "handle dcr read"
> +kvm_handle_dcr_read(void) "handle dcr read"
>  kvm_handle_halt(void) "handle halt"
>  kvm_handle_papr_hcall(void) "handle PAPR hypercall"
>  kvm_handle_epr(void) "handle epr"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzI+LwACgkQbDjKyiDZ
s5Lzqg/+ORBCrLY882RwAMJSx7nE/WQpZbXx7RA3Bl5O9fLrY7QWq1Yy0k3KkNOG
iF1nUHpl8lTnrtPcvrwPBx0Szj7w9ezOELA5nMTPbpVRQoBIzoxhToIM8mPPUOT8
2VqtbS3y4anIOjLh/yxVBXJ/BY6d+iTTzORgTBQ5iBS1YPBpCwFLgJHhS4uSJv+2
PcFQ+MHziZqSKAgaynaz19uj/dmeAntF7ROHCzZgPveS5/eensS4VaUHda+0F1wu
hohPTFWym9QNLyOUmzskaF5GSl+hSvK25MNZjSqCU6xXouaI3BllYv8JN8+9hqZg
0HuIjfdIbXeYO2ZJ7jKs7HZmQEbO9HhpageyRenY3GxFaYSlwRQrd5jV7J05nn2I
xEpwG2feE165+sxBtCe1viuMz366k0Gs65VLXvLDWgQ6J7u1iuehQ6SOoinVSn57
Q6XrV4tEyc/bIzzMT8skQwZcIlm5wwQ+v7sU1vQtnfCWRdNctwgVGwLYmPISM3LK
9HHEgw+XBJVx24keTP1g5/leYkZ/ePqPVEHHdE51brJ8zoEQjECUOm0mWJhoVMxf
xYOrwY5HnXcFJd6V7ZFZmBKQwN1VXB502bPbPG7/6c1kJQwXifr5OfdVg00hC++R
JWf8XxbB57YEqUrFWlevz3CkQ2Z2/7/VgdyQ43qBdBxvKFH42Gc=
=ac0E
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
