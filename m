Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BF9C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 00:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123B82073D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 00:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Vf070/sF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123B82073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieqFF-0008L5-5o
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 19:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ieqC9-0004TL-TZ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 19:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ieqC8-0002IQ-84
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 19:49:37 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:32799)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ieqC7-0002FI-6V; Tue, 10 Dec 2019 19:49:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47XdcC5dK0z9sRM; Wed, 11 Dec 2019 11:49:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576025371;
 bh=q04M5Bgp9GU+3MbvptvIWzDbJwYnjdw2Mrqi2x7Exec=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vf070/sFPbSMmRqN9bc9ZbANM4h066s7pzEdoPnC0S70gJH05i5dU4smQ91bucjxG
 e5YREdoCX/MrwB135VOE7JKMPRbdox1Z4JEmpgKOkcvGlC8aPyNrhVUxeLT3RRPFml
 wKlMWsF+gOg/ujvv4eOGMuYFpBH03T2K1ayWMWRs=
Date: Wed, 11 Dec 2019 11:35:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] ppc: Drop useless extern annotation for functions
Message-ID: <20191211003502.GP207300@umbus.fritz.box>
References: <157596536058.115682.18155243603867418789.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NDuspjMMC1Ui5ypn"
Content-Disposition: inline
In-Reply-To: <157596536058.115682.18155243603867418789.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NDuspjMMC1Ui5ypn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 09:09:20AM +0100, Greg Kurz wrote:

Applied to ppc-for-5.0.

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  include/hw/ppc/pnv_xscom.h |   22 +++++++++++-----------
>  include/hw/ppc/spapr_vio.h |    6 +++---
>  2 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index a40d2a2a2a98..1c1d76bf9be5 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -109,16 +109,16 @@ typedef struct PnvXScomInterfaceClass {
>  #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
>  #define PNV10_XSCOM_PSIHB_SIZE     0x100
> =20
> -extern void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp=
);
> -extern int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
> -
> -extern void pnv_xscom_add_subregion(PnvChip *chip, hwaddr offset,
> -                                    MemoryRegion *mr);
> -extern void pnv_xscom_region_init(MemoryRegion *mr,
> -                                  struct Object *owner,
> -                                  const MemoryRegionOps *ops,
> -                                  void *opaque,
> -                                  const char *name,
> -                                  uint64_t size);
> +void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp);
> +int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
> +
> +void pnv_xscom_add_subregion(PnvChip *chip, hwaddr offset,
> +                             MemoryRegion *mr);
> +void pnv_xscom_region_init(MemoryRegion *mr,
> +                           struct Object *owner,
> +                           const MemoryRegionOps *ops,
> +                           void *opaque,
> +                           const char *name,
> +                           uint64_t size);
> =20
>  #endif /* PPC_PNV_XSCOM_H */
> diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
> index 72762ed16b70..ce6d9b0c6605 100644
> --- a/include/hw/ppc/spapr_vio.h
> +++ b/include/hw/ppc/spapr_vio.h
> @@ -80,10 +80,10 @@ struct SpaprVioBus {
>      uint32_t next_reg;
>  };
> =20
> -extern SpaprVioBus *spapr_vio_bus_init(void);
> -extern SpaprVioDevice *spapr_vio_find_by_reg(SpaprVioBus *bus, uint32_t =
reg);
> +SpaprVioBus *spapr_vio_bus_init(void);
> +SpaprVioDevice *spapr_vio_find_by_reg(SpaprVioBus *bus, uint32_t reg);
>  void spapr_dt_vdevice(SpaprVioBus *bus, void *fdt);
> -extern gchar *spapr_vio_stdout_path(SpaprVioBus *bus);
> +gchar *spapr_vio_stdout_path(SpaprVioBus *bus);
> =20
>  static inline void spapr_vio_irq_pulse(SpaprVioDevice *dev)
>  {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NDuspjMMC1Ui5ypn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3wObQACgkQbDjKyiDZ
s5K1phAAsoHwR3OT/SIQsTzatLB8sNmM/B8q36WMO5OL633Oj/Dr2Ie1n2rT3WT7
9BiJ+PEHSjEvx4G6QJ96ACJTe6azfEajD06CT7RRZSV//Ty0Jb35YlEda23MCODh
cBptm4SVObJo1/bI6d6L0676n/f6+UbJ6MGTttupf9+/MyYRCXCm6oBTCVzSwnSu
f5WmKTmQNeKl4/g5+tm8ha2JRKvYq5V/jAELzf2QzAPiJEGTJ25I/uPYjEEWcuwD
grbH7ppETbg/sY0Bpf3/s2dLf+S5GJOFLyfW8U/VhZJHFCR4Djbw0QyZ1+oc8sJr
kJFPQvPrnn8p8+NCya4mfZFze5iR53C0lwH16LyF+Kf33s2onaeRI73tZEsD3Dad
5VD/Q6rCH7wZ22/Qza1AiAvr/RQ0Fa7c1ficWhe0uhi7CIjBxKrytv6jYuziXkcy
ef3DwSV2H1+HfkJvIROldOTbIhdSgaIkfWjr0iuvGxceoAFrbvXCjgR4/D+hf+k2
iU+j/X2UTRv0gZlkZsBxugzF/Afh0ZyaT3nksDuopQqXbcyz2OnJWGBM0+cyl3jJ
4EmIR4H+JJigwogb0vGwYb0BEUKvGsrqbarz+uRLYj9HUXTnCgN2nPXHn9bBx1x5
YMuy5C1Fm6smQ7f7fPU+nuAUGwgo+liCkDJ1HElmDxbHiRERbqo=
=SDnv
-----END PGP SIGNATURE-----

--NDuspjMMC1Ui5ypn--

