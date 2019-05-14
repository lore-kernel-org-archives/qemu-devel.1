Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B175C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 01:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D303B208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 01:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KTWvR5r1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D303B208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37654 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQMiV-0005fw-36
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 21:58:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQMfX-0003br-LF
	for qemu-devel@nongnu.org; Mon, 13 May 2019 21:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQMfS-0000Ay-LC
	for qemu-devel@nongnu.org; Mon, 13 May 2019 21:55:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57597 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hQMfL-0008Jv-0K; Mon, 13 May 2019 21:55:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45313p0HGrz9s9N; Tue, 14 May 2019 11:55:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557798934;
	bh=uUa2ddWxcAJURlvVJkOFWP291wolpLl5iv2Iz2vx6CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTWvR5r1wWX8JB8RgMd7mXXyOkOwQJCJlFHsj74wGNmBYzQKJ04QWF4n5QC01wBj0
	WK3pQalztdya2sS751tBqO+UcSXIfeEHQULFAMS6h/YgOB/1XtnUFYxmMuX7JHxfco
	a/R5oha79qlgJ5+HpEvcRNgqIc1webfrcDJjrf+k=
Date: Tue, 14 May 2019 11:52:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190514015246.GD6441@umbus.fritz.box>
References: <20190513084245.25755-1-clg@kaod.org>
	<20190513084245.25755-13-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <20190513084245.25755-13-clg@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v4 12/14] spapr/irq: initialize the IRQ
 device only once
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 10:42:43AM +0200, C=E9dric Le Goater wrote:
> Add a check to make sure that the routine initializing the emulated
> IRQ device is called once. We don't have much to test on the XICS
> side, so we introduce a 'init' boolean under ICSState.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

I'm not entirely sure it's the best way to accomplish what we need,
but it will do for now.

> ---
>=20
>  Changes since v3:
>=20
>  - introduced a 'init' boolean under ICSState
> =20
>  include/hw/ppc/xics.h | 1 +
>  hw/intc/spapr_xive.c  | 9 +++++++++
>  hw/intc/xics_spapr.c  | 7 +++++++
>  3 files changed, 17 insertions(+)
>=20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index eb65ad7e43b7..d6f8e4c4c282 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -119,6 +119,7 @@ struct ICSState {
>      uint32_t offset;
>      ICSIRQState *irqs;
>      XICSFabric *xics;
> +    bool init; /* sPAPR ICS device initialized */
>  };
> =20
>  #define ICS_PROP_XICS "xics"
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 246b21ae7f31..1e649d6cdbe1 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -338,6 +338,15 @@ void spapr_xive_init(SpaprXive *xive, Error **errp)
>      XiveSource *xsrc =3D &xive->source;
>      XiveENDSource *end_xsrc =3D &xive->end_source;
> =20
> +    /*
> +     * The emulated XIVE device can only be initialized once. If the
> +     * ESB memory region has been already mapped, it means we have been
> +     * through there.
> +     */
> +    if (memory_region_is_mapped(&xsrc->esb_mmio)) {
> +        return;
> +    }
> +
>      /* TIMA initialization */
>      memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
>                            "xive.tima", 4ull << TM_SHIFT);
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 9d2b8adef7c5..5a1835e8b1ed 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -239,6 +239,13 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
> =20
>  void xics_spapr_init(SpaprMachineState *spapr)
>  {
> +    /* Emulated mode can only be initialized once. */
> +    if (spapr->ics->init) {
> +        return;
> +    }
> +
> +    spapr->ics->init =3D true;
> +
>      /* Registration of global state belongs into realize */
>      spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xive=
);
>      spapr_rtas_register(RTAS_IBM_GET_XIVE, "ibm,get-xive", rtas_get_xive=
);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzaH24ACgkQbDjKyiDZ
s5L3SA/+IjWuRO5G9QcTp1bLzDzF5GIdTKr7nfpXvCqjfAi8Z6xFlKPu9oezCA5J
eVAy077EZUHkiiJxvBqMd8ZC94Uc3QCuYAnX3FZOYQ9E8NwSlNOKCMBAhf2T2Ov/
Qw2Pg9sy1w3CLSEPrC7iDpWaFjI7MPaHO22P6wR9pIwD5eF1f+xGm7D9eHCU5e1l
R6YzxWDlhedAIjhsMHX8PhoNTSRrU5iDDZ2mi15Tmlsrsy1TuFYQhxbrPRIISwFg
GBS0DTrRzjhHUZAws1Efxla2YAsC6d1XbjpCDdszi6TVEt5W1ntl+06pOS5wDg3b
PbfN5X03hCHuX642lAYLFgBidm2C5ainX4ZF+rWmezGS1yyL38PHhukdLBzoXXtm
HB7MGG1uscT7He6pNGFvCMeqtX4pDdpnRUhDWopHnPs/Ep79DwlRVLzK0j3vLdCf
NJOBSIu80U2poxd3NA2beaDp+mcpV58xwe7V0vHVIjd2jcPwXufbZhlpeLA8sUYy
fY78AlAGDwMH8FlsOTWCRO8eq4U7voa2haanjyZ5OKEFdcgngfNHIhtrCVwq4PCy
HlGWoVI64WoqlxzORNpwLUAHqqnizUgnzHSATHacs8wEGwcY9KHqHWpGYu+pw9av
jG5iIvMJzPul8iI396MXxarHvybsiQqCL98HgG5VSExK0VPq2GY=
=Ern6
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--

