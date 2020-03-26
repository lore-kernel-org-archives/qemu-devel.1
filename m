Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796B2C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4F420737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UQX9HXGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4F420737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHGbw-00044w-Ez
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 20:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXN-0003lh-3R
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXL-0002Jx-K1
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:21 -0400
Received: from ozlabs.org ([203.11.71.1]:37847)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHGXL-0002HR-6T; Wed, 25 Mar 2020 20:38:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48nmL82D1Yz9sSR; Thu, 26 Mar 2020 11:38:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585183088;
 bh=So1EfJeN6iY6rJUzTS/vftDQ9jJeo8rs3eLLfunBMjU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UQX9HXGBIE/T1YdxaKBKoFkZmgdxlsYZ/eENlTReXlclytdNrTkPkiiL6r6StSuNs
 PTtHJ70IPd8OiF+lVyoTXNXTRG5DCmCFN7lKf9xKGFKGtBN6oThbGhFOvZG5WZxITw
 4DHNOGj9r5aQrRvSm+1kdlXw/9gLyQ7hG57GfT+o=
Date: Thu, 26 Mar 2020 11:18:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 2/4] ppc/spapr: Improve FWNMI machine check delivery
 corner case comments
Message-ID: <20200326001825.GN36889@umbus.fritz.box>
References: <20200325142906.221248-1-npiggin@gmail.com>
 <20200325142906.221248-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OQhbRXNHSL5w/5po"
Content-Disposition: inline
In-Reply-To: <20200325142906.221248-3-npiggin@gmail.com>
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


--OQhbRXNHSL5w/5po
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 12:29:04AM +1000, Nicholas Piggin wrote:
> Some of the conditions are not as clearly documented as they could be.
> Also the non-FWNMI case does not need a large comment.
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-for-5.0.

> ---
>  hw/ppc/spapr_events.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index a4a540f43d..a908c5d0e9 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -860,17 +860,13 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool reco=
vered)
>      Error *local_err =3D NULL;
> =20
>      if (spapr->fwnmi_machine_check_addr =3D=3D -1) {
> -        /*
> -         * This implies that we have hit a machine check either when the
> -         * guest has not registered FWNMI (i.e., "ibm,nmi-register" not
> -         * called) or between system reset and "ibm,nmi-register".
> -         * Fall back to the old machine check behavior in such cases.
> -         */
> +        /* Non-FWNMI case, deliver it like an architected CPU interrupt.=
 */
>          cs->exception_index =3D POWERPC_EXCP_MCHECK;
>          ppc_cpu_do_interrupt(cs);
>          return;
>      }
> =20
> +    /* Wait for FWNMI interlock. */
>      while (spapr->fwnmi_machine_check_interlock !=3D -1) {
>          /*
>           * Check whether the same CPU got machine check error
> @@ -882,8 +878,13 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recov=
ered)
>              return;
>          }
>          qemu_cond_wait_iothread(&spapr->fwnmi_machine_check_interlock_co=
nd);
> -        /* Meanwhile if the system is reset, then just return */
>          if (spapr->fwnmi_machine_check_addr =3D=3D -1) {
> +            /*
> +             * If the machine was reset while waiting for the interlock,
> +             * abort the delivery. The machine check applies to a context
> +             * that no longer exists, so it wouldn't make sense to deliv=
er
> +             * it now.
> +             */
>              return;
>          }
>      }
> @@ -894,7 +895,9 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recove=
red)
>           * We don't want to abort so we let the migration to continue.
>           * In a rare case, the machine check handler will run on the tar=
get.
>           * Though this is not preferable, it is better than aborting
> -         * the migration or killing the VM.
> +         * the migration or killing the VM. It is okay to call
> +         * migrate_del_blocker on a blocker that was not added (which the
> +         * nmi-interlock handler would do when it's called after this).
>           */
>          warn_report("Received a fwnmi while migration was in progress");
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OQhbRXNHSL5w/5po
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl579NEACgkQbDjKyiDZ
s5Jt/Q/6Ao6NohaQHiN4FOLnNAyfaES4K5iDLZiFhSzlbWFv4uiaZgzoMDDtCy0g
SSwWlSoq01BYxAaIFl2FcGCeoaSX46WSO9pHmFpIPV9+YiXNCanhQzhvLq1ILdfk
ih0/zEQvlYaVVsQDx8AHGLJ1WQmiEr9dUdhDOnHAOMv6024ZzRdeEQkkbQWACScA
OG+EkIzNViQhYriT1wMUWumU31rOVytC7qudaMD2IN6jkPB4vj9KaxQuPVVtMleZ
k00Jms6/1d3epLdk2+PbBzxyzKH5M7vBOqorRXfeVFE45b9P+28m0kuQg+thBblW
JIpQYUKNcSBGcIlgS7zlAmZs6CWD7AQRBdq3gPnDeilJIcxxefFdc2uwOwFTsnMP
Ikwe+XqG4+x/tlKshcHIavqWvmb2leSs6Oo5QyBmOIGgf6QR/R1GuSkoqZE96k4X
fkemZRGSSJVGBRqx/h7LLDN54YbPpJqtDftwBYgE57bDa88G0egWtkVDG/Kta2Vp
TsHfFOfnsCnwFDmaYEI/KrgtoH2Bh8eCgHD+NFCCPzp2KYildFdq8lqFgOJ/oqom
4eu1jXqlS4roBB2RqUIaQqBsX09nA1TK9zCP1R1NQWySba6w0zuz2jmcnXpfd7ip
FjtiNAWyzv5mIn7jzTKwpSdvT0k3DxUstDBq0Gob2M43x6GRhpY=
=LvX2
-----END PGP SIGNATURE-----

--OQhbRXNHSL5w/5po--

