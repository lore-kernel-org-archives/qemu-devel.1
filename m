Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C35C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 05:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1E620863
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 05:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1E620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd6Km-0000jH-NI
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 01:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49044)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hd6JM-0000At-5G
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hd6JK-0001qK-DJ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:05:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52933)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hd6JJ-0001kV-E4
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:05:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so1654375wms.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 22:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6BmWZoE16z60CzezKmyRj/0UfXSoVV+paoDgBfIlLC0=;
 b=A95RnKBcoBjGzoxy32AXAa0nn2mb7NxU7V0MYxkjp2N98EJOpthFuLkQmuRiwACFUW
 hMBPatlSFnu0u556o67wykqKSCtagRsNc8dfl+xfQAQAKdri5uOrs4jbwHn0p1Uomfb9
 a9JU+DuFsDUz5DR4KxlyXwcW0mEWWU7weo3GjZdY64l0NDjGlGDyDA+pdKlzBJku+XLz
 SJfver/TU19KM5266xcCpdPROvJEAeMvVkrJA0nxX/igomJeo1mT23amBKC436h/XnhT
 VMp4T3chMx0r7LWEK5899vtu7uZN4oGt2G+VT+4uNUXlnrXP8r5X4J+NLB6ipQPlERWk
 5Qkg==
X-Gm-Message-State: APjAAAWx1eGZBKSpsw5U4viPYkn1P+CvLWpUUd1AtatwvZKl20yRqZzd
 FokM1khiEa61baP10tNfRCO7Vw0I9+Q=
X-Google-Smtp-Source: APXvYqzZjwauYKBTrg4cb2T8Pk0/D8rbEmZNUgCuAM9/zZD2JJgrvk8IfY3sTMpHFlLLa9zPc68BBQ==
X-Received: by 2002:a1c:f116:: with SMTP id p22mr1459486wmh.70.1560834328962; 
 Mon, 17 Jun 2019 22:05:28 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id v65sm865642wme.31.2019.06.17.22.05.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 22:05:28 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190617175317.27557-1-peter.maydell@linaro.org>
 <20190617175317.27557-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7803c62a-c574-cefd-02b4-41df08dca085@redhat.com>
Date: Tue, 18 Jun 2019 07:05:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617175317.27557-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 5/6] hw/timer/armv7m_systick: Forbid
 non-privileged accesses
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/19 7:53 PM, Peter Maydell wrote:
> Like most of the v7M memory mapped system registers, the systick
> registers are accessible to privileged code only and user accesses
> must generate a BusFault. We implement that for registers in
> the NVIC proper already, but missed it for systick since we
> implement it as a separate device. Correct the omission.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/armv7m_systick.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
> index a17317ce2fe..94640743b5d 100644
> --- a/hw/timer/armv7m_systick.c
> +++ b/hw/timer/armv7m_systick.c
> @@ -75,11 +75,17 @@ static void systick_timer_tick(void *opaque)
>      }
>  }
>  
> -static uint64_t systick_read(void *opaque, hwaddr addr, unsigned size)
> +static MemTxResult systick_read(void *opaque, hwaddr addr, uint64_t *data,
> +                                unsigned size, MemTxAttrs attrs)
>  {
>      SysTickState *s = opaque;
>      uint32_t val;
>  
> +    if (attrs.user) {
> +        /* Generate BusFault for unprivileged accesses */
> +        return MEMTX_ERROR;
> +    }
> +
>      switch (addr) {
>      case 0x0: /* SysTick Control and Status.  */
>          val = s->control;
> @@ -121,14 +127,21 @@ static uint64_t systick_read(void *opaque, hwaddr addr, unsigned size)
>      }
>  
>      trace_systick_read(addr, val, size);
> -    return val;
> +    *data = val;
> +    return MEMTX_OK;
>  }
>  
> -static void systick_write(void *opaque, hwaddr addr,
> -                          uint64_t value, unsigned size)
> +static MemTxResult systick_write(void *opaque, hwaddr addr,
> +                                 uint64_t value, unsigned size,
> +                                 MemTxAttrs attrs)
>  {
>      SysTickState *s = opaque;
>  
> +    if (attrs.user) {
> +        /* Generate BusFault for unprivileged accesses */
> +        return MEMTX_ERROR;
> +    }
> +
>      trace_systick_write(addr, value, size);
>  
>      switch (addr) {
> @@ -172,11 +185,12 @@ static void systick_write(void *opaque, hwaddr addr,
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "SysTick: Bad write offset 0x%" HWADDR_PRIx "\n", addr);
>      }
> +    return MEMTX_OK;
>  }
>  
>  static const MemoryRegionOps systick_ops = {
> -    .read = systick_read,
> -    .write = systick_write,
> +    .read_with_attrs = systick_read,
> +    .write_with_attrs = systick_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid.min_access_size = 4,
>      .valid.max_access_size = 4,
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

