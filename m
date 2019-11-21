Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB233C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA362068D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA362068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXj71-0002BE-RS
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 04:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iXj5t-0001X3-Kv
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iXj5s-0003eN-Db
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:49:45 -0500
Received: from 10.mo6.mail-out.ovh.net ([87.98.157.236]:48221)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iXj5r-0003YW-2H
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:49:44 -0500
Received: from player698.ha.ovh.net (unknown [10.109.143.18])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6AC231EB4DB
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 10:49:32 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player698.ha.ovh.net (Postfix) with ESMTPSA id 0CF7AC59984F;
 Thu, 21 Nov 2019 09:49:27 +0000 (UTC)
Date: Thu, 21 Nov 2019 10:49:26 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 11/23] ppc/pnv: Introduce a
 pnv_xive_is_cpu_enabled() helper
Message-ID: <20191121104926.4fe63f1c@bahia.lan>
In-Reply-To: <639848d3-8621-13e4-6e4b-1716b9c54372@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-12-clg@kaod.org>
 <20191120182612.3069e279@bahia.lan>
 <4549a66b-5db6-5a71-87a2-3c126fa4db6b@kaod.org>
 <20191121085856.0344fac5@bahia.lan>
 <639848d3-8621-13e4-6e4b-1716b9c54372@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 6749488468305090955
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehvddgtdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.157.236
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

On Thu, 21 Nov 2019 10:16:14 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 21/11/2019 08:58, Greg Kurz wrote:
> > On Wed, 20 Nov 2019 22:40:31 +0100
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >=20
> >> On 20/11/2019 18:26, Greg Kurz wrote:
> >>> On Fri, 15 Nov 2019 17:24:24 +0100
> >>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >>>
> >>>> and use this helper to exclude CPUs which are not enabled in the XIVE
> >>>> controller.
> >>>>
> >>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >>>> ---
> >>>>  hw/intc/pnv_xive.c | 18 ++++++++++++++++++
> >>>>  1 file changed, 18 insertions(+)
> >>>>
> >>>> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> >>>> index 71ca4961b6b1..4c8c6e51c20f 100644
> >>>> --- a/hw/intc/pnv_xive.c
> >>>> +++ b/hw/intc/pnv_xive.c
> >>>> @@ -372,6 +372,20 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, u=
int8_t blk, uint32_t idx,
> >>>>      return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
> >>>>  }
> >>>> =20
> >>>> +static int cpu_pir(PowerPCCPU *cpu)
> >>>> +{
> >>>> +    CPUPPCState *env =3D &cpu->env;
> >>>> +    return env->spr_cb[SPR_PIR].default_value;
> >>>> +}
> >>>> +
> >>>> +static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
> >>>> +{
> >>>> +    int pir =3D cpu_pir(cpu);
> >>>> +    int thrd_id =3D pir & 0x7f;
> >>>> +
> >>>> +    return xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(thrd_id);
> >>>
> >>> A similar check is open-coded in pnv_xive_get_indirect_tctx() :
> >>>
> >>>     /* Check that HW thread is XIVE enabled */
> >>>     if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) {
> >>>         xive_error(xive, "IC: CPU %x is not enabled", pir);
> >>>     }
> >>>
> >>> The thread id is only the 6 lower bits of the PIR there, and so seems=
 to
> >>> indicate the skiboot sources:
> >>>
> >>>         /* Get bit in register */
> >>>         bit =3D c->pir & 0x3f;
> >>
> >> skiboot uses 0x3f when enabling the TCTXT of a CPU because register
> >> INT_TCTXT_EN0 covers cores 0-15 (normal) and 0-7 (fused) and=20
> >> register INT_TCTXT_EN1 covers cores 16-23 (normal) and 8-11 (fused).=20
> >> The encoding in the registers is a bit different.
> >>
> >>> Why make it pir & 0x7f here ?=20
> >>
> >> See pnv_chip_core_pir_p9 comments for some details on the CPU ID=20
> >> layout.
> >>
> >=20
> > *   57:61  Core number
> > *   62:63  Thread ID
> >=20
> > Ok, so the CPU ID within the socket is 7 bits, ie. pir & 0x7f
> >=20
> >>> If it should actually be 0x3f,=20
> >> but yes, we should fix the mask in the register setting.=20
> >>
> >>> maybe also use the helper in pnv_xive_get_indirect_tctx().
> >>
> >> This is getting changed later on. So I rather not.
> >>
> >=20
> > I don't see any later change there, neither in this series,=20
>=20
> Patch "ppc/pnv: Clarify how the TIMA is accessed on a multichip system"
>=20
> changes a few things in that area.
>=20

No, it changes pnv_xive_get_tctx() which gets removed later by

"[PATCH for-5.0 v5 19/23] ppc/xive: Remove the get_tctx() XiveRouter handle=
r"

My remark was about pnv_xive_get_indirect_tctx(), but nevermind :)

> > nor in your powernv-4.2 on github, but nevermind, this patch is
> > good enough for the purpose of CAM line matching.
>=20
> Yes. It could be better though and it's a localized change.=20
>=20
> the INT_TCTXT_EN0 (PC_THREAD_EN_REG0) needs a small fix on the mask.=20
> We don't use the EN1 register also for cores > 15.=20
>=20
> It works today because we don't start the machine with all the=20
> possible cores. Although it should be possible to start a QEMU=20
> PowerNV machine with 24 cores on each socket.=20
>=20
>=20
> I would like to have stricter checks on CAM line accesses because
> it is an OS interface. The INT_TCTXT_EN0 (PC_THREAD_EN_REG0) is=20
> the first level (HW) but we need to check also the 'V' bit of=20
> each ring. That's more complex. For later.
>=20
>=20
> C.=20
>=20
>=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> >> C.
> >>
> >>>
> >>>> +}
> >>>> +
> >>>>  static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
> >>>>                                uint8_t nvt_blk, uint32_t nvt_idx,
> >>>>                                bool cam_ignore, uint8_t priority,
> >>>> @@ -393,6 +407,10 @@ static int pnv_xive_match_nvt(XivePresenter *xp=
tr, uint8_t format,
> >>>>              XiveTCTX *tctx;
> >>>>              int ring;
> >>>> =20
> >>>> +            if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
> >>>> +                continue;
> >>>> +            }
> >>>> +
> >>>>              tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> >>>> =20
> >>>>              /*
> >>>
> >>
> >=20
>=20


