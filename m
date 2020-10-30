Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1E8C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 06:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C1A22203
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 06:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acKkXA1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C1A22203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYO20-0004YK-3B
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 02:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYNz6-0002p2-GU; Fri, 30 Oct 2020 02:34:00 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYNz5-0000a1-01; Fri, 30 Oct 2020 02:34:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id g12so5178088wrp.10;
 Thu, 29 Oct 2020 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+WlayzpdNcz/iU+PGMDZI+CjYpaa0yC2h/lvinVuYOE=;
 b=acKkXA1O/7RDMyyYfaQTiDkJNoi1XCJrymf8qlozbqHNNE3W+UuGVzzO3fAHKJ0ZOX
 G66wWHwhqek58OzjGgKg4QD8vssVwj90R9ESD+tRYOlAPSNMy//55FtaD3rmPrGj2b19
 Fpe2NKiyX2eEGcYNFGN4+CSTHa4A9KI1pbp2tfNhR1n56SPUX3RhE7k5DF2GdMCzuBeH
 h96mNqA7yLOEX19Lr//CWMT8l3Iw/mKSU4H3K0jZ/osIrOMD14SoXnTE7XA4V7FWbK6y
 ttML4JsgxhH08MRDu++GIPLFNm/pppG+rAN/H0adfYxGxR91MCuKcVkX1Zw5z0HKowF1
 TRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+WlayzpdNcz/iU+PGMDZI+CjYpaa0yC2h/lvinVuYOE=;
 b=pa3EVT76YFVcSzXqpfmwAYMPvDm1QPZXSGJcjkdC5TOH3GjTGbHWmqEIQjQPhv6YWK
 n9jETN3wavaN1DTkNJ7aBIlGKriDkrYowXL6FOmu8j++p0B1YOkjNO+ofLX/EHu25SEc
 hHVaykV8djrojX5jjWmYS5jU4OW1Q+BqSNdbATSTIoqn1fas6kLviNqZ3pmzwsG9I4hr
 5/xvoq13DbgkJP/5S3OlQiD8TpYsaMRDNKRRK4WQQ6MKK2kh67CTADb9jjJG1SNpI6Q2
 49cTJAS4rn6CWjdZYWWEo48FQGH9TIgyHojMgDj8A16Od6zwIAbuSWof48soKHR40eqF
 Lrkg==
X-Gm-Message-State: AOAM533KsGd7vrkVssNetlezZxTHgS6S5+SPMVKo9LMvY5EHswC33FUj
 yDABL+Cbm857XyeVVh0LtjU=
X-Google-Smtp-Source: ABdhPJzsjP+eDeYFK2ApUTdjg8qbFo5NS1pA46O2cbZmvVC1GqFrnKmPwN/EoAZf5OoTftamdkqDBg==
X-Received: by 2002:adf:f74e:: with SMTP id z14mr1000154wrp.312.1604039637181; 
 Thu, 29 Oct 2020 23:33:57 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id l11sm8515461wro.89.2020.10.29.23.33.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 23:33:56 -0700 (PDT)
Subject: Re: [PATCH v2 8/8] target/ppc: replaced the TODO with LOG_UNIMP and
 add break for silence warnings
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201030004046.2191790-1-kuhn.chenqun@huawei.com>
 <20201030004046.2191790-9-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f950ef22-0124-26bb-2c37-2f6e32d6e1cc@amsat.org>
Date: Fri, 30 Oct 2020 07:33:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030004046.2191790-9-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.261,
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
Cc: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 zhang.zhanghailiang@huawei.com, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 1:40 AM, Chen Qun wrote:
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
> target/ppc/mmu_helper.c: In function ‘dump_mmu’:
> target/ppc/mmu_helper.c:1351:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>  1351 |         if (ppc64_v3_radix(env_archcpu(env))) {
>       |            ^
> target/ppc/mmu_helper.c:1358:5: note: here
>  1358 |     default:
>       |     ^~~~~~~
> 
> Use "qemu_log_mask(LOG_UNIMP**)" instead of the TODO comment.
> And add the break statement to fix it.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> v1->v2: replace the TODO by a LOG_UNIMP call and add break statement(Base on Philippe's comments)
> 
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/ppc/mmu_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 8972714775..12723362b7 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1349,11 +1349,12 @@ void dump_mmu(CPUPPCState *env)
>          break;
>      case POWERPC_MMU_3_00:
>          if (ppc64_v3_radix(env_archcpu(env))) {
> -            /* TODO - Unsupported */
> +            qemu_log_mask(LOG_UNIMP, "%s: the PPC64 MMU unsupported\n",
> +                          __func__);
>          } else {
>              dump_slb(env_archcpu(env));
> -            break;
>          }
> +        break;
>  #endif
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimplemented\n", __func__);
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


