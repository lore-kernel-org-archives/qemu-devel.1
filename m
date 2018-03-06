Received: from eggs.gnu.org ([2001:4830:134:3::10]:38162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et0Bf-0001RQ-Dp
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 19:10:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et0Bd-0003Bb-IY
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 19:10:35 -0500
Date: Tue, 6 Mar 2018 11:10:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180306001018.GP2650@umbus.fritz.box>
References: <20180305083655.6186-1-pbonzini@redhat.com>
	<20180305083655.6186-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YolNsh7G+K7zsfIR"
Content-Disposition: inline
In-Reply-To: <20180305083655.6186-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/7] openpic_kvm: drop
 address_space_to_flatview call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-stable@nongnu.org


--YolNsh7G+K7zsfIR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 09:36:49AM +0100, Paolo Bonzini wrote:
> The MemoryListener is registered on address_space_memory, there is
> not much to assert.  This currently works because the callback
> is invoked only once when the listener is registered, but section->fv
> is the _new_ FlatView, not the old one on later calls and that
> would break.
>=20
> This confines address_space_to_flatview to exec.c and memory.c.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Do you want me to take this through my tree?


> ---
>  hw/intc/openpic_kvm.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
> index fa83420254..39a6f369c5 100644
> --- a/hw/intc/openpic_kvm.c
> +++ b/hw/intc/openpic_kvm.c
> @@ -124,10 +124,6 @@ static void kvm_openpic_region_add(MemoryListener *l=
istener,
>      uint64_t reg_base;
>      int ret;
> =20
> -    if (section->fv !=3D address_space_to_flatview(&address_space_memory=
)) {
> -        abort();
> -    }
> -
>      /* Ignore events on regions that are not us */
>      if (section->mr !=3D &opp->mem) {
>          return;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YolNsh7G+K7zsfIR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqd3GoACgkQbDjKyiDZ
s5K+3BAA2WgdU14BXcXLCDkidDt6pgG0bU2OWLmB/09+9nUWylBdshbpyUmT48Xk
/2vf0xhdor3Lwn64Mi09aRBpemxQapQ/IDSThUk9XKaL1CtQ7yzQ1Ou4+f28qwGA
cCy8rtDrNoy+5JfZTx4kmti3MHdKBOjos+FQbZdGyavOCLLFatHsH/hK1yvMkYej
R00uzEzWR5IzmNICfXCA4hYf0+f5OyDxubyb86aoonTnpUKqLDvFuKxbokRMBamd
ICaFO9b1XFxYnEleHkUkgr/2sk604vrh9bDTv8ppDfxYsSN5fPodGKAkkXAVoIc2
zv7wjU7dWuguhIlk69mZH73crT3pbzAEIFia3OV3QBeQkc7i6aQYYc1QCvKP1iGR
m41hcDRmdLixRX4ZdCBOLIRNbbeenfeDWDjcV2fI8kLkQhjO5lwwZkq6fozJv8t0
uTJPSij+sRG7F+cVVtJRJV9hV/eI7HZOO4GQWKER+ZqLO4pPJiRtu6UfAm50r7mP
9a2D2CaQNEjTGW8csLM1qLJBGJUetv7u/+FDzgGfoFNQeQrJOexbk08DLaxgJUt9
14/dzcsnGNAEkBwzFJtpVewN5LOGBicHN5I1NoqttdmoPIxOYKRk/2meMg+PV3ci
Js1jEHblJKXbaKnS3QPbU4/ArvqTFm+PWsBq6Yq8WN2ihTrI1Dc=
=pgr6
-----END PGP SIGNATURE-----

--YolNsh7G+K7zsfIR--
