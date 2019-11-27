Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E413AC43215
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 05:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC64720665
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 05:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gOE29NQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC64720665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZq1j-00071n-Ps
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 00:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iZpzc-0005Qn-25
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 00:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iZpza-0000Jz-NZ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 00:35:59 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:42293)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iZpzZ-0000Cs-U3; Wed, 27 Nov 2019 00:35:58 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47N8d161txz9sSr; Wed, 27 Nov 2019 16:35:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574832949;
 bh=muvHzNHPRAzQayRob424Gx7xtQnhlueXPE+7tsCshy0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gOE29NQAtxzyVF8EDNbKalaBgYWdcYwJKBro8t6cYrJkGoRFZbu5z+5ziRKVxQ2pt
 GLAjSt6Hm8no200P3xUckTyemQL4DU5weN/FXK/BDQbHz3NRVmuzrbciXD4VkljK+E
 v/Av/2BmINIjMIPS3rAS6mVQFHUgV6z7qzq7po+U=
Date: Wed, 27 Nov 2019 15:57:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v6 04/20] ppc/pnv: Loop on the threads of the chip to
 find a matching NVT
Message-ID: <20191127045730.GN5582@umbus.fritz.box>
References: <20191125065820.927-1-clg@kaod.org>
 <20191125065820.927-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dbB7XJDnVO33DTCu"
Content-Disposition: inline
In-Reply-To: <20191125065820.927-5-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dbB7XJDnVO33DTCu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2019 at 07:58:04AM +0100, C=E9dric Le Goater wrote:
> CPU_FOREACH() loops on all the CPUs of the machine which is incorrect.
> Each XIVE Presenter should scan only the HW threads of the chip it
> belongs to.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Patches 1..4 applied to ppc-for-5.0.

> ---
>  hw/intc/pnv_xive.c | 61 ++++++++++++++++++++++++++--------------------
>  1 file changed, 35 insertions(+), 26 deletions(-)
>=20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 8055de89cf63..9798bd9e729f 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -377,34 +377,43 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, =
uint8_t format,
>                                bool cam_ignore, uint8_t priority,
>                                uint32_t logic_serv, XiveTCTXMatch *match)
>  {
> -    CPUState *cs;
> +    PnvXive *xive =3D PNV_XIVE(xptr);
> +    PnvChip *chip =3D xive->chip;
>      int count =3D 0;
> -
> -    CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -        XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> -        int ring;
> -
> -        /*
> -         * Check the thread context CAM lines and record matches.
> -         */
> -        ring =3D xive_presenter_tctx_match(xptr, tctx, format, nvt_blk, =
nvt_idx,
> -                                         cam_ignore, logic_serv);
> -        /*
> -         * Save the context and follow on to catch duplicates, that we
> -         * don't support yet.
> -         */
> -        if (ring !=3D -1) {
> -            if (match->tctx) {
> -                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a "
> -                              "thread context NVT %x/%x\n",
> -                              nvt_blk, nvt_idx);
> -                return -1;
> +    int i, j;
> +
> +    for (i =3D 0; i < chip->nr_cores; i++) {
> +        PnvCore *pc =3D chip->cores[i];
> +        CPUCore *cc =3D CPU_CORE(pc);
> +
> +        for (j =3D 0; j < cc->nr_threads; j++) {
> +            PowerPCCPU *cpu =3D pc->threads[j];
> +            XiveTCTX *tctx;
> +            int ring;
> +
> +            tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> +
> +            /*
> +             * Check the thread context CAM lines and record matches.
> +             */
> +            ring =3D xive_presenter_tctx_match(xptr, tctx, format, nvt_b=
lk,
> +                                             nvt_idx, cam_ignore, logic_=
serv);
> +            /*
> +             * Save the context and follow on to catch duplicates, that =
we
> +             * don't support yet.
> +             */
> +            if (ring !=3D -1) {
> +                if (match->tctx) {
> +                    qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found =
a "
> +                                  "thread context NVT %x/%x\n",
> +                                  nvt_blk, nvt_idx);
> +                    return -1;
> +                }
> +
> +                match->ring =3D ring;
> +                match->tctx =3D tctx;
> +                count++;
>              }
> -
> -            match->ring =3D ring;
> -            match->tctx =3D tctx;
> -            count++;
>          }
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dbB7XJDnVO33DTCu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3eAjgACgkQbDjKyiDZ
s5KawxAArVkIgsgMGyBoSTOf7nHQ/+4Xydwcd5xOqLfdsYIv/XBGzcXO95X3trtU
u6eLjZ8LE/NLh8fPROF7XKGlF1SrzUB9TIeB09D7V9h2JYsDXrSjVLmgvAXL3K11
aj07axzFDagiNoGCPI7lWylbBiSCddsrGYmgTOiKMWso/iHB/4J3c2hRwmVwp8cR
ab3GOiRK3wGczTH8/YghJO/rnUbGlJgPsvEPOWzD+AkAx0cH0QDUsabeRPMXFoPn
m+rKU6O2by0mjJNceCgbRPGJTzZMU6q+XBwcxRvVM0ZdxoCJw3JUnNMVWfwtBkV0
uWNntLaE40NWmuQZCeAiHtRXiZFC+R6djMInwUix6emMRaxVh8tU7iTacjJe7B5I
7Z+dr22pzlfw3ZaE0Bi/cDBBGtZVDYdXmjxhc5W/j2lbEhbe3bLsVOvNUTCBbslu
s3E9+mWTMteZFnsz78iGAEfPd/J1sPRaqrY+PQA6vUFh+evZjwRUcDa2tgc9TAFM
i7znk5OHw/ugrH3kITcuoBypGYzdODk5pOJj0A/o2ssHrFUEj4XxXzQmq+DCmZI8
XaCkPsaKJF6hcR2SGyvQIn1hZSgkRivEG/xsgEZ+hJPAhfpMstdJR1jB8Tl2gRal
SIaesboXOJqCoPciEgzdzFfeuzK083gKMm7tm4f3O4D9qH0H7aE=
=J3UE
-----END PGP SIGNATURE-----

--dbB7XJDnVO33DTCu--

