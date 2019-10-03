Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88330C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D989218DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D989218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFxef-0004gV-Ie
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 05:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFxdZ-0003sy-G9
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFxdX-0006QN-Rs
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:43:05 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:48862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFxdX-0006P1-ML
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:43:03 -0400
Received: from player694.ha.ovh.net (unknown [10.109.143.210])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 321CB229F42
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 11:42:57 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id 0CBD5A73FB5C;
 Thu,  3 Oct 2019 09:42:53 +0000 (UTC)
Subject: Re: [PATCH v4 03/25] ppc/pnv: Introduce a PNV_CHIP_CPU_FOREACH()
 helper
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-4-clg@kaod.org>
 <20191003015017.GE11105@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <44397f9c-1008-cf40-57ab-d07a98cf70ff@kaod.org>
Date: Thu, 3 Oct 2019 11:42:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003015017.GE11105@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 14024490717683420057
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.43.98
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/2019 03:50, David Gibson wrote:
> On Wed, Sep 18, 2019 at 06:06:23PM +0200, C=E9dric Le Goater wrote:
>> As there is now easy way to loop on the CPUs belonging to a chip, add
>> a helper to filter out external CPUs.
>=20
> This seems a somewhat odd way to go about it, given that the chip does
> have a cores array and the cores then have a threads array.  What's
> the difficulty with using that rather than looping through all vcpus
> and filtering?

because I find some ugliness in using the chip->cores array I guess.=20
See pnv_chip_core_realize(), pnv_chip_quad_realize() etc.

Anyway, I agree this is rather hacky and with Greg's ideas to move=20
the XiveTCTX list under the XiveRouter, we should get rid of it.

C.=20


>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/pnv_xive.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
>> index ae449aa1119b..e1c15b6b5b71 100644
>> --- a/hw/intc/pnv_xive.c
>> +++ b/hw/intc/pnv_xive.c
>> @@ -392,15 +392,36 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, ui=
nt8_t blk, uint32_t idx,
>>      return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
>>  }
>> =20
>> +static int cpu_pir(PowerPCCPU *cpu)
>> +{
>> +    CPUPPCState *env =3D &cpu->env;
>> +    return env->spr_cb[SPR_PIR].default_value;
>> +}
>> +
>> +static int cpu_chip_id(PowerPCCPU *cpu)
>> +{
>> +    int pir =3D cpu_pir(cpu);
>> +    return (pir >> 8) & 0x7f;
>> +}
>> +
>> +#define PNV_CHIP_CPU_FOREACH(chip, cs)                               =
   \
>> +    CPU_FOREACH(cs)                                                  =
   \
>> +        if (chip->chip_id !=3D cpu_chip_id(POWERPC_CPU(cs))) {} else
>> +
>>  static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
>>                                uint8_t nvt_blk, uint32_t nvt_idx,
>>                                bool cam_ignore, uint8_t priority,
>>                                uint32_t logic_serv, XiveTCTXMatch *mat=
ch)
>>  {
>> +    PnvXive *xive =3D PNV_XIVE(xptr);
>>      CPUState *cs;
>>      int count =3D 0;
>> =20
>> -    CPU_FOREACH(cs) {
>> +    /*
>> +     * Loop on all CPUs of the machine and filter out the CPUs
>> +     * belonging to another chip.
>> +     */
>> +    PNV_CHIP_CPU_FOREACH(xive->chip, cs) {
>>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>>          XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
>>          int ring;
>=20


