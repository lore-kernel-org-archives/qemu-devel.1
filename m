Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E647EC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7690D2071C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7690D2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXiaj-00051p-Ba
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 04:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXiZk-0004FW-1U
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXiZi-0003Nb-QA
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:16:31 -0500
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:47826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXiZi-0003Ll-IR
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:16:30 -0500
Received: from player688.ha.ovh.net (unknown [10.109.146.163])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id A804D82C2F
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 10:16:20 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id EFD33C49027D;
 Thu, 21 Nov 2019 09:16:15 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v5 11/23] ppc/pnv: Introduce a
 pnv_xive_is_cpu_enabled() helper
To: Greg Kurz <groug@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-12-clg@kaod.org> <20191120182612.3069e279@bahia.lan>
 <4549a66b-5db6-5a71-87a2-3c126fa4db6b@kaod.org>
 <20191121085856.0344fac5@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <639848d3-8621-13e4-6e4b-1716b9c54372@kaod.org>
Date: Thu, 21 Nov 2019 10:16:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121085856.0344fac5@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6189071789202246483
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehvddgtdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.53
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

On 21/11/2019 08:58, Greg Kurz wrote:
> On Wed, 20 Nov 2019 22:40:31 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 20/11/2019 18:26, Greg Kurz wrote:
>>> On Fri, 15 Nov 2019 17:24:24 +0100
>>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>>
>>>> and use this helper to exclude CPUs which are not enabled in the XIV=
E
>>>> controller.
>>>>
>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  hw/intc/pnv_xive.c | 18 ++++++++++++++++++
>>>>  1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
>>>> index 71ca4961b6b1..4c8c6e51c20f 100644
>>>> --- a/hw/intc/pnv_xive.c
>>>> +++ b/hw/intc/pnv_xive.c
>>>> @@ -372,6 +372,20 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, u=
int8_t blk, uint32_t idx,
>>>>      return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
>>>>  }
>>>> =20
>>>> +static int cpu_pir(PowerPCCPU *cpu)
>>>> +{
>>>> +    CPUPPCState *env =3D &cpu->env;
>>>> +    return env->spr_cb[SPR_PIR].default_value;
>>>> +}
>>>> +
>>>> +static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
>>>> +{
>>>> +    int pir =3D cpu_pir(cpu);
>>>> +    int thrd_id =3D pir & 0x7f;
>>>> +
>>>> +    return xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(thrd_id);
>>>
>>> A similar check is open-coded in pnv_xive_get_indirect_tctx() :
>>>
>>>     /* Check that HW thread is XIVE enabled */
>>>     if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) =
{
>>>         xive_error(xive, "IC: CPU %x is not enabled", pir);
>>>     }
>>>
>>> The thread id is only the 6 lower bits of the PIR there, and so seems=
 to
>>> indicate the skiboot sources:
>>>
>>>         /* Get bit in register */
>>>         bit =3D c->pir & 0x3f;
>>
>> skiboot uses 0x3f when enabling the TCTXT of a CPU because register
>> INT_TCTXT_EN0 covers cores 0-15 (normal) and 0-7 (fused) and=20
>> register INT_TCTXT_EN1 covers cores 16-23 (normal) and 8-11 (fused).=20
>> The encoding in the registers is a bit different.
>>
>>> Why make it pir & 0x7f here ?=20
>>
>> See pnv_chip_core_pir_p9 comments for some details on the CPU ID=20
>> layout.
>>
>=20
> *   57:61  Core number
> *   62:63  Thread ID
>=20
> Ok, so the CPU ID within the socket is 7 bits, ie. pir & 0x7f
>=20
>>> If it should actually be 0x3f,=20
>> but yes, we should fix the mask in the register setting.=20
>>
>>> maybe also use the helper in pnv_xive_get_indirect_tctx().
>>
>> This is getting changed later on. So I rather not.
>>
>=20
> I don't see any later change there, neither in this series,=20

Patch "ppc/pnv: Clarify how the TIMA is accessed on a multichip system"

changes a few things in that area.

> nor in your powernv-4.2 on github, but nevermind, this patch is
> good enough for the purpose of CAM line matching.

Yes. It could be better though and it's a localized change.=20

the INT_TCTXT_EN0 (PC_THREAD_EN_REG0) needs a small fix on the mask.=20
We don't use the EN1 register also for cores > 15.=20

It works today because we don't start the machine with all the=20
possible cores. Although it should be possible to start a QEMU=20
PowerNV machine with 24 cores on each socket.=20


I would like to have stricter checks on CAM line accesses because
it is an OS interface. The INT_TCTXT_EN0 (PC_THREAD_EN_REG0) is=20
the first level (HW) but we need to check also the 'V' bit of=20
each ring. That's more complex. For later.


C.=20


> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
>> C.
>>
>>>
>>>> +}
>>>> +
>>>>  static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
>>>>                                uint8_t nvt_blk, uint32_t nvt_idx,
>>>>                                bool cam_ignore, uint8_t priority,
>>>> @@ -393,6 +407,10 @@ static int pnv_xive_match_nvt(XivePresenter *xp=
tr, uint8_t format,
>>>>              XiveTCTX *tctx;
>>>>              int ring;
>>>> =20
>>>> +            if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
>>>> +                continue;
>>>> +            }
>>>> +
>>>>              tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
>>>> =20
>>>>              /*
>>>
>>
>=20


