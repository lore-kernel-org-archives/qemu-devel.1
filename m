Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2D9C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044DF208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044DF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41877 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIb5K-0001bQ-Vj
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIaeu-0002km-Lw
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIaes-0004dQ-Qc
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:47:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIaes-0004ca-Hx
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:47:18 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABED4C034E71
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 15:47:15 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id l12so2938311wrm.6
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 08:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W84v35mLOg0JGBptKr1AmpPQK9RVN2nFNy+aZylg2Y8=;
 b=Gx4xOftptC/ubxTXj/b0E4JbXSYJyqzWGNpflJCTDWvRliY4JAmji9hM5KPyksOhEy
 zecVwKrRQrIb9hW5S7X4hbAXp9HSDKFfTYkz2HMcqka/5l7+kJ/npRBjxkLRvhYjL/FN
 2mV4UGz72Ah9giVm94DXy/VdZmbnZwipc2YaylIbzxQCK0I4+Vlql+bOszOgYXI4aHLF
 kK0Wlg6qo4ZBp2mmFQ4jhXUwrCg3f06fcynKh6Z5gKpGpFRSmGUoAX5RUxPXpvy7F4gq
 hVqCgNsK0b0gnlILzuzhBdukBN6ld/EmvFuo85khMAB9JezxYTPxdEKXO78E8wNvZiEB
 qZ+Q==
X-Gm-Message-State: APjAAAWD5YQZ8LO3rH8W7vP0eKY99JT1he2vRywscqavXQFsXCpKbPYs
 k7R9E4opbRt5febPaj1s/mGmzjeeDvcXOfe7zMwcuqYtO/6sGG6zxdcPIVvqEjP1b5N6706zaem
 8v1pPzY5i0qEsnxo=
X-Received: by 2002:a5d:67c5:: with SMTP id n5mr4679447wrw.72.1570722434482;
 Thu, 10 Oct 2019 08:47:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqya0uy32gEXJp989rqoyjdDBcMDQlO6+HyrduW7YTFwFNYWmBJYKV1Qkq/DTmlbdHXU8Gy9eg==
X-Received: by 2002:a5d:67c5:: with SMTP id n5mr4679427wrw.72.1570722434273;
 Thu, 10 Oct 2019 08:47:14 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id z4sm5665583wrh.93.2019.10.10.08.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 08:47:13 -0700 (PDT)
Subject: Re: [PATCH v8 04/15] hw/i386/pc: replace use of strtol with
 qemu_strtol in x86_load_linux()
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191010143125.67246-1-slp@redhat.com>
 <20191010143125.67246-5-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f147fefc-1bec-2ac1-b5d6-35bcfdddf2fc@redhat.com>
Date: Thu, 10 Oct 2019 17:47:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191010143125.67246-5-slp@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sergio,

On 10/10/19 4:31 PM, Sergio Lopez wrote:
> Follow checkpatch.pl recommendation and replace the use of strtol with
> qemu_strtol in x86_load_linux().
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>   hw/i386/pc.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 77e86bfc3d..e6bcc3ff42 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -68,6 +68,7 @@
>   #include "qemu/config-file.h"
>   #include "qemu/error-report.h"
>   #include "qemu/option.h"
> +#include "qemu/cutils.h"
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/cpu_hotplug.h"
>   #include "hw/boards.h"
> @@ -1201,7 +1202,8 @@ static void x86_load_linux(PCMachineState *pcms,
>       /* handle vga= parameter */
>       vmode = strstr(kernel_cmdline, "vga=");
>       if (vmode) {
> -        unsigned int video_mode;
> +        long video_mode;

Why do you change 'video_mode' to a signed type?

> +        int ret;
>           /* skip "vga=" */
>           vmode += 4;
>           if (!strncmp(vmode, "normal", 6)) {
> @@ -1211,7 +1213,12 @@ static void x86_load_linux(PCMachineState *pcms,
>           } else if (!strncmp(vmode, "ask", 3)) {
>               video_mode = 0xfffd;
>           } else {
> -            video_mode = strtol(vmode, NULL, 0);
> +            ret = qemu_strtol(vmode, NULL, 0, &video_mode);
> +            if (ret != 0) {
> +                fprintf(stderr, "qemu: can't parse 'vga' parameter: %s\n",
> +                        strerror(-ret));
> +                exit(1);
> +            }
>           }
>           stw_p(header + 0x1fa, video_mode);
>       }
> 

