Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EF5C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 07:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1FC2088F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 07:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1FC2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXh4I-0002bm-H0
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 02:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXh3P-00021m-30
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 02:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXh3N-0000mM-J9
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 02:39:02 -0500
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:58813)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXh3N-0000m5-CY
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 02:39:01 -0500
Received: from player697.ha.ovh.net (unknown [10.108.57.95])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id BC964114A03
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 08:38:58 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id 98DE3C607F59;
 Thu, 21 Nov 2019 07:38:54 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v5 14/23] ppc/spapr: Implement the XiveFabric
 interface
To: Greg Kurz <groug@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-15-clg@kaod.org> <20191120185324.7f859d39@bahia.lan>
 <f2adb826-d62b-e593-3fd0-ddcad3e53771@kaod.org>
 <20191121082439.3ffdb02a@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <68f509ee-e993-3a84-bc09-a00b591b2a4b@kaod.org>
Date: Thu, 21 Nov 2019 08:38:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121082439.3ffdb02a@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 4544694977611205459
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehuddguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeljedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.109.80
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

On 21/11/2019 08:24, Greg Kurz wrote:
> On Thu, 21 Nov 2019 07:56:32 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 20/11/2019 18:53, Greg Kurz wrote:
>>> On Fri, 15 Nov 2019 17:24:27 +0100
>>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>>
>>>> The CAM line matching sequence in the pseries machine does not chang=
e
>>>> much apart from the use of the new QOM interfaces. There is an extra
>>>> indirection because of the sPAPR IRQ backend of the machine. Only th=
e
>>>> XIVE backend implements the new 'match_nvt' handler.
>>>>
>>>
>>> The changelog needs an update since you dropped the indirection you h=
ad
>>> in v4.
>>
>> Indeed.
>>
>>>
>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  hw/ppc/spapr.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 36 insertions(+)
>>>>
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 94f9d27096af..a8f5850f65bb 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -4270,6 +4270,39 @@ static void spapr_pic_print_info(InterruptSta=
tsProvider *obj,
>>>>                     kvm_irqchip_in_kernel() ? "in-kernel" : "emulate=
d");
>>>>  }
>>>> =20
>>>> +static int spapr_xive_match_nvt(XiveFabric *xfb, uint8_t format,
>>>> +                                uint8_t nvt_blk, uint32_t nvt_idx,
>>>> +                                bool cam_ignore, uint8_t priority,
>>>> +                                uint32_t logic_serv, XiveTCTXMatch =
*match)
>>>> +{
>>>> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(xfb);
>>>> +    XivePresenter *xptr =3D XIVE_PRESENTER(spapr->xive);
>>>> +    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
>>>> +    int count;
>>>> +
>>>
>>> As suggested by David, you should probably assert() that XIVE is in u=
se
>>> for extra paran^Wsafety.
>>
>> I don't see the need. The stack call is clear enough IMO. It can only =
be=20
>> reached from the XiveRouter.
>>
>=20
> Hmm... the assert() proposal isn't about this getting called by some
> other code, it is about ensuring XIVE is the active IC in case the
> machine was started with ic-mode=3Ddual. But if you're confident enough
> it can never ever happen, no matter any subsequent change may done to
> the code, then don't add it :)

If XIVE mode is not selected, the XIVE ESB pages are not mapped in the=20
machine address space and you can not reach the Router without them.

C.

>=20
>> Thanks,
>>
>> C.=20
>>
>>> With these fixed,
>>>
>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>>
>>>> +    count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ig=
nore,
>>>> +                           priority, logic_serv, match);
>>>> +    if (count < 0) {
>>>> +        return count;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * When we implement the save and restore of the thread interru=
pt
>>>> +     * contexts in the enter/exit CPU handlers of the machine and t=
he
>>>> +     * escalations in QEMU, we should be able to handle non dispatc=
hed
>>>> +     * vCPUs.
>>>> +     *
>>>> +     * Until this is done, the sPAPR machine should find at least o=
ne
>>>> +     * matching context always.
>>>> +     */
>>>> +    if (count =3D=3D 0) {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is not disp=
atched\n",
>>>> +                      nvt_blk, nvt_idx);
>>>> +    }
>>>> +
>>>> +    return count;
>>>> +}
>>>> +
>>>>  int spapr_get_vcpu_id(PowerPCCPU *cpu)
>>>>  {
>>>>      return cpu->vcpu_id;
>>>> @@ -4366,6 +4399,7 @@ static void spapr_machine_class_init(ObjectCla=
ss *oc, void *data)
>>>>      PPCVirtualHypervisorClass *vhc =3D PPC_VIRTUAL_HYPERVISOR_CLASS=
(oc);
>>>>      XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
>>>>      InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_=
CLASS(oc);
>>>> +    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
>>>> =20
>>>>      mc->desc =3D "pSeries Logical Partition (PAPR compliant)";
>>>>      mc->ignore_boot_device_suffixes =3D true;
>>>> @@ -4442,6 +4476,7 @@ static void spapr_machine_class_init(ObjectCla=
ss *oc, void *data)
>>>>      smc->linux_pci_probe =3D true;
>>>>      smc->smp_threads_vsmt =3D true;
>>>>      smc->nr_xirqs =3D SPAPR_NR_XIRQS;
>>>> +    xfc->match_nvt =3D spapr_xive_match_nvt;
>>>>  }
>>>> =20
>>>>  static const TypeInfo spapr_machine_info =3D {
>>>> @@ -4460,6 +4495,7 @@ static const TypeInfo spapr_machine_info =3D {
>>>>          { TYPE_PPC_VIRTUAL_HYPERVISOR },
>>>>          { TYPE_XICS_FABRIC },
>>>>          { TYPE_INTERRUPT_STATS_PROVIDER },
>>>> +        { TYPE_XIVE_FABRIC },
>>>>          { }
>>>>      },
>>>>  };
>>>
>>
>=20


