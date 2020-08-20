Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B38C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53602078B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CU+OJldp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53602078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Zcb-0007M2-Tw
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 21:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8Zbh-0005nr-FZ; Wed, 19 Aug 2020 21:43:09 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8Zbb-0003xS-6C; Wed, 19 Aug 2020 21:43:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BX6q54Ybfz9sTd; Thu, 20 Aug 2020 11:42:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597887777;
 bh=OYAjZmQAmdvEtNtV04p2In/ISMFgg8OnNUkEn8nIsNQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CU+OJldp3hPnonTiTDPp3QodXUQYsfCmyk1In41sN+xzsc+XJlMw72vp5LMHXhyfA
 zRTJXr3DuPA2esOto712t4N4KDfmdB/qNpgKbxXdQYKKlW2ah3A35NO31VuMC3RK4a
 c0lmzezmoZNV6SFivKvVw/t7jNNhrcXcmJqzokPA=
Date: Thu, 20 Aug 2020 11:36:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 7/8] spapr/xive: Use the xics flag to check for XIVE-only
 IRQ backends
Message-ID: <20200820013659.GH271315@yekko.fritz.box>
References: <20200819130843.2230799-1-clg@kaod.org>
 <20200819130843.2230799-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline
In-Reply-To: <20200819130843.2230799-8-clg@kaod.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2020 at 03:08:42PM +0200, C=E9dric Le Goater wrote:

I can see why this is a good idea, but it really needs a rationale in
the comment for posterity.

> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr_irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 80cf1c3d6bb2..d036c8fef519 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -172,7 +172,7 @@ static int spapr_irq_check(SpaprMachineState *spapr, =
Error **errp)
>           * To cover both and not confuse the OS, add an early failure in
>           * QEMU.
>           */
> -        if (spapr->irq =3D=3D &spapr_irq_xive) {
> +        if (!spapr->irq->xics) {
>              error_setg(errp, "XIVE-only machines require a POWER9 CPU");
>              return -1;
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8907sACgkQbDjKyiDZ
s5IGixAAqDPziaEn7qa3dAuK1myBHJF1OovXagQeTvqNkX93y12DVRjiU0+6NIJU
lnzC/+MgPZbYQ+QF6zEEB9gkdKeQOb1CIhiICiXdHEgGq86piTPtWR9QxiH/siVd
xzMt1yP99OVfsEVqpVUxiZTlP50ShSXTH3/PT4apHC8ErX6cd5eVS2RKrRlNzpDt
5n2+QbSPFyKFyIPChKfuV49YJ4bSRnYDqG55Cc+xn3oC2D6zLTTQq2sCUW17jxHU
SjPtSOX4US+nOl2eyBRs4Zpok9PNvu4laB1PZTH7UNlWlNW4T+AiducVQtDTPqP1
whXlhufQ91GwYilNAPoeDZMCS7c6IRc77WLRpSuXpN7VSZEXNN4lyYV6/zX3U+Kj
qkvcRbpWxj6uZpf57udSWMm4Pq63p4F67Mu7f5pGAjnrqPg7qyLsc9yNH+floGyp
qU0YuvTWNpq+B2jDw09d9SWDtANBly43v1TojnJuFfU7F0oOY0CKzTuRT08Jd0VP
1cx5JfEVBl+gJuXuEu2VovePB4h1G+5rVBepaCl2uJe3JClzf2UB6rhf5hm/GGXX
X842EXZcaRrueq50RIT7vVZ2/Sxe2AsIv21ly8sYQjD2BqLOdwnGTmaIy4y6hEFw
f7FPgmNZfLtxSe6/T7FBk4WM8o4O07UEuZ8uEfl/+DiBtn3up/Q=
=HwzW
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--

