Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BD2C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CFF20665
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CFF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnSc2-00045u-P8
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 14:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39957)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnSbs-0003hW-BM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnSbq-0007R0-3z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:55:31 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:33781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnSbo-0007PT-TM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:55:29 -0400
Received: by mail-wm1-f54.google.com with SMTP id h19so17405384wme.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 11:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+UNlYTO4rZ90HtkcakKqhgHW4eGTCn8HF452Dpm+RQc=;
 b=pLwSLxf01sQ0kAVUjBZqUVYANUpoddBMXMqcl4nJelt+cXsLfpA5DRddsL/1qHIVLC
 QQoroV99elNcOnEznmhgqrllX1HMIJEL5x76Lo30TbYaXt0u0At9pMEoXyUdO49MrEww
 GO+wUTRXqyuJu/bjVUsWDDj1zw9PHrMYg3gkTqJEtzTZzrl1V61eP5RKQt5Ff9z7RNhs
 reLuZIdCXppdfZPmUJ2CIlh1FTY3j1HH4bXLyrI5e3TrBgcqUKXNPJLzX57vknuz7Nql
 Lk0RFAhf9Z3uGcnx54hpfV5iFYDHVZyw8CqJ/HTNTfS3rVGUMcGF7BmlxBxNCiPFbX+P
 nt0w==
X-Gm-Message-State: APjAAAXchlIviD3cih72yY2pDOfSEpYeHOSeHl7J4L0Zs7OtKLbrNeAX
 xrL37xOxzd5sOU8wgnSED6JhbQ==
X-Google-Smtp-Source: APXvYqyBgE+jfXlGYa7cpHeNJ2klWIQaR+o8HM5fKkmVUiNHpJN/ko/qwaz8zXMqRY0oXw8fMM+LBA==
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr31781605wml.84.1563303327229; 
 Tue, 16 Jul 2019 11:55:27 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id x24sm21389953wmh.5.2019.07.16.11.55.26
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 11:55:26 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
 <1563264677-39718-9-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <94cbff56-cca6-119e-b873-d8fcdf9e11f8@redhat.com>
Date: Tue, 16 Jul 2019 20:55:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1563264677-39718-9-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.54
Subject: Re: [Qemu-devel] [PULL 08/19] hw/i386: turn off vmport if
 CONFIG_VMPORT is disabled
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
Cc: Julio Montes <julio.montes@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 7/16/19 10:11 AM, Paolo Bonzini wrote:
> From: Julio Montes <julio.montes@intel.com>
> 
> vmport device is not included when CONFIG_VMPORT is disabled, hence
> QEMU fails with the following error:
> 
> `Unknown device 'vmport' for bus 'ISA': unknown.`
> 
> v2: imply VMPORT (Paolo Bonzini )
> 
> Signed-off-by: Julio Montes <julio.montes@intel.com>
> Message-Id: <20190712160257.18270-1-julio.montes@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/Kconfig | 4 ++--
>  hw/i386/pc.c    | 5 +++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 4ddf2a9..b9c96ac 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -51,6 +51,7 @@ config PC_ACPI
>  config I440FX
>      bool
>      imply E1000_PCI
> +    imply VMPORT
>      select PC_PCI
>      select PC_ACPI
>      select ACPI_SMBUS
> @@ -58,7 +59,6 @@ config I440FX
>      select IDE_PIIX
>      select DIMM
>      select SMBIOS
> -    select VMPORT
>      select VMMOUSE
>      select FW_CFG_DMA
>  
> @@ -77,6 +77,7 @@ config Q35
>      imply VTD
>      imply AMD_IOMMU
>      imply E1000E_PCI_EXPRESS
> +    imply VMPORT
>      select PC_PCI
>      select PC_ACPI
>      select PCI_EXPRESS_Q35
> @@ -84,7 +85,6 @@ config Q35
>      select AHCI_ICH9
>      select DIMM
>      select SMBIOS
> -    select VMPORT
>      select VMMOUSE
>      select FW_CFG_DMA
>  
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c33ce47..549c437 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -83,6 +83,7 @@
>  #include "hw/mem/memory-device.h"
>  #include "sysemu/replay.h"
>  #include "qapi/qmp/qerror.h"
> +#include "config-devices.h"
>  
>  /* debug PC/ISA interrupts */
>  //#define DEBUG_IRQ
> @@ -2793,7 +2794,11 @@ static void pc_machine_initfn(Object *obj)
>  
>      pcms->max_ram_below_4g = 0; /* use default */
>      pcms->smm = ON_OFF_AUTO_AUTO;
> +#ifdef CONFIG_VMPORT
>      pcms->vmport = ON_OFF_AUTO_AUTO;
> +#else
> +    pcms->vmport = ON_OFF_AUTO_OFF;
> +#endif /* CONFIG_VMPORT */
>      /* acpi build is enabled by default if machine supports it */
>      pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
>      pcms->smbus_enabled = true;
> 

Testing v4.1.0-rc1, this commit breaks ./configure
--without-default-devices:

  GEN     i386-softmmu/config-devices.mak.tmp
    select VMMOUSE if I440FX
    select VMMOUSE if Q35
    config VMMOUSE depends on VMPORT
Traceback (most recent call last):
  File "scripts/minikconf.py", line 703, in <module>
    config = data.compute_config()
  File "scripts/minikconf.py", line 253, in compute_config
    clause.process()
  File "scripts/minikconf.py", line 188, in process
    self.dest.set_value(False, self)
  File "scripts/minikconf.py", line 118, in set_value
    raise KconfigDataError('contradiction between clauses when setting
%s' % self)
__main__.KconfigDataError: contradiction between clauses when setting
VMMOUSE

97fd1ea8c1065839ae4c19bfdc3590033a5b9788 is the first bad commit
commit 97fd1ea8c1065839ae4c19bfdc3590033a5b9788
Author: Julio Montes <julio.montes@intel.com>
Date:   Fri Jul 12 16:02:57 2019 +0000

    hw/i386: turn off vmport if CONFIG_VMPORT is disabled

    vmport device is not included when CONFIG_VMPORT is disabled, hence
    QEMU fails with the following error:

    `Unknown device 'vmport' for bus 'ISA': unknown.`

    v2: imply VMPORT (Paolo Bonzini )

    Signed-off-by: Julio Montes <julio.montes@intel.com>
    Message-Id: <20190712160257.18270-1-julio.montes@intel.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

