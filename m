Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32A1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB7720678
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbpWWuUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB7720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgLmC-0002Lt-2B
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 01:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgLlV-0001mw-KW; Wed, 03 Jun 2020 01:16:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgLlU-0000lv-UY; Wed, 03 Jun 2020 01:16:37 -0400
Received: by mail-wm1-x343.google.com with SMTP id c71so543324wmd.5;
 Tue, 02 Jun 2020 22:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Muqzcfi0chH/Y7Tor0GgBKAK3xF2W5UhW3gXe8RB6yo=;
 b=vbpWWuUp8cTmzDxijOVO6HiDqFDbSBroDHTgBp/oZFUOisRGIl9HfXHmkGqF2cnGI6
 2ciBbWuDpAeMScW6tOCmp1VczC09LVuPqyAQh5gDJRQNU6eeCwhR2SfHJBE1yKziT4s/
 6zlhbmfWjKR6bGnv9ic/QDtIHY0OiMCAsz2NaBbEJShRKbbZ5LFWbQqg1U1CEj9uqEOD
 fsx4XmV7LKkJ1M3wpCnD/VPcEJZBDTXlmdipxxTAjtNKMppUiwvu8rS0xKTdGaanHmvO
 KTz13gj/WWjghkpCvCD5+7i7z1MFn5fjvqG44dvqfkYE3nhd9F56tCv1x0yvqUfVeiD+
 TdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Muqzcfi0chH/Y7Tor0GgBKAK3xF2W5UhW3gXe8RB6yo=;
 b=cMVzzxCqH0ne3nAMPcm75E/nCxfnupJxxF3pfpOwtJHfw2rD2SSs0zk1icEfWcSNzY
 C1Y813lGR/vaVXfm6vaUIoa26fht3AmTYcW+Mz9JounnnPX5sRdZCb1hEhaoNfRamDE4
 q/1tLA0jkyJaXG5ie4XbDbMEbXhX8hJGaC33s/JmlmJ2nHsAQDaH+nkqB6V50kLeyL1/
 kfRtgkBgIWwg0MAwzomc5uS87vSEvFtMNuzbbMW4GwmHZvTHpdKEKMziW4ofjPq0qGLE
 5WAQbRFV63PA9ToAH889JUZxOlzTQbJXXOA4mxd5PTDNSmJKbCrhKK2mWAuojo3zHzAs
 QLWw==
X-Gm-Message-State: AOAM532ve4b5BM2yY7zXbvSixu1LlcADPatTjmnJfY07P7oe8GrOmPB2
 85eLmUt6NRzb4So+S5ZloDI=
X-Google-Smtp-Source: ABdhPJwN7yfF4vvn6CBrhFy7v+BFkCFfr9N7le+mjwoCpofUuhhHm71UAP/CIRMK1veFf6GIKAru9A==
X-Received: by 2002:a1c:25c3:: with SMTP id l186mr7001395wml.103.1591161395165; 
 Tue, 02 Jun 2020 22:16:35 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 5sm1814108wrr.5.2020.06.02.22.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 22:16:34 -0700 (PDT)
Subject: Re: [PATCH] hw/isa/apm: Convert debug printf()s to trace events
To: qemu-devel@nongnu.org
References: <20200524164806.12658-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c79a9dd3-fd68-ea43-90c0-ad2b9cb87c22@amsat.org>
Date: Wed, 3 Jun 2020 07:16:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200524164806.12658-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping for review?

On 5/24/20 6:48 PM, Philippe Mathieu-Daudé wrote:
> Convert APM_DPRINTF() to trace events and remove ifdef'ry.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/isa/apm.c        | 15 +++++----------
>  hw/isa/trace-events |  4 ++++
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/isa/apm.c b/hw/isa/apm.c
> index 6300b1ba7a..bce266b957 100644
> --- a/hw/isa/apm.c
> +++ b/hw/isa/apm.c
> @@ -24,14 +24,8 @@
>  #include "hw/isa/apm.h"
>  #include "hw/pci/pci.h"
>  #include "migration/vmstate.h"
> +#include "trace.h"
>  
> -//#define DEBUG
> -
> -#ifdef DEBUG
> -# define APM_DPRINTF(format, ...)       printf(format, ## __VA_ARGS__)
> -#else
> -# define APM_DPRINTF(format, ...)       do { } while (0)
> -#endif
>  
>  /* fixed I/O location */
>  #define APM_STS_IOPORT  0xb3
> @@ -41,8 +35,8 @@ static void apm_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
>  {
>      APMState *apm = opaque;
>      addr &= 1;
> -    APM_DPRINTF("apm_ioport_writeb addr=0x%" HWADDR_PRIx
> -                " val=0x%02" PRIx64 "\n", addr, val);
> +
> +    trace_apm_io_write(addr, val);
>      if (addr == 0) {
>          apm->apmc = val;
>  
> @@ -65,7 +59,8 @@ static uint64_t apm_ioport_readb(void *opaque, hwaddr addr, unsigned size)
>      } else {
>          val = apm->apms;
>      }
> -    APM_DPRINTF("apm_ioport_readb addr=0x%" HWADDR_PRIx " val=0x%02x\n", addr, val);
> +    trace_apm_io_read(addr, val);
> +
>      return val;
>  }
>  
> diff --git a/hw/isa/trace-events b/hw/isa/trace-events
> index 202f8938e7..3544c6213c 100644
> --- a/hw/isa/trace-events
> +++ b/hw/isa/trace-events
> @@ -9,3 +9,7 @@ superio_create_ide(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x,
>  # pc87312.c
>  pc87312_io_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
>  pc87312_io_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
> +
> +# apm.c
> +apm_io_read(uint8_t addr, uint8_t val) "read addr=0x%x val=0x%02x"
> +apm_io_write(uint8_t addr, uint8_t val) "write addr=0x%x val=0x%02x"
> 

