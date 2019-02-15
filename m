Received: from eggs.gnu.org ([209.51.188.92]:39985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guRmU-0000Wi-Hn
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guRYx-00050I-KY
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:41:08 -0500
Date: Fri, 15 Feb 2019 11:18:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190215001833.GA4573@umbus.fritz.box>
References: <20190212113929.31390-1-ppandit@redhat.com>
	<20190213013850.GX1884@umbus.fritz.box>
	<nycvar.YSQ.7.76.1902150047200.27283@xnncv>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1902150047200.27283@xnncv>
Subject: Re: [Qemu-devel] [PATCH v2] ppc: add host-serial and host-model
 machine attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: "Daniel P . Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 12:57:35AM +0530, P J P wrote:
> +-- On Wed, 13 Feb 2019, David Gibson wrote --+
> | > +
> | > +    object_class_property_add_str(oc, "host-serial",
> | > +        machine_get_host_serial, machine_set_host_serial,
> | > +        &error_abort);
> | > +    object_class_property_set_description(oc, "host-serial",
> | > +        "Set host's system-id to use", &error_abort);
> | > +
> | > +    object_class_property_add_str(oc, "host-model",
> | > +        machine_get_host_model, machine_set_host_model,
> | > +        &error_abort);
> | > +    object_class_property_set_description(oc, "host-model",
> | > +        "Set host's model-id to use", &error_abort);
> |=20
> | You're adding properties to *all* machines, for something that's only
> | used on the PAPR machine.  That doesn't seem right.
>=20
> I tried to figure out about adding these options to only spapr machine, b=
ut it=20
> does not seem straight forward as above.

It really should be.  You can just put those
object_class_property_add()s into spapr_machine_class_init().

> | >      spapr_machine_4_0_class_options(mc);
> | >      compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_=
len);
> | > +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> |=20
> | I'm still not convinced maintaining super-strict backwards compat at
> | the expense of security is a good tradeoff here, but since the code's
> | already written, let's run with it.
>=20
> I think current patch will provide a way to help fix the security issue, =
we=20
> can revise it further if required.

That's reasonable.

>=20
> Thank you.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxmBVcACgkQbDjKyiDZ
s5Is4Q/9ENrwikIXtGdfBXBVe0/cVcMripq/VfQsTD7p52vB2Y2qqS3E6rnN2gcj
DwJDRWDUSqF5xbJMdq1g30rkfIZ6/B1qCR5saMMDx078bvkwx77adFlbq3Vj8EF6
CowbN5bjcQpqxKNStswfQvk1gZVPi8CGgWTvpQrU/HC2VtsThIp9u0fiP4QnlnDC
E0+yhg3Faij6uRmauZ+aPC/tGFZQSBzOUCB5fGuYbFwEQKRHYvROLjjOOBfu6ib/
ReBCJVdgL5ZLaEkG143Ks4LUwD8cOl0BLMaa85vGPF7aP1eAIHqTt79o1pgXXeGe
pzEG7UITkRKftKtWtcY/9wdptTTQTLxT+FDB5hGqXCu0RHtRyhwKnooGDcDMYLgP
AjooUlAzpn3PEKIV/oLTjHFbOsNLVdb4ydWp34qHKeNKgIz+toYoIFGlur6YIxKG
g38bMIQGGedRKV8EI3A6brXQ7yZ3J5ckfUV9ZAUeu4v20WPmwAPieE/K5g//IrcB
Ylh7xKIGFmXUc1lZOllj1XTxvwFDGPZFhijRV/KtODsE4eXhpgx/mOaEt6LW5bic
YTH+sbzPOUGnh6NYOeASI7PxfMdtKvy5XG1daiTaub+p1Z8iA4NsaXb7Ktw4S7Ol
g8h5vYdUx1M9hjzeMRr90un3u6ujRDUrZu8CGhvCr7wgFHMBll4=
=5Q5J
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
