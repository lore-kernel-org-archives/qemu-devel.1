Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F6BC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61FA2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJ3nJQU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61FA2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1qB-0004RZ-WB
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 06:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kL1p7-0003aO-6V
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:16:29 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:45193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kL1p5-0003Ae-Cu
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:16:28 -0400
Received: by mail-ed1-x542.google.com with SMTP id l17so19199528edq.12
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zgI0fSjoHrXdXRAVrfh3IOcuHUgPn7Lpg5PGgJXx1tc=;
 b=lJ3nJQU+mlZNOqWcau0E/KbOEvIQ6+K9adXwuuW2r93NQwwjhIVxjyAhq5ccW9xnaU
 CYMvfOD+3wUvxgZ47AG5tvmyPcinEPyLuhhwmTp8vNxxRzykmR9hXMtwtYk2Y/ZyG930
 oUF0NER1cFRRhnjzKeR9L1FDy5eWWpKNrYlLxeqZ3713CEeJMwNamUeIzzLPUm/lh3eO
 WVaJMzXEqg6ZhpiO6ELgKc3c31ZC9UtDTvacSwPlUlUxNoadcvvy5yUwLPilMFlN9ucI
 9nQJwbeIjnJWYNMTR5xbAySm9B1XB2iXRRkS8ByOFVfN+UyBTXiPE9FxO46DItQPLA+2
 lqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zgI0fSjoHrXdXRAVrfh3IOcuHUgPn7Lpg5PGgJXx1tc=;
 b=C9KCIY5KV7gjjx+zKUYENQTT8ltB1l9bVe6tawtINPnW5xDidw9IUrCKjRgPKgM/+C
 ICyULAu+qQAU0TB6xmDl2KVfJO9TCvIDbrt7ChXyD3bv0npL2Co62WA1OA9REob6nN9b
 QDLA+KVBednb/5JstKIuA8smFE8Ce1ZYdlKkWL6Bu4Fgzqx8voX8PmPsd/M/1WA992LQ
 kp2NyMj41zDWc6gBm8HyJqeOFTc40ySFa0Gt5boQ4FhYSevYQqqy13Z1xg2szzeQqb0U
 CNoRm3sUaVO3Ei8sThRcJuOIJ7w6kPfvIzn837MfsA7XjFaT+4j2iLh28+rU/TEeoILs
 NwQQ==
X-Gm-Message-State: AOAM532wU5Bhfb/alksXZpklBRbCObVaFqBnSapqLuLlicoWYM4euZbB
 DwMZMPch/6ghaNb/QJX0P7hKGRBpo9uV1SJWZZiyFg==
X-Google-Smtp-Source: ABdhPJx/ZJHV8qym1pKmuWEGrK+OuXUErKB/Q+7Gm4QW/+isETmweOxIGRYzgwGn2RVzbA/i+2RuqhSwIs8wvJsZ3N8=
X-Received: by 2002:a50:f1cf:: with SMTP id y15mr8987004edl.204.1600856185839; 
 Wed, 23 Sep 2020 03:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200923100220.674903-1-philmd@redhat.com>
 <20200923100220.674903-5-philmd@redhat.com>
In-Reply-To: <20200923100220.674903-5-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Sep 2020 11:16:14 +0100
Message-ID: <CAFEAcA9XOpCyWr0QXn6T_y9nh4ZX5Op2ztonefr-pV2oQfU3iw@mail.gmail.com>
Subject: Re: [PATCH 4/4] qemu/bswap: Remove <byteswap.h> dependency
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Sep 2020 at 11:09, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> All our supported compilers provide the __builtin_bswap()
> functions. Drop the <byteswap.h> dependency.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 6875e48d617..c192a6ad3e7 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -10,23 +10,6 @@
>  # include <sys/endian.h>
>  #elif defined(__HAIKU__)
>  # include <endian.h>
> -#elif defined(CONFIG_BYTESWAP_H)
> -# include <byteswap.h>
> -
> -static inline uint16_t bswap16(uint16_t x)
> -{
> -    return bswap_16(x);
> -}
> -
> -static inline uint32_t bswap32(uint32_t x)
> -{
> -    return bswap_32(x);
> -}
> -
> -static inline uint64_t bswap64(uint64_t x)
> -{
> -    return bswap_64(x);
> -}
>  #else
>  # define bswap16(_x) __builtin_bswap16(_x)
>  # define bswap32(_x) __builtin_bswap32(_x)

I suppose if we wanted to just use the __builtin_bswap*
implementation on all hosts (ie drop the special casing
of CONFIG_MACHINE_BSWAP_H/FreeBSD/Haiku) we'd need to
rename our macros to avoid potential conflicts with the
versions in the system headers there in case they were
pulled in via some other path ?

thanks
-- PMM

