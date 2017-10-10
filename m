Received: from eggs.gnu.org ([2001:4830:134:3::10]:38878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kU0-0004MQ-CQ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kTx-0004U9-8b
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:24 -0400
Received: from ozlabs.org ([103.22.144.67]:38247)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1e1kTw-0004Ps-H4
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:21 -0400
Date: Tue, 10 Oct 2017 12:42:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171010014237.GC2668@umbus.fritz.box>
References: <20171009170607.4155-1-mdroth@linux.vnet.ibm.com>
	<20171009170607.4155-3-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <20171009170607.4155-3-mdroth@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] Revert "qdev: Free QemuOpts when
 the QOM path goes away"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, groug@kaod.org, peter.maydell@linaro.org, armbru@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, ehabkost@redhat.com


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2017 at 12:06:06PM -0500, Michael Roth wrote:
> This reverts commit abed886ec60cf239a03515cf0b30fb11fa964c44.
>=20
> This patch originally addressed an issue where a DEVICE_DELETED
> event could be emitted (in device_unparent()) before a Device's
> QemuOpts were cleaned up (in device_finalize()), leading to a
> "duplicate ID" error if management attempted to immediately add
> a device with the same ID in response to the DEVICE_DELETED event.
>=20
> An alternative will be implemented in a subsequent patch where we
> defer the DEVICE_DELETED event until device_finalize(), which would
> also prevent the race, so we revert the original fix in preparation.
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Tested-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/core/qdev.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 0542e1879f..f7c66d9bd0 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -1068,6 +1068,7 @@ static void device_finalize(Object *obj)
>      NamedGPIOList *ngl, *next;
> =20
>      DeviceState *dev =3D DEVICE(obj);
> +    qemu_opts_del(dev->opts);
> =20
>      QLIST_FOREACH_SAFE(ngl, &dev->gpios, node, next) {
>          QLIST_REMOVE(ngl, node);
> @@ -1117,9 +1118,6 @@ static void device_unparent(Object *obj)
>          g_free(dev->canonical_path);
>          dev->canonical_path =3D NULL;
>      }
> -
> -    qemu_opts_del(dev->opts);
> -    dev->opts =3D NULL;
>  }
> =20
>  static void device_class_init(ObjectClass *class, void *data)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlncJY0ACgkQbDjKyiDZ
s5IcbQ/+OlhYp0UbBtpVGZQdJQB7bU67rIxbaccC2RBpLJkZE3muh3mljN9bR9lN
ch5PjA8BRBN8Qz0LLrQQ1vRYimf/va3F02RKbNawHCHfgBkYKMsw917RH8qoq/q9
zCXa2vy+eO+Y7HX+kQ1s6JMFi2mbwBuW56oP4+KBuc5QgvSFJnpn1cNjl6Rhc8+e
ZEkUAoyGxcP4reVrrD9lWRNmHihPS6M2WXLmYxjbuv1MkNL0IZsttGeVjEPXGlTg
rcuzY/pr5q85Hg5PR3yy01ih0CcENV9H4wkXsnAQ9utSSWrOcQnhPCU5TIjy/EgC
rlOlqolz8cyIPFy15SjqBQQGHbWMhDv/gn2z8E9lMWfO3QiyVhCiaxlB7o+8rFgt
328ReUKi9SHWlSY+FTy4s8cNzAT3SCCn7lNz7FpTDgvyMS6sZbrXQMrgjRq+fvDO
53sn7uPTmwKCTilpA1lEvoEe+wCGmxYdk3J2ZQ+uYmO9T9QUy2kygUG3B/Ak7ef4
RqzIyw/IgLDXEqb+2gxoREk5z+t/qUJjrxucc0d2NW4UDTsrSdTn4vIFED8eNySV
fwUTfqHLIZhAx+W4XhN+lMkfsN+knVcYJj0jPq4+M2+9CuwENhAJuPtL8IsUz+0i
OJMtPCu9/4WSnBHzt4gA5FwPeThwshAzqUix3aAIvGIhAii9gGw=
=pt3s
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
