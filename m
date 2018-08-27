Received: from eggs.gnu.org ([2001:4830:134:3::10]:47904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fu5kS-0005TI-Qg
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 20:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fu5gn-0006vE-H2
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 20:47:30 -0400
Date: Mon, 27 Aug 2018 10:41:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180827004156.GA2222@umbus.fritz.box>
References: <20180824203101.30125-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20180824203101.30125-1-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix leak of rev array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 24, 2018 at 04:31:01PM -0400, Emilio G. Cota wrote:
> Introduced in 04d595b300 ("spapr: do not use CPU_FOREACH_REVERSE",
> 2018-08-23)
>=20
> Fixes: CID1395181
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  hw/ppc/spapr.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4edb6c7d16..505d4c84e5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -607,6 +607,7 @@ static void spapr_populate_cpus_dt_node(void *fdt, sP=
APRMachineState *spapr)
>          spapr_populate_cpu_dt(cs, fdt, offset, spapr);
>      }
> =20
> +    g_free(rev);
>  }
> =20
>  static uint32_t spapr_pc_dimm_node(MemoryDeviceInfoList *list, ram_addr_=
t addr)

Applied, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluDSNIACgkQbDjKyiDZ
s5IOew/9HooC+66JCQBNos6LLSWtpB3Lu9WWXGd65YAtvvnS+qU/7fo74llgkTnx
LZkGk7e04IptG7QVxUAFxgJZBvh5Lt8i7QRtIllrU6hCFbG2DDWLX+7ECKXBixRJ
FRv59oCLa/VIx5syicWh/mltGAL7TipHN2lKY+7uHY01TZ0HEAXOp+U2ON1ZQZgM
iB/SlRHF9TsOJZ2emZGWNd+2vpvGhF0Eb6WlkRJbT2qVdHTKVVeSwBuAeNfRKbjP
CKNAIuvJw+L90idfupcKDFGyeiylFs+fepHLhveym7Xl/N6qcmD3DxrZghTu6Plb
lSgj6F7RTpt74RC5h6mEMfTV8dC2Z9jE1CJKAFONWSM/ydmezdiSmGPREN2ghRuB
aogSm75Bcf/lKLNv62UMesfZsCoEC42SMZHjLFTFBYCBlEZfihKfk/XTo3lrzoUp
b/K147AKxAjWSGBnpnQS0bwuVsAAP+yTBj5dqy+RaTI7UiqtBFpV9eCmQvxdLMsF
MNS8JGsKXsvtoJBhnT49jfX98l8IAwvYMBnJop9ZcLB0qvp7rQuvcyam1uBoAhPs
k6SI+aKyCclM3GEDbDRQc+xvtVfuwVbUPXyRaAm0wAkmmIRQWf/1t6xoHa7MPHx8
71JiJxDCvDb0gauHo+VRjtF6DEZKv/TKa5aHAIYUhMyK/lX1oNc=
=Zi28
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
