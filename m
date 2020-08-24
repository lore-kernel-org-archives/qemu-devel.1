Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4ECC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 12:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD112074D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 12:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywpANhWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD112074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kABbV-0008LF-5A
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 08:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kABal-0007nh-5m
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 08:28:51 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:33942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kABah-0001h5-MH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 08:28:50 -0400
Received: by mail-ej1-x644.google.com with SMTP id d26so1534262ejr.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 05:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0+IWJpKj6mxCkscyGhEufFMt2vJpj0/TILSpee/6VgE=;
 b=ywpANhWyq4jIrnCBaB0SNPUK39RMBp9sE3bvC90PVTPk0842NZrRh+VZt6VarfyTBu
 RJmcTiGAF8iXsIyECOMlbGLWbdfNUOpMGkpaM0IYB8iBP56LyBVGZc+GPp8uA9pe6SGK
 grcdmKyrn839t1jSOBaq1J3V/YjuKTKcQceYZMwg4gPFBMQZLyxtup8o2mp0l5FoPsBj
 hgL7Eo0ZW+xAq+/y6boteQPQPwnIv/9rFLEFfjKSkbiUU0k2K1n8JR1ip6nMlXkdyCXh
 9GaNNyvKGiRcNROScY9+KH9aVpptFedRWnf4mJtwyfvOFQOnvoymhz6HcIUGaAxr0zk8
 mqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0+IWJpKj6mxCkscyGhEufFMt2vJpj0/TILSpee/6VgE=;
 b=D8IbRaFuIP4GBRMh857f4JEANAxsCBfV3HHTmpooeBdVo7N/Hy4Pu686GNpkL5+0AD
 GbfDmWeW9hUIJfHogaYycLTcvo0rK4fDO7AjUwhKqGNnelpfwM0IVAcp92mwPiSJLm85
 oWlRlagLbUMSRMrBxrFCCeVMSz4e5lsq+i3SbXepD5lgW/iLVlFJzEKpf4RitnNco+8m
 dOQITVAS/T1IAaETwD30/XbeBuiFrhewbYEGrTNtbPHpzpkOAUP70Mxypw2NYSVbqCBm
 wZ6iUYJ03qfQq3axlc5sV/HGJJH9HJL2kEne8sArwcHNqS8yNOXRYlE+mN2r3XW5cam8
 dwnQ==
X-Gm-Message-State: AOAM530VYyCj4e3jdB4pVQxr5kXOHKmgtsTyWlDSItDo5YIbBV4ncOHZ
 E4o9gfu2d8SAC67BlOjE8PdrYqSH+HxCCXxkjHkD2g==
X-Google-Smtp-Source: ABdhPJxJQh33fCbzBnaXuendl50c76RCEsOti1DBQ4ShtAIzx3fRwMbbdDv5dWIUZr1qN6OC/2KYgTovXv356xwvPDQ=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr5114312ejb.382.1598272125942; 
 Mon, 24 Aug 2020 05:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200812101500.2066-1-zhaolichang@huawei.com>
 <20200812101500.2066-8-zhaolichang@huawei.com>
In-Reply-To: <20200812101500.2066-8-zhaolichang@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 13:28:34 +0100
Message-ID: <CAFEAcA_8MhCzgXrz9xX_u-YHnq-WZveux1M1tJ+tNAmgYP10UQ@mail.gmail.com>
Subject: Re: [PATCH RFC 07/10] block/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Aug 2020 at 14:42, zhaolichang <zhaolichang@huawei.com> wrote:
>
> I found that there are many spelling errors in the comments of qemu,
> so I used the spellcheck tool to check the spelling errors
> and finally found some spelling errors in the block folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -318,7 +318,7 @@ static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
>   * Do copy of cluster-aligned chunk. Requested region is allowed to exceed
>   * s->len only to cover last cluster when s->len is not aligned to clusters.
>   *
> - * No sync here: nor bitmap neighter intersecting requests handling, only copy.
> + * No sync here: nor bitmap neither intersecting requests handling, only copy.

This should read "neither bitmap nor intersecting requests handling"

thanks
-- PMM

