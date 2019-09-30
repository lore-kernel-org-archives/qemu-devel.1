Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0F8C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 07:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69F02081B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 07:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IxfHCAHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69F02081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEq8g-0004Z4-Ps
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 03:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iEq78-0003TD-O0
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 03:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iEq77-00006v-A0
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 03:28:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46789 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iEq76-0008V7-4c; Mon, 30 Sep 2019 03:28:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46hYtC3cwlz9sPG; Mon, 30 Sep 2019 17:28:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569828531;
 bh=Ve9Z++CMgcUBRdRvovNGbR1AxqHdpxKndYnsZqGY9Zs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IxfHCAHhLMZ3EISz+4xcvSpuPeys+z/Fg5LHLzLH88nWITarY1fMGqfsRDLDQYtjI
 8TKiL5v+vLO3AXRAucYBpFDUZ92l86/n73mFa54oURniWMJukzqDImN9SkLPnJEZhZ
 MTj5O8VUvPXuxuqed1Mb/n/c14dIwIDmAA4ckfQU=
Date: Mon, 30 Sep 2019 16:14:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 21/33] spapr, xics, xive: Move cpu_intc_create from
 SpaprIrq to SpaprInterruptController
Message-ID: <20190930061445.GG11105@umbus.fritz.box>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-22-david@gibson.dropbear.id.au>
 <20190927121649.5b9f3db7@bahia.lan>
 <20190930014904.GB11105@umbus.fritz.box>
 <adb67721-5c4e-50ac-f459-a48570a45d6e@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L1c6L/cjZjI9d0Eq"
Content-Disposition: inline
In-Reply-To: <adb67721-5c4e-50ac-f459-a48570a45d6e@kaod.org>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--L1c6L/cjZjI9d0Eq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2019 at 07:28:45AM +0200, C=E9dric Le Goater wrote:
> On 30/09/2019 03:49, David Gibson wrote:
> > On Fri, Sep 27, 2019 at 12:16:49PM +0200, Greg Kurz wrote:
> >> On Fri, 27 Sep 2019 15:50:16 +1000
> >> David Gibson <david@gibson.dropbear.id.au> wrote:
> >>
> >>> This method essentially represents code which belongs to the interrupt
> >>> controller, but needs to be called on all possible intcs, rather than
> >>> just the currently active one.  The "dual" version therefore calls
> >>> into the xics and xive versions confusingly.
> >>>
> >>> Handle this more directly, by making it instead a method on the intc
> >>> backend, and always calling it on every backend that exists.
> >>>
> >>> While we're there, streamline the error reporting a bit.
> >>>
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > [snip]
> >>> @@ -525,6 +469,30 @@ static void spapr_irq_check(SpaprMachineState *s=
papr, Error **errp)
> >>>  /*
> >>>   * sPAPR IRQ frontend routines for devices
> >>>   */
> >>> +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> >>> +                              PowerPCCPU *cpu, Error **errp)
> >>> +{
> >>> +    if (spapr->xive) {
> >>> +        SpaprInterruptController *intc =3D SPAPR_INTC(spapr->xive);
> >>> +        SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS=
(intc);
> >>> +
> >>> +        if (sicc->cpu_intc_create(intc, cpu, errp) < 0) {
> >>> +            return -1;
> >>> +        }
> >>> +    }
> >>> +
> >>> +    if (spapr->ics) {
> >>> +        SpaprInterruptController *intc =3D SPAPR_INTC(spapr->ics);
> >>> +        SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS=
(intc);
> >>> +
> >>> +        if (sicc->cpu_intc_create(intc, cpu, errp) < 0) {
> >>> +            return -1;
> >>> +        }
> >>> +    }
> >>> +
> >>
> >> Instead of these hooks, what about open-coding spapr_xive_cpu_intc_cre=
ate()
> >> and xics_spapr_cpu_intc_create() directly here, like you already did f=
or the
> >> ICS and the XIVE objects in spapr_irq_init() ?
> >=20
> > I'd prefer not to.  The idea is I want to treat this as basically:
> >=20
> > 	foreach_possible_intc(intc)
> > 		intc::cpu_intc_create(...)
> >=20
> > If I find time I might indeed replace the explicit ics and xive
> > pointers with just an array of SpaprInterruptController *.
>=20
> Or you could use object_child_foreach() and check for the type. If we had
> a helper object_child_foreach_type(), we could use it elsewhere.

I thought about that, but I don't think it quite works.  The
complication is that the xics device is made explicitly a child of the
machine, but the xive device has mmio, so it's a SusBusDevice sitting
on the root bus instead.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L1c6L/cjZjI9d0Eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2RnVIACgkQbDjKyiDZ
s5JMSA/+IkuL/ZUHBTp4uo7sbDAl/QZAENvgJrVz4tE+DRXWSTsrNpBl3wrXQr38
8zF2G++61eRTLEIuxB4aSL3skkMhaf+YRyDaCnHlGETpdRZ0H8UqGeJKHi2Y8RSr
wzVPqO49wDeMWYA/miu5YxbIbXzIjfgB+QcJX5MV+XThls0kfdyiTZdEdG/zKwaq
fg7qwRWqxb7/k7VCbOasDzvNmDTov6tXKWvYNGqM97xJWjlhP0NMGxHdPnSeAQvW
3HJEUJlVcsuQOTwDjU6xjQCi46PrmNXKjJqJEhI0Sf2CSC0XnQ3SZFCFDfksvwAP
mne0Cl6VRwRpJCLSuOOmVSPDkxlH+X6IBmjRB8BbrO6Ghl+UbjbLTQz7MQSw76DV
k7KWxHyCs2LIarTAeKrV1g3pAg5jc6BMamiTRZ05Ey4IPaVvUHVOxpYuSZrHme6p
ieSu5hILkxrkrOV7SaY1jx8sV7bumkwlpTx8II6wDys0MWMFPNuUoq9Vm6M0Lr07
nK1CvcilvmwD2erMnQ6QRchprUY/J2orsgNMN22hB8eYvKtK6BZF3GHQ9WdSYpQ/
MjFpzdnDfyfNkqha3qnTGx0FyesbHR4vBwirsCqi3ZFer8u5HqBqRbm9j7fTLJ90
zOmgcKxJ6crC1SkLeq2AoydrL6jKGvWBV6eRVHjzIEe7a75JpyU=
=2JkR
-----END PGP SIGNATURE-----

--L1c6L/cjZjI9d0Eq--

