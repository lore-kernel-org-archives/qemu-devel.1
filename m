Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE10C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F20206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW/TmqZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F20206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvxpM-0005G8-U1
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 02:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvxoV-00049r-I1; Thu, 16 Jul 2020 02:56:15 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvxoT-0002BJ-Of; Thu, 16 Jul 2020 02:56:15 -0400
Received: by mail-wm1-x344.google.com with SMTP id o8so8889525wmh.4;
 Wed, 15 Jul 2020 23:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1nhHol+OeuolxLn8zd2+EjxiDEScjQpLpAy15xU6n64=;
 b=IW/TmqZkZ3rxIaSTnLs4ALfjQiu9tvpFXgTydRBWIOhSwtwb8ngq06PCxbeu3Pk6Yq
 bocvnyi1WM1OpTqXoJHhPy08ER+V2N+d7+CCRd6JANqj06bNknvbQ5p49vncjcLktI65
 3FmkRmPd3RrafCvsREeAZxrVrNJMW/Adf3O0TEkIqPK3kJe3DkV41/r6PjsFqV4bPvlO
 KFMe2EAMX77NNvdhV6Gzw9/Q5jsApHileqVL8ZJ1TYLcLlyLU2CrkBPN4ktYBBkRiJc9
 gjbqOhla7jypJKIT+zN6OtyA23aQ9nHPSKTHsIC8yg50rp8XPn8owwRS+GeCaAjphTi2
 ZDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1nhHol+OeuolxLn8zd2+EjxiDEScjQpLpAy15xU6n64=;
 b=pfJYzRS0+B1D/E2ucRwItwSQvs+zHx6I604TxtyRzyLmuijadC9JHfzWIKOQY69bRR
 D7/m6MKeaZVQ79iS5q4GlXD9o19kwFAFX3kC9FPYfljYKe7ZiUTfVwjsewY9lhxOeTii
 /e6wu8EwwClTyHp/xe6aGYDhmIi4VPfHxbWxPRnFky9WJaNtetjo07/SpHe1OGzIHGkb
 CjMHeyfg2NRNt3lKiSqXVgqoVV7NnEmcoOhhKYQabB644JYozlQCzitbbbpO+xZaYLWW
 krplR1879OcgAe00xRWma9938Z/GQnEaDa8GzG1FJAfzdhdbYOs3JIabghzkLDMt4+FB
 wNgA==
X-Gm-Message-State: AOAM532pA0Xo27xVKDAg+kbWDMHG3yS20T8lbkv2vF7iB1LS+dPiUCo1
 rX/8obkwK574spAGYmrDeG0=
X-Google-Smtp-Source: ABdhPJxnTCBQlRJsz9QH0vjxbnxvOjqFmzMxXiOg1U2Kxi7opSujRAgod4JjlUv3COUg8I2NFB2Ohg==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr2931537wme.0.1594882571868; 
 Wed, 15 Jul 2020 23:56:11 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id g13sm7623107wro.84.2020.07.15.23.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2020 23:56:11 -0700 (PDT)
Subject: Re: [PATCH v2] .mailmap: Update Paul Burton email address
To: qemu-devel@nongnu.org
References: <20200707022544.24925-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <19b2c623-7c8e-fd93-290f-86498b85caf5@amsat.org>
Date: Thu, 16 Jul 2020 08:56:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200707022544.24925-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Burton <paulburton@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paul,

Do you mind Acking this patch? QEMU's get_maintainer.pl
still selects pburton@wavecomp.com for various of your
contributions and wavesemi.com (where wavecomp.com seems
redirected) keeps sending "The recipient email address is
incorrect or does not exist in this domain."

In case you don't want to receive any more emails from the
QEMU mailing list, you can Nack this patch, so I'll have a
good reason to insist with the alternative to have a
'ignore .mailmap', suggested here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg717757.html

On 7/7/20 4:25 AM, Philippe Mathieu-Daudé wrote:
> Following the Linux kernel equivalent patch posted on
> linux-mips@vger.kernel.org [*], update Paul Burton email
> address to avoid emails bouncing.
> 
> [*] 'MAINTAINERS: Use @kernel.org address for Paul Burton'
> https://lore.kernel.org/patchwork/patch/1140341/
> 
> Cc: Paul Burton <paulburton@kernel.org>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .mailmap | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 926cac6bb8..fe4c561338 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -49,9 +49,10 @@ Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
>  Frederic Konrad <konrad@adacore.com> <fred.konrad@greensocs.com>
>  James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>  Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
> -Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
> -Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
> -Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
> +Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
> +Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
> +Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
> +Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
>  Philippe Mathieu-Daudé <philmd@redhat.com> <f4bug@amsat.org>
>  Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
>  Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
> 

