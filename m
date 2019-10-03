Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E675C4360C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D36121D81
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jfembrSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D36121D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFrGy-0002UD-3T
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 22:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5P-0000AK-G1
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5N-00010d-6L
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58509 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFr5M-0000xq-Io; Wed, 02 Oct 2019 22:43:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kHPC0Nvsz9sQv; Thu,  3 Oct 2019 12:43:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570070591;
 bh=D83nMpK3B9GzE0sRrNbZuOBzfObm9XI3qmffYjMJbUs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jfembrSgwSHMJ+HBuIILOmlTggdLAUoaqcDW6tIWeLV0CG8FymB0ILbtbcg7L86eV
 zdgndoDr9jZeOlZuvCCJTQBSYVtwabD8yWlukFL03aP//XY3nPjaw21tCZ9nAGXSPO
 dSWFMNDmnwD2SG1Ym7xy4CdyBT1NlFMcXBv2AZU8=
Date: Thu, 3 Oct 2019 12:41:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 24/25] ppc/pnv: Improve trigger data definition
Message-ID: <20191003024156.GQ11105@umbus.fritz.box>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-25-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fTD7sGci972winw4"
Content-Disposition: inline
In-Reply-To: <20190918160645.25126-25-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--fTD7sGci972winw4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 06:06:44PM +0200, C=C3=A9dric Le Goater wrote:
> The trigger definition is used for triggers both for HW source
> interrupts, PHB, PSI, as well as for rerouting interrupts between
> Interrupt Controller.
>=20
> HW source controllers set bit0 of word0 to =E2=80=980=E2=80=99 as they pr=
ovide EAS
> information (EAS block + EAS index) in the 8 byte data and not END
> information, and bit1 of word0 to =E2=80=981=E2=80=99 to signal that the =
state bit
> check has been performed.
>=20
> Introduce these new trigger bits and rename the XIVE_SRCNO macros in
> XIVE_EAS to reflect better the nature of the data. This is breaking
> the notification for the PSI model which will be fixed in the next
> patch.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive_regs.h | 24 +++++++++++++++++++++---
>  hw/intc/pnv_xive.c         | 16 ++++++++++++----
>  hw/intc/xive.c             |  4 ++--
>  3 files changed, 35 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index dd42c33cef35..83a2f2cc1318 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -22,9 +22,27 @@
>  /*
>   * Interrupt source number encoding on PowerBUS
>   */
> -#define XIVE_SRCNO_BLOCK(srcno) (((srcno) >> 28) & 0xf)
> -#define XIVE_SRCNO_INDEX(srcno) ((srcno) & 0x0fffffff)
> -#define XIVE_SRCNO(blk, idx)    ((uint32_t)(blk) << 28 | (idx))
> +/*
> + * Trigger data definition
> + *
> + * The trigger definition is used for triggers both for HW source
> + * interrupts (PHB, PSI), as well as for rerouting interrupts between
> + * Interrupt Controller.
> + *
> + * HW source controllers set bit0 of word0 to =E2=80=980=E2=80=99 as the=
y provide EAS
> + * information (EAS block + EAS index) in the 8 byte data and not END
> + * information, and bit1 of word0 to =E2=80=981=E2=80=99 to signal that =
the state bit
> + * check has been performed.
> + */
> +#define XIVE_TRIGGER_END        PPC_BIT(0)
> +#define XIVE_TRIGGER_EAS        PPC_BIT(1)

These names seem really confusing in light of the comment above.  HW
source controllers set the XIVE_TRIGGER_END bit in order to indicate
that they're providing EAS info, not END info??  And also set the
XIVE_TRIGGER_EAS bit to indicate something different?

Also, the comment implies that HW source controllers set both bits,
but I'm not really sure if that's what you meant.  Expanding on what
non-HW source controllers might set could be helpful, too..

> +
> +/*
> + * QEMU macros to manipulate the trigger payload in native endian
> + */
> +#define XIVE_EAS_BLOCK(n)       (((n) >> 28) & 0xf)
> +#define XIVE_EAS_INDEX(n)       ((n) & 0x0fffffff)
> +#define XIVE_EAS(blk, idx)      ((uint32_t)(blk) << 28 | (idx))
> =20
>  #define TM_SHIFT                16
> =20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 4c1fa024cdf5..61af3f23000f 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -385,7 +385,7 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_t=
 blk, uint32_t idx,
