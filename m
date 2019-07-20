Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6396C76188
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 09:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15BF020873
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 09:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BF020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1holhL-0005QB-3c
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 05:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59302)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1holh7-0004xv-AO
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 05:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1holh6-0006fB-4E
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 05:30:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1holh5-0006eR-Qj
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 05:30:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so34484290wrr.5
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 02:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/PlwPHmHaXWHUpB0JH2FAx8GXcjrJ+3fCU2qOm3ElOM=;
 b=ZjbIjpWBzp0VYSmZnWL4N+8DLUBm70N0NkgEX3jbNo+tCiwFYu0CEaupdTcH/K6epp
 AAStjkq8U9UpyX2JzRwRqTeFuAmiaNjsff4I/ZwzzTx/9TZRZUAJVVzN0xO8neWUlnWV
 IHdFbjyKJqvMhz3B50aURNo6NQVTPwKDRkcl0yShLPCyV2xi88+gby33UOUUdso5I1C6
 70krfhJg3ulYlcX7lAnx0gWF63RsYX9RM4vKHYITZC3NX33n+lUjDNneZcwvamK2x53y
 75E/cOlpQLN+zekKD2bxmeNHyTGaeUIsjU4M/ybkUCFYjnbP1DGxh3qsWDXPvKPk5ODU
 p5Nw==
X-Gm-Message-State: APjAAAW/SB5D9Y8kQVrz5UlLEacDhb2H9uN29bG2v+pPRZfXfZtZ0xt/
 DlKN2WDFxLd/wrud746fCxSN2Q==
X-Google-Smtp-Source: APXvYqwlVWaLRbPEVXbSovopTGQrZ8pN9fkX8sDhi+M0Q6kkUvw9sBVvkf5kWBbJSqij8eHBzucFuQ==
X-Received: by 2002:a5d:4e06:: with SMTP id p6mr18510203wrt.336.1563615018811; 
 Sat, 20 Jul 2019 02:30:18 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id g11sm32617628wru.24.2019.07.20.02.30.17
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 Jul 2019 02:30:18 -0700 (PDT)
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <edd3c94d357207e3862d1f5fec7e7346e70831f4.1563559494.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <550d4158-d7dd-c38b-3082-302184a20883@redhat.com>
Date: Sat, 20 Jul 2019 11:30:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <edd3c94d357207e3862d1f5fec7e7346e70831f4.1563559494.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v1 1/1] riscv/boot: Fixup the RISC-V
 firmware warning
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
Cc: alistair23@gmail.com, palmer@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/19/19 8:05 PM, Alistair Francis wrote:
> Fix a typo in the warning message displayed to users, don't print the
> message when running inside qtest and don't mention a specific QEMU
> version for the deprecation.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/boot.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 5dee63011b..4b32ab1d26 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -26,6 +26,7 @@
>  #include "hw/riscv/boot.h"
>  #include "hw/boards.h"
>  #include "elf.h"
> +#include "sysemu/qtest.h"
>  
>  #if defined(TARGET_RISCV32)
>  # define KERNEL_BOOT_ADDRESS 0x80400000
> @@ -46,10 +47,13 @@ void riscv_find_and_load_firmware(MachineState *machine,
>           * In the future this defaul will change to loading the prebuilt
>           * OpenSBI firmware. Let's warn the user and then continue.
>          */
> -        warn_report("No -bios option specified. Not loading a firmware.");
> -        warn_report("This default will change in QEMU 4.3. Please use the " \
> -                    "-bios option to aviod breakages when this happens.");
> -        warn_report("See QEMU's deprecation documentation for details");
> +        if (!qtest_enabled()) {
> +            warn_report("No -bios option specified. Not loading a firmware.");
> +            warn_report("This default will change in a future QEMU release. " \
> +                        "Please use the -bios option to avoid breakages when "\
> +                        "this happens.");
> +            warn_report("See QEMU's deprecation documentation for details");

Maybe a final '.' in the last warning to be consistent with the previous
lines?

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        }
>          return;
>      }
>  
> 

