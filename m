Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139A6C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 08:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE25B21783
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 08:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE25B21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFwX0-000654-Vx
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 04:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFwVI-0005Gb-OS
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 04:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFwVF-0008Iv-11
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 04:30:27 -0400
Received: from 7.mo1.mail-out.ovh.net ([87.98.158.110]:36170)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFwVD-0008Gh-Pq
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 04:30:24 -0400
Received: from player728.ha.ovh.net (unknown [10.108.54.13])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 17E841913D0
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 10:30:19 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id C383FA705E0E;
 Thu,  3 Oct 2019 08:30:14 +0000 (UTC)
Subject: Re: [PATCH v4 24/25] ppc/pnv: Improve trigger data definition
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-25-clg@kaod.org>
 <20191003024156.GQ11105@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <12153fc5-714a-a5dd-4c58-d416d1a2bce5@kaod.org>
Date: Thu, 3 Oct 2019 10:30:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003024156.GQ11105@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 12797822768433040281
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.158.110
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

On 03/10/2019 04:41, David Gibson wrote:
> On Wed, Sep 18, 2019 at 06:06:44PM +0200, C=C3=A9dric Le Goater wrote:
>> The trigger definition is used for triggers both for HW source
>> interrupts, PHB, PSI, as well as for rerouting interrupts between
>> Interrupt Controller.
>>
>> HW source controllers set bit0 of word0 to =E2=80=980=E2=80=99 as they=
 provide EAS
>> information (EAS block + EAS index) in the 8 byte data and not END
>> information, and bit1 of word0 to =E2=80=981=E2=80=99 to signal that t=
he state bit
>> check has been performed.
>>
>> Introduce these new trigger bits and rename the XIVE_SRCNO macros in
>> XIVE_EAS to reflect better the nature of the data. This is breaking
>> the notification for the PSI model which will be fixed in the next
>> patch.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/xive_regs.h | 24 +++++++++++++++++++++---
>>  hw/intc/pnv_xive.c         | 16 ++++++++++++----
>>  hw/intc/xive.c             |  4 ++--
>>  3 files changed, 35 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
>> index dd42c33cef35..83a2f2cc1318 100644
>> --- a/include/hw/ppc/xive_regs.h
>> +++ b/include/hw/ppc/xive_regs.h
>> @@ -22,9 +22,27 @@
>>  /*
>>   * Interrupt source number encoding on PowerBUS
>>   */
>> -#define XIVE_SRCNO_BLOCK(srcno) (((srcno) >> 28) & 0xf)
>> -#define XIVE_SRCNO_INDEX(srcno) ((srcno) & 0x0fffffff)
>> -#define XIVE_SRCNO(blk, idx)    ((uint32_t)(blk) << 28 | (idx))
>> +/*
>> + * Trigger data definition
>> + *
>> + * The trigger definition is used for triggers both for HW source
>> + * interrupts (PHB, PSI), as well as for rerouting interrupts between
>> + * Interrupt Controller.
>> + *
>> + * HW source controllers set bit0 of word0 to =E2=80=980=E2=80=99 as =
they provide EAS
>> + * information (EAS block + EAS index) in the 8 byte data and not END
>> + * information, and bit1 of word0 to =E2=80=981=E2=80=99 to signal th=
at the state bit
>> + * check has been performed.
>> + */
>> +#define XIVE_TRIGGER_END        PPC_BIT(0)
>> +#define XIVE_TRIGGER_EAS        PPC_BIT(1)
>=20
> These names seem really confusing in light of the comment above.  HW
> source controllers set the XIVE_TRIGGER_END bit in order to indicate
> that they're providing EAS info, not END info??=20

The END bit defines an END trigger, which is a forward trigger between=20
ICs. In that case, the remote IC needs to do a lookup of an END and it=20
needs an EAS containing an END index.

An END trigger, bit0 of word0 set to '1', is defined as :

         01234567 01234567 01234567 01234567=20

W0 E=3D1   1P--BLOC          END IDX       =20
W1 E=3D1   M             END DATA        =20
   =20
An EAS is defined as :

         01234567 01234567 01234567 01234567=20
W0       V---BLOC          END IDX
W1       M             END DATA             =20

Same layout as you can see. There is an extra 'PQ' bit, bit1 of word0=20
set to '1', signaling that the PQ bits have been checked. But that bit=20
is unused in the initial EAS definition.

> And also set the XIVE_TRIGGER_EAS bit to indicate something different?

That's where the confusion comes from.=20

I have called it 'EAS' because the trigger data in that case contains=20
an EAS index which the IC needs to look for. This is the format the HW=20
devices use to perform the trigger.   =20

An EAS trigger, bit0 of word0 set to '0', is defined as :

         01234567 01234567 01234567 01234567=20
