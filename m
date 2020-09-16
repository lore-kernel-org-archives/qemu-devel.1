Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1DAC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5FA22450
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKbMCPjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5FA22450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIZIi-0007C0-Od
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 11:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIZIA-0006mv-P8
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:24:18 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIZI9-0006Fn-9E
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:24:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id q9so3202912wmj.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=20WbA9wOq3ZAuxXbWRa7WibPAeveEVz7aPvxcSQF6Ew=;
 b=ZKbMCPjPiMEAMLiCHhw3WDlbRXD96qMkzlLpIX5fonLfhTDOcDo8f/e5WDyr/SBIQJ
 YeUXYoJg+ETM79NTMiZ593ofVNHwLSBqywXr5XZNvyFzQEbpBDMKWpZnu69fvp4QDSUq
 Gc7Y/Iu9iU1UOiuimzp+HXJix4NlZTNqtIs1rNwdWwmvgk2TjHcaxXqcT55A18JUm2zX
 qqxEiLzCkjz/mJuPKYEGWe6eocQPyDEmMmfOp88CTX1XQWbZGQQ4Y19cSfPV9nuQ0wtw
 7Z0mOFVaCmQ1VoAQX+GKL2TQqkDfc/w4zOEpKBhNcs/vXDBnx/LXMA2WSPva8mqxtwuo
 nkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=20WbA9wOq3ZAuxXbWRa7WibPAeveEVz7aPvxcSQF6Ew=;
 b=TPmcf6O1TZTzMp24ldM3NLZURuK4QZnFauZRARXW3eb7cv7PWPdH93IpFB2cF0bfSG
 tXwGuK4P8FbUwR09jFQXapwL8DL/5eZFnrdDtl1Trjgu4kyC0gLTBErttDBRzr5DeSxA
 AcMd8/OFjEJUS+R1naRuJBzI6ACOWreoxydXuHiKe7Ukroa3n5BUobJ5zfffBOvP8NNS
 zEbqIPcccCx5tu7Sy7dEgbmfGn/N7YgMNXwXKNeNVA8DTHF6ceqIc4N8dRJ8vn2/dDse
 zXgr+oUtEXahBGKY3siYblfjGCpc/AR6O8LwgEMdnUODZcpk85XMjha/vPl4oxCzEX+u
 c1Fg==
X-Gm-Message-State: AOAM532t3xVWxnD27iG8BJFcsXq9BM5l/2fIMW2i3p/2HcI9jzQUn5sl
 ulVjGfhdit37BhRdYEyDrAY=
X-Google-Smtp-Source: ABdhPJyL1LIftjItt02WbmfVPuv+1XptMf8sUkMLwAd/8lnSfwl4T3QLZ6ygjtlwzVfkSS98B7yetQ==
X-Received: by 2002:a7b:ce8d:: with SMTP id q13mr5262981wmj.119.1600269855495; 
 Wed, 16 Sep 2020 08:24:15 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id c4sm33179569wrp.85.2020.09.16.08.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 08:24:14 -0700 (PDT)
Subject: Re: [PATCH v8 17/17] accel/tcg: use current_machine as it is always
 set for softmmu
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200916142004.27429-1-cfontana@suse.de>
 <20200916142004.27429-18-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d2339c8e-ffe4-b774-0b36-7a64c7efa9fb@amsat.org>
Date: Wed, 16 Sep 2020 17:24:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916142004.27429-18-cfontana@suse.de>
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
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.062,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, haxm-team@intel.com,
 Colin Xu <colin.xu@intel.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 4:20 PM, Claudio Fontana wrote:
> current_machine is always set before accelerators are initialized,
> so use that instead of MACHINE(qdev_get_machine()).
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  accel/tcg/tcg-cpus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/tcg-cpus.c b/accel/tcg/tcg-cpus.c
> index ec7158b55e..05af1168a2 100644
> --- a/accel/tcg/tcg-cpus.c
> +++ b/accel/tcg/tcg-cpus.c
> @@ -484,7 +484,7 @@ static void tcg_start_vcpu_thread(CPUState *cpu)
>           * then we will have cpus running in parallel.
>           */
>          if (qemu_tcg_mttcg_enabled()) {
> -            MachineState *ms = MACHINE(qdev_get_machine());
> +            MachineState *ms = current_machine;
>              if (ms->smp.max_cpus > 1) {

What about simply using:

               if (current_machine->smp.max_cpus > 1) {

>                  parallel_cpus = true;
>              }
> 

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


