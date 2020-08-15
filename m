Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807C8C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC5C23AA0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKcdzNq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC5C23AA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yrA-0001Tw-U8
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6ypn-0008RU-D3; Sat, 15 Aug 2020 12:15:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6ypl-0003Ba-WD; Sat, 15 Aug 2020 12:15:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so10929295wrw.1;
 Sat, 15 Aug 2020 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nSrc/lb9fkx3CNfm+ox5hrRtqhW1/GlYoh+C1KHuZYA=;
 b=AKcdzNq5HaZXLkcZYpCBtPQrKMtWcq7VMs35+4fu+28ojUJtOnkSSpWEc1SfMtjIXh
 x8NF553TYXqJ6hyEscbcBeJdQDNyvOanYh5UJhwGt8pwOdf/WqTUdZRT8WbhJVawkRTH
 wwj1fh03NdJ3wbcZKtomOsXW38ZmUsylgMRcbbwaULUX4t2b4yjUUI7wUjvjHRgwSpSE
 U+Lbe83bI1VlY7VoxEOmKrlEq/EvO3T/n1nHuTVYxnDZb7bDqVUsxWMXY0fNK6PIg6sW
 kPT1F9xnlj19qRULbpU4nAHAUra2ANkhSCEkHxDTWTSli4si/eF34a41SxIrUthWeHBv
 w3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nSrc/lb9fkx3CNfm+ox5hrRtqhW1/GlYoh+C1KHuZYA=;
 b=TrEicz/8KuIPpR+fGYmGb4296YT7mswCSQU14pQwR1W0titAGctW41ENztkzElxEIf
 DdTQBUPs0CBasjqCnXqT+/wmB2Sy6VijcRgsMupGtPkLWQRFdCNsCpcHsNrrxR1QKgEc
 VR8dv9ZUb/aqT+DpgRTkqvUYprdv8Aybyq9ATt4vZO4ch1//Pn4F6bpF/dwlbiz+2ToQ
 JgJMgggBl2OADqQRVOqJrZauv+PsusvzJEGOUe64IJ/Av1ZsMoLGVH0CwfOLwS6Sg/a4
 XDBBkiMX2TtfTBdBdSkIIzldHbVaSz+g7MFOuKGk8Wqu6BCFWg0kZGKGbqcVUzLEq/Il
 titw==
X-Gm-Message-State: AOAM533RJxhZjHEzX8eYQsXCTvAw0RS5b5+PHnk1JlefRIsj2B4uAtup
 FKdk1OgUxS72Scq/TjYrUXJZaCTkWE0=
X-Google-Smtp-Source: ABdhPJwF/U0O3qXjFbyal5jme90ZU0vTSSux9BYEgGksdFa3QUEmLTbb+wFj3JmG6ilxi+59FKRX5Q==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr5870342wrt.8.1597478332238;
 Sat, 15 Aug 2020 00:58:52 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id n11sm14558612wmi.15.2020.08.15.00.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2020 00:58:51 -0700 (PDT)
Subject: Re: [PATCH 07/18] hw/sd: sd: Fix incorrect populated function switch
 status data structure
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Sai Pavan Boddu <saipava@xilinx.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-8-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <565d9936-3eda-db2f-b390-05f675cf6644@amsat.org>
Date: Sat, 15 Aug 2020 09:58:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1597423256-14847-8-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Sai Pavan

On 8/14/20 6:40 PM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> At present the function switch status data structure bit [399:376]
> are wrongly pupulated. These 3 bytes encode function switch status
> for the 6 function groups, with 4 bits per group, starting from
> function group 6 at bit 399, then followed by function group 5 at
> bit 395, and so on.
> 
> However the codes mistakenly fills in the function group 1 status
> at bit 399. This fixes the code logic.
> 

Fixes: a1bb27b1e9 ("SD card emulation (initial implementation)")

> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
> 
>  hw/sd/sd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index fad9cf1..51f5900 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -806,11 +806,15 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
>      sd->data[11] = 0x43;
>      sd->data[12] = 0x80;	/* Supported group 1 functions */
>      sd->data[13] = 0x03;
> +
> +    sd->data[14] = 0;
> +    sd->data[15] = 0;
> +    sd->data[16] = 0;

Pointless zero initialization.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

I'll wait until next week in case Sai Pavan wants to test this
patch (I don't have access to the Xilinx images anymore) then
I'll queue this via my sd-next tree.

Regards,

Phil.

>      for (i = 0; i < 6; i ++) {
>          new_func = (arg >> (i * 4)) & 0x0f;
>          if (mode && new_func != 0x0f)
>              sd->function_group[i] = new_func;
> -        sd->data[14 + (i >> 1)] = new_func << ((i * 4) & 4);
> +        sd->data[16 - (i >> 1)] |= new_func << ((i % 2) * 4);
>      }
>      memset(&sd->data[17], 0, 47);
>      stw_be_p(sd->data + 64, sd_crc16(sd->data, 64));
> 


