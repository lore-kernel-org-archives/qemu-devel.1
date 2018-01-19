Received: from eggs.gnu.org ([2001:4830:134:3::10]:52881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecO7h-0000Nf-QB
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecO7g-0008OM-Nd
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:17:49 -0500
Date: Fri, 19 Jan 2018 15:16:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180119041646.GD30352@umbus.fritz.box>
References: <20180119014313.445517456CD@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oMfk58fZ06Sy4zVm"
Content-Disposition: inline
In-Reply-To: <20180119014313.445517456CD@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] sm501: Add missing break to case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>


--oMfk58fZ06Sy4zVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 07:01:19PM +0100, BALATON Zoltan wrote:
> Noticed by Coverity, forgotten in 5690d9ece
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-2.12, thanks.

> ---
>  hw/display/sm501.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 4f7dc59b2..134cbed 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -797,6 +797,7 @@ static uint64_t sm501_system_config_read(void *opaque=
, hwaddr addr,
>          break;
>      case SM501_COMMAND_LIST_STATUS:
>          ret =3D 0x00180002; /* FIFOs are empty, everything idle */
> +        break;
>      case SM501_IRQ_MASK:
>          ret =3D s->irq_mask;
>          break;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oMfk58fZ06Sy4zVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlphcS4ACgkQbDjKyiDZ
s5JVAA/6A/1yp3HsKqDLMZMqvICx+ytL2E/3HFutarBJopvFbULvcZwyQOjRQApK
bBr1Fhgo6mZL6m1lM4qJqiHP24KrDkpMVLQ62iBWEtBGXKAfYx81txSiKzAO3gQC
szzBNxWR28QI/3vO6Aqcwtv5JzmYfPhPF2x/RrI45Mn9WJ1YqDLvnPe5GMvTFQ2l
sY4nH1ZyvxCB8DRvxq1eZDPUHIsthcbmwWLMv65fpTWwmwoKw9VKGqvQTeCiUTke
PDl7/Gze1VTYVBoNssJgkGOMoNIr9HDCx625NUzOruS6F+/NDk2Bf0hPvVS7NnDu
WJRRcOBhUekwf8xVVtrGqAuPV0O5dnG3dm8S9tswhgOMsxEz4/B61O0Zniy269Gj
/Y4Xf/kLNmjOTt33rvXmBt13hdhHcP4qUhJwR0x3uh9ONlG579E7vG5bRO6F41Nc
3eq3YSpFyx2qmhL037lob8GpDB6PQ5S7n8iic8VPscJyBbBmkPqVtBn9wCCqibp3
NpeHiRP3UNvlLRiLK4mwnLFtrs8NndOWu0QJmUnjNSc+kTu3oy6/CxKno5SLoIHf
i8nSQq3BXpUkXOKFclf3q7NyYygdnXBBozVzDTPfKukYX5q2hdV3cbJp/D103vj5
mcaNymiTR+rqF99d3LIgOnzHjT2vK+04YbHHd844rDa/9tOA8JY=
=fyD4
-----END PGP SIGNATURE-----

--oMfk58fZ06Sy4zVm--
