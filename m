Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF41BC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C9821534
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DvpMh6du"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C9821534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUsn3-0003Ky-0Y
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUskl-0000JU-BA
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:36:43 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:35317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUski-0001QD-D1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:36:43 -0400
Received: by mail-ed1-x543.google.com with SMTP id cq12so2101469edb.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 07:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=keLStt28txwsn24/WObNtsu64O7sm+xQkX05Hs6JSfQ=;
 b=DvpMh6duhdCmBU1347TMe/fSCxQ9nhquOe5KgtAcyRxbI8i7d6TKifwYeHcFai5eMB
 /c6OF+dm2YKbBsUCU4jbYXTbPGvFJ2Mcy8L+cld4simiJqbfbyhg4QpNWHJRfscr0Twp
 CWwizN3Fs0HeUSdiPiE8are3UjWZfMU3DMRzDqCQaubbKmbYTwX1Glhw8oZB9ZsVXZnT
 imOeOx+yRdbLlR5qovv8onTzJJrEDYRzALT/FjjrvGtMrgG5eMPelkkxKLYStkYycpG0
 lwl4mi/BRqwQwimIK+Ok15OwihUYyvZ0uFN/HL8WMfB0U7Pog0xlCLrGJQgVPM+r+ZqG
 eQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=keLStt28txwsn24/WObNtsu64O7sm+xQkX05Hs6JSfQ=;
 b=gtzUnBdj7I8/svaGwHjThWpravwEfIbdWL9r+CQdDn4UpqT5FDm2N1Q5uig93zaqhn
 fg+W70Sb+xXondmtHydByX8sFpWCt9s/6kO4TS35B3yUWnEd9o4b1bcZgAY9/2Gd724q
 8m5e8r22P12m/bWtDIrsRaiwmXipJv0+MYachARz0n+WRDwcQaHVKWetdhZrWjj5AhZy
 Aeug34hRDvfr/ZVuAJEZuiga+8M+oZKlpnvNZ3947i6p1jMaF3Xw9wYn6buljuUg0j6Q
 W9I76u+QEn5jYmEf7ytDtGr19k1HiKqF02yqONN6W8ZieKKq+ffJvp9jL9gwBqRDpnTD
 K4bw==
X-Gm-Message-State: AOAM530k3ww0kA5pKNM/N1US9dKpH3+AWpHPWfZtQclepoLbKSnACS8U
 VsgfUUhMjUf4ozKnkOSS/hapyjkUYEM5gaVZcykGuA==
X-Google-Smtp-Source: ABdhPJzZxAFW5AwJQylkPRxulXKwDCjMrWa/10L6XtcVzPhmNUq+TfE48f+XnapdcwV07VNlRjfnNCSyr92LRj9wyqY=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr3065612edq.146.1603204598892; 
 Tue, 20 Oct 2020 07:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201019093401.2993833-1-liangpeng10@huawei.com>
In-Reply-To: <20201019093401.2993833-1-liangpeng10@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 15:36:27 +0100
Message-ID: <CAFEAcA9Kh3nhjRiXD-YBZLoT_o82ZEcRn4NtPmhUpvBSNZGB5Q@mail.gmail.com>
Subject: Re: [PATCH] microbit_i2c: Fix coredump when dump-vmstate
To: Peng Liang <liangpeng10@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Xiangyou Xie <xiexiangyou@huawei.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 at 10:36, Peng Liang <liangpeng10@huawei.com> wrote:
>
> VMStateDescription.fields should be end with VMSTATE_END_OF_LIST().
> However, microbit_i2c_vmstate doesn't follow it.  Let's change it.
>
> Fixes: 9d68bf564e ("arm: Stub out NRF51 TWI magnetometer/accelerometer detection")
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Peng Liang <liangpeng10@huawei.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

