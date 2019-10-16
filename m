Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9851C4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF93620650
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF93620650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKfaW-0001HC-WA
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 05:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKfZt-0000pP-4L
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKfZr-00005l-NI
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:26:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKfZr-00005B-HB
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:26:43 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 483BA4ACA7
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 09:26:42 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j14so76474wrp.6
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 02:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FmNieoC72m25n2CcxRCXGkjoghdzkJVIg2/SkdBBodA=;
 b=bd6N/pofH195B+fxNMDoYJWirhvwJzIPCqWqRAa3dqrYQXKsW6Oh0Q1frUvbSq2BE0
 WvkjFMZN0XQeq7G+dwsMXvrZLQ3LsblL6oP75Vx2dnHkzl9p8T9GOpXwShOrBRJGs/pe
 rufCaugS5PuE8vaT55QR40vMcm57nONgCyTyGx4Ng3BKnWth+i/yoXK62RMKaZyRblYV
 djrrajYYdF8cRhpCX8JMJZfQkzyIW8RwMvmN0gxqr5QMTLjD70ND0e7KMY7NVCNe0TRY
 NXhnDF9E2eeB5HznhaebMOOMHUtPjuLOe98ZIjm3sBcksUuxMvEtVQCNHymlH0S1tN3s
 B+SA==
X-Gm-Message-State: APjAAAU8W9kn6QZ7zqnRG3okaymRE5/0JrAZoNZSvExVB2o1p0tqGpgK
 urOJNrHybWsl73x7KfXE8KYtbRtLsC0GJNkI8HV8wOLy9nx7YmVmq08FyoDX922bPIQY6zX26YM
 D9rZfigVxPmJMplI=
X-Received: by 2002:adf:db0e:: with SMTP id s14mr1857518wri.341.1571218001020; 
 Wed, 16 Oct 2019 02:26:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy39ueEYMoc+9aIF9Hfr2TJ61eXMUMOVHdvTH4sMMpu9l23YOllxGjnLfP36zcoaZEsGKy45g==
X-Received: by 2002:adf:db0e:: with SMTP id s14mr1857496wri.341.1571218000781; 
 Wed, 16 Oct 2019 02:26:40 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id z9sm23895495wrl.35.2019.10.16.02.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2019 02:26:40 -0700 (PDT)
Subject: Re: [PATCH v9 14/15] hw/i386: Introduce the microvm machine type
To: Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-devel@nongnu.org
References: <20191015112346.45554-1-slp@redhat.com>
 <20191015112346.45554-15-slp@redhat.com>
 <6276a8e7-2928-6e33-64a1-3ae01a30a718@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a5863b05-4021-df51-d84f-1bb070fa6137@redhat.com>
Date: Wed, 16 Oct 2019 11:26:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <6276a8e7-2928-6e33-64a1-3ae01a30a718@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, imammedo@redhat.com,
 rth@twiddle.net, lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 9:46 AM, Paolo Bonzini wrote:
> 
>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index c5c9d4900e..d399dcba52 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -92,6 +92,10 @@ config Q35
>>       select SMBIOS
>>       select FW_CFG_DMA
>>   
>> +config MICROVM
>> +    bool
> 
> Missing:
> 
>      select ISA_BUS
>      select APIC
>      select IOAPIC
>      select I8259
>      select MC146818RTC

maybe 'select SERIAL_ISA' too?

> No need to post v10 just for this.
> 
> Paolo
> 
> 
>> +    select VIRTIO_MMIO
>> +
>>   config VTD
>>       bool
>>   
>> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
>> index 7ed80a4853..0d195b5210 100644
>> --- a/hw/i386/Makefile.objs
>> +++ b/hw/i386/Makefile.objs
>> @@ -4,6 +4,7 @@ obj-y += x86.o
>>   obj-y += pc.o
>>   obj-$(CONFIG_I440FX) += pc_piix.o
>>   obj-$(CONFIG_Q35) += pc_q35.o
>> +obj-$(CONFIG_MICROVM) += microvm.o
>>   obj-y += fw_cfg.o pc_sysfw.o
>>   obj-y += x86-iommu.o
>>   obj-$(CONFIG_VTD) += intel_iommu.o
>>
> 

