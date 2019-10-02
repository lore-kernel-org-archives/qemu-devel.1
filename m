Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0177C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51AC2086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MCRwIX5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51AC2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFU9X-0002J4-Kt
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 22:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFTBM-0007iW-TP
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 21:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFTBK-0006qd-BB
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 21:11:56 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34115 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFTBG-0006kZ-Cj; Tue, 01 Oct 2019 21:11:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46jdQ84ZJCz9sPh; Wed,  2 Oct 2019 11:11:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569978704;
 bh=OLVxyQW5762cwwR5FN/pK92drJvOD7ZLqtT83C4l6nQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MCRwIX5oNVXztdC8J9dB8XH0WFFlzsDnyJa4onwwhbZTqfvn1tqlRWuoF4G5gAHv7
 Tc0aUCnbVipiVuKc9zIsecSEoWEkyR9775doh8su/xhbgpdQ+1j85ZNAbM/tHe+qnb
 N6WHWrNwr74i569WUGfhcRFP130whO8T//ZRXltI=
Date: Wed, 2 Oct 2019 11:11:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 21/33] spapr, xics, xive: Move cpu_intc_create from
 SpaprIrq to SpaprInterruptController
Message-ID: <20191002011126.GU11105@umbus.fritz.box>
References: <20190930014904.GB11105@umbus.fritz.box>
 <adb67721-5c4e-50ac-f459-a48570a45d6e@kaod.org>
 <20190930061445.GG11105@umbus.fritz.box>
 <75672a0f-6bae-406c-0f0c-d23cc58c9c9f@kaod.org>
 <20191001023102.GN11105@umbus.fritz.box>
 <9c6c7e17-0578-2313-4324-a5ca75149762@kaod.org>
 <20191001064726.GP11105@umbus.fritz.box>
 <5d1910be-7bb7-19d9-73c3-269f2d0c2ee7@kaod.org>
 <20191001081135.GQ11105@umbus.fritz.box>
 <2273d09c-1379-cdbe-0aa9-76f3f4ece349@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FfX2iGK5t5ehHnsE"
