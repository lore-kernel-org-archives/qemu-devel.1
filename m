Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE34C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41C921852
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41C921852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqy7D-00031b-Vm
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 07:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57130)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqy71-0002Rb-24
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqy6z-0001Vc-3U
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:10:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqy6u-0001FW-Lp
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:10:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so53971442wre.12
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 04:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ounZOwkyFGqC14lRdJqbAGk6COTUDq2tI4pk26+DExo=;
 b=uh6hOxhYzrKWzuT9F47vX0xVAkG1oEK0CXT3HXJUoJyG8hJ6EFg+L/jRVzoN2RPEcm
 AEo6n03YMpfBoj5Tl6OGL0fMxM/6Va52h4ffcLeUCWNvBzI1pUE02q3XjCouGskLLKsB
 njUSy1SsHyUCm4tNerSwL8V4/9xBwjn21C4EVUOwsbJRjIJQ7mczdeRqkJtkaIvO7urs
 T9nFEll4p62ZpjTw3pTyaoClqrEs3fRudMZ5UF6pur3+0qwaWfK/YHlt1jWuo9zywdfe
 LHFaFUWK0E6r0eSsfSPMq0QPW6Kyqs+biCi1UqUd1nqJkUYCzeQ2csabMw5bTIvZLZ1H
 ntLw==
X-Gm-Message-State: APjAAAWi/rYbJUONYL9tmuwr4wby3O4oREKK3CGF63Y8kNv5+maQ9gQC
 7URX+b/g6YbP3Jsj4/b3j2TPdQ==
X-Google-Smtp-Source: APXvYqz5QgIVgtZ5c0C0aNd7tleBhWhsamtAOyT4Vw6nZtICbzR1RiUyH89oL5jHkdAiOuWzsQvudg==
X-Received: by 2002:adf:ed8a:: with SMTP id c10mr104400859wro.33.1564139385344; 
 Fri, 26 Jul 2019 04:09:45 -0700 (PDT)
Received: from [192.168.50.36] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id 4sm120347700wro.78.2019.07.26.04.09.44
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 04:09:44 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190722151804.25467-1-peter.maydell@linaro.org>
 <20190722151804.25467-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4f431fd5-bd06-c784-4cd8-fd53d8ee9aca@redhat.com>
Date: Fri, 26 Jul 2019 13:09:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190722151804.25467-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH for-4.1? 1/2] hw/arm/boot: Rename elf_{low,
 high}_addr to image_{low, high}_addr
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/19 5:18 PM, Peter Maydell wrote:
> Rename the elf_low_addr and elf_high_addr variables to image_low_addr
> and image_high_addr -- in the next commit we will extend them to
> be set for other kinds of image file and not just ELF files.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/boot.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 1fb24fbef27..b7b31753aca 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -986,7 +986,9 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
>      int kernel_size;
>      int initrd_size;
>      int is_linux = 0;
> -    uint64_t elf_entry, elf_low_addr, elf_high_addr;
> +    uint64_t elf_entry;
> +    /* Addresses of first byte used and first byte not used by the image */
> +    uint64_t image_low_addr, image_high_addr;
>      int elf_machine;
>      hwaddr entry;
>      static const ARMInsnFixup *primary_loader;
> @@ -1014,24 +1016,24 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
>          info->nb_cpus = 1;
>  
>      /* Assume that raw images are linux kernels, and ELF images are not.  */
> -    kernel_size = arm_load_elf(info, &elf_entry, &elf_low_addr,
> -                               &elf_high_addr, elf_machine, as);
> +    kernel_size = arm_load_elf(info, &elf_entry, &image_low_addr,
> +                               &image_high_addr, elf_machine, as);
>      if (kernel_size > 0 && have_dtb(info)) {
>          /*
>           * If there is still some room left at the base of RAM, try and put
>           * the DTB there like we do for images loaded with -bios or -pflash.
>           */
> -        if (elf_low_addr > info->loader_start
> -            || elf_high_addr < info->loader_start) {
> +        if (image_low_addr > info->loader_start
> +            || image_high_addr < info->loader_start) {
>              /*
> -             * Set elf_low_addr as address limit for arm_load_dtb if it may be
> +             * Set image_low_addr as address limit for arm_load_dtb if it may be
>               * pointing into RAM, otherwise pass '0' (no limit)
>               */
> -            if (elf_low_addr < info->loader_start) {
> -                elf_low_addr = 0;
> +            if (image_low_addr < info->loader_start) {
> +                image_low_addr = 0;
>              }
>              info->dtb_start = info->loader_start;
> -            info->dtb_limit = elf_low_addr;
> +            info->dtb_limit = image_low_addr;
>          }
>      }
>      entry = elf_entry;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

