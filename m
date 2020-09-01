Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDF6C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96F8207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C24GLxl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96F8207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDASJ-0005nG-RN
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDAQs-00045Y-EH
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:50:59 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDAQq-0002ks-TG
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:50:58 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ds1so1000404pjb.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7Ko1jM+38f+VOxHuq8IymQYkeWmQIek8QusLvh9d0fg=;
 b=C24GLxl8ZOktYzKsSfJDaZ2LgxElgIfkMv/dklBM28gU+/56MZNyumhTuFMVEyUqkj
 b3Cg2641DEEyQgw7x882Yog1vFHogE6W6IjEw9hPplApxb41dyMDP+WKl0BNsJoqLf+w
 fPBZ/8xUK01IMx9gVwDIQOd0WI6qxYgV4V88sJJYa7341whgab61id/2AvhOwjul3jzp
 oD33ZT7cXBUaDuyCL0qtWW7jgbxdaOFSiLflnTauHCDeU1WYKe/DnD+HSXyLeuY5Nsp/
 ai4tUud8gx3pmfuP3Q6kA7i3GPPWQy2nmU1c9RWyC/0+NeACkIehZcF3C8QPweDsXIem
 pB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7Ko1jM+38f+VOxHuq8IymQYkeWmQIek8QusLvh9d0fg=;
 b=oJcNqn84DGNEdfw5S4U7EadiZ8du4XhrWjCLoHJHWCn3JSN/D7KWERExOBSHqSzQ8D
 P7Kc+wY4G86refMqWuzC7OoXVM1Bx2weQAHzfy2myZVa2e10sswzdBysAS5obWIcmuv7
 iJ/WdYom6mxLlR0gOJkOGvFwgxmry8uRHcTY3UynkBk3xhea4ezCG9fwe29RncNXLRkG
 JbOb/t2arB5L7VdOmend3raYVWzPlOAaWA3V23a1S2m4KL7nlYEjsIPwBdqedIU2Bii5
 JItaSdyT6crwwUuPcOEbAA4CttZf9OIH7/2FNRKo8zx3L2HWp/65XKvWOruEpVAhjDtR
 +dlw==
X-Gm-Message-State: AOAM530Tx+4kw7nHiTpj9XTezYAWPSbg3JxJlonVczV2WAsUFKo1EB4t
 mlLPqc2H7BWluuYCdn+qYWd9rA==
X-Google-Smtp-Source: ABdhPJyw5j64baONFL3+S6Y4M6yGHvx3pgWDaHilByaCumrtvLv2JVgfnLGW31vmGzM8iSOKBP6Rcg==
X-Received: by 2002:a17:902:10f:: with SMTP id
 15mr2306925plb.232.1598982655459; 
 Tue, 01 Sep 2020 10:50:55 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y65sm2521484pfb.155.2020.09.01.10.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 10:50:54 -0700 (PDT)
Subject: Re: [PATCH 5/5] hw/isa/isa-bus: Replace hw_error() by assert()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200901104043.91383-1-f4bug@amsat.org>
 <20200901104043.91383-6-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <79238190-0c1d-f6c1-bf2b-e9094241689a@linaro.org>
Date: Tue, 1 Sep 2020 10:50:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901104043.91383-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 3:40 AM, Philippe Mathieu-Daudé wrote:
> As we can never have more than ISA_NUM_IRQS (16) ISA IRQs,
> replace the not very interesting hw_error() call by an
> assert() which is more useful to debug condition that can
> not happen.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/isa/isa-bus.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



