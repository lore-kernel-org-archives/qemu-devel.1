Received: from eggs.gnu.org ([2001:4830:134:3::10]:39471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKAhM-0005br-Ol
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKASV-0007dM-BH
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:08:33 -0500
Date: Wed, 7 Nov 2018 09:45:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181106224534.GB24589@umbus.fritz.box>
References: <20181106102335.20027-1-kraxel@redhat.com>
	<20181106102335.20027-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20181106102335.20027-2-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] move ObjectClass to typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2018 at 11:23:30AM +0100, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/qemu/typedefs.h | 1 +
>  include/qom/object.h    | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 3ec0e13a96..fed53f6de2 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -62,6 +62,7 @@ typedef struct NetClientState NetClientState;
>  typedef struct NetFilterState NetFilterState;
>  typedef struct NICInfo NICInfo;
>  typedef struct NumaNodeMem NumaNodeMem;
> +typedef struct ObjectClass ObjectClass;
>  typedef struct PCIBridge PCIBridge;
>  typedef struct PCIBus PCIBus;
>  typedef struct PCIDevice PCIDevice;
> diff --git a/include/qom/object.h b/include/qom/object.h
> index f0b0bf39cc..499e1fd8b7 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -20,7 +20,6 @@
>  struct TypeImpl;
>  typedef struct TypeImpl *Type;
> =20
> -typedef struct ObjectClass ObjectClass;
>  typedef struct Object Object;
> =20
>  typedef struct TypeInfo TypeInfo;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlviGY4ACgkQbDjKyiDZ
s5LDfhAAj5f0ofUO3QoH2yIbChg34BvY9Asz/NOkbPcBTwfiF0qqHutfyqcYa9tU
GebYaGwoAnGPuxX8+cJPZFxK+K77nTMQisfLXodAgZO9zt2+kydFTb6VxTPLcRuL
h3IOrb9YJBWg+mlo10hjpaj8SgK2dl3IoKImeA4w49zNA7unO6tuwvPvEP+fGKJ8
/T5uvJwQR7bTNW9I54z/wHXdeQNQjNfYOXx1BRf2TegBoDZw8C20G/EDphIgBuBi
8OHmFFhQcKAehGcE+NZdwFz2iY3sIji6CLimIPnyHBFi+3x6M4vLm/hZCo802W3A
3MNdO+NQqfqd2Pr7XKJx+/lIDdtFJbDVVPR3x8lmNrmt9+dxoQu/OtVa4BDMr95N
SURvRcc9Zob769gqlNzOZ1MytbOucDiKOYvbE5VxG4Ged3OP149qx9ArW/OULyuE
KfVjUnnplEEJM5b+SyHkAP/PVlDMrQlJw6EM9CuOZfgkQFYZ7mx7l71wSPCs7F2W
7cYEzVg3b+tVxhE84HZOVK/SeiF9lURCMquZxe0yL1Em4vGM1TK0IMT9LCPGpTbY
Uk7s+iCsA25CemdsBPugJq6yqU3kn0Sgip5jSenZ/kthIdnjGcTKIN8vU9frUhaC
NLb+WbLb9+1zIzf7imCfDNpJ6rS1RIyOpyOfurYKAdvVMOrgJf8=
=4qm6
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
