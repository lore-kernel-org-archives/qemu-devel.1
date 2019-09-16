Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C76FC4CEC7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 00:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E75206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 00:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OP40yNVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E75206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9f6i-0006iM-Ch
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 20:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i9f5W-0005ZJ-Hb
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 20:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i9f5V-0005B0-7D
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 20:41:54 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:42083)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i9f5U-0005AS-5O; Sun, 15 Sep 2019 20:41:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46WnVy0DYkz9sP7; Mon, 16 Sep 2019 10:41:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568594506;
 bh=m56W1yxJfNO7p4dTRcRMa/SsFj15wFdd3+lEIPlqDrM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OP40yNVmZztiJnTPbv0SVbeVv6qno2FC2wX8Hlw1EaI+FVWmJ01+vnOv6G+uuBlcl
 UteNUfE/BURYfRIHW0NcyYRomSpToSB5rYHHC4J+YS700VXg66garbDQR3xFM0c89v
 gg2l3xR9DDqqzjb66Seb1DBGMeJF7sBH5d6F9r3k=
Date: Mon, 16 Sep 2019 10:38:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190916003849.GE2104@umbus.fritz.box>
References: <20190911133937.2716-1-clg@kaod.org>
 <20190911133937.2716-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
Content-Disposition: inline
In-Reply-To: <20190911133937.2716-2-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2 1/2] spapr/irq: Introduce an
 ics_irq_free() helper
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
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 03:39:36PM +0200, C=E9dric Le Goater wrote:
> It will help us to discard interrupt numbers which have not been
> claimed in the next patch.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.2, thanks.

> ---
>  include/hw/ppc/xics.h | 5 +++++
>  hw/ppc/spapr_irq.c    | 9 +++------
>  2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index f2a8d6a4b4f9..64a2c8862a72 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -179,6 +179,11 @@ void ics_simple_write_xive(ICSState *ics, int nr, in=
t server,
>                             uint8_t priority, uint8_t saved_priority);
>  void ics_simple_set_irq(void *opaque, int srcno, int val);
> =20
> +static inline bool ics_irq_free(ICSState *ics, uint32_t srcno)
> +{
> +    return !(ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK);
> +}
> +
>  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
>  void icp_pic_print_info(ICPState *icp, Monitor *mon);
>  void ics_pic_print_info(ICSState *ics, Monitor *mon);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 06fe2432bae5..d8f46b6797f8 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -114,9 +114,6 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_irqs,
>      xics_spapr_init(spapr);
>  }
> =20
> -#define ICS_IRQ_FREE(ics, srcno)   \
> -    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
> -
>  static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool =
lsi,
>                                  Error **errp)
>  {
> @@ -129,7 +126,7 @@ static int spapr_irq_claim_xics(SpaprMachineState *sp=
apr, int irq, bool lsi,
>          return -1;
>      }
> =20
> -    if (!ICS_IRQ_FREE(ics, irq - ics->offset)) {
> +    if (!ics_irq_free(ics, irq - ics->offset)) {
>          error_setg(errp, "IRQ %d is not free", irq);
>          return -1;
>      }
> @@ -147,7 +144,7 @@ static void spapr_irq_free_xics(SpaprMachineState *sp=
apr, int irq, int num)
>      if (ics_valid_irq(ics, irq)) {
>          trace_spapr_irq_free(0, irq, num);
>          for (i =3D srcno; i < srcno + num; ++i) {
> -            if (ICS_IRQ_FREE(ics, i)) {
> +            if (ics_irq_free(ics, i)) {
>                  trace_spapr_irq_free_warn(0, i);
>              }
>              memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
> @@ -767,7 +764,7 @@ static int ics_find_free_block(ICSState *ics, int num=
, int alignnum)
>              return -1;
>          }
>          for (i =3D first; i < first + num; ++i) {
> -            if (!ICS_IRQ_FREE(ics, i)) {
> +            if (!ics_irq_free(ics, i)) {
>                  break;
>              }
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1+2ZkACgkQbDjKyiDZ
s5I6tA//S12yz7zDmQpaswCmTerP7yZuji+Q5u0oc0/UXh+Bt5Emre1iH6s9O7Q1
6IECz98nr3BKIw969McGvePvEquz0BXZgmVSF8EY71vAnIh3n3MdLnST87K4O0/x
8uDhywDcKjeNyCrsAV/TIqrcQQg3NCHmTcVM+rRau/LrPhVpHd5/tAvqOrd/Yink
puxxewKX5HGdMtO9oQ2C6Ze/aA//vi2nrx7qnkvT7jxJnQdTkBE5o+Dt/3//klMt
CG4YjgMtDtWLoyvy7CDZ03R1kwIal9OLqQMIuziyg+izd4J1+GdVDOi0bzTnOKvx
k5rp9JBX+SSHcJo6ku/drd2RDTR7b08Hk/7AA9W396RNV5fAYRFbQZjEfjZg3eoJ
iYDN0p9xp1EDHHe+JI9EKCgo+FyYtOpraWiukKVePPa/k5U7CEZ6JGsogrfR46/I
sdq7n4V7GKk0V5WTaq7TXgQotTQvDyJqjfmpmioPkWw8lG8MpihE06K5YtxqsCaT
nTf2uiOsl4N/sKF2dAucApXA/ZiLBNV5bu8DBtzS5RwHJ687LWD4b06H9VlmY2Kg
zLIQ8DGryisTlCbrErwSpYKEdFrsNcokGn9FteHwSf7HwsxCeW7L4XuXczmKPr9h
x8TF5vOhL9aNkf7sboEZdisqzUAVc2oXMbPOKCTV9kNS4MZ/BXQ=
=YXjy
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--

