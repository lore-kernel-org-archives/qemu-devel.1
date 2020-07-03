Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED236C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA60E20870
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDOgTKXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA60E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQd0-0008MX-2B
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrQcF-0007k0-IB; Fri, 03 Jul 2020 14:40:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrQcD-0005Me-U0; Fri, 03 Jul 2020 14:40:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so30704864wrw.1;
 Fri, 03 Jul 2020 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zKW8uGzDNof149XVaM4VncUjTfTRcyRUxTVSqbKYTrs=;
 b=VDOgTKXPt/emqEGvfpgM6plvRzIo+lmsRXnHfVETL8scxVKoZNYq5EydHZE4jhVlzK
 hL0MznW5LJPrYfOlUnAH1sAqhFquXLCs/ldgWi6Rix8KiFOJD9laQJHm+uwGgyA3w1M9
 ujAMXBaIm4es5VvI/fbsM3V7Z+FmJi/OMu4wKqm7ZRrERsYuLG+DxVgkW5XmiK+5FKA+
 LfizXxmRmxXAN7p6U8LmcO51TVgxjj5jDi0JIFx+avbf9AGaTP946tMw14Fea+m1TdSk
 LS5bfFhCB+qunPumflDyJkdU2XRjYAxQTgikS1SleUWuo3q88u0+F2EkbWEQQzmBVVZK
 m8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zKW8uGzDNof149XVaM4VncUjTfTRcyRUxTVSqbKYTrs=;
 b=V728ti3xZsYyiaS3xmwyYPY66bGwEL1JdpTL7BWEQom9m7LwVMjWMTuA0qoS22Zigg
 K5AMmbBnDYe+8S0hpfDGr2D/aoCE2jBisb61Xl0Rc6BVQNMk0/ttS3/mkWJ8NV1C1Czh
 xT8giqbPJhCrNW9rHlEMam4A30wzAoRi2tkBFMMM1EchiDgJN7J15YMgt4NtF8UM2vX2
 D3syChq4ntDcyilDp0eBqb+zxrs5q0gjo9Qwv+huHFQTV0+hSbi835TWu2x/Z4FxQV/+
 IYjT5XO2So7AWQkOR/xBxxACs8OiBXjJDJgSda00x8U7KWe+3JOold+Msnl4zzedUq5A
 bTUQ==
X-Gm-Message-State: AOAM531MDReJ8+SX1trpAjbRPzZHapLDHlk6Qk2pLaoo1mE1J6vUsOaK
 DiEqGKL+I9uPgJkRyAsZHAObHkAKmLY=
X-Google-Smtp-Source: ABdhPJxMBpmZvAwriAskRvATkUyONdd09awhiiDSwka+Ky/hJGt9FM4llTe/MiWzG7owqeFAiLkgdA==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr37223363wre.369.1593801647323; 
 Fri, 03 Jul 2020 11:40:47 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x18sm14645715wrq.13.2020.07.03.11.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 11:40:46 -0700 (PDT)
Subject: Re: [PATCH] Fix MIPS add.s after
 1ace099f2acb952eaaef0ba7725879949a7e4406
To: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200703161515.25966-1-Alexander.Richardson@cl.cam.ac.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <013da4b5-be9e-aeae-5e88-82188a26d4bf@amsat.org>
Date: Fri, 3 Jul 2020 20:40:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703161515.25966-1-Alexander.Richardson@cl.cam.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: qemu-trivial@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 7/3/20 6:15 PM, Alex Richardson wrote:
> After merging latest QEMU upstream into our CHERI fork, I noticed that
> some of the FPU tests in our MIPS baremetal testsuite

I understand by baremetal your soft core implementation running on
a FPGA, right?

> (https://github.com/CTSRD-CHERI/cheritest) started failing. It turns out
> this commit accidentally changed add.s into a subtract.

Fixes: 1ace099f2a ("target/mips: fpu: Demacro ADD.<D|S|PS>")
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Thanks for your quick fix!

Phil.

> Signed-off-by: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
> ---
>  target/mips/fpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
> index 7a3a61cab3..56beda49d8 100644
> --- a/target/mips/fpu_helper.c
> +++ b/target/mips/fpu_helper.c
> @@ -1221,7 +1221,7 @@ uint32_t helper_float_add_s(CPUMIPSState *env,
>  {
>      uint32_t wt2;
>  
> -    wt2 = float32_sub(fst0, fst1, &env->active_fpu.fp_status);
> +    wt2 = float32_add(fst0, fst1, &env->active_fpu.fp_status);
>      update_fcr31(env, GETPC());
>      return wt2;
>  }
> 