>       * EAT lookups should be local to the IC
>       */
>      if (pnv_xive_block_id(xive) !=3D blk) {
> -        xive_error(xive, "VST: EAS %x is remote !?", XIVE_SRCNO(blk, idx=
));
> +        xive_error(xive, "VST: EAS %x is remote !?", XIVE_EAS(blk, idx));
>          return -1;
>      }
> =20
> @@ -502,7 +502,7 @@ static void pnv_xive_notify(XiveNotifier *xn, uint32_=
t srcno)
>      PnvXive *xive =3D PNV_XIVE(xn);
>      uint8_t blk =3D pnv_xive_block_id(xive);
> =20
> -    xive_router_notify(xn, XIVE_SRCNO(blk, srcno));
> +    xive_router_notify(xn, XIVE_EAS(blk, srcno));
>  }
> =20
>  /*
> @@ -1287,12 +1287,20 @@ static const MemoryRegionOps pnv_xive_ic_reg_ops =
=3D {
> =20
>  static void pnv_xive_ic_hw_trigger(PnvXive *xive, hwaddr addr, uint64_t =
val)
>  {
> +    uint8_t blk =3D XIVE_EAS_BLOCK(val);
> +    uint32_t idx =3D XIVE_EAS_INDEX(val);
> +
>      /*
>       * Forward the source event notification directly to the Router.
>       * The source interrupt number should already be correctly encoded
>       * with the chip block id by the sending device (PHB, PSI).
>       */
> -    xive_router_notify(XIVE_NOTIFIER(xive), val);
> +    if (val & XIVE_TRIGGER_EAS) {
> +        xive_router_notify(XIVE_NOTIFIER(xive), XIVE_EAS(blk, idx));
> +    } else {
> +        xive_error(xive, "IC: END trigger at @0x%"HWADDR_PRIx" data 0x%"=
PRIx64,
> +                   addr, val);
> +    }
>  }
> =20
>  static void pnv_xive_ic_notify_write(void *opaque, hwaddr addr, uint64_t=
 val,
> @@ -1683,7 +1691,7 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor=
 *mon)
>      XiveRouter *xrtr =3D XIVE_ROUTER(xive);
>      uint8_t blk =3D pnv_xive_block_id(xive);
>      uint8_t chip_id =3D xive->chip->chip_id;
> -    uint32_t srcno0 =3D XIVE_SRCNO(blk, 0);
> +    uint32_t srcno0 =3D XIVE_EAS(blk, 0);
>      uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive, blk);
>      XiveEAS eas;
>      XiveEND end;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 07b7c3586c12..6702f32be601 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1652,8 +1652,8 @@ do_escalation:
>  void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
>  {
>      XiveRouter *xrtr =3D XIVE_ROUTER(xn);
> -    uint8_t eas_blk =3D XIVE_SRCNO_BLOCK(lisn);
> -    uint32_t eas_idx =3D XIVE_SRCNO_INDEX(lisn);
> +    uint8_t eas_blk =3D XIVE_EAS_BLOCK(lisn);
> +    uint32_t eas_idx =3D XIVE_EAS_INDEX(lisn);
>      XiveEAS eas;
> =20
>      /* EAS cache lookup */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fTD7sGci972winw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VX/QACgkQbDjKyiDZ
s5KGxhAAqudJeJXRkJKk+12i6ZUVf/zfJXy5QtZYiQxYe1v4zA0DP9e+RUFuQ8vW
7gUvbHELmN+bdL3I408ClWEwn4L54rhXewv8NgiUFrePk2qinuiXwZPRJN69Zkfg
r7POEFQxPS8yRkSp1LO7igYigeIZIZDZMklpiDDvzs0P8ScnUdpJm3HOhZAAqYm+
TVWVq7PDng5PhpZssALzudzWzMGjlmNY0d6QyrXDHpsHPXGPTi9Qku3LpZ9pLMGh
5yqMUy+ms8GyCRRo9qM29e4fmEtX/GJP+XH51xU9MxAm5hYFGgEEu8edXS6lJLRz
MLH1eAAePTtPr4ea6QDU/S5L5AGHnwLe7b3F+lWViYRG3mEawVCv267VaMy/kzg1
uDxarb4uRD9a1enL+s8fwEU++gxdj9J3majqRgxrebkubAs9ZOzHo7dC8RXpxcIu
rDN+LsQMN13mFtbS3FKZYiITy2AeFiMZluMV3vGQNtUNl2iZnbb/+PLjIg5lsRkD
YxX+zBx2xrqcw4ANPFc4SSGUQpq8o9lrYnUXGpaClaU+Bb8awxBD8hSiTG/M2BPW
JGbNSEFBJG18MoUw1iJ/l0iLNXnvDR+B9V4x8rdlgbf4O9JpfZGb221sVn4PV5uU
zSQtHfxKJOnLigPHpiYefa7TdSS3A+3yHMTc4jzdz4DvkvmURkk=
=pDIr
-----END PGP SIGNATURE-----

--fTD7sGci972winw4--

