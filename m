Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84567C742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5822C206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5822C206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwfU-0005Qj-LV
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45791)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlwdr-0006xE-Aw
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlwdd-0003Q2-9o
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:35:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlwdd-0003KW-2S
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:35:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so9395241wme.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 07:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I3Rqj94Dj4IR0qU/xeDzTPEkRicLJfLqFPxPRhgmulg=;
 b=gXV+qBxAGlcr2SoRAlE/47mvGmQfZbPsaMAYAGdH3vElJRde3uX7h3NrX6/HF/9veg
 jpB0CiB1KTlhluMq8htT82SZ9BjKWKIEMeZ97UGKwg250lYzbfaSgtPzQ51WED5Zxvhv
 Ki21dUroIyqZ8WelbqcbyOCTRyK/3ONyLzHPsUoiz9slkULqjHwn6GuzYrdUCUNqvtdP
 I2sPsP+7HcIx2ziDdXE3WW05f63D+f9JTQ0pyKfZ0mi8CNRlt7DaK79uclAWVslm7l6d
 zZqn1ocdo0ItsPqdDf5w0n3f+W4bT4t6JMUmAflHW14oWGeeE+kmgcnFPlKpRPdyJdNB
 npTg==
X-Gm-Message-State: APjAAAXPv3VPcQhylJFkUeN+JPdPChd+CVBbWsc7eLt/eZjgGM4ntfh5
 DTCE4lDYnVaxT+qFKWDGn9IVyg==
X-Google-Smtp-Source: APXvYqxk3U8qABAdEJE6G+JSraaoAd+HuT1ExSa9eeKpCMIBBstMWRur3SI2kxridYrWO/whRYmQRQ==
X-Received: by 2002:a1c:56d7:: with SMTP id k206mr9833794wmb.56.1562942100139; 
 Fri, 12 Jul 2019 07:35:00 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id o6sm14570538wra.27.2019.07.12.07.34.59
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 07:34:59 -0700 (PDT)
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
References: <20190712132611.20411-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <056e4dd6-70b7-395a-2062-913ddcea0028@redhat.com>
Date: Fri, 12 Jul 2019 16:34:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712132611.20411-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH for 4.1] Fix broken build with WHPX enabled
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Justin Terry <juterry@microsoft.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Justin

Maybe we should add a MAINTAINERS section for the WHPX files.

On 7/12/19 3:26 PM, Stefan Weil wrote:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  target/i386/whpx-all.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 31d47320e4..ed95105eae 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -1396,7 +1396,7 @@ static int whpx_accel_init(MachineState *ms)
>      }
>  
>      memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
> -    prop.ProcessorCount = smp_cpus;
> +    prop.ProcessorCount = ms->smp.cpus;

I tried to understand how the Windows Hypervisor would answer to an
invalid or zeroed property, but I can't find doc for
WHvPartitionPropertyCodeProcessorCount.

There is a funny comment in VirtualBox although:

 /**
  * @todo Someone at Microsoft please explain another weird API:
  *  - Why this API doesn't take the WHV_PARTITION_PROPERTY_CODE value as an
  *    argument rather than as part of the struct.  That is so weird if
you've
  *    used any other NT or windows API,  including WHvGetCapability().
  *  - Why use PVOID when WHV_PARTITION_PROPERTY is what's expected.  We
  *    technically only need 9 bytes for setting/getting
  *    WHVPartitionPropertyCodeProcessorClFlushSize, but the API insists
on 16. */

https://www.virtualbox.org/svn/vbox/trunk/src/VBox/VMM/VMMR3/NEMR3Native-win.cpp

>      hr = whp_dispatch.WHvSetPartitionProperty(
>          whpx->partition,
>          WHvPartitionPropertyCodeProcessorCount,
> @@ -1405,7 +1405,7 @@ static int whpx_accel_init(MachineState *ms)
>  
>      if (FAILED(hr)) {
>          error_report("WHPX: Failed to set partition core count to %d,"
> -                     " hr=%08lx", smp_cores, hr);
> +                     " hr=%08lx", ms->smp.cores, hr);
>          ret = -EINVAL;
>          goto error;
>      }
> 

