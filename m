Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229A8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62382053B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qemx+Vu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62382053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jotXg-00061K-8Z
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jotX7-0005aF-UF
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:57:05 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:39407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jotX6-000050-9a
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:57:05 -0400
Received: by mail-oi1-x22d.google.com with SMTP id w17so8213905oie.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=VHBPVqcMt5sCPlQeVBxzWdhU8nukmV6QsdzubvylcGU=;
 b=Qemx+Vu6EMCGUegPvdP1ymb0wQ7RPtilJgj2C7cqt4+SiSjUooDJbuSOsDBNH1wZcK
 09j8gNCM6oALT3eIDkippMfCcYK97DYzsWUZ+1oj01FwO4pi7KCt5PeDUnweqZiMF1Kj
 HZj1ypHVJ2+cY/NP0Y1J2MYWIqnprU7LmITQjmJSMfQyiKOrzmm1zHHjVoxRIEywi/se
 MSzFSFZudm48y5ubaETLc+wKCXleJ5G3g+DWY24KsYPl9vcQ27wE5wlUNn7IId53QL8X
 WPQ0XyFQ+oQtmSmcRCFl8NEPa4z1KB8XCRj0fWl5NWTYgQTbm8zQjI8UgjGcL0Blz7/g
 KYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=VHBPVqcMt5sCPlQeVBxzWdhU8nukmV6QsdzubvylcGU=;
 b=licfbhC8X6BBdUksCg41tZ0PV9Mt8WCm2PYG7tJ/1owY+9kHVhwZEzOhDydtkds4vG
 rJaYoWq+4htzeWx/K1KWzg/6en1Uf18EzEe8Ja7tGBk1xDwZNJBVG2BalWxH0uzCaOlZ
 BLGV7WS07t2aO7vn3b3O9IyZ1mBjbbfWbf9OuW9+7VljDebvAZdIMsnf8C5xSvjon5eK
 OZwRizQlHZZ03F35oOn+t7UpfrBF1pgm+I+sCqeoI+4PJvNFN6GRjh+UhdJcxIK5d5FC
 PXUOfMIgc5XZqriWL+MZcCmwYq5oHl1pezHxViSSqyAZdABfI8olwU1XvHiy9xZnvmE7
 qLfw==
X-Gm-Message-State: AOAM530R6Ix+WE+aej5yo3UmjXsa5kKp11ZLh0dGdt9GEhbmjvs6qjho
 6A8LDPuz1iixt4Si859VmgEOzYvs9oE8MAZQZvkR7j/IiG8=
X-Google-Smtp-Source: ABdhPJyWxIvUWzGylk3iDb1B0f0cKKBPcuTiDWPjZF2F1NeTCaPcss07X+8NXkE5cGmptAX9bDP5Glj1/nIVsdLNGxQ=
X-Received: by 2002:aca:568c:: with SMTP id k134mr3344169oib.48.1593197822404; 
 Fri, 26 Jun 2020 11:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200626151424.30117-1-peter.maydell@linaro.org>
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 19:56:51 +0100
Message-ID: <CAFEAcA8Y1iWB++bahiRz38xevxy=UVx_j2phgjdGX0kS0Xzfqw@mail.gmail.com>
Subject: Re: [PULL 00/57] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 16:14, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Mostly this is RTH's memtag series, but there are also some cleanups
> from Philippe.
>
> thanks
> -- PMM
>
> The following changes since commit 10f7ffabf9c507fc02382b89912003b1c43c3231:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-macppc-20200626' into staging (2020-06-26 12:14:18 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200626
>
> for you to fetch changes up to c7459633baa71d1781fde4a245d6ec9ce2f008cf:
>
>   target/arm: Enable MTE (2020-06-26 14:32:24 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/arm/aspeed: improve QOM usage
>  * hw/misc/pca9552: trace GPIO change events
>  * target/arm: Implement ARMv8.5-MemTag for system emulation
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

