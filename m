Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB8FC5517A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 06:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FBC22202
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 06:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W90wGVSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FBC22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYNzh-0002mm-KG
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 02:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYNxm-0001oq-UW; Fri, 30 Oct 2020 02:32:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYNxh-00009A-Dv; Fri, 30 Oct 2020 02:32:38 -0400
Received: by mail-wm1-x341.google.com with SMTP id p22so1835629wmg.3;
 Thu, 29 Oct 2020 23:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x6CaBBtnk1ZQ5qcwfpox4tasXgcArXuldXXRPaxVmCs=;
 b=W90wGVSaNIhJkvccwKdqUWehUZJt+WNeGU5fxj3bYEYHge+tUDLaeKRsb0GG7nK6tc
 2DYETw0hcKJs39ipR/VbGGix6ubiyOXVPbSuq/gXlCEQeMiD+SjM5tTwP8yDdE0fM/EP
 SpHRX1j2VwVTfa4hiUXTKKNOgHM7NPmlpTwdQ/6tue2jiD5oYtDYvZbTnxiBxgaeAAvN
 2ftcLWwLfSqInZpvCXv4wjF+1xXbt+T+53HhfaOnJ6FZZ1IG0Y2rn6eLevLtJVoX30IT
 dwh80SNZp8sNdYsk/D4XEyA3lHvdCL7qjR3wZzz64WrJTVKMjWRjxbWIj1fEM7dxuivx
 329w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x6CaBBtnk1ZQ5qcwfpox4tasXgcArXuldXXRPaxVmCs=;
 b=CqIBbrAEXKqlYLNAxqEbpEcFIdETykCCcHM2hnwa3uq69edTEqZOuPboaS8ZvZDOiL
 o7P3sSxX6H/du/KSZFvBIvBoKT+xjgafrRTnzvLqhEjEaBR6MZY53XMwV9A79lgH2S9p
 2cHIgAEb3ImgpUtQ1ze7Du7M5LNGKPIrWG9k6wQaKmoMbZeuUiZsYZ2DlLzcAbe6Kimm
 fWp8KMcDAc8FoUnnMpr+Z5F16EP19H4kcastOqTF24IqFa3/ML38mq3AAfsBKpomBhYr
 5CrRVWL+7EPeF27TpP7cWpTPVjs319oSVEKMQECSBt1SjTWrXVhBghT+DuT/fXFJManO
 g4fw==
X-Gm-Message-State: AOAM533XJYqMhVi2yol3zkSROqdZ6ZQoRu6vLd5XfvJoSK2kDBvK72FB
 8lNjFiGKtxosfITefhoVhjc=
X-Google-Smtp-Source: ABdhPJx6p5yydnT6e3PBbIktaZyydlBFdDz+lv/7uwgRgVttJIgMWh2VU2MKtjgwxlN9CUkUHdlDbQ==
X-Received: by 2002:a1c:7f0f:: with SMTP id a15mr755885wmd.97.1604039551215;
 Thu, 29 Oct 2020 23:32:31 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t1sm8965282wrs.48.2020.10.29.23.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 23:32:30 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] target/sparc/win_helper: silence the compiler
 warnings
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20201030004046.2191790-1-kuhn.chenqun@huawei.com>
 <20201030004046.2191790-7-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <01f1395a-fb31-b3bb-c252-437f48efafd1@amsat.org>
Date: Fri, 30 Oct 2020 07:32:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030004046.2191790-7-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: zhang.zhanghailiang@huawei.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philippe.mathieu.daude@gmail.com>,
 ganqixin@huawei.com, Euler Robot <euler.robot@huawei.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 1:40 AM, Chen Qun wrote:
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
> target/sparc/win_helper.c: In function ‘get_gregset’:
> target/sparc/win_helper.c:304:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   304 |         trace_win_helper_gregset_error(pstate);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> target/sparc/win_helper.c:306:5: note: here
>   306 |     case 0:
>       |     ^~~~
> 
> Add the corresponding "fall through" comment to fix it.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
> v1->v2: Combine the /* fall through */ to the preceding comments
> (Base on Philippe's comments).

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

