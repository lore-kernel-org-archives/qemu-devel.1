Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56A9C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B842074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POETLewF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B842074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZMS-0007Bh-AQ
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZJ7-0002vb-AZ; Wed, 30 Sep 2020 06:25:57 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZJ5-0006z7-Ps; Wed, 30 Sep 2020 06:25:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id s13so1104061wmh.4;
 Wed, 30 Sep 2020 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XPCOUC1vLC6r+0Is3Ssp1OqodbSdPWJ1yBc04upvks8=;
 b=POETLewFjB5hAHVR8Cz0Zd0vH5mKsrCLTWQnohx3SQppjvaU8VHmeFUnSnmsGTEchb
 fwIjOtmVPzodO6RuuLYnO9Z+H9HwqgwlTWpzHpQJnw6X1HUK85B8H0NsUt7aXT+DmFhF
 LKpvhmxdzQoBkg0LJw6QH8QGf2/DV/95WVF1rTlA7pc10qnxOJb2rzNdU7WvgoRH2nBL
 rts6QAQvNqHXHUY6brRiQRFNvp5eV63cyihZVYDCdve/W+cb1HKpcLYmZnmhNbLcDgB5
 KhlM3JV8DW4Qz3ijOg/lIp5FPdDkeaTvXbn752k3UCh6UGADiovUEsn6tMoD/PECUcPm
 kf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XPCOUC1vLC6r+0Is3Ssp1OqodbSdPWJ1yBc04upvks8=;
 b=Tm0u3hpR+a/0460eU+2d/l/w2ROcmylc3oEhxxIPxFZOzArnm3fcI0b4eLt+TAT6Qk
 lg7VJVxapILYENc8UpI2I1Og0Di7Z1vznGO4MCDNhPx4p+voMCyyO57gp/nIaCcpn5v9
 yjM7q4ya/I8INA6xK+bFw4A2ejp+GP38P7ngOrHgWCCcBoCbFs6a9AqPh1C3s90miBPN
 9MdLQeqmuu4IkAau6EbATFu8eTOC6aH6mjPTY49urYo9v6iatF5+1A+Qahs+ZccqViz5
 a0DjZYAIBvXiVh2PG8WKmspvReHb87LaTU916oXVoUh81C20VHif61AFBdS4dbodt767
 G/jQ==
X-Gm-Message-State: AOAM533CRvqb1hHv8xDNtzI37Uo1b/cmb0mEMVtqwzigzwYQBCpc5miy
 RAzmVCs3QVzi9jiorkVZEyX1mh4fs58=
X-Google-Smtp-Source: ABdhPJz3vIoQAFgRvtlrYaOF8MB18HwDc8AlR5bgpwASfCXpjg9zl3YJw7/xVVn6swBlsutgpgzU9g==
X-Received: by 2002:a1c:9a10:: with SMTP id c16mr2102350wme.96.1601461554087; 
 Wed, 30 Sep 2020 03:25:54 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id m13sm2163677wrr.74.2020.09.30.03.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:25:53 -0700 (PDT)
Subject: Re: [PATCH RFC 04/14] rx/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-5-zhaolichang@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e93f84bc-acfd-7974-f701-2fbe79b98a0b@amsat.org>
Date: Wed, 30 Sep 2020 12:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930095321.2006-5-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 11:53 AM, zhaolichang wrote:
> I found that there are many spelling errors in the comments of qemu/target/rx.
> I used spellcheck to check the spelling errors and found some errors in the folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/rx/op_helper.c | 2 +-
>  target/rx/translate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
> index f89d294..59389f4 100644
> --- a/target/rx/op_helper.c
> +++ b/target/rx/op_helper.c
> @@ -318,7 +318,7 @@ void helper_swhile(CPURXState *env, uint32_t sz)
>      env->psw_c = (tmp <= env->regs[2]);
>  }
>  
> -/* accumlator operations */
> +/* accumulator operations */
>  void helper_rmpa(CPURXState *env, uint32_t sz)
>  {
>      uint64_t result_l, prev;
> diff --git a/target/rx/translate.c b/target/rx/translate.c
> index 482278e..9ea941c 100644
> --- a/target/rx/translate.c
> +++ b/target/rx/translate.c
> @@ -1089,7 +1089,7 @@ static void rx_sub(TCGv ret, TCGv arg1, TCGv arg2)
>      tcg_gen_xor_i32(temp, arg1, arg2);
>      tcg_gen_and_i32(cpu_psw_o, cpu_psw_o, temp);
>      tcg_temp_free_i32(temp);
> -    /* CMP not requred return */
> +    /* CMP not required return */
>      if (ret) {
>          tcg_gen_mov_i32(ret, cpu_psw_s);
>      }
> 


