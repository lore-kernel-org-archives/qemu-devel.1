Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E1CC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 10:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE922068E
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 10:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4w5Dkxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE922068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTj2p-0006Di-FQ
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 06:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTj0x-0004vH-SX; Sat, 17 Oct 2020 06:00:39 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTj0w-0002ED-43; Sat, 17 Oct 2020 06:00:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id x7so6190640wrl.3;
 Sat, 17 Oct 2020 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yZ2p0awb4xdvIgsWalJxmwnxws+DJkEPDtd/7wvDzYo=;
 b=l4w5DkxziZuee4NTfbYvDyDbZDgU3sRG6cfMGArYCddMhzclzniZi9UilVbEUVZLdg
 LT9kOWk5GA6FfE6Xg87Q84y4LsZ0H/3xOfeyaSUINaXLQ3+TOQnsY0geEBPPvMaPf/9u
 bS9MWwHQZ/l82yBFS41z/je0HsxRI1QFrPYKMLhYb3srGsJ0qID4F574CWlPusdlMWsb
 OV3WKs4iM/4LpsZYXB4UmYeFuCPg+6OoEeMHjrBPv5SGtfo7wUP2uVQ2D56XzfMMTzM3
 VohYRm+fPdaaBMjs4vu1CuuUiNXrFYXGBZ2ihzjJ6TQJUan9O3tAunquKe9oocQvsT2n
 DPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yZ2p0awb4xdvIgsWalJxmwnxws+DJkEPDtd/7wvDzYo=;
 b=bs6PUfS3KpIgrtvEOLCSoK46MHmQkCfA2H1JS4OhthtDtg8eSiy3ygxOw7qG2wSXVb
 2/DZibr8NA0EJEa5RAivxHeZQiDnuFNWCyhGcEZYyaJyzj7xQZeGQEXnjJgxcI1w8/7z
 3oDmCrevM11VU0R3lW2r8tfSI6GYhwZCb35M+vWVJ/wownHGSL8/0DgKa4iForQZsIbN
 BGr/8hhuyOUsMsU4IYDI9IJXO/NF1iKxsKwe7pYC4NTZL0FoWlyKotxI3jL8CPuuRgu5
 Nf+IwCtHxJm9arrq7BtGQAbetpZA45ZXW9/pEreFv3+2dMciHNJN29CVv5McpbQfBFYq
 cvBA==
X-Gm-Message-State: AOAM5314BgIK+tuKeqKw/NYQSSzMWMDQxmd1EuX6fsOZVTydgSiv5nyx
 7Q5MlB9itTTNOf3WYLH2H+xTZMiZ6Rc=
X-Google-Smtp-Source: ABdhPJxZfyZAIVB2Q2/TsdTvKwoMIVbAIf2yUbqSRwZNmyMXPEBO9z4NjYx5tOPmE8AERViNus8uDw==
X-Received: by 2002:a05:6000:10c6:: with SMTP id
 b6mr9616946wrx.10.1602928835270; 
 Sat, 17 Oct 2020 03:00:35 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id y185sm5996103wmb.29.2020.10.17.03.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 03:00:34 -0700 (PDT)
Subject: Re: [PATCH v3 08/15] hw/misc/bcm2835_cprman: add a PLL channel
 skeleton implementation
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20201010135759.437903-1-luc@lmichel.fr>
 <20201010135759.437903-9-luc@lmichel.fr>
 <e6e2341a-6ccc-b1cc-6e25-b3d57e1cae6d@amsat.org>
Message-ID: <ced8b284-1581-ecef-6b07-edee64ac3233@amsat.org>
Date: Sat, 17 Oct 2020 12:00:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <e6e2341a-6ccc-b1cc-6e25-b3d57e1cae6d@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/20 6:05 PM, Philippe Mathieu-Daudé wrote:
> On 10/10/20 3:57 PM, Luc Michel wrote:
>> PLLs are composed of multiple channels. Each channel outputs one clock
>> signal. They are modeled as one device taking the PLL generated clock as
>> input, and outputting a new clock.
>>
>> A channel shares the CM register with its parent PLL, and has its own
>> A2W_CTRL register. A write to the CM register will trigger an update of
>> the PLL and all its channels, while a write to an A2W_CTRL channel
>> register will update the required channel only.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Signed-off-by: Luc Michel <luc@lmichel.fr>
>> ---
>>   include/hw/misc/bcm2835_cprman.h           |  44 ++++++
>>   include/hw/misc/bcm2835_cprman_internals.h | 146 +++++++++++++++++++
>>   hw/misc/bcm2835_cprman.c                   | 155 +++++++++++++++++++--
>>   3 files changed, 337 insertions(+), 8 deletions(-)
[...]

>> +#define FILL_PLL_CHANNEL_INIT_INFO_common(pll_, channel_)            \
>> +    .parent = CPRMAN_ ## pll_,                                       \
>> +    .cm_offset = R_CM_ ## pll_,                                      \
>> +    .cm_load_mask = R_CM_ ## pll_ ## _ ## LOAD ## channel_ ## _MASK, \
>> +    .a2w_ctrl_offset = R_A2W_ ## pll_ ## _ ## channel_
>> +
>> +#define FILL_PLL_CHANNEL_INIT_INFO(pll_, channel_)                   \
>> +    FILL_PLL_CHANNEL_INIT_INFO_common(pll_, channel_),               \
>> +    .cm_hold_mask = R_CM_ ## pll_ ## _ ## HOLD ## channel_ ## _MASK, \
>> +    .fixed_divider = 1
>> +
>> +#define FILL_PLL_CHANNEL_INIT_INFO_nohold(pll_, channel_) \
>> +    FILL_PLL_CHANNEL_INIT_INFO_common(pll_, channel_),    \
>> +    .cm_hold_mask = 0
>> +
>> +static PLLChannelInitInfo PLL_CHANNEL_INIT_INFO[] = {
> 
> Hmm I missed this static definition in an header.
> As it is local and only include once, I'd prefer match the
> rest of the source tree style and name it .c.inc:
> 
> -- >8 --
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index 7e415a017c9..9d4c0ee6c73 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -48,7 +48,7 @@
>   #include "migration/vmstate.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/misc/bcm2835_cprman.h"
> -#include "hw/misc/bcm2835_cprman_internals.h"
> +#include "bcm2835_cprman_internals.c.inc"
>   #include "trace.h"
> 
>   /* PLL */
> diff --git a/include/hw/misc/bcm2835_cprman_internals.h 
> b/hw/misc/bcm2835_cprman_internals.c.inc
> similarity index 100%
> rename from include/hw/misc/bcm2835_cprman_internals.h
> rename to hw/misc/bcm2835_cprman_internals.c.inc
> ---

This can be applied directly by Peter, or can
be cleaned later. This is not a blocker to get
this series merged.

