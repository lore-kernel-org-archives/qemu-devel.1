Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3200CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DF02071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DF02071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdB5V-0005qd-7a
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jdB4N-0004MO-Ho
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:15:01 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:42802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jdB4L-0007eM-EH
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:14:59 -0400
Received: from player763.ha.ovh.net (unknown [10.108.35.232])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id A1A88134B72
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 13:14:54 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player763.ha.ovh.net (Postfix) with ESMTPSA id CC2BE12A9FA84;
 Mon, 25 May 2020 11:14:50 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006d2b08bf1-2e5f-4cea-8d9a-5279a18f49c3,26835B9205782E90874D777227A1F0DDBFD0E061)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 6/9] ppc/pnv: Add a OCC model for POWER10
To: Greg Kurz <groug@kaod.org>
References: <20200513151109.453530-1-clg@kaod.org>
 <20200513151109.453530-7-clg@kaod.org> <20200520162229.7f66f78d@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bc639bd2-7f39-3d4f-8d0a-2d23e8ce9110@kaod.org>
Date: Mon, 25 May 2020 13:14:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520162229.7f66f78d@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12154652446664592192
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddvtddgfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejieefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.51.249; envelope-from=clg@kaod.org;
 helo=6.mo177.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 07:14:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

On 5/20/20 4:22 PM, Greg Kurz wrote:
> On Wed, 13 May 2020 17:11:06 +0200
> Cédric Le Goater <clg@kaod.org> wrote:
> 
>> Needs some more refinements but this model does not do much anyhow.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/pnv.h       |  1 +
>>  include/hw/ppc/pnv_occ.h   |  2 ++
>>  include/hw/ppc/pnv_xscom.h |  3 +++
>>  hw/ppc/pnv.c               | 14 ++++++++++++++
>>  hw/ppc/pnv_occ.c           | 17 +++++++++++++++++
>>  5 files changed, 37 insertions(+)
>>
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index f318bb10add4..3ff610a9c7b5 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -122,6 +122,7 @@ typedef struct Pnv10Chip {
>>      PnvXive2     xive;
>>      Pnv9Psi      psi;
>>      PnvLpcController lpc;
>> +    PnvOCC       occ;
>>  } Pnv10Chip;
>>  
>>  #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
>> diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
>> index f8d3061419dc..57cb437c9ca1 100644
>> --- a/include/hw/ppc/pnv_occ.h
>> +++ b/include/hw/ppc/pnv_occ.h
>> @@ -28,6 +28,8 @@
>>  #define PNV8_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV8_OCC)
>>  #define TYPE_PNV9_OCC TYPE_PNV_OCC "-POWER9"
>>  #define PNV9_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV9_OCC)
>> +#define TYPE_PNV10_OCC TYPE_PNV_OCC "-POWER10"
>> +#define PNV10_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV10_OCC)
>>  
>>  #define PNV_OCC_SENSOR_DATA_BLOCK_OFFSET 0x00580000
>>  #define PNV_OCC_SENSOR_DATA_BLOCK_SIZE   0x00025800
>> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
>> index 1211add3e79c..f26c5217764d 100644
>> --- a/include/hw/ppc/pnv_xscom.h
>> +++ b/include/hw/ppc/pnv_xscom.h
>> @@ -133,6 +133,9 @@ typedef struct PnvXScomInterfaceClass {
>>  #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
>>  #define PNV10_XSCOM_PSIHB_SIZE     0x100
>>  
>> +#define PNV10_XSCOM_OCC_BASE       PNV_XSCOM_OCC_BASE
>> +#define PNV10_XSCOM_OCC_SIZE       0x8000
>> +
> 
> I don't understand why you explicitly reuse the P8/P9 definition
> for the base address and you open-code the size which is the
> same as P9... 

I will clean that up. 

>>  #define PNV10_XSCOM_XIVE2_BASE     0x2010800
>>  #define PNV10_XSCOM_XIVE2_SIZE     0x400
>>  
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 73c40ce3209f..9f1698a74467 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -1617,6 +1617,8 @@ static void pnv_chip_power10_instance_init(Object *obj)
>>                              TYPE_PNV10_PSI, &error_abort, NULL);
>>      object_initialize_child(obj, "lpc",  &chip10->lpc, sizeof(chip10->lpc),
>>                              TYPE_PNV10_LPC, &error_abort, NULL);
>> +    object_initialize_child(obj, "occ",  &chip10->occ, sizeof(chip10->occ),
>> +                            TYPE_PNV10_OCC, &error_abort, NULL);
>>  }
>>  
>>  static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>> @@ -1690,6 +1692,18 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>>  
>>      chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
>>                                              (uint64_t) PNV10_LPCM_BASE(chip));
>> +
>> +    /* Create the simplified OCC model */
>> +    object_property_set_link(OBJECT(&chip10->occ), OBJECT(&chip10->psi), "psi",
>> +                             &error_abort);
>> +    object_property_set_bool(OBJECT(&chip10->occ), true, "realized",
>> +                             &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_OCC_BASE,
>> +                            &chip10->occ.xscom_regs);
>>  }
>>  
>>  static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
>> diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
>> index 5a716c256edc..7a2aea8fb9d1 100644
>> --- a/hw/ppc/pnv_occ.c
>> +++ b/hw/ppc/pnv_occ.c
>> @@ -249,6 +249,22 @@ static const TypeInfo pnv_occ_power9_type_info = {
>>      .class_init    = pnv_occ_power9_class_init,
>>  };
>>  
>> +static void pnv_occ_power10_class_init(ObjectClass *klass, void *data)
>> +{
>> +    PnvOCCClass *poc = PNV_OCC_CLASS(klass);
>> +
>> +    poc->xscom_size = PNV9_XSCOM_OCC_SIZE;
> 
> Shouldn't it be PNV10_XSCOM_OCC_SIZE since you define it in
> include/hw/ppc/pnv_xscom.h above ?
> 
>> +    poc->xscom_ops = &pnv_occ_power9_xscom_ops;
>> +    poc->psi_irq = PSIHB9_IRQ_OCC;
> 
> Using P9 bits in P10 code might be a little confusing for the
> casual reader. 

The HW interface has not changed between P9 and P10. That's all.

C. 

> A comment could be helpful until you come up
> with the refinements mentioned in the changelog.
>> +}
>> +
>> +static const TypeInfo pnv_occ_power10_type_info = {
>> +    .name          = TYPE_PNV10_OCC,
>> +    .parent        = TYPE_PNV_OCC,
>> +    .instance_size = sizeof(PnvOCC),
>> +    .class_init    = pnv_occ_power10_class_init,
>> +};
>> +
>>  static void pnv_occ_realize(DeviceState *dev, Error **errp)
>>  {
>>      PnvOCC *occ = PNV_OCC(dev);
>> @@ -297,6 +313,7 @@ static void pnv_occ_register_types(void)
>>      type_register_static(&pnv_occ_type_info);
>>      type_register_static(&pnv_occ_power8_type_info);
>>      type_register_static(&pnv_occ_power9_type_info);
>> +    type_register_static(&pnv_occ_power10_type_info);
>>  }
>>  
>>  type_init(pnv_occ_register_types);
> 


