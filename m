Received: from eggs.gnu.org ([209.51.188.92]:53127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gr0xh-0005YX-Bi
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gr0xg-0004ex-3F
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:40:28 -0500
Date: Tue, 5 Feb 2019 17:13:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190205061346.GM22661@umbus.fritz.box>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774528595.1208625.15523908858345133758.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qgof7w7UksPF5inF"
Content-Disposition: inline
In-Reply-To: <154774528595.1208625.15523908858345133758.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3 03/19] xics: Disintricate allocation and
 type setting of interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--Qgof7w7UksPF5inF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 06:14:46PM +0100, Greg Kurz wrote:
> The current code assumes that an interrupt is allocated as soon as its
> type is set to MSI or LSI. PHB hotplug will require to be able to set
> the type of an interrupt before actually allocating it.

Hm.. why?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qgof7w7UksPF5inF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxZKZcACgkQbDjKyiDZ
s5KRwBAAuVtWmphbAhDwHNRL3HjP7Shfa7JL8I1Z5PS8vj3Mv9T9XRNdi7qEP1nK
StVGqWFCzNk2d+eXAjXeWNpBLdpsxxV4G7CnzpKJV7MML8OvXEji4TDS9QOtpGr+
DXO4tLoCCH0n0iVsciD6AfKa8/DouyAA21PhaB6A53z+OYekP5BWyT68fz2w07QM
8oY/oLp6srjPPEVQxzyEEEApeDHRSDEVYCq/7AmmhDiA3FTdkdlKjsfFAjZLnIPF
86tuj+7PhCScyR5vbz1ocbwdfy3qCFWOrO4ayGRTpV3BJQIuDKAHKba6JoLr2VMl
OCgQou8kdLvGYv4Pykj4LGXH7qUe5CF4bpZvW45WJHWpF42/HGnYuc8XFnG8nJQU
mkwVxd62huSMbdFZTqHyqj4cZMubMwhS5RVQkMuHbISoGT1C/591/9AWOc4JWh+x
5t38Jt7QnojzBBc0qys9ey6UKcK8i/01P99Mb3LAClAM9WweCtt2+UQ4bo0ZPKTV
hYRZuKdatK5U8nexV97tGYQc45S9pmv41SXJiNYWpxUkX7FKic3d0SDIvNpvoLuv
Be6t9sfpsXD9eQam4Wb82IOBQ/npQNw4OrCkNzmzUrqAKhmy5BnRenr9P3/Od4tx
ayCVZUPvZUp/wu/fmWlnjcLENC1XXa1bTn1mve6On0uQ4L164qg=
=zibz
-----END PGP SIGNATURE-----

--Qgof7w7UksPF5inF--
