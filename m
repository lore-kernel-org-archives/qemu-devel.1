Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E19C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 09:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CB0206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 09:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CB0206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36994 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMUGT-00082v-HE
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 05:13:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jirislaby@gmail.com>) id 1hMUF8-0006YA-S4
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jirislaby@gmail.com>) id 1hMUF7-0001N8-UO
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:12:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jirislaby@gmail.com>) id 1hMUF7-0001MS-Mw
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:12:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id y5so5847298wma.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 02:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=fL2Imtign9HBpf9NNCoTBWHYazCVb/jmT9ZRiNJq1O8=;
	b=Ei4QjcGjddgO0ERa+MRH9QcWMBm6AiAxWrjh+EfeewNA5LZwzYLPaP+SRZbwfPZ/CS
	m0NOTWM8nPA8fRAw8JC7fFzPmUg+y3CLXof100nD1c4pMMgYGsdvuzAIh4DqUSimdFl5
	hd5/ioVzo6W2Wu0yJ8l6xii6cairGs2VXL1CuA4e176cmx3Go0qzK0aV5f7Gi0kH3ZGA
	jzB5hQVuZPsFfRqJ02xLl8rZOBHdqaevGFTe3GAMzy9wCMhCXggr/qPniamIGP09RZlV
	dkS7Df++TZ14ZkN+zxaULFzAhV4ImyhP3e7OwnMiIjyR+26g9CJRPTZ7CEYxmdLBSwXs
	jIbw==
X-Gm-Message-State: APjAAAXw2LngEAB8a47oetBbqC32DFkZ1GnlMTuMvouOVuEVl3oHYrHa
	C6ThzWkkpUGNbzCyYystYCg=
X-Google-Smtp-Source: APXvYqz/RKttT/grCP0FFSAlQKuwtZbAejVMd7wiqj5qqxvEjyfH6iVGLnBD/xKFw2pC9bD7vrhcBw==
X-Received: by 2002:a1c:1b08:: with SMTP id b8mr5698354wmb.35.1556874751935;
	Fri, 03 May 2019 02:12:31 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
	by smtp.gmail.com with ESMTPSA id n4sm1854508wmk.24.2019.05.03.02.12.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 02:12:30 -0700 (PDT)
To: Li Qiang <liq3ea@163.com>, pbonzini@redhat.com
References: <20190422141156.15746-1-liq3ea@163.com>
	<20190422141156.15746-4-liq3ea@163.com>
From: Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
	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
Message-ID: <0f466daa-2d94-b95e-d653-d44123829459@suse.cz>
Date: Fri, 3 May 2019 11:12:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422141156.15746-4-liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v3 3/3] edu: uses uint64_t in dma operation
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
Cc: philmd@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503091229.L9uv4uU5rJ9e8crtCm_xcH3wqNgczf4yJNGVA-roU-k@z>

On 22. 04. 19, 16:11, Li Qiang wrote:
> The dma related variable dma.dst/src/cnt is dma_addr_t, it is
> uint64_t in x64 platform. Change these usage from uint32_to
> uint64_t to avoid trancation in edu_dma_timer.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
> ---
>  hw/misc/edu.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 33de05141f..401ada74af 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -98,23 +98,24 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
>      }
>  }
>  
> -static bool within(uint32_t addr, uint32_t start, uint32_t end)
> +static bool within(uint64_t addr, uint64_t start, uint64_t end)
>  {
>      return start <= addr && addr < end;
>  }
>  
> -static void edu_check_range(uint32_t addr, uint32_t size1, uint32_t start,
> +static void edu_check_range(uint64_t addr, uint64_t size1, uint64_t start,
>                  uint32_t size2)

So in this version you don't change size2's type, but you still change
size1's one :)?

Other than that, looks good to me.

>  {
> -    uint32_t end1 = addr + size1;
> -    uint32_t end2 = start + size2;
> +    uint64_t end1 = addr + size1;
> +    uint64_t end2 = start + size2;
>  
>      if (within(addr, start, end2) &&
>              end1 > addr && within(end1, start, end2)) {
>          return;
>      }
>  
> -    hw_error("EDU: DMA range 0x%.8x-0x%.8x out of bounds (0x%.8x-0x%.8x)!",
> +    hw_error("EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
> +             " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
>              addr, end1 - 1, start, end2 - 1);
>  }



-- 
js
suse labs

