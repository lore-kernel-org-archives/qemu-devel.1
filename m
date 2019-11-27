Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4900CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 06:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1315420665
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 06:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1315420665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZrHd-00079v-8j
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 01:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iZrGj-0006i2-Oj
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 01:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iZrGh-00053P-LI
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 01:57:45 -0500
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:33520)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iZrGe-00050j-7I
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 01:57:41 -0500
Received: from player694.ha.ovh.net (unknown [10.109.143.24])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 85188114E41
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 07:57:37 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id C3EFFC83E478;
 Wed, 27 Nov 2019 06:57:32 +0000 (UTC)
Subject: Re: [PATCH v6 13/20] ppc/pnv: Clarify how the TIMA is accessed on a
 multichip system
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191125065820.927-1-clg@kaod.org>
 <20191125065820.927-14-clg@kaod.org> <20191127052353.GR5582@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <49a23d16-596f-9345-f734-b06443704dfa@kaod.org>
Date: Wed, 27 Nov 2019 07:57:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191127052353.GR5582@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 2189030895509539648
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeigedguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeehnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.72.238
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/11/2019 06:23, David Gibson wrote:
> On Mon, Nov 25, 2019 at 07:58:13AM +0100, C=E9dric Le Goater wrote:
>> The TIMA region gives access to the thread interrupt context registers
>> of a CPU. It is mapped at the same address on all chips and can be
>> accessed by any CPU of the system. To identify the chip from which the
>> access is being done, the PowerBUS uses a 'chip' field in the
>> load/store messages. QEMU does not model these messages, instead, we
>> extract the chip id from the CPU PIR and do a lookup at the machine
>> level to fetch the targeted interrupt controller.
>>
>> Introduce pnv_get_chip() and pnv_xive_tm_get_xive() helpers to clarify
>> this process in pnv_xive_get_tctx(). The latter will be removed in the
>> subsequent patches but the same principle will be kept.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/pnv.h |  3 +++
>>  hw/intc/pnv_xive.c   | 40 +++++++++++++++++++++++-----------------
>>  hw/ppc/pnv.c         | 14 ++++++++++++++
>>  3 files changed, 40 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index a58cfea3f2fd..3a7bc3c57e0d 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -103,6 +103,7 @@ typedef struct Pnv9Chip {
>>   * A SMT8 fused core is a pair of SMT4 cores.
>>   */
>>  #define PNV9_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
>> +#define PNV9_PIR2CHIP(pir)      (((pir) >> 8) & 0x7f)
>> =20
>>  typedef struct PnvChipClass {
>>      /*< private >*/
>> @@ -197,6 +198,8 @@ static inline bool pnv_is_power9(PnvMachineState *=
pnv)
>>      return pnv_chip_is_power9(pnv->chips[0]);
>>  }
>> =20
>> +PnvChip *pnv_get_chip(uint32_t chip_id);
>> +
>>  #define PNV_FDT_ADDR          0x01000000
>>  #define PNV_TIMEBASE_FREQ     512000000ULL
>> =20
>> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
>> index 95e9de312cd9..db9d9c11a8f4 100644
>> --- a/hw/intc/pnv_xive.c
>> +++ b/hw/intc/pnv_xive.c
>> @@ -439,31 +439,37 @@ static int pnv_xive_match_nvt(XivePresenter *xpt=
r, uint8_t format,
>>      return count;
>>  }
>> =20
>> +/*
>> + * The TIMA MMIO space is shared among the chips and to identify the
>> + * chip from which the access is being done, we extract the chip id
>> + * from the PIR.
>> + */
>> +static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
>> +{
>> +    int pir =3D ppc_cpu_pir(cpu);
>> +    PnvChip *chip;
>> +    PnvXive *xive;
>> +
>> +    chip =3D pnv_get_chip(PNV9_PIR2CHIP(pir));
>> +    assert(chip);
>> +    xive =3D &PNV9_CHIP(chip)->xive;
>> +
>> +    if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
>> +        xive_error(xive, "IC: CPU %x is not enabled", pir);
>> +    }
>> +    return xive;
>> +}
>> +
>>  static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
>>  {
>>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> -    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
>> -    PnvXive *xive =3D NULL;
>> -    CPUPPCState *env =3D &cpu->env;
>> -    int pir =3D env->spr_cb[SPR_PIR].default_value;
>> +    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
>> =20
>> -    /*
>> -     * Perform an extra check on the HW thread enablement.
>> -     *
>> -     * The TIMA is shared among the chips and to identify the chip
>> -     * from which the access is being done, we extract the chip id
>> -     * from the PIR.
>> -     */
>> -    xive =3D pnv_xive_get_ic((pir >> 8) & 0xf);
>>      if (!xive) {
>>          return NULL;
>>      }
>> =20
>> -    if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) =
{
>=20
> I'm not seeing any code which will replace this check on the thread
> enabled register.  Is that really what you intend?

it is calling pnv_xive_tm_get_xive() which calls pnv_xive_is_cpu_enabled(=
)
which does the same check in better.

C.=20


>=20
>> -        xive_error(PNV_XIVE(xrtr), "IC: CPU %x is not enabled", pir);
>> -    }
>> -
>> -    return tctx;
>> +    return XIVE_TCTX(pnv_cpu_state(cpu)->intc);
>>  }
>> =20
>>  /*
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 5b8b07f6aedc..fa656858b24a 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -1472,6 +1472,20 @@ static int pnv_match_nvt(XiveFabric *xfb, uint8=
_t format,
>>      return total_count;
>>  }
>> =20
>> +PnvChip *pnv_get_chip(uint32_t chip_id)
>> +{
>> +    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
>> +    int i;
>> +
>> +    for (i =3D 0; i < pnv->num_chips; i++) {
>> +        PnvChip *chip =3D pnv->chips[i];
>> +        if (chip->chip_id =3D=3D chip_id) {
>> +            return chip;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>>  static void pnv_get_num_chips(Object *obj, Visitor *v, const char *na=
me,
>>                                void *opaque, Error **errp)
>>  {
>=20


