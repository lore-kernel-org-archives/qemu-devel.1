Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C1FC388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15995206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2KfJrvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15995206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbtsx-00069A-0t
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 18:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbts9-0005ht-3b
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:13:21 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbts7-0007ZO-AS
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:13:20 -0500
Received: by mail-wr1-x441.google.com with SMTP id x7so6875707wrl.3
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 15:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xHuPMoNhce6JBToDRnIKq/2vosQ/aXJN5Z+fOaZyusE=;
 b=T2KfJrvENr3h79sXpTApaad9VJekfK1KlU127lrk67GcuUSy6et9GWj41zV8hYKac4
 CrHmEayoooRXKxYjH+BH+9/5SdanVF4YkPGqOq8NRmsMDEuhVtWmP1fssgRA7o7NdNO5
 ojmcqCfLRU163KbbqLSRmC6QvsSTN+VpXUBXHrdhb+XXF4wJRSLj04092Yft9MNYooAc
 uh4tjba+NIYgIchcRVWLYJfL3gjqVvCfMj7kZllSpXIDwSmkcAmCs1F3W7KJYU8jNQ/K
 MWi5SaeyccdoVeEG7sdhoGiGeUeDqS/I/DKyNjQPUpvDU5CeUU2SH2Lds0g3cUlZ7Am8
 ioFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xHuPMoNhce6JBToDRnIKq/2vosQ/aXJN5Z+fOaZyusE=;
 b=kBPhWk58Vptjhb1Bhez8LLZ+cAraVcoBcVB2O1+JKM5PsVo23sEN5OxHSErDI5xux+
 h479RxG3dp8B2dgt1QNYorAUAupgYjjMVKF4v0etYVYo6JbDwvIWJOJn2lzBhgLQjc3V
 zJYv5oBGuZf96p2Mr1k0SrUG09wx4uu/2xmh9gIaLVXFdjMHRqEEImp9VRdLZtoVmCPa
 nfkrxzeaOqzaUEp6hTe36hHFMHK2BJ5DtsQ4dKBIeAiL4JZPO3HjEjBbW35B4mgocTPj
 QplDMdxx8t3vI5ThRA/rVgvaTC4B1Q3BrHabifS2hptgdVORMQlgA65bUWKW1VKUIzNw
 zAHw==
X-Gm-Message-State: AOAM532ilyYrtX+DnDTgWs2dylz1HVM0nzN19aXxHzQaOD2BGNckzNc2
 L85luA7sAPRvvFEtutgjfXg=
X-Google-Smtp-Source: ABdhPJy+zNtHBgRKlK3Q6nZ22koqMXHGGzfoF+auaJrX6qOGn2NaTncrG4CL7vUU/oPYsYrn88hR/w==
X-Received: by 2002:a05:6000:1188:: with SMTP id
 g8mr14313616wrx.422.1604877197507; 
 Sun, 08 Nov 2020 15:13:17 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t6sm10844966wrp.68.2020.11.08.15.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 15:13:16 -0800 (PST)
Subject: Re: [PATCH for-5.2] hw/mips/boston.c: Fix memory leak in
 boston_fdt_filter() error-handling paths
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201106175823.1650-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c9c2023a-fa95-33e2-0ae2-265b2e398f84@amsat.org>
Date: Mon, 9 Nov 2020 00:13:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201106175823.1650-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 6:58 PM, Peter Maydell wrote:
> Coverity points out that the error-handling paths in the
> boston_fdt_filter() function don't free the fdt that was allocated.
> Fix the leak by using g_autofree.
> 
> Fixes: Coverity CID 1432275
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/mips/boston.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Thanks, applied to mips-fixes.