W0 E=3D0   0P------ -------- -------- --------                           =
  =20
W1 E=3D0   BLOC          EAS INDEX           =20


There is also a 'PQ' bit, bit1 of word0 to '1', signaling that the=20
PQ bits have been checked.=20


> Also, the comment implies that HW source controllers set both bits,
> but I'm not really sure if that's what you meant. =20

END trigger starts with 0b11 (IC <-> IC)
EAS trigger starts with 0b01 (HW -> IC)

> Expanding on what non-HW source controllers might set could be helpful
> too ..

what do you mean ? this is all HW ! guests ?=20

C.=20


>=20
>> +
>> +/*
>> + * QEMU macros to manipulate the trigger payload in native endian
>> + */
>> +#define XIVE_EAS_BLOCK(n)       (((n) >> 28) & 0xf)
>> +#define XIVE_EAS_INDEX(n)       ((n) & 0x0fffffff)
>> +#define XIVE_EAS(blk, idx)      ((uint32_t)(blk) << 28 | (idx))
>> =20
>>  #define TM_SHIFT                16
>> =20
>> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
>> index 4c1fa024cdf5..61af3f23000f 100644
>> --- a/hw/intc/pnv_xive.c
>> +++ b/hw/intc/pnv_xive.c
>> @@ -385,7 +385,7 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint=
8_t blk, uint32_t idx,
>>       * EAT lookups should be local to the IC
>>       */
>>      if (pnv_xive_block_id(xive) !=3D blk) {
>> -        xive_error(xive, "VST: EAS %x is remote !?", XIVE_SRCNO(blk, =
idx));
>> +        xive_error(xive, "VST: EAS %x is remote !?", XIVE_EAS(blk, id=
x));
>>          return -1;
>>      }
>> =20
>> @@ -502,7 +502,7 @@ static void pnv_xive_notify(XiveNotifier *xn, uint=
32_t srcno)
>>      PnvXive *xive =3D PNV_XIVE(xn);
>>      uint8_t blk =3D pnv_xive_block_id(xive);
>> =20
>> -    xive_router_notify(xn, XIVE_SRCNO(blk, srcno));
>> +    xive_router_notify(xn, XIVE_EAS(blk, srcno));
>>  }
>> =20
>>  /*
>> @@ -1287,12 +1287,20 @@ static const MemoryRegionOps pnv_xive_ic_reg_o=
ps =3D {
>> =20
>>  static void pnv_xive_ic_hw_trigger(PnvXive *xive, hwaddr addr, uint64=
_t val)
>>  {
>> +    uint8_t blk =3D XIVE_EAS_BLOCK(val);
>> +    uint32_t idx =3D XIVE_EAS_INDEX(val);
>> +
>>      /*
>>       * Forward the source event notification directly to the Router.
>>       * The source interrupt number should already be correctly encode=
d
>>       * with the chip block id by the sending device (PHB, PSI).
>>       */
>> -    xive_router_notify(XIVE_NOTIFIER(xive), val);
>> +    if (val & XIVE_TRIGGER_EAS) {
>> +        xive_router_notify(XIVE_NOTIFIER(xive), XIVE_EAS(blk, idx));
>> +    } else {
>> +        xive_error(xive, "IC: END trigger at @0x%"HWADDR_PRIx" data 0=
x%"PRIx64,
>> +                   addr, val);
>> +    }
>>  }
>> =20
>>  static void pnv_xive_ic_notify_write(void *opaque, hwaddr addr, uint6=
4_t val,
>> @@ -1683,7 +1691,7 @@ void pnv_xive_pic_print_info(PnvXive *xive, Moni=
tor *mon)
>>      XiveRouter *xrtr =3D XIVE_ROUTER(xive);
>>      uint8_t blk =3D pnv_xive_block_id(xive);
>>      uint8_t chip_id =3D xive->chip->chip_id;
>> -    uint32_t srcno0 =3D XIVE_SRCNO(blk, 0);
>> +    uint32_t srcno0 =3D XIVE_EAS(blk, 0);
>>      uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive, blk);
>>      XiveEAS eas;
>>      XiveEND end;
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 07b7c3586c12..6702f32be601 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -1652,8 +1652,8 @@ do_escalation:
>>  void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
>>  {
>>      XiveRouter *xrtr =3D XIVE_ROUTER(xn);
>> -    uint8_t eas_blk =3D XIVE_SRCNO_BLOCK(lisn);
>> -    uint32_t eas_idx =3D XIVE_SRCNO_INDEX(lisn);
>> +    uint8_t eas_blk =3D XIVE_EAS_BLOCK(lisn);
>> +    uint32_t eas_idx =3D XIVE_EAS_INDEX(lisn);
>>      XiveEAS eas;
>> =20
>>      /* EAS cache lookup */
>=20


