Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94A3C2D0E7
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DC920737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PgYyM1Qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DC920737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHGaF-00011y-Qf
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 20:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXN-0003lj-73
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXL-0002KV-ML
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:21 -0400
Received: from ozlabs.org ([203.11.71.1]:47281)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHGXL-0002HY-9n; Wed, 25 Mar 2020 20:38:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48nmL83L1zz9sSY; Thu, 26 Mar 2020 11:38:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585183088;
 bh=+ozS18bsZrwYGlOCRNToOi3jupPK6PNT9ybjul+tRMU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PgYyM1QzlT56UEDiIbhwAM3dT5dYSF85TJg0Wz2Ixzww+Sfd0vuakthqKuUzIn3xc
 CALs5+1PPjUmy/1kR4372xOa13NqfuN74gYCZl9aRv4nuitWzsK6wpW6bKyf9XPrtO
 wGt7t+jy6dPiW8FrQL7xnx4HVmx8sZmw2yv4wzEs=
Date: Thu, 26 Mar 2020 11:30:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] ppc/spapr: Don't kill the guest if a recovered
 FWNMI machine check delivery fails
Message-ID: <20200326003042.GQ36889@umbus.fritz.box>
References: <20200325142906.221248-1-npiggin@gmail.com>
 <20200325142906.221248-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MM5RgFPKyuP3gDcV"
Content-Disposition: inline
In-Reply-To: <20200325142906.221248-5-npiggin@gmail.com>
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MM5RgFPKyuP3gDcV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 12:29:06AM +1000, Nicholas Piggin wrote:
> Try to be tolerant of FWNMI delivery errors if the machine check had been
> recovered by the host.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-for-5.0.

> ---
>  hw/ppc/spapr_events.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index c8964eb25d..b90ecb8afe 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -833,13 +833,25 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu=
, bool recovered)
>      /* get rtas addr from fdt */
>      rtas_addr =3D spapr_get_rtas_addr();
>      if (!rtas_addr) {
> -        error_report(
> +        if (!recovered) {
> +            error_report(
>  "FWNMI: Unable to deliver machine check to guest: rtas_addr not found.");
> -        qemu_system_guest_panicked(NULL);
> +            qemu_system_guest_panicked(NULL);
> +        } else {
> +            warn_report(
> +"FWNMI: Unable to deliver machine check to guest: rtas_addr not found. "
> +"Machine check recovered.");
> +        }
>          g_free(ext_elog);
>          return;
>      }
> =20
> +    /*
> +     * Must not set interlock if the MCE does not get delivered to the g=
uest
> +     * in the error case above.
> +     */
> +    spapr->fwnmi_machine_check_interlock =3D cpu->vcpu_id;
> +
>      stq_be_phys(&address_space_memory, rtas_addr + RTAS_ERROR_LOG_OFFSET,
>                  env->gpr[3]);
>      cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
> @@ -876,9 +888,15 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recov=
ered)
>           * that CPU called "ibm,nmi-interlock")
>           */
>          if (spapr->fwnmi_machine_check_interlock =3D=3D cpu->vcpu_id) {
> -            error_report(
> +            if (!recovered) {
> +                error_report(
>  "FWNMI: Unable to deliver machine check to guest: nested machine check."=
);
> -            qemu_system_guest_panicked(NULL);
> +                qemu_system_guest_panicked(NULL);
> +            } else {
> +                warn_report(
> +"FWNMI: Unable to deliver machine check to guest: nested machine check. "
> +"Machine check recovered.");
> +            }
>              return;
>          }
>          qemu_cond_wait_iothread(&spapr->fwnmi_machine_check_interlock_co=
nd);
> @@ -906,7 +924,6 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recove=
red)
>          warn_report("Received a fwnmi while migration was in progress");
>      }
> =20
> -    spapr->fwnmi_machine_check_interlock =3D cpu->vcpu_id;
>      spapr_mce_dispatch_elog(cpu, recovered);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MM5RgFPKyuP3gDcV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5797IACgkQbDjKyiDZ
s5LdMA//fhou/EOmlZaAByTSHor5tmJ4hJKQqqe+bIqeM2EhlBtlU4Gdp2K/nKeg
ewZ62e64vkNecjg4N4XrlzZ4MsTvz0L3sSczWsyFK7GtEF2n6oIHsyX76n+wDqTl
YubKCXSx/J4NAkkY6/jD59kTcFauzUkDZsxam9VAiZ0AYF0Rsjzm5dXNpdEituNe
t/pQDhmz/DepFtbSarhUPLkaX2egIDBx9Wt5G8vqCPbq55N6yKsXqUZPwgQf1CRq
sxUhShp4IGfBuApcEaLhxPRTi4oaKGFbi5TpCfXJDXEL5u4JA0wb7Fzvr60Mp16h
A/cPWw1bjXz+PeL6BlYl244T1KdExG5b0TlXaGsgcU3d0eCqYPZZiAjF/oY0wLRi
6p2wPz2COGgtYSoB6mEayoS/7xiz8EAgUgai+hDJ31o+852NPxkrlSU/8X8n2HbV
mUAAeMPVoM2dFP0n9BfqjY36+eB5dd7f7vSVj2k+xXNHtVXZ4qTgSBesO1kpNEKM
QGAlzb1ACH7ADaRUZcJ2G4Brp/8ry670oETk3DYK9imgp+ML0tlfT1qAthPHJwBr
1+Gn9MDLw/q1U2Lzzz2gQUm3ISSIIycq+h8hTuphgvTXOaOuEeBk9KQjww/3l+sx
FTBowKOxYKxcXx3O/kefK+5YvRWcqdxt51il3sHVLEgPhr7C0PI=
=TtcR
-----END PGP SIGNATURE-----

--MM5RgFPKyuP3gDcV--

