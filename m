Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FF9C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC712086A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC712086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFyoR-0001lI-C4
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 06:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFynW-0001GM-1i
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFynU-0001pB-A2
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:57:25 -0400
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:36054)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFynU-0001ma-2W
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:57:24 -0400
Received: from player158.ha.ovh.net (unknown [10.109.146.106])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 7CF1A6B617
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 12:57:21 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id ED6C1A6D48B1;
 Thu,  3 Oct 2019 10:57:16 +0000 (UTC)
Subject: Re: [PATCH v4 11/25] ppc/xive: Move the TIMA operations to the
 controller model
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-12-clg@kaod.org>
 <20191003020859.GJ11105@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e98e9ebf-3cd7-2af0-8e58-1db08da5a23d@kaod.org>
Date: Thu, 3 Oct 2019 12:57:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003020859.GJ11105@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 15280995013449124761
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgdefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.173
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

On 03/10/2019 04:08, David Gibson wrote:
> On Wed, Sep 18, 2019 at 06:06:31PM +0200, C=E9dric Le Goater wrote:
>> This also removes the need of the get_tctx() XiveRouter handler in the
>> core XIVE framework.
>=20
> In general these commit messages could really do with more context.
> What exactly is the "controller model"?  Where were the TIMA
> operations before now.  Why is having them in the controller model
> better?
>=20
> I could probably answer those with some investigation, but the point
> is that the commit message is supposed to make it easy to find that
> information.
>=20
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/xive.h |  1 -
>>  hw/intc/pnv_xive.c    | 35 ++++++++++++++++++++++++++++++++++-
>>  hw/intc/spapr_xive.c  | 33 +++++++++++++++++++++++++++++++--
>>  hw/intc/xive.c        | 29 -----------------------------
>>  4 files changed, 65 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 536deea8c622..9d9cd88dd17e 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -462,7 +462,6 @@ typedef struct XiveENDSource {
>>  #define XIVE_TM_OS_PAGE         0x2
>>  #define XIVE_TM_USER_PAGE       0x3
>> =20
>> -extern const MemoryRegionOps xive_tm_ops;
>>  void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr o=
ffset,
>>                          uint64_t value, unsigned size);
>>  uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwadd=
r offset,
>> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
>> index 3d6fcf9ac139..40e18fb44811 100644
>> --- a/hw/intc/pnv_xive.c
>> +++ b/hw/intc/pnv_xive.c
>> @@ -1475,6 +1475,39 @@ static const MemoryRegionOps xive_tm_indirect_o=
ps =3D {
>>      },
>>  };
>> =20
>> +static void pnv_xive_tm_write(void *opaque, hwaddr offset,
>> +                              uint64_t value, unsigned size)
>> +{
>> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
>> +    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
>> +    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
>> +
>> +    xive_tctx_tm_write(XIVE_PRESENTER(xive), tctx, offset, value, siz=
e);
>> +}
>> +
>> +static uint64_t pnv_xive_tm_read(void *opaque, hwaddr offset, unsigne=
d size)
>> +{
>> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
>> +    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
>> +    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
>> +
>> +    return xive_tctx_tm_read(XIVE_PRESENTER(xive), tctx, offset, size=
);
>=20
> You're not using the opaque pointer in either of these cases.  So
> couldn't you make it point to the presenter for pnv as well, then...

On PowerNV, it's the cpu doing the TIMA load/store which determines=20
the chip and the XiveTCTX is deduced from the pnv_cpu_state().

The TIMA is only mapped on chip0 in our model. See CQ_TM1_BAR reg.
=20
>=20
>> +}
>> +
>> +const MemoryRegionOps pnv_xive_tm_ops =3D {
>> +    .read =3D pnv_xive_tm_read,
>> +    .write =3D pnv_xive_tm_write,
>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>> +    .valid =3D {
>> +        .min_access_size =3D 1,
>> +        .max_access_size =3D 8,
>> +    },
>> +    .impl =3D {
>> +        .min_access_size =3D 1,
>> +        .max_access_size =3D 8,
>> +    },
>> +};
>> +
>>  /*
>>   * Interrupt controller XSCOM region.
>>   */
>> @@ -1832,7 +1865,7 @@ static void pnv_xive_realize(DeviceState *dev, E=
rror **errp)
>>                            "xive-pc", PNV9_XIVE_PC_SIZE);
>> =20
>>      /* Thread Interrupt Management Area (Direct) */
>> -    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops,
>> +    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &pnv_xive_tm_=
ops,
>>                            xive, "xive-tima", PNV9_XIVE_TM_SIZE);
>> =20
>>      qemu_register_reset(pnv_xive_reset, dev);
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index eefc0d4c36b9..e00a9bdd901b 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -222,6 +222,35 @@ void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx)
>>      memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &nvt_cam, 4);
>>  }
>> =20
>> +static void spapr_xive_tm_write(void *opaque, hwaddr offset,
>> +                          uint64_t value, unsigned size)
>> +{
>> +    XiveTCTX *tctx =3D spapr_cpu_state(POWERPC_CPU(current_cpu))->tct=
x;
>> +
>> +    xive_tctx_tm_write(XIVE_PRESENTER(opaque), tctx, offset, value,
>> size);
>=20
> ... there would be no difference from the spapr versions, AFAICT.

the XiveTCTX is deduced from the spapr_cpu_state().

C.

>=20
>> +}
>> +
>> +static uint64_t spapr_xive_tm_read(void *opaque, hwaddr offset, unsig=
ned size)
>> +{
>> +    XiveTCTX *tctx =3D spapr_cpu_state(POWERPC_CPU(current_cpu))->tct=
x;
>> +
>> +    return xive_tctx_tm_read(XIVE_PRESENTER(opaque), tctx, offset, si=
ze);
>> +}
>> +
>> +const MemoryRegionOps spapr_xive_tm_ops =3D {
>> +    .read =3D spapr_xive_tm_read,
>> +    .write =3D spapr_xive_tm_write,
>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>> +    .valid =3D {
>> +        .min_access_size =3D 1,
>> +        .max_access_size =3D 8,
>> +    },
>> +    .impl =3D {
>> +        .min_access_size =3D 1,
>> +        .max_access_size =3D 8,
>> +    },
>> +};
>> +
>>  static void spapr_xive_end_reset(XiveEND *end)
>>  {
>>      memset(end, 0, sizeof(*end));
>> @@ -331,8 +360,8 @@ static void spapr_xive_realize(DeviceState *dev, E=
rror **errp)
>>      qemu_register_reset(spapr_xive_reset, dev);
>> =20
>>      /* TIMA initialization */
>> -    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops,=
 xive,
>> -                          "xive.tima", 4ull << TM_SHIFT);
>> +    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &spapr_xive_t=
m_ops,
>> +                          xive, "xive.tima", 4ull << TM_SHIFT);
>>      sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
>> =20
>>      /*
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 9bb09ed6ee7b..11432f04f5c3 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -483,35 +483,6 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, X=
iveTCTX *tctx, hwaddr offset,
>>      return xive_tm_raw_read(tctx, offset, size);
>>  }
>> =20
>> -static void xive_tm_write(void *opaque, hwaddr offset,
>> -                          uint64_t value, unsigned size)
>> -{
>> -    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), curr=
ent_cpu);
>> -
>> -    xive_tctx_tm_write(XIVE_PRESENTER(opaque), tctx, offset, value, s=
ize);
>> -}
>> -
>> -static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned si=
ze)
>> -{
>> -    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), curr=
ent_cpu);
>> -
>> -    return xive_tctx_tm_read(XIVE_PRESENTER(opaque), tctx, offset, si=
ze);
>> -}
>> -
>> -const MemoryRegionOps xive_tm_ops =3D {
>> -    .read =3D xive_tm_read,
>> -    .write =3D xive_tm_write,
>> -    .endianness =3D DEVICE_BIG_ENDIAN,
>> -    .valid =3D {
>> -        .min_access_size =3D 1,
>> -        .max_access_size =3D 8,
>> -    },
>> -    .impl =3D {
>> -        .min_access_size =3D 1,
>> -        .max_access_size =3D 8,
>> -    },
>> -};
>> -
>>  static char *xive_tctx_ring_print(uint8_t *ring)
>>  {
>>      uint32_t w2 =3D xive_tctx_word2(ring);
>=20


