Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184A6C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 02:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37C22168B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 02:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JeozYZ5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37C22168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF86s-0001J3-1j
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 22:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iF868-0000fO-MH
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 22:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iF867-0001yN-69
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 22:41:08 -0400
Received: from ozlabs.org ([203.11.71.1]:33243)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iF865-0001ra-3L; Mon, 30 Sep 2019 22:41:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46j3Rd0zGTz9sPJ; Tue,  1 Oct 2019 12:41:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569897661;
 bh=D1OEfA3hm5OticGiZeS05BP2zutpZ8A8HGqniWo3Usc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JeozYZ5lfzJ0kkMnSNoE3piQxHiTxdQ02kvPxD2KBH2wZuyTKz4N5N1cVJiRNrlP/
 YAJMt7UoBtrY+Bo5OaEarHAzUY8aYlqD6XBhxsrjXqIHrWrnIPgdFRKsQdbd51iTkP
 qsTLRxJLBgunWEe9oFGJZ0akfKgXGkt2Q0nGQO08=
Date: Tue, 1 Oct 2019 12:31:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 21/33] spapr, xics, xive: Move cpu_intc_create from
 SpaprIrq to SpaprInterruptController
Message-ID: <20191001023102.GN11105@umbus.fritz.box>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-22-david@gibson.dropbear.id.au>
 <20190927121649.5b9f3db7@bahia.lan>
 <20190930014904.GB11105@umbus.fritz.box>
 <adb67721-5c4e-50ac-f459-a48570a45d6e@kaod.org>
 <20190930061445.GG11105@umbus.fritz.box>
 <75672a0f-6bae-406c-0f0c-d23cc58c9c9f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1HuzLmPZrG5RH6bG"
Content-Disposition: inline
In-Reply-To: <75672a0f-6bae-406c-0f0c-d23cc58c9c9f@kaod.org>
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


--1HuzLmPZrG5RH6bG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2019 at 12:13:14PM +0200, C=E9dric Le Goater wrote:
> On 30/09/2019 08:14, David Gibson wrote:
> > On Mon, Sep 30, 2019 at 07:28:45AM +0200, C=E9dric Le Goater wrote:
> >> On 30/09/2019 03:49, David Gibson wrote:
> >>> On Fri, Sep 27, 2019 at 12:16:49PM +0200, Greg Kurz wrote:
> >>>> On Fri, 27 Sep 2019 15:50:16 +1000
> >>>> David Gibson <david@gibson.dropbear.id.au> wrote:
> >>>>
> >>>>> This method essentially represents code which belongs to the interr=
upt
> >>>>> controller, but needs to be called on all possible intcs, rather th=
an
> >>>>> just the currently active one.  The "dual" version therefore calls
> >>>>> into the xics and xive versions confusingly.
> >>>>>
> >>>>> Handle this more directly, by making it instead a method on the intc
> >>>>> backend, and always calling it on every backend that exists.
> >>>>>
> >>>>> While we're there, streamline the error reporting a bit.
> >>>>>
> >>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>> [snip]
> >>>>> @@ -525,6 +469,30 @@ static void spapr_irq_check(SpaprMachineState =
*spapr, Error **errp)
> >>>>>  /*
> >>>>>   * sPAPR IRQ frontend routines for devices
> >>>>>   */
> >>>>> +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> >>>>> +                              PowerPCCPU *cpu, Error **errp)
> >>>>> +{
> >>>>> +    if (spapr->xive) {
> >>>>> +        SpaprInterruptController *intc =3D SPAPR_INTC(spapr->xive);
> >>>>> +        SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLA=
SS(intc);
> >>>>> +
> >>>>> +        if (sicc->cpu_intc_create(intc, cpu, errp) < 0) {
> >>>>> +            return -1;
> >>>>> +        }
> >>>>> +    }
> >>>>> +
> >>>>> +    if (spapr->ics) {
> >>>>> +        SpaprInterruptController *intc =3D SPAPR_INTC(spapr->ics);
> >>>>> +        SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLA=
SS(intc);
> >>>>> +
> >>>>> +        if (sicc->cpu_intc_create(intc, cpu, errp) < 0) {
> >>>>> +            return -1;
> >>>>> +        }
> >>>>> +    }
> >>>>> +
> >>>>
> >>>> Instead of these hooks, what about open-coding spapr_xive_cpu_intc_c=
reate()
> >>>> and xics_spapr_cpu_intc_create() directly here, like you already did=
 for the
> >>>> ICS and the XIVE objects in spapr_irq_init() ?
> >>>
> >>> I'd prefer not to.  The idea is I want to treat this as basically:
> >>>
> >>> 	foreach_possible_intc(intc)
> >>> 		intc::cpu_intc_create(...)
> >>>
> >>> If I find time I might indeed replace the explicit ics and xive
> >>> pointers with just an array of SpaprInterruptController *.
> >>
> >> Or you could use object_child_foreach() and check for the type. If we =
had
> >> a helper object_child_foreach_type(), we could use it elsewhere.
> >=20
> > I thought about that, but I don't think it quite works.  The
> > complication is that the xics device is made explicitly a child of the
> > machine, but the xive device has mmio, so it's a SusBusDevice sitting
> > on the root bus instead.
>=20
> PnvXscom works fine with Devices and SysBusDevices.

Uh... what's an example of it working with a SysBusDevice?  All the
implementors of PNV_XSCOM_INTERFACE I could find were instantiated
with object_initialize_child() making them explicitly children of the
chip.  The SPAPR_XIVE is instantiated with qdev_create(NULL,
TYPE_SPAPR_XIVE), making it a child of the root bus, not the machine,
I believe.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1HuzLmPZrG5RH6bG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2SumQACgkQbDjKyiDZ
s5JiLQ//ee4kR5gPW3p3obQBQm57MGIGLuejuciCNaKEkgbkXCYfKDlWipx+LVKR
NXnjpKmmQFN9fDL06eg1HQcQBGiwkwxSSEN9Jf+so6XrdJjHafTv7H0OgpZsKZ8R
hzkbMjHX1NeX4VW5bMGGog6FGG2nhraB7rtCurvjOmXHXcseJNnL5f7YK9rBqiq/
JuVvcL/zACBdNENza5CJ3y2kMBd1n0SHfc7zNX75bL0xNKz02uEpANNVOvlJkmxc
8kIImOfAJBf78jKbxNaUx3DQ0ubJx0NEvp2Mc3BNbdhgRPDATUK0HLTkHvQHNUuH
p/IaT+kR8XwK4cHXKjz8YUoE/l7dc4h7yl5mqpvlvD4vxEWDXncWwcs36vOKr3G4
XGv5cj6dtD/soTOaeh8gmgNJTy/cbswRqXclfoEI/WN7GJUGNn2JME4HaTJhcakP
JZT02sfVWuX4yw1lckO7xoO2mswgpgT5ZNNHBKzFpTozB+zT8hIpAR8hgDJTQ/Qe
fEX2lISdTB8qUlj0TzaxXVVntDrmzAjr3tJLc7MIsk3lXtwjJou1GQBuw9c6Jvxy
qU2lxfI3hRU0AQRwVWw4vByutCiOcRldBfNYh9nPDR/n6fu4bogaJGxWwndd664R
zpsZKTbDri5IUM9+xWE1olRZoJwtFtNFG+AYRfbl/o16Ey+cOYg=
=hYyr
-----END PGP SIGNATURE-----

--1HuzLmPZrG5RH6bG--