Content-Disposition: inline
In-Reply-To: <2273d09c-1379-cdbe-0aa9-76f3f4ece349@kaod.org>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FfX2iGK5t5ehHnsE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2019 at 01:43:12PM +0200, C=E9dric Le Goater wrote:
> On 01/10/2019 10:11, David Gibson wrote:
> > On Tue, Oct 01, 2019 at 09:41:27AM +0200, C=E9dric Le Goater wrote:
> >> On 01/10/2019 08:47, David Gibson wrote:
> >>> On Tue, Oct 01, 2019 at 07:43:51AM +0200, C=E9dric Le Goater wrote:
> >>>> On 01/10/2019 04:31, David Gibson wrote:
> >>>>> On Mon, Sep 30, 2019 at 12:13:14PM +0200, C=E9dric Le Goater wrote:
> >>>>>> On 30/09/2019 08:14, David Gibson wrote:
> >>>>>>> On Mon, Sep 30, 2019 at 07:28:45AM +0200, C=E9dric Le Goater wrot=
e:
> >>>>>>>> On 30/09/2019 03:49, David Gibson wrote:
> >>>>>>>>> On Fri, Sep 27, 2019 at 12:16:49PM +0200, Greg Kurz wrote:
> >>>>>>>>>> On Fri, 27 Sep 2019 15:50:16 +1000
> >>>>>>>>>> David Gibson <david@gibson.dropbear.id.au> wrote:
> >>>>>>>>>>
> >>>>>>>>>>> This method essentially represents code which belongs to the =
interrupt
> >>>>>>>>>>> controller, but needs to be called on all possible intcs, rat=
her than
> >>>>>>>>>>> just the currently active one.  The "dual" version therefore =
calls
> >>>>>>>>>>> into the xics and xive versions confusingly.
> >>>>>>>>>>>
> >>>>>>>>>>> Handle this more directly, by making it instead a method on t=
he intc
> >>>>>>>>>>> backend, and always calling it on every backend that exists.
> >>>>>>>>>>>
> >>>>>>>>>>> While we're there, streamline the error reporting a bit.
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>>>>>>>> [snip]
> >>>>>>>>>>> @@ -525,6 +469,30 @@ static void spapr_irq_check(SpaprMachine=
State *spapr, Error **errp)
> >>>>>>>>>>>  /*
> >>>>>>>>>>>   * sPAPR IRQ frontend routines for devices
> >>>>>>>>>>>   */
> >>>>>>>>>>> +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> >>>>>>>>>>> +                              PowerPCCPU *cpu, Error **errp)
> >>>>>>>>>>> +{
> >>>>>>>>>>> +    if (spapr->xive) {
> >>>>>>>>>>> +        SpaprInterruptController *intc =3D SPAPR_INTC(spapr-=
>xive);
> >>>>>>>>>>> +        SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_G=
ET_CLASS(intc);
> >>>>>>>>>>> +
> >>>>>>>>>>> +        if (sicc->cpu_intc_create(intc, cpu, errp) < 0) {
> >>>>>>>>>>> +            return -1;
> >>>>>>>>>>> +        }
> >>>>>>>>>>> +    }
> >>>>>>>>>>> +
> >>>>>>>>>>> +    if (spapr->ics) {
> >>>>>>>>>>> +        SpaprInterruptController *intc =3D SPAPR_INTC(spapr-=
>ics);
> >>>>>>>>>>> +        SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_G=
ET_CLASS(intc);
> >>>>>>>>>>> +
> >>>>>>>>>>> +        if (sicc->cpu_intc_create(intc, cpu, errp) < 0) {
> >>>>>>>>>>> +            return -1;
> >>>>>>>>>>> +        }
> >>>>>>>>>>> +    }
> >>>>>>>>>>> +
> >>>>>>>>>>
> >>>>>>>>>> Instead of these hooks, what about open-coding spapr_xive_cpu_=
intc_create()
> >>>>>>>>>> and xics_spapr_cpu_intc_create() directly here, like you alrea=
dy did for the
> >>>>>>>>>> ICS and the XIVE objects in spapr_irq_init() ?
> >>>>>>>>>
> >>>>>>>>> I'd prefer not to.  The idea is I want to treat this as basical=
ly:
> >>>>>>>>>
> >>>>>>>>> 	foreach_possible_intc(intc)
> >>>>>>>>> 		intc::cpu_intc_create(...)
> >>>>>>>>>
> >>>>>>>>> If I find time I might indeed replace the explicit ics and xive
> >>>>>>>>> pointers with just an array of SpaprInterruptController *.
> >>>>>>>>
> >>>>>>>> Or you could use object_child_foreach() and check for the type. =
If we had
> >>>>>>>> a helper object_child_foreach_type(), we could use it elsewhere.
> >>>>>>>
> >>>>>>> I thought about that, but I don't think it quite works.  The
> >>>>>>> complication is that the xics device is made explicitly a child o=
f the
> >>>>>>> machine, but the xive device has mmio, so it's a SusBusDevice sit=
ting
> >>>>>>> on the root bus instead.
> >>>>>>
> >>>>>> PnvXscom works fine with Devices and SysBusDevices.
> >>>>>
> >>>>> Uh... what's an example of it working with a SysBusDevice?  All the
> >>>>> implementors of PNV_XSCOM_INTERFACE I could find were instantiated
> >>>>> with object_initialize_child() making them explicitly children of t=
he
> >>>>> chip.  The SPAPR_XIVE is instantiated with qdev_create(NULL,
> >>>>> TYPE_SPAPR_XIVE), making it a child of the root bus, not the machin=
e,
> >>>>> I believe.
> >>>>
> >>>> I see. We should reparent the interrupt controller then.
> >>>
> >>> Well, maybe.  It's not obvious to me that that's the right approach
> >>> just because of this.
> >>>
> >>>
> >>>> Could we rework=20
> >>>> the code to instantiate and realize the XICS and XIVE model objects =
?=20
> >>>> We have the handlers spapr_instance_init() and spapr_machine_init().=
=20
> >>>
> >>> I'm not really sure what you're suggesting here.
> >>
> >> Define the device model objects under the machine and not pointers :
> >>
> >> 	struct SpaprMachineState {
> >> 		...
> >> 		ICSState ics;
> >> 		SpaprXive  xive;
> >> 		...
> >> 	};
> >>
> >> in spapr_instance_init() :
> >>
> >> 	object_initialize_child(obj, "ics",  &spapr->ics, sizeof(spapr->ics),
> >>                             TYPE_ICS, &error_abort, NULL);
> >> 	object_property_add_const_link(OBJECT(&spapr->ics), "xics", obj,
> >>                                    &error_abort);
> >>
> >> 	object_initialize_child(obj, "xive",  &spapr->xive, sizeof(spapr->xiv=
e),
> >>                             TYPE_SPAPR_XIVE, &error_abort, NULL);
> >>
> >>
> >> in spapr_machine_init(), call the realize handler depending on the cho=
sen=20
> >> 'ic-mode'.
> >=20
> > Hm, yeah, maybe.  I don't love having a whole structure in there
> > that's unused when ic-mode !=3D dual.
> >=20
>=20
> This is the pattern followed in the ARM SoC models. Enough room is=20
> provisioned for the maximum controllers and depending on the SoC
> configuration only some are realized.

Hm, ok, I guess that makes it a pretty promising approach.  Maybe for
another day though.  In the meantime I've come up with an approach
that's not totally elegant, but it does remove the duplication of the
paths for xics vs. xive, keep the individual pointers in the structure
for now, and isn't *too* verbose.

I've stripped your R-b due to the change, so please have a look in the
next spin.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FfX2iGK5t5ehHnsE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2T+T4ACgkQbDjKyiDZ
s5IVPg/+KphXcYbARR1HecpOADQ96JTcCS5ODic7tEiutH4SpO9Cs7+sHATwGo6M
Kn9XShKJOGehlqe/iMKu7+S9spgoxunXzhltyiMKunk8PJeTViFjpCN5kYTbfWOJ
va8xT6n1ZOt5J3R5E9oAlgd/PdmfKVmEMPQDOF+BWkVHb5zVfxzfrssRzYaB+pob
rBI9b+GcuGuwefHOCDxcSaJjeSnUVwkZKo18Davo8ft2wAQiaBmXRN3ptyglVq1u
L8VPXi2CPcqtUaJ1/jEA6glLyRKiXC3/DKRXRuywsW5lGVZu//7Wt4OqSjIaPLio
jBU1+PBIiPtFWk7zYID/r4VyTmIbhkaX+WU7w+5Ge/H+1eWOBjegP+RUW/v0dSoG
dtji5kU8tNfoAWXfd2U4NZUt/D96JNh+giQYCmr9UarvhliVaiBzIzfeu6kiND8k
7ObAHGGjJwHgB9Uwsrn023snTyzoGIPIgbh7xCbGdfswXx5k5SPoi+mILytXT2lq
YCm54JO5zDDrPVPvILjQGCZffh1SaaGXByE/Pv3RAmXUaJ/K3iRy8gf1581hG0SZ
1Te2ddE3gpnGX26duTBMavsiHoDzXTS82XIEfuziXOIUEI4s/Utt5osrFELv1Kdc
X6EGSZLYomDZU0Tfz2xi3fRYWGeaD9iHnwOZpXg6FZ/pQYkwwZo=
=YSPw
-----END PGP SIGNATURE-----

--FfX2iGK5t5ehHnsE--

