Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DEBC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E35B2184B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E35B2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbyU-00041Q-8Q
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49798)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqbyH-0003TF-IW
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqbyG-0007AK-CA
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:31:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqbyG-00079x-45
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:31:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so50410648wrm.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 04:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AizYLJUC8/bpkMUR9iyeBUQqrzd2m7arfwncBFdb8dA=;
 b=F1tgBUrIKkt9rSroNmCh/IKC08fQ/NEpqR4sP4IS0g5MCMhX9fbA7aLP1l2/+1EDVY
 WyOLrMJw1+xlBWWKKlb6EspQbm1bBxjVQ6ESc1ejkB5WYTRJ/ZLdx1Im+7a9s/7tN4ch
 KZFxZioyYxFxhUcRz15kTGWUlp0CFoLa2xry7+oD7AOV5TOhoJgdlCh3JuiQTHe+EUGt
 F+TVnnfjeL/wY0sd4NzIyjszKqpt02S4NbtNneWyQMgsx+QNMn1J+7QqElkhTuDFCkmY
 GmZ44zbmzZedcha4U88OkKk6VANbdbc5Ubw9fiq8PZ0Yvpg6r0OmgiAj8D/oD8miXbzB
 /cHA==
X-Gm-Message-State: APjAAAVM2XLMWozMmnt9dUkavWp7cGEQ4SH80XdXGMC6+04bBR1ukxh+
 9ph8+s+ZJjR8DcGIrTKEc84Vlg==
X-Google-Smtp-Source: APXvYqyKBuIHpi3kiAkxqfxMC0+wofSgFhIo0P4HhH21p2zHSnoNYspQ/94R02rVjbd6euOADQFqtw==
X-Received: by 2002:adf:cd84:: with SMTP id q4mr18155849wrj.232.1564054299238; 
 Thu, 25 Jul 2019 04:31:39 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id g19sm89988811wrb.52.2019.07.25.04.31.37
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 04:31:38 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45d1ebe4b2ed4c039c9da20a738652df@tpw09926dag18e.domain1.systemhost.net>
 <1564048432710.98755@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0ca427aa-5a18-785a-0152-bc9948c3970b@redhat.com>
Date: Thu, 25 Jul 2019 13:31:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564048432710.98755@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v4 05/15] hw/intc/armv7m_nic: Access
 MemoryRegion with MemOp
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, sagark@eecs.berkeley.edu,
 david@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 Alistair.Francis@wdc.com, edgar.iglesias@gmail.com, alex.williamson@redhat.com,
 arikalo@wavecomp.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 rth@twiddle.net, atar4qemu@gmail.com, ehabkost@redhat.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, stefanha@redhat.com,
 shorne@gmail.com, david@gibson.dropbear.id.au, qemu-riscv@nongnu.org,
 kbastian@mail.uni-paderborn.de, cohuck@redhat.com, laurent@vivier.eu,
 qemu-ppc@nongnu.org, amarkovic@wavecomp.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 11:53 AM, tony.nguyen@bt.com wrote:
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  hw/intc/armv7m_nvic.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 9f8f0d3..25bb88a 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -18,6 +18,7 @@
>  #include "hw/intc/armv7m_nvic.h"
>  #include "target/arm/cpu.h"
>  #include "exec/exec-all.h"
> +#include "exec/memop.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "trace.h"
> @@ -2345,7 +2346,8 @@ static MemTxResult nvic_sysreg_ns_write(void *opaque, hwaddr addr,
>      if (attrs.secure) {
>          /* S accesses to the alias act like NS accesses to the real region */
>          attrs.secure = 0;
> -        return memory_region_dispatch_write(mr, addr, value, size, attrs);
> +        return memory_region_dispatch_write(mr, addr, value, SIZE_MEMOP(size),
> +                                            attrs);
>      } else {
>          /* NS attrs are RAZ/WI for privileged, and BusFault for user */
>          if (attrs.user) {
> @@ -2364,7 +2366,8 @@ static MemTxResult nvic_sysreg_ns_read(void *opaque, hwaddr addr,
>      if (attrs.secure) {
>          /* S accesses to the alias act like NS accesses to the real region */
>          attrs.secure = 0;
> -        return memory_region_dispatch_read(mr, addr, data, size, attrs);
> +        return memory_region_dispatch_read(mr, addr, data, SIZE_MEMOP(size),
> +                                           attrs);
>      } else {
>          /* NS attrs are RAZ/WI for privileged, and BusFault for user */
>          if (attrs.user) {
> @@ -2390,7 +2393,8 @@ static MemTxResult nvic_systick_write(void *opaque, hwaddr addr,
> 
>      /* Direct the access to the correct systick */
>      mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
> -    return memory_region_dispatch_write(mr, addr, value, size, attrs);
> +    return memory_region_dispatch_write(mr, addr, value, SIZE_MEMOP(size),
> +                                        attrs);
>  }
> 
>  static MemTxResult nvic_systick_read(void *opaque, hwaddr addr,
> @@ -2402,7 +2406,7 @@ static MemTxResult nvic_systick_read(void *opaque, hwaddr addr,
> 
>      /* Direct the access to the correct systick */
>      mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
> -    return memory_region_dispatch_read(mr, addr, data, size, attrs);
> +    return memory_region_dispatch_read(mr, addr, data, SIZE_MEMOP(size), attrs);
>  }
> 
>  static const MemoryRegionOps nvic_systick_ops = {
> --
> 1.8.3.1
> 
> 
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

