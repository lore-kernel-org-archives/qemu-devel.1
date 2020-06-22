Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81EBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9BF206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9BF206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnMSL-0006ag-TN
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 09:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnMRe-00060i-MD
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:25:07 -0400
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:56342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnMRb-0002d1-C8
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:25:06 -0400
Received: from player739.ha.ovh.net (unknown [10.108.42.176])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id A251F21B491
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 15:25:00 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player739.ha.ovh.net (Postfix) with ESMTPSA id 5E07CF968D33;
 Mon, 22 Jun 2020 13:24:52 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G0035aca5aa9-3126-4c04-8516-1a592f4e1f32,D5B34DF2F1998B4AFDB97B5973F1BB92C24DD330)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v4 4/8] hw/misc/pca9552: Add a 'description' property for
 debugging purpose
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-5-f4bug@amsat.org>
 <4d335933-9669-43e1-0966-5f0255142012@kaod.org>
 <34fe3d2b-6b41-0509-f172-5b45486fdf0c@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <deccf836-48ef-7112-d66e-a8d3cc4a9681@kaod.org>
Date: Mon, 22 Jun 2020 15:24:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <34fe3d2b-6b41-0509-f172-5b45486fdf0c@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12766579047821970193
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekvddgieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkeeirddvuddtrdduhedvrddvgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.36.150; envelope-from=clg@kaod.org;
 helo=17.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 09:25:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Corey Minyard <cminyard@mvista.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 10:31 AM, Philippe Mathieu-Daudé wrote:
> On 6/22/20 8:27 AM, Cédric Le Goater wrote:
>> On 6/21/20 12:58 AM, Philippe Mathieu-Daudé wrote:
>>> Add a description field to distinguish between multiple devices.
>>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>
>> Could it be a QOM attribute ? 
> 
> What do you call a 'QOM attribute'?
> Is it what qdev properties implement?
> (in this case via DEFINE_PROP_STRING).

I meant a default Object property, which would apply to all Objects. 

What you did is fine, so :

Reviewed-by: Cédric Le Goater <clg@kaod.org>

but, may be, a well defined child name is enough for the purpose.

C.


> 
>>
>> C.
>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  include/hw/misc/pca9552.h |  1 +
>>>  hw/misc/pca9552.c         | 10 ++++++++++
>>>  2 files changed, 11 insertions(+)
>>>
>>> diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
>>> index ef6da4988f..c5be7f1c5e 100644
>>> --- a/include/hw/misc/pca9552.h
>>> +++ b/include/hw/misc/pca9552.h
>>> @@ -27,6 +27,7 @@ typedef struct PCA9552State {
>>>  
>>>      uint8_t regs[PCA9552_NR_REGS];
>>>      uint8_t max_reg;
>>> +    char *description; /* For debugging purpose only */
>>>      uint8_t nr_leds;
>>>  } PCA9552State;
>>>  
>>> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
>>> index b97fc2893c..54ccdcf6d4 100644
>>> --- a/hw/misc/pca9552.c
>>> +++ b/hw/misc/pca9552.c
>>> @@ -12,6 +12,7 @@
>>>  #include "qemu/osdep.h"
>>>  #include "qemu/log.h"
>>>  #include "qemu/module.h"
>>> +#include "hw/qdev-properties.h"
>>>  #include "hw/misc/pca9552.h"
>>>  #include "hw/misc/pca9552_regs.h"
>>>  #include "migration/vmstate.h"
>>> @@ -312,8 +313,16 @@ static void pca9552_realize(DeviceState *dev, Error **errp)
>>>                     __func__, s->nr_leds, PCA9552_PIN_COUNT);
>>>          return;
>>>      }
>>> +    if (!s->description) {
>>> +        s->description = g_strdup("pca-unspecified");
>>> +    }
>>>  }
>>>  
>>> +static Property pca9552_properties[] = {
>>> +    DEFINE_PROP_STRING("description", PCA9552State, description),
>>> +    DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>>  static void pca9552_class_init(ObjectClass *klass, void *data)
>>>  {
>>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>> @@ -325,6 +334,7 @@ static void pca9552_class_init(ObjectClass *klass, void *data)
>>>      dc->realize = pca9552_realize;
>>>      dc->reset = pca9552_reset;
>>>      dc->vmsd = &pca9552_vmstate;
>>> +    device_class_set_props(dc, pca9552_properties);
>>>  }
>>>  
>>>  static const TypeInfo pca9552_info = {
>>>
>>
>>


