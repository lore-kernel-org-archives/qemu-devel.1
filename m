Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BFFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 18:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FBE2053B
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 18:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYB8aPS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FBE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ja1yP-0004KY-AI
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 14:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ja1wq-0003oc-Pl
 for qemu-devel@nongnu.org; Sat, 16 May 2020 14:54:12 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ja1wq-0000NY-0c
 for qemu-devel@nongnu.org; Sat, 16 May 2020 14:54:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id z4so4213168wmi.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 11:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wK7trHBvtNiVe+NLUbMBHcG1A0mPIrLMyviQ20TRLzI=;
 b=CYB8aPS4c+f3QM6Vf8fQRkH2mc1S3FUIbkMhycCjqQO+BwKCTWllo0YDZKcJxH4fPE
 MXZADkrC+xw5BScUzcxj/8NW8Ef4wmFzCXkg+Sc+1tZ4gOsvDnS15XKYp2I57/Y6/fMF
 vfIUvnwotzpC8GplnTpmXsS/E0mKTTVdKjigY+/iQ0O1nTAqqqz4pl8Yim9sdW6wRPo2
 OEmhYfYFiIk1heVsGXphPlonSagdsHsJcCAhgqaI9A4LcHuer6H6CkOap8L01rPSYdh0
 3F5HvzfIPzLnMmL+L+yOmGY4VcX5WrHmBAjX6iJ6cuTgOa3drvS0ElEI//pLr1RENrUC
 7XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wK7trHBvtNiVe+NLUbMBHcG1A0mPIrLMyviQ20TRLzI=;
 b=pSI3EuQvwIrwEKTbAPP6pd/S/bHoC5L9PqiUDLE8jDQMGCQVXrrE9SQRWiUgtOezhz
 +Jd8KSw1dW+GGzlNOQn6TAQusnRULRtfbayPAv7aYuO4lV6eTluhvgPpI2sb6pmFo2GX
 1W7pQWsPKX0EjR2nwD5MRaZTG5tdKZ6lP0MoWmpLYEQLaOLifYuVvAOTHxmKMf9mNbbS
 XmsgO6DZpmPITYspU8IcAlE9le28BZfQUSTQikp6j0dUXpIGClky/gjf3ZyJ7gM0rp3G
 1NCNJ/FMLf7ASO61uAC6imUGZ+/NF5s+n9An88Pd6Rx+HryNc6zU2KenhldouqmYWvFM
 S2nA==
X-Gm-Message-State: AOAM532/5Z4GYRIdY0s099ppvPJFDTQF6c2QQAQwoLG0RnE3EFXSUmrv
 1sRATU9oQDBhS31ENkBAImE=
X-Google-Smtp-Source: ABdhPJyJA+MzWZcGOfLTBDMsXgRymgbu0VyGspmGB/cR13qnwRbWply1zPDKoE7cxMNC20/+l+X3Bg==
X-Received: by 2002:a1c:25c3:: with SMTP id
 l186mr10539431wml.103.1589655249732; 
 Sat, 16 May 2020 11:54:09 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m65sm9000995wmm.17.2020.05.16.11.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2020 11:54:08 -0700 (PDT)
Subject: Re: [PATCH v3 17/18] hw/mips: Add some logging for bad register
 offset cases
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
 <20200516174548.7631-18-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5f91b139-7749-f2cf-2135-93850204c651@amsat.org>
Date: Sat, 16 May 2020 20:54:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200516174548.7631-18-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@rt-rk.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/16/20 7:45 PM, Aleksandar Markovic wrote:
> Log the cases where a guest attempts read or write using bad
> register offset.
> 
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> CC: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/mips/mips_malta.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index e4c4de1b4e..88869b828e 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -427,10 +427,9 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr addr,
>           break;
>   
>       default:
> -#if 0
> -        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "\n",
> -               addr);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "malta_fpga_read: Bad register offset 0x"
> +                      TARGET_FMT_lx "\n", addr);
>           break;
>       }
>       return val;
> @@ -515,10 +514,9 @@ static void malta_fpga_write(void *opaque, hwaddr addr,
>           break;
>   
>       default:
> -#if 0
> -        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx "\n",
> -               addr);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "malta_fpga_write: Bad register offset 0x"
> +                      TARGET_FMT_lx "\n", addr);
>           break;
>       }
>   }
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

