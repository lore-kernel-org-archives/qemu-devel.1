Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B0CC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 07:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462D920645
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 07:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462D920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49562 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIq8Y-0001eA-By
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 03:46:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIq6y-0000TF-Um
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIptn-00020n-Ue
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:31:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIptn-00020W-ON
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:31:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id c6so13085558wrm.1
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 00:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=wwbqD8/+JqWm8fYTbt5Ab/iL8mhFjzUWiDzvbNlUmY4=;
	b=rsyXnDlwDbwh/458DZA/DW9qEC+HgwfFhdxoFRhOiNkVXBC+hjPQQsNu31pAiG0CBU
	DlzLPpjYDtQGNS4m+iJjb6C5BV1wp2aK8ceSdg3uXXYhxUAWk7Fmyu/izUzX/t8FlWFi
	lm9gPalpRIw/5A/AX5vcwerxeYucGkg+AiFJOF7ihpS/+q4Y1y4eLiMDZK7dgbgKEGdv
	ZqlTFhyG7mY/OI4I+OmlP8qPhrHbTild8M6J8/7E64RW8ymdCQwnjcKIhRwHj+RpuJ2a
	fSIOL19f2T1WWWnPWthpTFzA81+dg+zxpCXwrj/qDUPTFYPF7hhz/c4cv6jfu6M6gyVn
	HaHg==
X-Gm-Message-State: APjAAAWlRnhHLz3OrvYWWruiu1hJZJ9jA7MyjjCVlOEpnKurqTHytyCH
	wy6JRqXbxN1mVBx17k1+hAO2Nw==
X-Google-Smtp-Source: APXvYqwfGOGXogURWBUERG4DdhOkZX2nWfCi+5H6oj7wliZnKeNF9sE2VaphAQ+A6S8i6MZh0lHWgg==
X-Received: by 2002:adf:dc11:: with SMTP id t17mr766033wri.324.1556004686781; 
	Tue, 23 Apr 2019 00:31:26 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	x205sm19677850wmg.9.2019.04.23.00.31.14
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 00:31:26 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
References: <20190422195020.1494-1-philmd@redhat.com>
	<20190422195020.1494-6-philmd@redhat.com>
	<20190423012057.GA31496@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c082036d-9bac-8c4c-ddf8-02f3852ebb99@redhat.com>
Date: Tue, 23 Apr 2019 09:31:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423012057.GA31496@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
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
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423073108.HVdMhR07wAyeL3hAymLa2Ty8hyumIKBCDtJ4mv9kX7Y@z>

Hi David,

On 4/23/19 3:20 AM, David Gibson wrote:
> On Mon, Apr 22, 2019 at 09:50:18PM +0200, Philippe Mathieu-Daudé wrote:
>> Implement fw_cfg_arch_key_name(), which returns the name of a
>> ppc-specific key.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> What ppc machines actually use fw_cfg?  I know pseries and powernv
> don't.

I see:

- 40p
- g3beige (newworld)
- mac99 (oldworld)

I guess it is because they use OpenBIOS.

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
> 

