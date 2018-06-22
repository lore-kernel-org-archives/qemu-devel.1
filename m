Received: from eggs.gnu.org ([2001:4830:134:3::10]:45524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPn-0000aa-S6
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPm-0003Lk-B9
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:39 -0400
Date: Fri, 22 Jun 2018 20:25:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180622102512.GH612@umbus.fritz.box>
References: <20180622080009.5707-1-mark.cave-ayland@ilande.co.uk>
	<20180622080009.5707-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline
In-Reply-To: <20180622080009.5707-2-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 1/2] mac_dbdma: only dump commands for
 debug enabled channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2018 at 09:00:08AM +0100, Mark Cave-Ayland wrote:
> This enables us to apply the same filter in DEBUG_DBDMA_CHANMASK to the
> DBDMA command execution debug output.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/misc/macio/mac_dbdma.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
> index 1b2a69b3ef..87ae246d37 100644
> --- a/hw/misc/macio/mac_dbdma.c
> +++ b/hw/misc/macio/mac_dbdma.c
> @@ -71,18 +71,19 @@ static DBDMAState *dbdma_from_ch(DBDMA_channel *ch)
>  }
> =20
>  #if DEBUG_DBDMA
> -static void dump_dbdma_cmd(dbdma_cmd *cmd)
> +static void dump_dbdma_cmd(DBDMA_channel *ch, dbdma_cmd *cmd)
>  {
> -    printf("dbdma_cmd %p\n", cmd);
> -    printf("    req_count 0x%04x\n", le16_to_cpu(cmd->req_count));
> -    printf("    command 0x%04x\n", le16_to_cpu(cmd->command));
> -    printf("    phy_addr 0x%08x\n", le32_to_cpu(cmd->phy_addr));
> -    printf("    cmd_dep 0x%08x\n", le32_to_cpu(cmd->cmd_dep));
> -    printf("    res_count 0x%04x\n", le16_to_cpu(cmd->res_count));
> -    printf("    xfer_status 0x%04x\n", le16_to_cpu(cmd->xfer_status));
> +    DBDMA_DPRINTFCH(ch, "dbdma_cmd %p\n", cmd);
> +    DBDMA_DPRINTFCH(ch, "    req_count 0x%04x\n", le16_to_cpu(cmd->req_c=
ount));
> +    DBDMA_DPRINTFCH(ch, "    command 0x%04x\n", le16_to_cpu(cmd->command=
));
> +    DBDMA_DPRINTFCH(ch, "    phy_addr 0x%08x\n", le32_to_cpu(cmd->phy_ad=
dr));
> +    DBDMA_DPRINTFCH(ch, "    cmd_dep 0x%08x\n", le32_to_cpu(cmd->cmd_dep=
));
> +    DBDMA_DPRINTFCH(ch, "    res_count 0x%04x\n", le16_to_cpu(cmd->res_c=
ount));
> +    DBDMA_DPRINTFCH(ch, "    xfer_status 0x%04x\n",
> +                    le16_to_cpu(cmd->xfer_status));
>  }
>  #else
> -static void dump_dbdma_cmd(dbdma_cmd *cmd)
> +static void dump_dbdma_cmd(DBDMA_channel *ch, dbdma_cmd *cmd)
>  {
>  }
>  #endif
> @@ -448,7 +449,7 @@ static void channel_run(DBDMA_channel *ch)
>      uint32_t phy_addr;
> =20
>      DBDMA_DPRINTFCH(ch, "channel_run\n");
> -    dump_dbdma_cmd(current);
> +    dump_dbdma_cmd(ch, current);
> =20
>      /* clear WAKE flag at command fetch */
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsszoYACgkQbDjKyiDZ
s5KtLg/+JdacidVlRo3d/dDK5tpSJuLjD7JcpTzec/WBM5E8gJakzN5e2RRKwLnw
JqgOGYfmYe8nhlP7pXgcHd0Y8VF+iktrIXUodb74HsfnQORx1fX7nb0wY+ykHPwc
aofIpHXhHwEFDuAPsmxrRFu+QuZfhUmsHnWsMn/k8bjkcOVRVTuiCFK69SnI3jRc
RUXod1HyVZMqubliIck2aOAizYtLXpvWnEjQf25pcSytjwyFo5xhcAA0QzR+zjQM
TLJPON3uPRYJsxS6+Wxwb2XGhEwKGr/boqceRMwg6Hz1XYOYQRqFBes/7hJ3AQND
4Pu9tNMnxkq+vgRQThmH9SaPrjG/VauAmwPjk55bzifOPA+pdvhS55J0QNsTWqAM
pSgvXSOrooVgFFkCd9gtE2HLpu1LYTi2RpfZG2W/KdvSnYSVX6YpRM3IUOZGEC9P
c/UjolhTGhRdcXAENQ6RLVpBsbMku+bm4bh1RCAWl3+CDl5GcyqLUVZaT1Q1VJf2
bmkMxcbu59pVzDX77got3y0HowX1CLwMI+odfSPfqw+ZWf4fwhajevbCE6zRmmwV
QCh7WTzygyrvOnmGQcE0aPIDdnBQLx5Dw19fKMFPx2U0II3e98iNucCcWmnDvwdB
sIV15KXD94HPQ1YjRHbdsJGe0WayO1jR32BE9eXZVJplaqfOzkU=
=+atq
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
