Received: from eggs.gnu.org ([2001:4830:134:3::10]:46618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsgrC-0005WN-L5
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 22:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsgrB-0002ZL-Cy
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 22:59:54 -0400
Date: Fri, 15 Sep 2017 10:54:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170915005415.GB5250@umbus.fritz.box>
References: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
	<150541712226.1616.17581342887936984948.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <150541712226.1616.17581342887936984948.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/3] kvm: check KVM_CAP_SYNC_MMU with
 kvm_vm_check_extension()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 09:25:22PM +0200, Greg Kurz wrote:
> On a server-class ppc host, this capability depends on the KVM type,
> ie, HV or PR. If both KVM are present in the kernel, we will always
> get the HV specific value, even if we explicitely requested PR on
> the command line.
>=20
> This can have an impact if we're using hugepages or a balloon device.
>=20
> Since we've already created the VM at the time any user calls
> kvm_has_sync_mmu(), switching to kvm_vm_check_extension() is
> enough to fix any potential issue.
>=20
> It is okay for the other archs that also implement KVM_CAP_SYNC_MMU,
> ie, mips, s390, x86 and arm, because they don't depend on the VM being
> created or not.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  accel/kvm/kvm-all.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f85553a85194..323c567cfb68 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2234,7 +2234,7 @@ int kvm_device_access(int fd, int group, uint64_t a=
ttr,
>  /* Return 1 on success, 0 on failure */
>  int kvm_has_sync_mmu(void)
>  {
> -    return kvm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
> +    return kvm_vm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
>  }
> =20
>  int kvm_has_vcpu_events(void)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm7JLcACgkQbDjKyiDZ
s5K89A/+KTjv+q7BucRnN3SEY+u2RHm93BOTVXhPheA1oIyw5zwn/7ALzxQB3q2l
ehPc2UqPkWxtpCRiSrVDSG3rdROzdB3kpUNgmP1E3bQT8iwvDzJo2Z0Af1dlyG7u
eWm+W9xaMLLLDhcBx/B4i6UZatQCzyU4YRgzo4bng0ocZ0hFBKDTTq1B0y+R4KJ1
oNV8CVXJM2SCu+yRWAWzIAiAQdTcFoporc/Lkp1BU+/GJpRL7Y1AOM7T4WyE0ZqB
W/tMfM2LuBcSck/ftwDFE9Tdq6bco8ztd5uSnwjbNOlESSgxwL+a9ZGcJ5Dwmdoi
/+X5/G/eK6TkQRr2y73jL6z4VP36SKGU3Pc/UgW54Nwuornxugmd7a7pTFKOSS0T
qGiECZ2eub7FJXMMnKUw00JNHMChMa4TkFzfhSjVPctaDawzWfsg9lNb2zpQUOVr
vtpP8Y5spzZr59lWSWKHaDDhprpjcXSj2g+tDY5Undk+5AgM4E9ZEiqL4tsIixBA
NiJEKkeoVVJip1KLRQeJDtgqNiP7R4KP8MzwE8xiewk/0zKGnrio28bZugNnMg87
Z2WHJzHj0nrSCfed2C47ZE8C6sIEXFqN9166KgK+e57CP1CxvfN2z6/0SWg2Rn/9
HjPD26R3/SPl/GjVMIhaPtEguXT2/HJFGf8kqx3ELbTnhtMbDYs=
=N06f
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
