Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1F6C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8237C20737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oKt/v6HH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8237C20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHGbn-0003ne-MV
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 20:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXM-0003lf-Tu
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXL-0002KP-Le
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:20 -0400
Received: from ozlabs.org ([203.11.71.1]:48977)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHGXL-0002HT-8d; Wed, 25 Mar 2020 20:38:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48nmL82cSnz9sSV; Thu, 26 Mar 2020 11:38:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585183088;
 bh=nHkn43nALS267IgxmjNcOhNlRhHPMQp8SdF+D7QlZrw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oKt/v6HHyds3B+Uuu34Iz6j57qfCd1/G9IoAel30QSnplEmPkHsz+YXObwg/tla7o
 uPNAzu16Ad4u1JSEE49g7gztjnFlrv4pA0QkkuCPQaLNGfMnRg5nLWvJQ7/+kzlris
 5KqYgIL2JvGPtnFYDMAgmkSXBzBj2PNE7XJDQmtM=
Date: Thu, 26 Mar 2020 11:19:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/4] ppc/spapr: Add FWNMI machine check delivery
 warnings
Message-ID: <20200326001937.GO36889@umbus.fritz.box>
References: <20200325142906.221248-1-npiggin@gmail.com>
 <20200325142906.221248-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GOzekVbrLdOLv44p"
Content-Disposition: inline
In-Reply-To: <20200325142906.221248-4-npiggin@gmail.com>
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


--GOzekVbrLdOLv44p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 12:29:05AM +1000, Nicholas Piggin wrote:
> Add some messages which explain problems and guest misbehaviour that
> may be difficult to diagnose in rare cases of machine checks.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-for-5.0.

> ---
>  hw/ppc/spapr_events.c | 4 ++++
>  hw/ppc/spapr_rtas.c   | 3 +++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index a908c5d0e9..c8964eb25d 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -833,6 +833,8 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, =
bool recovered)
>      /* get rtas addr from fdt */
>      rtas_addr =3D spapr_get_rtas_addr();
>      if (!rtas_addr) {
> +        error_report(
> +"FWNMI: Unable to deliver machine check to guest: rtas_addr not found.");
>          qemu_system_guest_panicked(NULL);
>          g_free(ext_elog);
>          return;
> @@ -874,6 +876,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recove=
red)
>           * that CPU called "ibm,nmi-interlock")
>           */
>          if (spapr->fwnmi_machine_check_interlock =3D=3D cpu->vcpu_id) {
> +            error_report(
> +"FWNMI: Unable to deliver machine check to guest: nested machine check."=
);
>              qemu_system_guest_panicked(NULL);
>              return;
>          }
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 29abe66d01..bcac0d00e7 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -462,6 +462,9 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>      }
> =20
>      if (spapr->fwnmi_machine_check_addr =3D=3D -1) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +"FWNMI: ibm,nmi-interlock RTAS called with FWNMI not registered.\n");
> +
>          /* NMI register not called */
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>          return;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GOzekVbrLdOLv44p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl579RkACgkQbDjKyiDZ
s5JxohAAwVxv06KKsJsswIMcLOqBo/dl4t8thsBYTjGXJro1IBS7XFR1ETlZf+mz
Uk1bok1WFG9486lmx5KlqXowTN3BvwFmn8KliUi7SZGS4mrXwkFqp4XAhSIZljem
GwYdddvWhaWPcTFthSpdwIP/6LkTac2KdUlrdPni3XrJiB49i4grcX126MZhUR2S
LM3PH+ZtqiOfyMu28VcvsY7LFo3OQJfBIcUE7RgcVWfynOwiQsYa4LA7SXfzDUde
1TMwVH8mpn3ZZ8IG5SPDjnITpC/dcfjREbOsotvIgCWHeWbUxqzgRnYIUdrI1TTD
2ifl/90J88WXmkIe2Jae3Nh4hWLkFpSzRngzET5bnrLm5X8SbBZQde4BbMRYcOpl
p4piwIcw33PS70sQPQCv/ALxhsQpmKFlJYkWH8+j8vq2psG2I8Bt/TVNIJRX+8zQ
ybx2LKshyJx5lSb9OjiV9NWtC72j2u/7ey8dV4fduq2bkI152XhKG6qqoQSqFRW5
Kk2E3cRJG2S3PQp+J88ccmKAywWk80xUD28PWtB/FVN5wQJvTFJOVfJN/vtzcob2
URfL/PySQJ4FLKt7uRxwNTuiZdfpqXcSUQl8Sry3xiUt4ojXRBgBxKpcFjzrDkO1
ZlOVUD6qTA2CxIY+pno+5RsQs2YXp0LXrGyrVvtVuO3CxhA/N2U=
=W8D3
-----END PGP SIGNATURE-----

--GOzekVbrLdOLv44p--

