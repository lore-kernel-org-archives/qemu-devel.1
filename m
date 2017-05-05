Received: from eggs.gnu.org ([2001:4830:134:3::10]:51206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6T0V-0006sW-Fe
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6T0U-0000v7-F8
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:30:11 -0400
Date: Fri, 5 May 2017 11:45:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170505014522.GK14413@umbus.fritz.box>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-13-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kswDJesP0akhmDn8"
Content-Disposition: inline
In-Reply-To: <1493816238-33120-13-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 12/24] numa: add numa_[has_]node_id()
 wrappers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--kswDJesP0akhmDn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2017 at 02:57:06PM +0200, Igor Mammedov wrote:
> wrappers should make access to [has]node_id fields more readable
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Correct, though I'm not sure it actually simplifies things that much.
Maybe more in future patches, though.

> ---
>  follow up patches will use this wrappers
>  v2:
>     - add wrappers (Drew)
> ---
>  include/sysemu/numa.h | 10 ++++++++++
>  numa.c                |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 46ea6c7..98d01e6 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -35,4 +35,14 @@ uint32_t numa_get_node(ram_addr_t addr, Error **errp);
>  /* on success returns node index in numa_info,
>   * on failure returns nb_numa_nodes */
>  int numa_get_node_for_cpu(int idx);
> +
> +static inline bool numa_has_node_id(const CPUArchIdList *possible_cpus, =
int idx)
> +{
> +    return possible_cpus->cpus[idx].props.has_node_id;
> +}
> +
> +static inline int numa_node_id(const CPUArchIdList *possible_cpus, int i=
dx)
> +{
> +    return possible_cpus->cpus[idx].props.node_id;
> +}
>  #endif
> diff --git a/numa.c b/numa.c
> index c7e3e0a..872ee0d 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -394,7 +394,7 @@ void parse_numa_opts(MachineState *ms)
> =20
>          possible_cpus =3D mc->possible_cpu_arch_ids(ms);
>          for (i =3D 0; i < possible_cpus->len; i++) {
> -            if (possible_cpus->cpus[i].props.has_node_id) {
> +            if (numa_has_node_id(possible_cpus, i)) {
>                  break;
>              }
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kswDJesP0akhmDn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZC9kuAAoJEGw4ysog2bOSmSsP/0ccdmR65sMDQswO18tGBQUu
H9UJQJImV0UkmeTrbeN7JRzqKIOmqQ1dkunRzeS2R7M6vdyZZFZPbjMhNocOTmmh
hOg/yBM3rPPtUnOHkQ68zhQlVS0nrwZSpExoyFt9UWed8i0thQZSVxAw1OP0Ya5v
lI8GuP5s051cn1a2VzjpPJJFEgKxVBsEYXPhpU0Qc0Ql6mupLoF0hTp6v6jSjbDi
Np4G/znuzO3Ze4vhRBhzlfwgcOZdCHM8laXUNWo/TpzZlIO9lB0XPe3WLGgD3UQB
FcikNtGRFK6zQ65MosCL9Y1cdnxHzOwJRedzlDZm8zvsfs6pTB5GXeLiGetln7Gz
bNe1ddFtzrbUICgrqduBhMud9shhROqfFakzNO9oQDqk4RcLwDuFIGPL1nMHIGGn
rjJdqjqjhnt0RLmx5viwqRxP82Jxr0tC6q9KScVc4w/QGNVBtkLAM9arf/cgGER+
+DnMOytU2Sjia1C2nrc/iRPzy7CPUS3540EZvEWaQ9HfAKQKJ4tVO+eHNF1oA4e0
yZ3p1FCCctkao0GiJr+aZCw/gitVwMXCw/aUHM15mwKMgUzyqTLHYxTCjKuu5u4B
tBUDkKdvXxZvG6fsj4VE0x4GRL8vEYkBxRG3+VWKJHuudwkl54JMCa+RBFarSQLj
CCuYREyAVcBX/F+j7yVL
=e8CJ
-----END PGP SIGNATURE-----

--kswDJesP0akhmDn8--
