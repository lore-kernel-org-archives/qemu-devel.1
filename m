Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9519BC43219
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 13:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6619B2087C
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 13:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6619B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60102 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKN0c-0006dY-3O
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 09:04:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKMzm-0006MQ-OO
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 09:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKMzl-0006Ba-Ib
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 09:03:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKMzl-0006AA-9x
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 09:03:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id j13so7416128wmh.2
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 06:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=gGWH6wXoykgf3T7JRQOE/awKnBMa+zWsN6qD2ifoWKU=;
	b=USu8OLV/DV86IXM3QPbhilaAlUA8sG8Pw3Ngut6HGAUF2AGQSYXaJImt6eOJt3JZLI
	DxG2TWprNomBMlnSEdfMEJYNUWjuj2hU7rjqSuoKXBga3lzdF8aQ610XmLUL+ZMaGBcS
	gUipWPgEd2KDnBBjNGP8nPV+1rcNsLIdxiD700zNTrUCqe/RA02r7E35s6+7xoIjGjhr
	6VdWXO5m9pMTapx5b0K7gzwaEEofc/xUeiT0FA5qaYlde+rJOkXR72j9Cx9mrv/syZAw
	WY+C52qHISn+OpWjxp/2TNwhXnZOyYsHA4epv1Ba8Y4EMbcEX4ZhJPTQjibV5LLQ28Zq
	TdHA==
X-Gm-Message-State: APjAAAXzN4OirDHBSR1sPUYBsF3CZ5TKsT6Qx4Tns3COCcj2kWpSu+1y
	tbnnT1fHAhbTKn4Y8TcitGnfxVZoZR6zlw==
X-Google-Smtp-Source: APXvYqwZ/LZ/zasvzm1gxbqO9xTvi1SeSiONW9ZXLjmBqLgufaGNdyEEQ2+MkRF0ScVjgp9/ZxpEdw==
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr11977026wmh.74.1556370234591; 
	Sat, 27 Apr 2019 06:03:54 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id q25sm4411065wmj.3.2019.04.27.06.03.53
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sat, 27 Apr 2019 06:03:53 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190427005124.12756-1-richard.henderson@linaro.org>
	<20190427005124.12756-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <64849861-0d2f-efbe-85ea-2b1076d8d8d9@redhat.com>
Date: Sat, 27 Apr 2019 15:03:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190427005124.12756-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 1/2] target/alpha: Clean up
 alpha_cpu_dump_state
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427130352.xgCSJlZB2tiQdAHSqG2fr4Twwb1DJDXergyIqaRuS7Q@z>

On 4/27/19 2:51 AM, Richard Henderson wrote:
> Drop the "RI" and "FIR" prefixes; use only the normal linux names.
> Add the FPCR to the dump.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/alpha/helper.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 7201576aae..31de9593b6 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -429,32 +429,33 @@ bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  
>  void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>  {
> -    static const char *linux_reg_names[] = {
> -        "v0 ", "t0 ", "t1 ", "t2 ", "t3 ", "t4 ", "t5 ", "t6 ",
> -        "t7 ", "s0 ", "s1 ", "s2 ", "s3 ", "s4 ", "s5 ", "fp ",
> -        "a0 ", "a1 ", "a2 ", "a3 ", "a4 ", "a5 ", "t8 ", "t9 ",
> -        "t10", "t11", "ra ", "t12", "at ", "gp ", "sp ", "zero",
> +    static const char linux_reg_names[31][4] = {
> +        "v0",  "t0",  "t1", "t2",  "t3", "t4", "t5", "t6",
> +        "t7",  "s0",  "s1", "s2",  "s3", "s4", "s5", "fp",
> +        "a0",  "a1",  "a2", "a3",  "a4", "a5", "t8", "t9",
> +        "t10", "t11", "ra", "t12", "at", "gp", "sp"
>      };
>      AlphaCPU *cpu = ALPHA_CPU(cs);
>      CPUAlphaState *env = &cpu->env;
>      int i;
>  
> -    qemu_fprintf(f, "     PC  " TARGET_FMT_lx "      PS  %02x\n",
> +    qemu_fprintf(f, "PC      " TARGET_FMT_lx " PS      %02x\n",
>                   env->pc, extract32(env->flags, ENV_FLAG_PS_SHIFT, 8));
>      for (i = 0; i < 31; i++) {
> -        qemu_fprintf(f, "IR%02d %s " TARGET_FMT_lx "%c", i,
> +        qemu_fprintf(f, "%-8s" TARGET_FMT_lx "%c",

I often wondered was this useful for (I mean, one would focus on one or
another, but having both displayed was not helpful IMO). Now the output
looks clearer, thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>                       linux_reg_names[i], cpu_alpha_load_gr(env, i),
>                       (i % 3) == 2 ? '\n' : ' ');
>      }
>  
> -    qemu_fprintf(f, "lock_a   " TARGET_FMT_lx " lock_v   " TARGET_FMT_lx "\n",
> +    qemu_fprintf(f, "lock_a  " TARGET_FMT_lx " lock_v  " TARGET_FMT_lx "\n",
>                   env->lock_addr, env->lock_value);
>  
>      if (flags & CPU_DUMP_FPU) {
>          for (i = 0; i < 31; i++) {
> -            qemu_fprintf(f, "FIR%02d    %016" PRIx64 "%c", i, env->fir[i],
> +            qemu_fprintf(f, "f%-7d%016" PRIx64 "%c", i, env->fir[i],
>                           (i % 3) == 2 ? '\n' : ' ');
>          }
> +        qemu_fprintf(f, "fpcr    %016" PRIx64 "\n", cpu_alpha_load_fpcr(env));
>      }
>      qemu_fprintf(f, "\n");
>  }
> 

