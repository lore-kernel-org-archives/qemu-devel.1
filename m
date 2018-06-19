Received: from eggs.gnu.org ([2001:4830:134:3::10]:43482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVGPc-0005oU-74
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVGPY-0007wM-A4
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:11:08 -0400
Date: Tue, 19 Jun 2018 21:17:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180619111716.GA3546@umbus.fritz.box>
References: <20180619085631.2859-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20180619085631.2859-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] xics-kvm: Fix compile warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 06:56:31PM +1000, Alexey Kardashevskiy wrote:
> This fixes uninitialized variable warning:
>=20
> /home/aik/p/qemu/hw/intc/xics_kvm.c: In function =E2=80=98ics_set_kvm_sta=
te=E2=80=99:
> /home/aik/p/qemu/hw/intc/xics_kvm.c:281:20: warning: =E2=80=98ret=E2=80=
=99 may be used uninitialized in this function [-Wmaybe-uninitialized]
>              return ret;
>                     ^~~
>=20
> Discovered with gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0 from Ubuntu 18.04.
>=20
> Fixes: bf358b541b8 "xics_kvm: use KVM helpers"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

This no longer applies on ppc-for-3.0.

> ---
>  hw/intc/xics_kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 8bdf6af..48efbce 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -273,8 +273,8 @@ static int ics_set_kvm_state(ICSState *ics, int versi=
on_id)
>                  state |=3D KVM_XICS_QUEUED;
>          }
> =20
> -        kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> -                          i + ics->offset, &state, true, &local_err);
> +        ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURC=
ES,
> +                                i + ics->offset, &state, true, &local_er=
r);
>          if (local_err) {
>              error_report("Unable to restore KVM interrupt controller sta=
te"
>                      " for IRQs %d: %s", i + ics->offset, strerror(errno)=
);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlso5joACgkQbDjKyiDZ
s5K+qRAAjhN534Vxd35eEPcmKn2IwqIEa1+26gkPhYFeQRErAL2zOcRc8u9zS8cd
nZ7iD0Kg4hzugrF/vJO6QAAnmfGSZQ8fd35ZUHClXgTmF1huU9RO1hauAluKPkQP
7r7TOYaLeYbxi4cNvbggZ1iJjvpfdSoYvEI3wYvZ7VjMudEiyt8lDnf7FMtBOLlK
3iO4jTmSQ5SFzxKqW9NoRru1lRYH19qtsXzF5lrNFIS5oYxuBPALCHvauHvwXLQp
KfwphejSZRWeILJ9IBU0L42YFTZEBkgVMfWQEN6DY3ML0+2Znw577NIplqFOYgOk
OKlCkzhl/yeN1prgez+g0R0Q2wRZVpsQJvF2i48WzzaNdKVndnyxhuEr8ZlN1YCj
D21cSxVQZtGajds228xcD5VoE336yWtNQAnpUW6zyn6cXhcLuV51Ar0n9gcyFBB3
UruRGEw1wYDvfEKlQkgRyF6Wc1JTSZFflrKGw8jnDeJnaIIgZ9yhoyFblIh+AC+4
2S8Red3EmgcoCcniXva14vyry2wYSD5KFNAmmYABsTld4QK43yvaSiFUNpvOkviG
ru+CYfjFWphhcivrY5qlrA4aZa1oTd940gU/iOszthIQwovHBwxN0GkK/lKYlAH9
w1CQZ6EpzttyM37WZN+wvUBX9A9+gWwtoQou5aHMJoknhTFI0/Q=
=WE6w
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
