Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E73C32754
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 08:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292EE217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 08:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292EE217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47657 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hve69-0007gg-GD
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 04:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41481)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hve4Q-0005XQ-7m
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hve4O-0001rW-Nj
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:46:50 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:40415)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hve4O-0001pJ-Go
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:46:48 -0400
Received: from player729.ha.ovh.net (unknown [10.109.146.5])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 6BFFC60D0D
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2019 10:46:44 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player729.ha.ovh.net (Postfix) with ESMTPSA id 309F88DC7A87;
 Thu,  8 Aug 2019 08:46:35 +0000 (UTC)
To: Balamuruhan S <bala24@linux.ibm.com>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-5-bala24@linux.ibm.com>
 <555de06b-a959-76ce-ee89-05c4b7cab25a@kaod.org>
 <20190807101214.GB10532@dhcp-9-109-247-185.in.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4eab0dcc-ca11-b5cf-491c-0efd122aa649@kaod.org>
Date: Thu, 8 Aug 2019 10:46:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807101214.GB10532@dhcp-9-109-247-185.in.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 16245609758072998720
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudduhedgtdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.52.203
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] hw/ppc/pnv: initialize and realize
 homer/occ common area
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
Cc: hari@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 maddy@linux.vnet.ibm.com, pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/2019 12:12, Balamuruhan S wrote:
> On Wed, Aug 07, 2019 at 09:59:26AM +0200, C=C3=A9dric Le Goater wrote:
>> On 07/08/2019 09:14, Balamuruhan S wrote:
>>> homer and occ common area region base address are initialized
>>> to create device tree and realized to map the address with
>>> mmio callbacks during `pnv_chip_realize()`.
>>>
>>> `SysBusNum` enum is introduced to set sysbus for XSCOM, ICP,
>>> HOMER and OCC appropriately and chip_num to initialize and
>>> retrieve base address + size contiguously on a PowerNV with
>>> multichip boot.
>>
>> Can't you use the chip_id ?=20
>=20
> if the chip_id is contiguous always we can use it. I was not
> sure about it.

When I introduced PNV_CHIP_HWID(), I made it follow the 2S tuletas
numbers, which are DCMs. So you get 0x0, 0x1, 0x10, 0x11.=20

PNV_CHIP_INDEX() is to be used for MMIO addresses. We can fix that=20
if there is a problem.=20

C.

>>
>>>
>>> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
>>> ---
>>>  hw/ppc/pnv.c         | 49 ++++++++++++++++++++++++++++++++++++++++++=
+++----
>>>  include/hw/ppc/pnv.h |  1 +
>>>  2 files changed, 46 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>> index bd4531c822..f6e56e915d 100644
>>> --- a/hw/ppc/pnv.c
>>> +++ b/hw/ppc/pnv.c
>>> @@ -675,6 +675,7 @@ static void pnv_init(MachineState *machine)
>>>          Object *chip =3D object_new(chip_typename);
>>> =20
>>>          pnv->chips[i] =3D PNV_CHIP(chip);
>>> +        PNV_CHIP(chip)->chip_num =3D i;
>>>
>>>          /* TODO: put all the memory in one node on chip 0 until we f=
ind a
>>>           * way to specify different ranges for each chip
>>> @@ -824,18 +825,20 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip=
8, Error **errp)
>>>   {
>>>      PnvChip *chip =3D PNV_CHIP(chip8);
>>>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
>>> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(chip);
>>>      const char *typename =3D pnv_chip_core_typename(chip);
>>>      size_t typesize =3D object_type_get_instance_size(typename);
>>>      int i, j;
>>>      char *name;
>>>      XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
>>> =20
>>> +    sbd->num_mmio =3D PNV_ICP_SYSBUS;
>>
>> OK. I think I know why you want this but it probably means that you ne=
ed=20
>> a new PnvHomer model and that you should use PnvOCC instead.=20
>=20
> okay, I will have to work on it.
>=20
>>
>>>      name =3D g_strdup_printf("icp-%x", chip->chip_id);
>>>      memory_region_init(&chip8->icp_mmio, OBJECT(chip), name, PNV_ICP=
_SIZE);
>>> -    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip8->icp_mmio);
>>> +    sysbus_init_mmio(sbd, &chip8->icp_mmio);
>>>      g_free(name);
>>> =20
>>> -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
>>> +    sysbus_mmio_map(sbd, PNV_ICP_SYSBUS, PNV_ICP_BASE(chip));
>>> =20
>>>      /* Map the ICP registers for each thread */
>>>      for (i =3D 0; i < chip->nr_cores; i++) {
>>> @@ -866,7 +869,26 @@ static void pnv_chip_power8_realize(DeviceState =
*dev, Error **errp)
>>>          error_propagate(errp, local_err);
>>>          return;
>>>      }
>>> -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_XSCOM_SYSBUS,
>>> +                                   PNV_XSCOM_BASE(chip));
>>> +
>>> +    /* homer */
>>> +    pnv_homer_realize(chip, &local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        return;
>>> +    }
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_HOMER_SYSBUS,
>>> +                    PNV_HOMER_BASE(chip));
>>> +    /* occ common area */
>>> +    pnv_occ_common_area_realize(chip, &local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        return;
>>> +    }
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_OCC_COMMON_AREA_SYSBUS=
,
>>> +                    PNV_OCC_COMMON_AREA(chip));
>>> =20
>>>      pcc->parent_realize(dev, &local_err);
>>>      if (local_err) {
>>> @@ -1035,7 +1057,26 @@ static void pnv_chip_power9_realize(DeviceStat=
e *dev, Error **errp)
>>>          error_propagate(errp, local_err);
>>>          return;
>>>      }
>>> -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV9_XSCOM_BASE(chip));
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_XSCOM_SYSBUS,
>>> +                    PNV9_XSCOM_BASE(chip));
>>> +
>>> +    /* homer */
>>> +    pnv_homer_realize(chip, &local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        return;
>>> +    }
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_HOMER_SYSBUS,
>>> +                    PNV9_HOMER_BASE(chip));
>>> +
>>> +    /* occ common area */
>>> +    pnv_occ_common_area_realize(chip, &local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        return;
>>> +    }
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_OCC_COMMON_AREA_SYSBUS=
,
>>> +                    PNV9_OCC_COMMON_AREA(chip));
>>> =20
>>>      pcc->parent_realize(dev, &local_err);
>>>      if (local_err) {
>>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>>> index 6464e32892..dea6772988 100644
>>> --- a/include/hw/ppc/pnv.h
>>> +++ b/include/hw/ppc/pnv.h
>>> @@ -57,6 +57,7 @@ typedef struct PnvChip {
>>> =20
>>>      /*< public >*/
>>>      uint32_t     chip_id;
>>> +    uint32_t     chip_num;
>>>      uint64_t     ram_start;
>>>      uint64_t     ram_size;
>>> =20
>>>
>>
>=20


