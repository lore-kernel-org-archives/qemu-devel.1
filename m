Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C255AC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D4E20936
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W22L3lEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D4E20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFkXb-00034g-8O
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFkWv-0002at-8M
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:47:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFkWt-0001o8-IQ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:47:52 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so624614wrt.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1gERhPhGqBPCUdRLAW3FwfZ+0ecfLiCKlFhp+EpnWak=;
 b=W22L3lEAZfPwDog1IH/1Z26iMrmC0rjJKoMr1SfK4dlFs3rFz9ZQ/BKOZ0oiWfS4HN
 uQmXq7v2SC8lCbbizLLp748J0yqMHVUzdx/yJpWw3u/KUQUGKNE+F2bD4gorRvfPBZbt
 3sU6+1BDFZ8qrzgX/K2OfWp2ifBZ8+hXd7wz/rDJ/PqUK5XkmCwEBi+w0BFtVeEJiswl
 KGNOHibsZyB7Xmfq/o8n4ECUA0KFP1uHIkHopfE5zO4vkJe9BKIjtMvhAHaPbFUQyd4S
 Vwa1ifdooMrq9ptxd5re+KEf+A1uoR89j2Qku24WVI9gqVG+psEA73XEN0ItN8B9glEU
 goZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1gERhPhGqBPCUdRLAW3FwfZ+0ecfLiCKlFhp+EpnWak=;
 b=cPCHHuYIwEReEw4TbpOZvZUwQoMyA3D4hPTLyMpskXbPNjwheBOBaVZxXAwJvKodge
 /paMYfAIc72HF0EqwGzT2AaIPowbgBXmlu88iAm3sazUAv+OAtbvmTNyCmKJOKHdGGcT
 B8QJmo2HIW1MEb+K8iAS+iUd4ChW09ceViHWNrez37lNSr/Syj0aeItgvmNwK3gmPigN
 4KlfsfDQ5DAEGF+sEpe3h38YUCqvQSRgQoQQXvGS8MnI83WbFckQPtVcwaIWeY+NrFEg
 h7NUgutD8QUqLukHm5gYF/aDZWSiK6XH1nirKkZrA3+zyg/vXmI+QFwWgbLRhQ3h+lSV
 FAnQ==
X-Gm-Message-State: AOAM533OwutLneT1RdnhkwOReJkpYeunwFn4JAffV4ZR2UVA7p30z7yi
 w+4DDnLxdaB7fqQoFrFNH9ayInLIH2s=
X-Google-Smtp-Source: ABdhPJzV2Ahnp6uikPd0JkC5z2Cb9uu/cDPfaiLPwi+Le5oDFTapeAVZ4MBeXWgjNB3mcLsgkeKrbg==
X-Received: by 2002:a5d:4a0e:: with SMTP id m14mr300939wrq.313.1599598069639; 
 Tue, 08 Sep 2020 13:47:49 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i1sm977064wrc.49.2020.09.08.13.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 13:47:48 -0700 (PDT)
Subject: Re: [PATCH 03/20] hw/rx: Firmware and kernel loader.
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
 <20200827123859.81793-4-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0902b5b5-af5d-5740-8525-3733d62b65c7@amsat.org>
Date: Tue, 8 Sep 2020 22:47:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827123859.81793-4-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.626,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 2:38 PM, Yoshinori Sato wrote:
> Suppoerted format.

Typo "Supported".

(Also, QEMU commits avoid to have a trailing dot '.'
 in their subject).

> ELF, HEX, SREC and Raw firmware.
> fit and Raw kernel image.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/rx/loader.h |  35 ++++++++
>  hw/rx/loader.c         | 182 +++++++++++++++++++++++++++++++++++++++++
>  hw/rx/Kconfig          |   1 +
>  hw/rx/meson.build      |   1 +
>  4 files changed, 219 insertions(+)
>  create mode 100644 include/hw/rx/loader.h
>  create mode 100644 hw/rx/loader.c
> 
> diff --git a/include/hw/rx/loader.h b/include/hw/rx/loader.h
> new file mode 100644
> index 0000000000..71f3bd2bb3
> --- /dev/null
> +++ b/include/hw/rx/loader.h
> @@ -0,0 +1,35 @@
> +/*
> + * RX QEMU frimware loader
> + *
> + * Copyright (c) 2020 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +
> +typedef struct {
> +    hwaddr ram_start;
> +    size_t ram_size;
> +    hwaddr entry;
> +    hwaddr kernel_entry;
> +    hwaddr dtb_address;
> +    const char *filename;
> +    const char *dtbname;
> +    const char *cmdline;
> +} rx_kernel_info_t;
> +
> +bool load_bios(const char *filename, int rom_size, Error **errp);
> +
> +bool load_kernel(rx_kernel_info_t *info);
> diff --git a/hw/rx/loader.c b/hw/rx/loader.c
> new file mode 100644
> index 0000000000..c262f3ef86
> --- /dev/null
> +++ b/hw/rx/loader.c
> @@ -0,0 +1,182 @@
> +/*
> + * RX QEMU frimware loader

Typo "firmware".

[...]

