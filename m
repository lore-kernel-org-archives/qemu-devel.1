Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B86C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E962075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E962075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59903 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8ln-0004vg-Kf
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 12:04:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL8j0-00035Q-3j
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL8iy-0004Sr-GH
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:01:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL8iy-0004R3-99
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:01:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so16609421wml.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=xzECh5Uet51rVs2bM/6JjMpia0msRmS9xyUKJRf3jEw=;
	b=bSMO28ZMZ3+D3VVFxfJ4q9Sl30xVTZxMMzHborMffw9GUeTQp/9yApmeQAb9QN/oFU
	NDO+ALoL03wAEIJXN22ndCRQfV5oqo6uYEvKSEaWgepraK6wtMdn6hIF1ODtk4QsnJ+P
	Keb0qOn1tGZmHsf3O/lrAnLEXZhfl2c4kXOj1DgUcp+a+2L0/+jpANCPDlN96s1D5kNg
	DxIlLgcfGBi6jb6L0YtDlDLT80jEZm9wNgPVBmcsvw5TDDhRHpwbrgvKepPRE32ApuIX
	7I8KNZ8n0I8B5E/t8a4sgYuZo9QTfn/cdDHZ/v8d069muop6rf2tGNiRLHZ4jVMGgKN2
	sUQQ==
X-Gm-Message-State: APjAAAVF/rHqhdgZMIhIPim+95TjJG4jwq6mMCbdE0FhVM7SCDO6/D1S
	gDOsF85YCjDHVYRQGyqhDrNf2A==
X-Google-Smtp-Source: APXvYqwmD4thaEJY/VegtLehjl0KE9o5vZuYagmgQ1Ogsl0qK9umU6RKZTvm/cJDmWIMORDCfeoFcA==
X-Received: by 2002:a7b:ce85:: with SMTP id q5mr4980374wmj.54.1556553706867;
	Mon, 29 Apr 2019 09:01:46 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	p2sm26457228wru.73.2019.04.29.09.01.45
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 09:01:46 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20190422195020.1494-1-philmd@redhat.com>
	<20190422195020.1494-6-philmd@redhat.com>
	<ccbc2340-1f33-000f-0f7e-051b67337a85@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7064b823-3016-142f-5b1b-28a46fd6272a@redhat.com>
Date: Mon, 29 Apr 2019 18:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ccbc2340-1f33-000f-0f7e-051b67337a85@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hw/ppc: Implement
 fw_cfg_arch_key_name()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429160144.-zrrzIMVMumzrauIxGDt68FJayZbErAFRdyEKroqi3A@z>

Hi Laszlo,

On 4/23/19 9:02 PM, Laszlo Ersek wrote:
> On 04/22/19 21:50, Philippe Mathieu-Daudé wrote:
>> Implement fw_cfg_arch_key_name(), which returns the name of a
>> ppc-specific key.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/ppc/Makefile.objs |  2 +-
>>  hw/ppc/fw_cfg.c      | 45 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 46 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/ppc/fw_cfg.c
>>
>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
>> index 1111b218a04..ae940981553 100644
>> --- a/hw/ppc/Makefile.objs
>> +++ b/hw/ppc/Makefile.objs
>> @@ -1,5 +1,5 @@
>>  # shared objects
>> -obj-y += ppc.o ppc_booke.o fdt.o
>> +obj-y += ppc.o ppc_booke.o fdt.o fw_cfg.o
>>  # IBM pSeries (sPAPR)
>>  obj-$(CONFIG_PSERIES) += spapr.o spapr_caps.o spapr_vio.o spapr_events.o
>>  obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
>> diff --git a/hw/ppc/fw_cfg.c b/hw/ppc/fw_cfg.c
>> new file mode 100644
>> index 00000000000..a88b5c4bde2
>> --- /dev/null
>> +++ b/hw/ppc/fw_cfg.c
>> @@ -0,0 +1,45 @@
>> +/*
>> + * fw_cfg helpers (PPC specific)
>> + *
>> + * Copyright (c) 2019 Red Hat, Inc.
>> + *
>> + * Author:
>> + *   Philippe Mathieu-Daudé <philmd@redhat.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/ppc/ppc.h"
>> +#include "hw/nvram/fw_cfg.h"
>> +
>> +const char *fw_cfg_arch_key_name(uint16_t key)
>> +{
>> +    static const struct {
>> +        uint16_t key;
>> +        const char *name;
>> +    } fw_cfg_arch_wellknown_keys[] = {
>> +        {FW_CFG_PPC_WIDTH, "width"},
>> +        {FW_CFG_PPC_HEIGHT, "height"},
>> +        {FW_CFG_PPC_DEPTH, "depth"},
>> +        {FW_CFG_PPC_TBFREQ, "tbfreq"},
>> +        {FW_CFG_PPC_CLOCKFREQ, "clockfreq"},
>> +        {FW_CFG_PPC_IS_KVM, "is_kvm"},
>> +        {FW_CFG_PPC_KVM_HC, "kvm_hc"},
>> +        {FW_CFG_PPC_KVM_PID, "pid"},
>> +        {FW_CFG_PPC_NVRAM_ADDR, "nvram_addr"},
>> +        {FW_CFG_PPC_BUSFREQ, "busfreq"},
>> +        {FW_CFG_PPC_NVRAM_FLAT, "nvram_flat"},
>> +        {FW_CFG_PPC_VIACONFIG, "viaconfig"},
>> +    };
>> +
>> +    for (size_t i = 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i++) {
>> +        if (fw_cfg_arch_wellknown_keys[i].key == key) {
>> +            return fw_cfg_arch_wellknown_keys[i].name;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>>
> 
> (1) Have you considered extracting the struct type, and the linear
> search, to code that's shared between the arches?
> 
> It might suffice to make only the "fw_cfg_arch_wellknown_keys" array
> target-specific.

Yes, I tried different ways:

1/ Declare as extern

If we declare the array as 'extern const', we can no more use the
ARRAY_SIZE() macro, so we have to use an 'extern const size_t' too.
(No need to use a getter() since the array is *const*).

I personally try to avoid extern variables when possible, I find them
bug prone.

2/ Add a macro in the header, use it in each source

The macro is ugly to read, the result looked worse to me.

3/ I don't expect new keys to be added often, and adding them will be
trivial 1-line patch each key.

I might be unaware of better ways to deduplicate this, so if you have
suggestions I'm happy to learn :)

> (It's not complex code so I don't mind if you opt for the code duplication.)
> 
> (2) PPC highlights my question#2 from under "v3 3/7". Namely, we
> extracted the x86 constants into "hw/i386/fw_cfg.h". But the PPC
> constants already exist in "include/hw/ppc/ppc.h". (My point being the
> difference in the "include/" pathname prefix.) Should we be consistent?

I'd like to be consistent :)

So far only machines set fw_cfg keys.

I don't see arch-specific devices accessing arch-specific fw_cfg keys,
so we might move arch-specific key definitions in hw/$ARCH/fw_cfg.h (not
include/hw/$ARCH/fw_cfg.h).

> If you decide to stick with this variant:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!

> 
> Thanks
> Laszlo
> 

