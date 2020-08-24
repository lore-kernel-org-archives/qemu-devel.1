Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956F0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 12:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B0D20706
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 12:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oz9wcDyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B0D20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kABht-0006TI-MD
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 08:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kABhL-0005vX-GQ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 08:35:39 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:36755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kABhJ-0002ui-FX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 08:35:39 -0400
Received: by mail-ej1-x643.google.com with SMTP id l2so5647331eji.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/2T9BRo+gP4YX9uMR93EbHu76neaAL0XPnMTMxXKWk0=;
 b=oz9wcDyUGBa2kM0CHdhY96VndXbCh50P4u0aocIm3x8K+h+4L8yl9ANmz1GHvxcejg
 OMftRjT9JWP/Ksqp1ZkIwkJNlHploPWplONbbEZu2wiPsF298FNQxYaWE4hSnXG5RZsY
 xba7i/QUkHCuHiVsC0wiGvI2Gyydz0PHKZqO6sbysxzuxJRLe1GAi2cTqlaNIy6N7RXZ
 HZe5JDiQrfnzXj8SPvYSEp77RdBWYwF3Ld6RmhZOCsIRI4CMn2oJA4CH2zFJo77ILIT6
 fqxgzC1lthkUBjmfa2ZNocNtJJ5BFeEcxNHQMN6PQ/bDECCJGS5KYHeACSvUugGit2LX
 kS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/2T9BRo+gP4YX9uMR93EbHu76neaAL0XPnMTMxXKWk0=;
 b=FaR1DMPE6PKiGOldiyUQgQzgYrVY8xr2eNUaMptO0gPBO7SiKSBJcEHxGs8z8F7U0J
 ZZ5ZRVZIAVfuGL2Qg5IVkfmAqMnf6lHngXjNs0mAcemgXfHQEzD/N6wOYJXz0voCpUfL
 q4DAIBGYrs7Hvn6UXzcF/kf21pfcsSzNBbhzx25jp5A2qNd0E9V+QB962XM+FJZkScOA
 U/FXYeU3so4JuELlwDr/pzEBZj5re2pUeMMXSsEHWjDrP78bDWXzrX4PxGG6Rnv9vFH0
 J0mubY91pNlTncM4uBSZjlMbUM7WziQ53RvvRolRNa3HaAJZTZZIMekwy8c0rtgERJcX
 9tQQ==
X-Gm-Message-State: AOAM532541+JBgwDb1mmizSnoUmxNfqbUEeFu6TVxU1PFAa9zxz9voM5
 FIpml/DwLaZsVkJo6ZDh/5juF8ioaQ2sAecUFazSMw==
X-Google-Smtp-Source: ABdhPJwh/QAYJbu21zQvEkGSzv+9HKyuGwqyQq/dme+pwFNwezOD26qHIFcGyoqN9DPy/+bGIU133lQ29OcJOSHw08U=
X-Received: by 2002:a17:906:68da:: with SMTP id
 y26mr5215963ejr.250.1598272536095; 
 Mon, 24 Aug 2020 05:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200812101500.2066-1-zhaolichang@huawei.com>
 <20200812101500.2066-4-zhaolichang@huawei.com>
In-Reply-To: <20200812101500.2066-4-zhaolichang@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 13:35:25 +0100
Message-ID: <CAFEAcA8yMc+R+v_jhWeKPKWmjhR0VpfphLeK9PS0E+YtMDh-yQ@mail.gmail.com>
Subject: Re: [PATCH RFC 03/10] docs/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Aug 2020 at 14:43, zhaolichang <zhaolichang@huawei.com> wrote:
>
> I found that there are many spelling errors in the comments of qemu,
> so I used the spellcheck tool to check the spelling errors
> and finally found some spelling errors in the docs folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

> --- a/docs/devel/tracing.txt
> +++ b/docs/devel/tracing.txt
> @@ -55,7 +55,7 @@ without any sub-directory path prefix. eg io/channel-buffer.c would do
>    #include "trace.h"
>
>  To access the 'io/trace.h' file. While it is possible to include a trace.h
> -file from outside a source files' own sub-directory, this is discouraged in
> +file from outside a source files own sub-directory, this is discouraged in

should be "file's".

>  general. It is strongly preferred that all events be declared directly in
>  the sub-directory that uses them. The only exception is where there are some
>  shared trace events defined in the top level directory trace-events file.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

