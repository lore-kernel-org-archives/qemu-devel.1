Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE2EC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EDF248CB
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EDF248CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46061 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY287-0005J7-O6
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 01:37:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY25O-0003VE-Rf
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY25N-0005GM-S0
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:34:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hY25N-0005Fe-Mf
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:34:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so11304506wrs.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 22:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=8ekESd1gSGGAn0kKgbM4pOPIxcVvp29KJy0xVK4uy7E=;
	b=fIB6UdI9M6iyfn+HJ+gZljhkWgah6nyijE7TQKixbsDaKet/AGlmx9hRMk6FJJcbY/
	MW0e4ftn1KJCBEmpsmz9s4cDzi52uFnYnVvINYjnpjax8negtPs8VPhgXquLOQp3pMSL
	ZuqspyBzt/nJnXnRY+p4MUwDeRTfvCvUj+sRHfitdfKlWUBcm5oZadvH9HHWYmdnlDzU
	ViNmCWiImu9m37d7nzNfF/gRHnTcjJ542pHRltEuD8NlFtmnjqzaTYIh7yA0qqkYp377
	YiZgg5ndT3Gt9TtX/cU/zGp0n8YYZnoxyfFp83vtX5mEpPC6ayyLvaRthme3jD4/j6RX
	sLag==
X-Gm-Message-State: APjAAAXYxMwvSu47Zs189wbVMU7lQRin7Yxc2fusHbBh2ba8g/w/FE9w
	QXRwaT0r4N8HFPLfT/0RXm4pCw==
X-Google-Smtp-Source: APXvYqzzvB33XEDwQdXkfThTr+19yDli2Jclovjr3qtTnyasBBIj/NbK5xTEtRxkMgPL1COl9qDShw==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr17624871wrr.314.1559626452707;
	Mon, 03 Jun 2019 22:34:12 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	95sm34028325wrk.70.2019.06.03.22.34.11
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 22:34:12 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190531134315.4109-1-richard.henderson@linaro.org>
	<20190531134315.4109-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <199483f6-2ab5-5f10-011d-fd19154b2c29@redhat.com>
Date: Tue, 4 Jun 2019 07:34:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531134315.4109-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v16 15/23] hw/rx: Honor -accel qtest
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
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 3:43 PM, Richard Henderson wrote:
> Issue an error if no kernel, no bios, and not qtest'ing.
> Fixes make check-qtest-rx: test/qom-test.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/rx/rx62n.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
> index 3a8fe7b0bf..e55257c622 100644
> --- a/hw/rx/rx62n.c
> +++ b/hw/rx/rx62n.c
> @@ -21,11 +21,13 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qemu/error-report.h"
>  #include "hw/hw.h"
>  #include "hw/rx/rx62n.h"
>  #include "hw/loader.h"
>  #include "hw/sysbus.h"
>  #include "sysemu/sysemu.h"
> +#include "sysemu/qtest.h"
>  #include "cpu.h"
>  
>  /*
> @@ -190,8 +192,14 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
>      memory_region_init_rom(&s->c_flash, NULL, "codeflash",
>                             RX62N_CFLASH_SIZE, errp);
>      memory_region_add_subregion(s->sysmem, RX62N_CFLASH_BASE, &s->c_flash);
> +
>      if (!s->kernel) {
> -        rom_add_file_fixed(bios_name, RX62N_CFLASH_BASE, 0);
> +        if (bios_name) {
> +            rom_add_file_fixed(bios_name, RX62N_CFLASH_BASE, 0);
> +        }  else if (!qtest_enabled()) {
> +            error_report("No bios or kernel specified");
> +            exit(1);
> +        }
>      }
>  
>      object_initialize_child(OBJECT(s), "cpu", &s->cpu,
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

