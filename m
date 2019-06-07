Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104D5C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8A620840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8A620840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51244 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFAJ-00016x-6Q
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40636)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZF78-0006jO-88
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZF77-0006Dh-6W
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:41:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZF75-00065d-Bw
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:41:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id f10so2146570wmb.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jFklL2F7wjhT84Oyot0hKw3PudVVsZ/uVvh9m/H4EFA=;
 b=Kvks6/y9KaxPXYEqB5sFDXouEmP6ixhtq2h/3MvZMHcTwSDNrysfNECYsnhUjo1Deu
 6dti++/0UnTW9J+nLspQgjpN+WG9IBRLS/dMpJIz+Ct38Rc5YTKE4iZ5XewrI2FdEsQ4
 pMIU0LhXgAqV72NfutZscYZ/ngzCLus3zfL/qs5oSwVfbD96GTW+PQdFypkyxUdeWlb2
 oi8P+gtasRBO+aDOpc63tMUKzyyg4nt4h1Ia0kFnmRvJ5NTt8/8dzaNMlcDDI35GfjUa
 7FwEVArEZhTLor4NxZ3E0Z+t99dHYwnr6ynm2uTz4XZaSrKtTpoksIsD9xHnpricedfd
 3Pbw==
X-Gm-Message-State: APjAAAWvh71yZ36UBIQN9O5xCWfDGI8dmsUNPiltKmACfaZqyIeGIsu7
 iMrwf3oLyFSgX3yaNxcoZb6HOw==
X-Google-Smtp-Source: APXvYqxKXCWzd8/a0Cd5TT2C4GUf8jm4ncRaamrmin3/bffqN/kPSDt4O/6IlnWfizbnOf2U1ffp5w==
X-Received: by 2002:a1c:2358:: with SMTP id j85mr3877489wmj.46.1559914858301; 
 Fri, 07 Jun 2019 06:40:58 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id j3sm2069966wrt.73.2019.06.07.06.40.57
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 06:40:57 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190607091116.49044-1-ysato@users.sourceforge.jp>
 <20190607091116.49044-16-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <52b99176-faf0-b72d-4514-02e600ec1124@redhat.com>
Date: Fri, 7 Jun 2019 15:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607091116.49044-16-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v17 15/24] hw/rx: Honor -accel qtest
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 11:11 AM, Yoshinori Sato wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Issue an error if no kernel, no bios, and not qtest'ing.
> Fixes make check-qtest-rx: test/qom-test.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Again:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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

