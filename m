Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CEBC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8592173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8592173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnVMz-00067N-3N
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 17:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34564)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnVMo-0005iy-Uy
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnVMo-0001bb-19
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:52:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnVMn-0001bF-RX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:52:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so22567499wrm.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 14:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b7zMaoWLQaPJ5lcL57PEd9e6s68sxzLgJDDdekolSJg=;
 b=saKm1XZRMbXdn14/CW2VlM6Xw7slfbrRVxABK6RysPmzlF95FiGrGr+LPSN89xUmKE
 zQsLlz6svtCv9+ODgyW1w3HDFqdnpOLKVDKTgidNYZNmbJkEtE7co9bPK69HlJXZi5VR
 ZYcbL7J2HfYSIo1cFrvK1e2ugd61D3yTw/t83Ud1f1jFzLyjoTx39FVYoew4/t4hChX7
 1SoW1oovnTvbX2yLiRsnvMGHAMH46HRRfOb0zkpzzG9JPac6ceDcF4Sbdkv7kGUs/jSx
 26zYtuvuHMSR8sLPlWJP8nj8dm6LWIgFRZfnti/EbW2q7TKXNylFlKIfEXvCdae1Twb8
 HY0g==
X-Gm-Message-State: APjAAAWzoePPo2JcZlH9idGHkP1QMcI6QLNDpYVu8IpzVs+1JmPAFMPO
 LgpdH89AA5GW3hhmCzMsAmczgg==
X-Google-Smtp-Source: APXvYqwhM9pxdfk5aWjlqe+emfD4Cg9ed/eXGn1QbMdLqAopjaBFPFHZ/x622slo9nBKbq3f92X7lw==
X-Received: by 2002:adf:a341:: with SMTP id d1mr37655471wrb.260.1563313928996; 
 Tue, 16 Jul 2019 14:52:08 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id a8sm16886510wma.31.2019.07.16.14.52.08
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 14:52:08 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190716211343.10792-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <906863f3-cc13-d53b-65c9-566e1c014f3e@redhat.com>
Date: Tue, 16 Jul 2019 23:52:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190716211343.10792-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] kconfig: do not select VMMOUSE
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
Cc: Julio Montes <julio.montes@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/19 11:13 PM, Paolo Bonzini wrote:
> Just make it a default device, so that it is automatically removed if VMPORT
> is not included in the binary (as is the case with --with-default-devices).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index b9c96ac361..83a5d9c7c4 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -59,7 +59,6 @@ config I440FX
>      select IDE_PIIX
>      select DIMM
>      select SMBIOS
> -    select VMMOUSE
>      select FW_CFG_DMA
>  
>  config ISAPC
> @@ -85,7 +84,6 @@ config Q35
>      select AHCI_ICH9
>      select DIMM
>      select SMBIOS
> -    select VMMOUSE
>      select FW_CFG_DMA
>  
>  config VTD
> @@ -99,4 +97,5 @@ config VMPORT
>  
>  config VMMOUSE
>      bool
> +    default y
>      depends on VMPORT
> 

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

