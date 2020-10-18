Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129E9C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 07:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0EA208FE
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 07:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L001zw+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0EA208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kU2uF-0006Wd-Ct
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 03:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kU2rv-0004k2-9s; Sun, 18 Oct 2020 03:12:39 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kU2rt-0002Rp-0M; Sun, 18 Oct 2020 03:12:38 -0400
Received: by mail-wm1-x341.google.com with SMTP id d81so7292471wmc.1;
 Sun, 18 Oct 2020 00:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w9qnloaXTehjWE2xDJPN4CV/ksoPZ3IpNUDI4lR96tU=;
 b=L001zw+dbB+Vag/bYliDLeCikm3wXEh9YeT0+sL2UVhA2dZaRRwHNdjcAcipf+q0BC
 pbi6LZDAtb/zp3QTm/yI28+bX1Oyt1+iJM8oAOIlprss7RcBngDOwCusUsOVao85TEuB
 353EwvcdbBUZZm/8i20GYJXPCmSDI6t119K3xjbW0YkY4TeekLju3WSfDthpYey0DmjP
 r4j2KKulT938Pz4ID2ol6ToYSXI1lwyJs/tnOg/TetpoH1Iue9TZx/8Q9fNBTjat0nKf
 hqOuq+RuSrkVPK5dBOoO0CScQZtyiOa/f87Yz/ypk9znOSSPzWvunTpxkVhV/0y1lFtm
 3kLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w9qnloaXTehjWE2xDJPN4CV/ksoPZ3IpNUDI4lR96tU=;
 b=XK7pC6rfujChNaxhU+jN8wt4DYQ2V5/nI1gSeNP132h6K8XA3PzRb+C7YUfvYxiRR7
 AnkrWx5Dh4ORiD7lOIAhjbHeUZQRrgnPr63qtFnnfrQtUDgdVESIGmESddHNxUEWanCX
 +YHNpfo62MeapMNnkMquzFJ1kKvSwYN1SVkQbpMDc3toa0AmjWsblaZS/uurb4OaSDi3
 K7k+MubQiuqVnNydr+HLEbFHSNvBq4dborEwC3c1ccHqmQ+z6YBDH0bEOoNry+ENFaop
 H/42S4OaDCFwIq6MU18eNpj34JL292LYTC1bivQGGzEE8AhdAaObT+n8/syzqDHHFYCF
 Q2Yw==
X-Gm-Message-State: AOAM530QtDC9sN+kpDvVOgSRC2EWjo7wiS5yKFKqC1FIRAUtBVBqA5Ec
 jj90cSXfXY680+QzlmfG2ec=
X-Google-Smtp-Source: ABdhPJxVjEoLLb3KpkaRp+oJfCYwRo9teskVOUlvh/JkQMCUAe0M/WDJuDRWUBc3GWwj49BcdpoQ6w==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr12389826wmb.129.1603005154685; 
 Sun, 18 Oct 2020 00:12:34 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id q6sm11128339wma.0.2020.10.18.00.12.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2020 00:12:34 -0700 (PDT)
Subject: Re: [PATCH 3/6] sun4m: use qdev instead of legacy m48t59_init()
 function
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1602965621.git.balaton@eik.bme.hu>
 <8dc32bfedf44c77f3229bb2359565a2ee65409d7.1602965621.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <39091f3b-2313-a90c-f189-3e8fd203ec95@amsat.org>
Date: Sun, 18 Oct 2020 09:12:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <8dc32bfedf44c77f3229bb2359565a2ee65409d7.1602965621.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.247,
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
Cc: Herve Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/20 10:13 PM, BALATON Zoltan via wrote:
> Also declare nvram variable with the correct type.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/sparc/sun4m.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 54a2b2f9ef..7f1a48440c 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -837,7 +837,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>   {
>       DeviceState *slavio_intctl;
>       unsigned int i;
> -    void *nvram;
> +    Nvram *nvram;
>       qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
>       qemu_irq fdc_tc;
>       unsigned long kernel_size;
> @@ -966,7 +966,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>           create_unimplemented_device("SUNW,sx", hwdef->sx_base, 0x2000);
>       }
>   
> -    nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1968, 8);
> +    nvram = NVRAM(sysbus_create_simple("sysbus-m48t08", hwdef->nvram_base,
> +                                       slavio_irq[0]));
>   
>       slavio_timer_init_all(hwdef->counter_base, slavio_irq[19], slavio_cpu_irq, smp_cpus);
>   
> 

