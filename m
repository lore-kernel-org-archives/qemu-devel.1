Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A00C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 07:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D64320872
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 07:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D64320872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXgqQ-0006XU-DT
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 02:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iXgpe-00060f-Bo
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 02:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iXgpd-0002WS-4a
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 02:24:50 -0500
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:54408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iXgpc-0002Vn-Tj
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 02:24:49 -0500
Received: from player737.ha.ovh.net (unknown [10.109.159.154])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 5C6F419B0CF
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 08:24:46 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 38EC72EAF9EE;
 Thu, 21 Nov 2019 07:24:41 +0000 (UTC)
Date: Thu, 21 Nov 2019 08:24:39 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 14/23] ppc/spapr: Implement the XiveFabric
 interface
Message-ID: <20191121082439.3ffdb02a@bahia.lan>
In-Reply-To: <f2adb826-d62b-e593-3fd0-ddcad3e53771@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-15-clg@kaod.org>
 <20191120185324.7f859d39@bahia.lan>
 <f2adb826-d62b-e593-3fd0-ddcad3e53771@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 4304596822686210443
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehuddguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.104.224
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 07:56:32 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 20/11/2019 18:53, Greg Kurz wrote:
> > On Fri, 15 Nov 2019 17:24:27 +0100
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >=20
> >> The CAM line matching sequence in the pseries machine does not change
> >> much apart from the use of the new QOM interfaces. There is an extra
> >> indirection because of the sPAPR IRQ backend of the machine. Only the
> >> XIVE backend implements the new 'match_nvt' handler.
> >>
> >=20
> > The changelog needs an update since you dropped the indirection you had
> > in v4.
>=20
> Indeed.
>=20
> >=20
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/ppc/spapr.c | 36 ++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 36 insertions(+)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 94f9d27096af..a8f5850f65bb 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -4270,6 +4270,39 @@ static void spapr_pic_print_info(InterruptStats=
Provider *obj,
> >>                     kvm_irqchip_in_kernel() ? "in-kernel" : "emulated"=
);
> >>  }
> >> =20
> >> +static int spapr_xive_match_nvt(XiveFabric *xfb, uint8_t format,
> >> +                                uint8_t nvt_blk, uint32_t nvt_idx,
> >> +                                bool cam_ignore, uint8_t priority,
> >> +                                uint32_t logic_serv, XiveTCTXMatch *m=
atch)
> >> +{
> >> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(xfb);
> >> +    XivePresenter *xptr =3D XIVE_PRESENTER(spapr->xive);
> >> +    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
> >> +    int count;
> >> +
> >=20
> > As suggested by David, you should probably assert() that XIVE is in use
> > for extra paran^Wsafety.
>=20
> I don't see the need. The stack call is clear enough IMO. It can only be=
=20
> reached from the XiveRouter.
>=20

Hmm... the assert() proposal isn't about this getting called by some
other code, it is about ensuring XIVE is the active IC in case the
machine was started with ic-mode=3Ddual. But if you're confident enough
it can never ever happen, no matter any subsequent change may done to
the code, then don't add it :)

> Thanks,
>=20
> C.=20
>=20
> > With these fixed,
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> >> +    count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_igno=
re,
> >> +                           priority, logic_serv, match);
> >> +    if (count < 0) {
> >> +        return count;
> >> +    }
> >> +
> >> +    /*
> >> +     * When we implement the save and restore of the thread interrupt
> >> +     * contexts in the enter/exit CPU handlers of the machine and the
> >> +     * escalations in QEMU, we should be able to handle non dispatched
> >> +     * vCPUs.
> >> +     *
> >> +     * Until this is done, the sPAPR machine should find at least one
> >> +     * matching context always.
> >> +     */
> >> +    if (count =3D=3D 0) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is not dispat=
ched\n",
> >> +                      nvt_blk, nvt_idx);
> >> +    }
> >> +
> >> +    return count;
> >> +}
> >> +
> >>  int spapr_get_vcpu_id(PowerPCCPU *cpu)
> >>  {
> >>      return cpu->vcpu_id;
> >> @@ -4366,6 +4399,7 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
> >>      PPCVirtualHypervisorClass *vhc =3D PPC_VIRTUAL_HYPERVISOR_CLASS(o=
c);
> >>      XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
> >>      InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CL=
ASS(oc);
> >> +    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
> >> =20
> >>      mc->desc =3D "pSeries Logical Partition (PAPR compliant)";
> >>      mc->ignore_boot_device_suffixes =3D true;
> >> @@ -4442,6 +4476,7 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
> >>      smc->linux_pci_probe =3D true;
> >>      smc->smp_threads_vsmt =3D true;
> >>      smc->nr_xirqs =3D SPAPR_NR_XIRQS;
> >> +    xfc->match_nvt =3D spapr_xive_match_nvt;
> >>  }
> >> =20
> >>  static const TypeInfo spapr_machine_info =3D {
> >> @@ -4460,6 +4495,7 @@ static const TypeInfo spapr_machine_info =3D {
> >>          { TYPE_PPC_VIRTUAL_HYPERVISOR },
> >>          { TYPE_XICS_FABRIC },
> >>          { TYPE_INTERRUPT_STATS_PROVIDER },
> >> +        { TYPE_XIVE_FABRIC },
> >>          { }
> >>      },
> >>  };
> >=20
>=20


