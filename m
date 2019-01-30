Received: from eggs.gnu.org ([209.51.188.92]:44763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1goyhZ-00022h-Mn
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1goyhX-0001Hu-Ot
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:51:25 -0500
Date: Thu, 31 Jan 2019 09:38:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190130223831.GC1771@umbus.fritz.box>
References: <1548863140-31975-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <1548863140-31975-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: XIVE is an interrupt
 controller, not a machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 04:45:40PM +0100, Thomas Huth wrote:
> The "XIVE" section is currently listed in the "PowerPC Machines"
> section, which is weird, since this is an interrupt controller
> device. Move it to the "Devices" section instead.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-4.0, thanks.

> ---
>  MAINTAINERS | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b334b53..eac36b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1038,14 +1038,6 @@ F: tests/libqos/*spapr*
>  F: tests/rtas*
>  F: tests/libqos/rtas*
> =20
> -XIVE
> -M: David Gibson <david@gibson.dropbear.id.au>
> -M: C=E9dric Le Goater <clg@kaod.org>
> -L: qemu-ppc@nongnu.org
> -S: Supported
> -F: hw/*/*xive*
> -F: include/hw/*/*xive*
> -
>  virtex_ml507
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  L: qemu-ppc@nongnu.org
> @@ -1645,6 +1637,14 @@ F: tests/libqos/fw_cfg.c
>  F: tests/fw_cfg-test.c
>  T: git https://github.com/philmd/qemu.git fw_cfg-next
> =20
> +XIVE
> +M: David Gibson <david@gibson.dropbear.id.au>
> +M: C=E9dric Le Goater <clg@kaod.org>
> +L: qemu-ppc@nongnu.org
> +S: Supported
> +F: hw/*/*xive*
> +F: include/hw/*/*xive*
> +
>  Subsystems
>  ----------
>  Audio

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxSJ2cACgkQbDjKyiDZ
s5Kp9g//dkBUmWq57CuI2zHeEAGehftPgsMgHT08GzvryWXIcIPtq41ZSnmr3mNS
F4ddhHY2FkPMpFjOj27X9u3VW8WYdO7+qdifahw1pRF2CGroVINwe6AkH9wEX2ha
5wrRgTJr+mQBJ6bvT5jASkZXslO4NkjaEUc9BELe1MaF2h/HdpFKLTvSEgHvaHLm
wH0XyuQadwnYwk1vmzuugyOYWKRFAH1Q6AE/UK/x4pZR3eBT+rncEPnebIPXzy0M
fDpRRa74+cDtiV28JWRo1JErOts2Cc6VzhVi6IB7ca+lwVtTLKVahcTrf3aWwgFO
ueSgdvyaSDB+qiOsfK9b42G9fZJjq2BK96+qUjmVmjOKH3gLmnTEKDVYWB5ZDPiy
dF8HKLW8ZVSch5pjwf4WNsmbB0L7L6gzga9rXEoTSbN+AxBPo6FHXm/S3OqtWfys
rqYkhvV9I0QNk6y+6i6ySbU+r8XDCcxL5tKVaF7jLEQA3ndWkCoSQBeVBBaptmWC
0UyHf1Clfwa1dvy+/rdgFbmBxzP1WOUtQNyau857fUeztahFFq2DkxMuE53CYcpz
1HJlIn1hmGQJe6fNXCtVJ/L6FlrKnTyJgjcTuZwxiJuuYPRaKROawZb+I/XKT34i
L+iMGkQFsC9Fqf4ZdJ6OCFz2C3ZhH3BqG52zWM2Jf210aPObBwQ=
=VoR5
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
