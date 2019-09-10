Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5CAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6AB20692
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6AB20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7dwQ-0000XN-Vo
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 07:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i7dtd-0007vP-0B
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i7dtb-0004MY-KF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:01:16 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:43532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i7dtX-0004Jq-0J
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:01:15 -0400
Received: from player774.ha.ovh.net (unknown [10.108.54.72])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 9E5421ABA05
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 13:01:05 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player774.ha.ovh.net (Postfix) with ESMTPSA id D77FA9A20A6C;
 Tue, 10 Sep 2019 11:00:55 +0000 (UTC)
To: Balamuruhan S <bala24@linux.ibm.com>
References: <20190910071019.16689-1-bala24@linux.ibm.com>
 <20190910071019.16689-4-bala24@linux.ibm.com>
 <5aace97f-5a34-7e05-9cdc-65e17613033e@kaod.org>
 <20190910103054.GB16391@localhost.localdomain>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f0a5499f-4a76-85b8-db74-0c83a0587974@kaod.org>
Date: Tue, 10 Sep 2019 13:00:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910103054.GB16391@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9399293900483496786
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtddtgdduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.172.75
Subject: Re: [Qemu-devel] [PATCH v1 3/3] hw/ppc/pnv_homer: add PowerNV homer
 device model
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
Cc: maddy@linux.vnet.ibm.com, groug@kaod.org, qemu-devel@nongnu.org,
 anju@linux.vnet.ibm.com, qemu-ppc@nongnu.org, hari@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>> +
>>> +    object_initialize_child(obj, "homer",  &chip9->homer, sizeof(chip9->homer),
>>> +                            TYPE_PNV9_HOMER, &error_abort, NULL);
>>> +    object_property_add_const_link(OBJECT(&chip9->homer), "chip", obj,
>>> +                                   &error_abort);
>>
>> Does HOMER need the chip ? It is not used but we might want to in the 
>> core_max_array() ? 
> 
> sorry, no it is not required, I will remove it.

It seems you will need the chip in core_max_array(). I would keep it. 
See below,

[ ... ] 

>>> +static bool core_max_array(void *opaque, hwaddr addr)

Please change the 'void *opaque' function parameter in 'PnvHOMER *homer'

>>> +{
>>> +    PnvHOMER *homer = PNV_HOMER(opaque);
>>> +    PnvHOMERClass *homer_class = PNV_HOMER_GET_CLASS(homer);
>>> +
>>> +    MachineState *ms = MACHINE(qdev_get_machine());
>>
>> Do you need the whole machine or only the chip ?  
> 
> yes, I see it is for active cores in the chip, I can use `nr_cores`
> defined in PnvChip.


If you keep the QOM link above, you can grab it in the realize handler of
the HOMER model with :  

    Object *obj;
    Error *local_err = NULL;

    obj = object_property_get_link(OBJECT(dev), "chip", &local_err);
    if (!obj) {
        error_propagate(errp, local_err);
        error_prepend(errp, "required link 'chip' not found: ");
        return;
    }

    homer->chip = PNV_CHIP(obj);

[ ... ] 

>>> +
>>> +/* P9 Pstate table */
>>> +
>>
>> no version ? 
> 
> PNV9_OCC_PSTATE_MAJOR_VERSION is the P9 pstate version.

why isn't it in the switch statement below ? 

[ ... ] 
 
>>> +typedef struct PnvHOMER {
>>> +    DeviceState parent;
>>> +
>>> +    MemoryRegion homer_regs;
>>
>> the homer_ prefix is not useful.
> 
> okay, I will change it to `hregs`.

I would just remove the prefix

Thanks,

C. 


