Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B83C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 21:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44DF62075E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 21:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DF62075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXXj8-0005Z8-Df
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 16:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXXiM-00056U-F8
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXXiL-0003M3-8K
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:40:42 -0500
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:59303)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXXiL-0003KG-1d
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:40:41 -0500
Received: from player738.ha.ovh.net (unknown [10.109.160.40])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 7DFFF212EBA
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 22:40:38 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 2AB2CC789653;
 Wed, 20 Nov 2019 21:40:33 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v5 11/23] ppc/pnv: Introduce a
 pnv_xive_is_cpu_enabled() helper
To: Greg Kurz <groug@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-12-clg@kaod.org> <20191120182612.3069e279@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4549a66b-5db6-5a71-87a2-3c126fa4db6b@kaod.org>
Date: Wed, 20 Nov 2019 22:40:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120182612.3069e279@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 12886205910415084371
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehtddgudehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.36.253
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

On 20/11/2019 18:26, Greg Kurz wrote:
> On Fri, 15 Nov 2019 17:24:24 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> and use this helper to exclude CPUs which are not enabled in the XIVE
>> controller.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/pnv_xive.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
>> index 71ca4961b6b1..4c8c6e51c20f 100644
>> --- a/hw/intc/pnv_xive.c
>> +++ b/hw/intc/pnv_xive.c
>> @@ -372,6 +372,20 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uin=
t8_t blk, uint32_t idx,
>>      return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
>>  }
>> =20
>> +static int cpu_pir(PowerPCCPU *cpu)
>> +{
>> +    CPUPPCState *env =3D &cpu->env;
>> +    return env->spr_cb[SPR_PIR].default_value;
>> +}
>> +
>> +static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
>> +{
>> +    int pir =3D cpu_pir(cpu);
>> +    int thrd_id =3D pir & 0x7f;
>> +
>> +    return xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(thrd_id);
>=20
> A similar check is open-coded in pnv_xive_get_indirect_tctx() :
>=20
>     /* Check that HW thread is XIVE enabled */
>     if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) {
>         xive_error(xive, "IC: CPU %x is not enabled", pir);
>     }
>=20
> The thread id is only the 6 lower bits of the PIR there, and so seems t=
o
> indicate the skiboot sources:
>=20
>         /* Get bit in register */
>         bit =3D c->pir & 0x3f;

skiboot uses 0x3f when enabling the TCTXT of a CPU because register
INT_TCTXT_EN0 covers cores 0-15 (normal) and 0-7 (fused) and=20
register INT_TCTXT_EN1 covers cores 16-23 (normal) and 8-11 (fused).=20
The encoding in the registers is a bit different.

> Why make it pir & 0x7f here ?=20

See pnv_chip_core_pir_p9 comments for some details on the CPU ID=20
layout.

> If it should actually be 0x3f,=20
but yes, we should fix the mask in the register setting.=20

> maybe also use the helper in pnv_xive_get_indirect_tctx().

This is getting changed later on. So I rather not.

C.

>=20
>> +}
>> +
>>  static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
>>                                uint8_t nvt_blk, uint32_t nvt_idx,
>>                                bool cam_ignore, uint8_t priority,
>> @@ -393,6 +407,10 @@ static int pnv_xive_match_nvt(XivePresenter *xptr=
, uint8_t format,
>>              XiveTCTX *tctx;
>>              int ring;
>> =20
>> +            if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
>> +                continue;
>> +            }
>> +
>>              tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
>> =20
>>              /*
>=20


