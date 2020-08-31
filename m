Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4696C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EDB32071B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/3YYDoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDB32071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCois-0001Ir-9J
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kCoi3-0000tD-F3
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:39:15 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:40543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kCoi1-000721-75
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:39:15 -0400
Received: by mail-ej1-x636.google.com with SMTP id o18so9838339eje.7
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dICnIPZASVNKKrmh6ZmzExC0Ryd6kHigLRkpWqX9NQY=;
 b=h/3YYDoDynXglnHPxb5PBIQifNmbvChkyq1cniPmjkKwCgkxfM9t11MOBGP98BzLsW
 NZF/mHPAX4DzQ8Lem4RlW9D1if/o8r8MranJ+yuc2vpr7NcPi9HwAcC4lREBssa2MKAa
 71HYt95yYnobt2z0e9yN/y22VwHsDQeLQRX6j7DIg8bjn/wdVlnsuLp2SJzzMfLIYtM6
 skGMoEPYREEjtO04lepnkqJfBK0NDp2iRJAWf+Bv9wi/k6SBcjCin/OAna8VY/9MdDnG
 EPuGFNrooCS1+dfwKVdr1sKap8QEeTz30wFfY9MKuZCR5tkbitmRoyEEDWhTLfjPNyFp
 tOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dICnIPZASVNKKrmh6ZmzExC0Ryd6kHigLRkpWqX9NQY=;
 b=O/XKk/2rWFIJDUHjfSaqVv1yp3iCN6UptwP8LwE9l9jZYvIcDK2zrFsCfyab/CS6y4
 buUCaJ8o3dqqrg+tvowqeHEs96H7rhYGPMykhm6KCW1qdCTsJbnxPGUF9fscUd2B0zS5
 VV9RhJnCSemFpEGVUmYVzZ4gW1x8kRx8NGdaaqGhkzAulTD+4UwdMq6H9dM/2F4q4SOb
 G4RuWZhvjAfjIKY2S9+RZ6/oagI8Epm/GQro50syLfd4t4QzLS6YtZTRHrigI33/TXYM
 806+oCMevh4Kv07wo9qfmOkJ16fdq+GLfi+WqJAyLQyXMXYkPnUclcAeZ+bm+uGzjaro
 QF5g==
X-Gm-Message-State: AOAM530yqz2qc44izpD3NfoPBG46PSH59fZNwatxQkO3kNQ+hiYdBLOZ
 2zXyinHAIHoGepZ/jRA9z+Y13e42BwB/ADHOT6od7A==
X-Google-Smtp-Source: ABdhPJxErron6DsMNwVR5UWL0ACRTa3Av3zory3IgWrgoKn2RiQOKn0nEeJeQtEvwef0UNmz07+9vDq1lOlRJwfhdOY=
X-Received: by 2002:a17:906:71c9:: with SMTP id
 i9mr2183605ejk.250.1598899151072; 
 Mon, 31 Aug 2020 11:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200830023203.612312-1-richard.henderson@linaro.org>
In-Reply-To: <20200830023203.612312-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Aug 2020 19:38:59 +0100
Message-ID: <CAFEAcA9WsDs1J5tqWdh8KbkasGd4b8GA=+k11-7fy9ivhw-YwQ@mail.gmail.com>
Subject: Re: [PULL 0/7] softfloat patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 30 Aug 2020 at 03:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit ea1bb830cb021cca2e361091cf728aaabc8c0654:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200828' into staging (2020-08-28 15:14:40 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-sf-20200829
>
> for you to fetch changes up to c53b1079334c41b342a8ad3b7ccfd51bf5427f5a:
>
>   softfloat: Define comparison operations for bfloat16 (2020-08-29 19:25:42 -0700)
>
> ----------------------------------------------------------------
> * float16 comparison wrappers
> * float16 conversions to/from 8-bit integers
> * bfloat16 support
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

