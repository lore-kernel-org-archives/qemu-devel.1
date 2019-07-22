Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FC0C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 20:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7D2218C9
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 20:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7D2218C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpeWf-0005aZ-U1
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 16:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39695)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpeWT-0005CA-OW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpeWS-0001h9-PE
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:03:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpeWS-0001fi-JY
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:03:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so40700853wrr.5
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 13:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SQwVpzeihz3Utyp2gIc0Xh9IEn8t74k0WvHtcZfrHA0=;
 b=jKMk/Zdtr2HvbQpdftkql6kBmSRWVtDYy9L3Enr4+9IBQ0qu+0pUKoqfATMOGnMvfI
 lDfxJSPfCqKU4FCT69qhP/FfMkh92dgXvmFqJDjjyVh+S9EDSsdYOmYOyeM74O6xQd3n
 +pyhZfS7Df/LiO6jXfvtuZ2+kbzh4ZFdAiv6TtOFOKMqZ2XyDtIZn18aS/Qkc5JvQyLu
 nBFV1kSg0q1J7bo412icuGww+lV61NR4lJogfQzD0zXq5/uNyLxkgbjcThXLYX/C2wlI
 sp+0uooFlefJuglpAoA67Oh0b8X4vDA8Fq/FH8LS5tU2fJEJuNZbAiiMqS40po9PUElw
 qmpg==
X-Gm-Message-State: APjAAAWTyudyzMpNRE3F/LaCMUWsgpdsAKOAHnV60UaqQiZLhcJojIqK
 dcYAdn/lQ6FiYuWjKnY7GeAEMg==
X-Google-Smtp-Source: APXvYqzbEDKpbWmPi8aTApxF5rKGlx/cWOfVoGZzrvDjU8v88TqsHyhrPBnppfAlBNl7m5ysUTYQfQ==
X-Received: by 2002:adf:e883:: with SMTP id d3mr79287626wrm.330.1563825779698; 
 Mon, 22 Jul 2019 13:02:59 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id v5sm42149915wre.50.2019.07.22.13.02.58
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 13:02:59 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190717134335.15351-1-alex.bennee@linaro.org>
 <20190717134335.15351-18-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8a61c6ec-55a8-ab1f-4311-c47929d67233@redhat.com>
Date: Mon, 22 Jul 2019 22:02:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190717134335.15351-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 17/23] hw/i386: also turn off VMMOUSE is
 VMPORT is disabled
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/19 3:43 PM, Alex Bennée wrote:
> Commit 97fd1ea8c1 broke the build for --without-default-devices as
> VMMOUSE depends on VMPORT.
> 
> Fixes: 97fd1ea8c1
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  hw/i386/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index b9c96ac361e..6350438036f 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -52,6 +52,7 @@ config I440FX
>      bool
>      imply E1000_PCI
>      imply VMPORT
> +    imply VMMOUSE
>      select PC_PCI
>      select PC_ACPI
>      select ACPI_SMBUS
> @@ -59,7 +60,6 @@ config I440FX
>      select IDE_PIIX
>      select DIMM
>      select SMBIOS
> -    select VMMOUSE
>      select FW_CFG_DMA
>  
>  config ISAPC
> @@ -78,6 +78,7 @@ config Q35
>      imply AMD_IOMMU
>      imply E1000E_PCI_EXPRESS
>      imply VMPORT
> +    imply VMMOUSE
>      select PC_PCI
>      select PC_ACPI
>      select PCI_EXPRESS_Q35
> @@ -85,7 +86,6 @@ config Q35
>      select AHCI_ICH9
>      select DIMM
>      select SMBIOS
> -    select VMMOUSE
>      select FW_CFG_DMA
>  
>  config VTD
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

