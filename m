Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD872C4BA06
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 01:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9088120658
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 01:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nxGe+gRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9088120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6lUv-0006RH-Mt
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 20:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j6lTy-0005WI-QR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 20:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j6lTx-0001TK-EM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 20:27:26 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:59007 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j6lTw-0001Bf-SV; Tue, 25 Feb 2020 20:27:25 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48Ryp96l8yz9sRJ; Wed, 26 Feb 2020 12:27:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582680433;
 bh=kRQ8kNbq/1ROJcL+oCuqAQo8AQZVh+uUJ6uY0lNjb70=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nxGe+gRtOC/6hrZoPslLMNHsVIXk9oTxZCRfnvh2r4yi20n6vOQ6AkYGiorZ3YnSC
 s9gf6xGAmzMq07K+xRqpjSKyUurDdJvso80cAWijBeJNq8j/A7tUVhuBh4ID/lddfH
 G+lk56EjjolSdc1SGOauoGC9Vi+ihpJGkbgjSH/c=
Date: Wed, 26 Feb 2020 12:00:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6 06/18] spapr, ppc: Remove VPM0/RMLS hacks for POWER9
Message-ID: <20200226010041.GG41629@umbus.fritz.box>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-7-david@gibson.dropbear.id.au>
 <20200225122900.0fe0780b@bahia.home>
 <20200225165801.14cba74c@bahia.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
Content-Disposition: inline
In-Reply-To: <20200225165801.14cba74c@bahia.home>
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, farosas@linux.ibm.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@kaod.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2020 at 04:58:01PM +0100, Greg Kurz wrote:
> On Tue, 25 Feb 2020 12:29:00 +0100
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Tue, 25 Feb 2020 10:37:12 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > For the "pseries" machine, we use "virtual hypervisor" mode where we
> > > only model the CPU in non-hypervisor privileged mode.  This means that
> > > we need guest physical addresses within the modelled cpu to be treated
> > > as absolute physical addresses.
> > >=20
> > > We used to do that by clearing LPCR[VPM0] and setting LPCR[RMLS] to a=
 high
> > > limit so that the old offset based translation for guest mode applied,
> > > which does what we need.  However, POWER9 has removed support for that
> > > translation mode, which meant we had some ugly hacks to keep it worki=
ng.
> > >=20
> > > We now explicitly handle this sort of translation for virtual hypervi=
sor
> > > mode, so the hacks aren't necessary.  We don't need to set VPM0 and R=
MLS
> > > from the machine type code - they're now ignored in vhyp mode.  On th=
e cpu
> > > side we don't need to allow LPCR[RMLS] to be set on POWER9 in vhyp mo=
de -
> > > that was only there to allow the hack on the machine side.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> > > ---
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
>=20
> Ah wait...
>=20
> > >  hw/ppc/spapr_cpu_core.c | 6 +-----
> > >  target/ppc/mmu-hash64.c | 8 --------
> > >  2 files changed, 1 insertion(+), 13 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index d09125d9af..ea5e11f1d9 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -58,14 +58,10 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
> > >       * we don't get spurious wakups before an RTAS start-cpu call.
> > >       * For the same reason, set PSSCR_EC.
> > >       */
> > > -    lpcr &=3D ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->l=
pcr_pm);
> > > +    lpcr &=3D ~(LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpcr_pm);
>=20
> ... a few lines above, we have a comment that should be dropped as well.
>=20
>      * Clearing VPM0 will also cause us to use RMOR in mmu-hash64.c for
>      * real mode accesses, which thankfully defaults to 0 and isn't
>      * accessible in guest mode.

Removed, thanks.

>=20
> My R-b tag stands anyway.
>=20
> > >      lpcr |=3D LPCR_LPES0 | LPCR_LPES1;
> > >      env->spr[SPR_PSSCR] |=3D PSSCR_EC;
> > > =20
> > > -    /* Set RMLS to the max (ie, 16G) */
> > > -    lpcr &=3D ~LPCR_RMLS;
> > > -    lpcr |=3D 1ull << LPCR_RMLS_SHIFT;
> > > -
> > >      ppc_store_lpcr(cpu, lpcr);
> > > =20
> > >      /* Set a full AMOR so guest can use the AMR as it sees fit */
> > > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > > index e372c42add..caf47ad6fc 100644
> > > --- a/target/ppc/mmu-hash64.c
> > > +++ b/target/ppc/mmu-hash64.c
> > > @@ -1126,14 +1126,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ul=
ong val)
> > >                        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | L=
PCR_EEE |
> > >                        LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE |=
 LPCR_TC |
> > >                        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDI=
CE);
> > > -        /*
> > > -         * If we have a virtual hypervisor, we need to bring back RM=
LS. It
> > > -         * doesn't exist on an actual P9 but that's all we know how =
to
> > > -         * configure with softmmu at the moment
> > > -         */
> > > -        if (cpu->vhyp) {
> > > -            lpcr |=3D (val & LPCR_RMLS);
> > > -        }
> > >          break;
> > >      default:
> > >          g_assert_not_reached();
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5VwzcACgkQbDjKyiDZ
s5IVnw/7Bqc/IFZxnRt7Os2kmwmqzu+TY2zcJZ78chSQeJYC8TR84/APwFJf/pv4
4PWAopEeNxtwMEwa9paczpm87seepMOopj9mDBiejJHb54hJbk9EVXoIH7TMmRYy
PUKWg6Xrybf0A3HgpY0Jfb1hYo767rG7+ncTW9ufuT+7LN/fs7BR40j+1XNDoFu7
53mVlGe5ddUhxxlGDYLLSx2nOz2H7OF3kqKAWdDWgcfjwfP5xfiCQ95KtUexO4sd
KSWIUltRq+LVnrzB6rejZzDtU1wpyIc78dRtSz7G7nOsZ16avAjtt5REEUkS/wQS
6KFBkvex9N/LWhhUrEPLpYY2eDknjFp9jDEKACFMZXyzd+WVr/Tisz15kZY4BsN6
yIrxh+YpLvr84bNSO+2hUWPgObYasxRKBkjuZUk/HCB9vV2zICkiqEzbRXLbW0He
rGpSg+nqj07yB2fmXMomeM4rGeK/+isXfcPY12h6E9Cq9JQQ3Y6jk8BigivO0KsJ
GRwJd6J6jiCxsa1SCGamUBV/UKx+bDm+vtpchQ+NRzkJ6c41BTkMEx4fSqlNxPkn
iacBQPbEC9dV3OgGc2IKAC8tqjLwmmpfbHL8/5XiwL1EAz1tG061tx+J77+Yixmq
fR0R0enQCzwHfeMER18/QWvFOPJFHdS9GCYvcFNOsxHsUCiT9Lc=
=kGTY
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--

