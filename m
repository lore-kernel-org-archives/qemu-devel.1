Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F08C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 18:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB492074D
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 18:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHNuvpsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB492074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkAcz-0006s4-Hr
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 14:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkAcM-0006LP-Sl; Sat, 13 Jun 2020 14:10:58 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33597)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkAcL-0008O3-CU; Sat, 13 Jun 2020 14:10:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id j198so11183717wmj.0;
 Sat, 13 Jun 2020 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DjLAMFy+eRk47po0i454/vfP2IQoANHkVG+WhwLttkA=;
 b=PHNuvpsB/7awstx5MqUcuXUyUkes2C6Hr1yt2mHLgVc2dfs7mC35ePmKKT9gW5FAkT
 vZcdoydMRHStbADygOXmKQGGwaFI6Dxvc46KtpcWO1EwSqYdvENwts9o+HlisDYmNVKq
 q3T4K+nFHHxVxUObOZQufJ4JyKb8DL2oMyfET14FFANzcJ0aZL12jKQQwibmoO56ILMZ
 oCSV5LMEu/G/vrWgZd4bImnt+6Lik1Y3pG9KtmqCbrKbQBhb3lUZ1gC0PTUoSMHmpD4w
 FLxsiN5sfeP93+vCCw1wEQ6WGqaKmxS7C28UdVsYVtMb9NOcG36PCeIXM6qn7RC2vRes
 SwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DjLAMFy+eRk47po0i454/vfP2IQoANHkVG+WhwLttkA=;
 b=iQNZ8GO0xWzhUy2t0hQ+70T3vdqrZzCv/dzwJQY2xnAwVBcj9R+T5QnPnH2VRgHNZe
 1UbyySbgTTt/o258vSFmbVcuDQFI1SSDWPKyQXZN7MXtGddc8qBFc8EzJNvIXhQjjOo3
 F6XsmIpjabZLGab+g8lnWIaZwulENy31csRcoMKPS6eAyKgI8rX+sImt3sR95qbiwvFG
 ZMNapJs3+78MVvAYfu0QOM7yPIqD3v3CC9Zdv03YL6MrBK6gt9jbBuJRAVf8bH3gyJsW
 upXIHELCR0AXSdfPLvng45+c4Hz8vHbNwG1gQ4ydn0SLTMmEmZShhIb/D7+ipS7TUpcR
 k1PA==
X-Gm-Message-State: AOAM530Qft17gxz7/5tmR16BdWA8onRpXNVJcB+8yEvK2iQlWlbzHTiC
 K1hzRFnVhCyiR5IJ3gTJhBU=
X-Google-Smtp-Source: ABdhPJxwifFCH9dyeGs7qhqb1dA2d8pjKLHdT71Qjuuqq+1iMDf7WSw0t52iKAI/lRBW1bmlFKhQbw==
X-Received: by 2002:a1c:814c:: with SMTP id c73mr4711782wmd.140.1592071845459; 
 Sat, 13 Jun 2020 11:10:45 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id k21sm16559489wrd.24.2020.06.13.11.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Jun 2020 11:10:44 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] mac_oldworld: Rename ppc_heathrow_reset reset to
 ppc_heathrow_cpu_reset
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1592055375.git.balaton@eik.bme.hu>
 <dc05efa9c54fb4cafdcea70c396c0790bf99c849.1592055375.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a1c1b1ad-c117-6341-2678-f9bf5cc6c298@amsat.org>
Date: Sat, 13 Jun 2020 20:10:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <dc05efa9c54fb4cafdcea70c396c0790bf99c849.1592055375.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/13/20 3:36 PM, BALATON Zoltan wrote:
> This function resets a CPU not the whole machine so reflect that in
> its name.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ppc/mac_oldworld.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 4dd872c1a3..9138752ccb 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -73,7 +73,7 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>      return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
>  }
>  
> -static void ppc_heathrow_reset(void *opaque)
> +static void ppc_heathrow_cpu_reset(void *opaque)
>  {
>      PowerPCCPU *cpu = opaque;
>  
> @@ -127,7 +127,7 @@ static void ppc_heathrow_init(MachineState *machine)
>  
>          /* Set time-base frequency to 16.6 Mhz */
>          cpu_ppc_tb_init(env,  TBFREQ);
> -        qemu_register_reset(ppc_heathrow_reset, cpu);
> +        qemu_register_reset(ppc_heathrow_cpu_reset, cpu);
>      }
>  
>      /* allocate RAM */
> 


