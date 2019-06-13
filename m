Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B61EC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFD420679
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFD420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQuQ-0005t3-Ev
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbPT8-0004cn-FV
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbPT6-00077E-JU
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:08:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbPT6-00075m-Ct
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:08:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so20715129wrm.8
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 06:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2/xTwiaw6JA4jI1YlowgfLsU7NNgPHQ4nuXr8PeIxUc=;
 b=VUbrQ4C7od7hUibd3TLFgVgEHtabO7JlxOjpZhlWzB/o744VXm3zOIJsRgW++yAcmi
 S401e/fuUbZghx4If5W9PMXery9H0td7nNR6ImmcTrRDB6ngiliZGPLH2HDA1JDIAkAX
 Z3BiAGl7rkhsSF6y/Af15lwCHH7gH1jN5sernjcuNI3IxwiKR7QOD2dNsoM/iNQR4mHN
 0LoR5/k3cpCgavpaosk6jRr0xGZQo9Bb8SVCQZXQ+Swy4+h+rCq6wfwe1hv+1sR/Nccm
 3fRbIvpleNA9H2KrLhJYd7K54q4C627tfjTvzqEVLBoa3zXHsq1lkQZLScncDVUitiAf
 Zj3Q==
X-Gm-Message-State: APjAAAURSJPedOHAuR0zmemccmsOELbHn7KgEux2UznegXeX70qW4LHO
 N3zcpUyG+WEkMiE8YpGOLdZe+Q==
X-Google-Smtp-Source: APXvYqy7kL7Wmi95wz5Q4IrPZDsxVNvv5X7kou+7bBNbZxf0pSAB2j73htb2ksJbzEEx/SayXWe8Yg==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr869622wrn.216.1560431318826;
 Thu, 13 Jun 2019 06:08:38 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id m21sm3012177wmc.1.2019.06.13.06.08.38
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 06:08:38 -0700 (PDT)
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
References: <20190613050937.124903-1-aik@ozlabs.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <35361394-42ba-dcf0-6fe2-5a0a538d1440@redhat.com>
Date: Thu, 13 Jun 2019 15:08:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613050937.124903-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH qemu] loader: Trace loaded images
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
Cc: David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alexey,

On 6/13/19 7:09 AM, Alexey Kardashevskiy wrote:
> This adds a trace point which prints every loaded image. This includes
> bios/firmware/kernel/initradmdisk/pcirom.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> The example for a pseries guest:
> 
> loader_write_rom slof.bin: @0x0 size=0xe22e0 ROM=0
> loader_write_rom phdr #0: /home/aik/t/vml4120le: @0x400000 size=0x13df000 ROM=0
> loader_write_rom /home/aik/t/le.cpio: @0x1ad0000 size=0x9463a00 ROM=0

I find the "ROM=0" part confuse, maybe you can change to "ROM:false".

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Sadly "spapr-rtas.bin" does not show up because it is loaded from
> the spapr machine reset handler rather than via rom_reset(), may be needs
> to be fixed.
> 
> ---
>  Makefile.objs        | 1 +
>  hw/core/loader.c     | 3 +++
>  hw/core/trace-events | 2 ++
>  3 files changed, 6 insertions(+)
>  create mode 100644 hw/core/trace-events
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index c8337fa34be8..036ca6752908 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -200,6 +200,7 @@ trace-events-subdirs += target/riscv
>  trace-events-subdirs += target/s390x
>  trace-events-subdirs += target/sparc
>  trace-events-subdirs += util
> +trace-events-subdirs += hw/core
>  
>  trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
>  
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index a097bbe30a74..7fe083af492f 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -44,6 +44,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "trace.h"
>  #include "hw/hw.h"
>  #include "disas/disas.h"
>  #include "monitor/monitor.h"
> @@ -1114,6 +1115,8 @@ static void rom_reset(void *unused)
>           * CPU definitely fetches its instructions from the just written data.
>           */
>          cpu_flush_icache_range(rom->addr, rom->datasize);
> +
> +        trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
>      }
>  }
>  
> diff --git a/hw/core/trace-events b/hw/core/trace-events
> new file mode 100644
> index 000000000000..fe47a9c8cb1f
> --- /dev/null
> +++ b/hw/core/trace-events
> @@ -0,0 +1,2 @@
> +# loader.c
> +loader_write_rom(const char *name, uint64_t gpa, uint64_t size, bool isrom) "%s: @0x%"PRIx64" size=0x%"PRIx64" ROM=%d"
> 

