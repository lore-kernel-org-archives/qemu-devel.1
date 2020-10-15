Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ACDC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A804420797
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bFd6ADel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A804420797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTDge-0007P0-Gj
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 20:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTDde-0004mW-Vp; Thu, 15 Oct 2020 20:30:33 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTDdc-0000ED-5f; Thu, 15 Oct 2020 20:30:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CC6Vx08psz9sTq; Fri, 16 Oct 2020 11:30:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602808217;
 bh=shvXjincyKEd/RPs1UF7LtW+EXJup4YM3bYJTjHdmy0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bFd6ADelprcK1bVaLf4swwgEaN4VSsyHkynAamg9Rvm7BXmozRwc9tHhA9zV8aqeI
 MufxqpTUWlYVzxYoHYGdhJo0v7xiJSVol6Wm8AiAZLLXsPGqUtQSYofD9qZWU1n+v9
 vd2GyzDZ5i1LLqwtA0DAXgAxmyxDT42ub5MztuVQ=
Date: Fri, 16 Oct 2020 10:58:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] ppc/spapr: re-assert IRQs during event-scan if there are
 pending
Message-ID: <20201015235845.GA7078@yekko.fritz.box>
References: <20201015210318.117386-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20201015210318.117386-1-lvivier@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2020 at 11:03:18PM +0200, Laurent Vivier wrote:
> If we hotplug a CPU during the first second of the kernel boot,
> the IRQ can be sent to the kernel while the RTAS event handler
> is not installed. The event is queued, but the kernel doesn't
> collect it and ignores the new CPU.
>=20
> As the code relies on edge-triggered IRQ, we can re-assert it
> during the event-scan RTAS call if there are still pending
> events (as it is already done in check-exception).
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Applied to ppc-for-5.2.

> ---
>  hw/ppc/spapr_events.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 1069d0197b4f..1add53547ec3 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -1000,10 +1000,22 @@ static void event_scan(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
>                         target_ulong args,
>                         uint32_t nret, target_ulong rets)
>  {
> +    int i;
>      if (nargs !=3D 4 || nret !=3D 1) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>          return;
>      }
> +
> +    for (i =3D 0; i < EVENT_CLASS_MAX; i++) {
> +        if (rtas_event_log_contains(EVENT_CLASS_MASK(i))) {
> +            const SpaprEventSource *source =3D
> +                spapr_event_sources_get_source(spapr->event_sources, i);
> +
> +            g_assert(source->enabled);
> +            qemu_irq_pulse(spapr_qirq(spapr, source->irq));
> +        }
> +    }
> +
>      rtas_st(rets, 0, RTAS_OUT_NO_ERRORS_FOUND);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+I4jIACgkQbDjKyiDZ
s5JCuA/7BegI12ieKIbefT4v0+IZ6M1WSyn32GzSF7lg+6Grt4Zd5OEtPu5sbS2x
lbO20lR/g0OkLNaPF0pMM0IratpxapUfFnts+U8zND+Q74CNZwivqFndscVDUeB9
zSW+9hi7Eq8QmCFQ8m1L7t9WLaYIA01XndImPiGvV4RBIdqhab0Auc8655fdWsLy
lnSN02Qq9+2RnjZsnnlTRB7JmMJWJu29TQFKj3jBXyMFvUCrELyvR9VdEva5uTOA
muOsQRt1zPVV93HWOTfl6TRNgtM9cBOEk58cAATcLuixmMkasf9aBBm4NRySGDyN
dS5h5PCCQxwMDjoBWlKlCn++bJAlH2QIUiLN00552jlBk5aZpg/q0tgB4PRZGBVV
d5BKfG6XRQJGBYpVB6fgyYBjsHfETrLRPCnFm9mTBgbLx5PU5gervno8SkI2uGpB
6EKWNfGKPiU76UGpyOVE7kpaz5oRBMXm2Vc+mZtZQolBie1toEMURPM3XDPJMner
iLODJsFJYIG4Tcutwk4/JJqmtteEP6+gBiHJLkEcDRVHxvgl1gEGHDBQ0JJnKL35
NKprh8YLWgSLWP2CmPwXprgvtDRUi0ZT52sN7bP8DcvqOwnWRStz1U/9M1d49fqu
VI43k7p3j8V+Y8YR4PRHNMG6fadCZnJoVdA1N30T+GXfmzWMdYI=
=RsEg
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

