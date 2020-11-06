Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C54C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FE020735
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOvSTK/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FE020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6f0-0001ZI-79
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:40:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kb6dA-0000Qj-H4
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:38:36 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kb6d9-0006XZ-40
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:38:36 -0500
Received: by mail-wm1-x341.google.com with SMTP id c16so2234242wmd.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 10:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dyqELL9am3Smi8A66Md++oAilMWhGEhqeOTPxQxDA58=;
 b=nOvSTK/H7SRHd8lhrjPzHxU5/WocQxHDo/3vgi3u0+Nc5CPrcLHktXAqLvQh+AMdMD
 opHEPD3JZ+ZyoUMz5bLe980rWPnb++tCxtuizsLvktAv+FvwEMZIHifhnL95f+oyYVKO
 WNR/b9IAen31IoNibaXNny6NdcqFRR/i3mmTfAqr0DANlb2ze17f5wGvU7/46cpWqJlq
 J/8LjIyUhIgvQ+bCt2WvXTf2Gjrtl/SiCrhvM+iFGtjcXREoLXhiZhYw0z0E/6D8I2RD
 D3iCyMCFvWv+4nySI0Pez79UF7MglyLQvrxjY0Kb3HJ++T70+P/tqbZb40IXamvp1C5Y
 +v6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dyqELL9am3Smi8A66Md++oAilMWhGEhqeOTPxQxDA58=;
 b=k7BP5yH4XRrahEpM3G28wnEnzxshS8ZzYVuApVrFMw9etMcAh32JE8fQuXhAn0Yeoq
 jGOdUegxOGEfZSLIEQGs1k3CQc4qVpkVY4cfPe8W/6pmjQ/a+3DXnXxbJC+wE+WIXFeA
 6zlhTh4vLpfC7O6ss8Rvta8VtahbYJ8zYSKEFTnrSMxPPNcJFYGymtjySKy+zz4gU8s/
 SdRQ7wAQ2fQ/GJ+StPs4hts4t/BApE+4SoPbzCS910k4JO3RfmPGmyO6LOBtdDlLcbaa
 1qStwgn2sUjW9C1dON4o1/FQo3GthuVYvdvdVz4VKLJ0K0ylSaq8gDIfp9wDX5BQk5AS
 xuJQ==
X-Gm-Message-State: AOAM532ZNPUYjBL9LBChSo9FMPXQnHQxOeRK49idJozS4+0f4JEkTej1
 dLQ5VRXkaCJlPJDql/bmILQ=
X-Google-Smtp-Source: ABdhPJyTTP7QTJ6VrXtBs8pGD/B9sc/5bxtDPT91V8rEtXolFMJekbn1DkKL3B5LAiyB44ALEXMFWA==
X-Received: by 2002:a1c:7202:: with SMTP id n2mr969680wmc.38.1604687913624;
 Fri, 06 Nov 2020 10:38:33 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t11sm3532115wmf.35.2020.11.06.10.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 10:38:32 -0800 (PST)
Subject: Re: [PATCH for-5.2] hw/mips/boston.c: Fix memory leak in
 boston_fdt_filter() error-handling paths
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201106175823.1650-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d9dc47a3-dd85-0eae-e862-c4b8482a4610@amsat.org>
Date: Fri, 6 Nov 2020 19:38:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201106175823.1650-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

