Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49892C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13767206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0AtwJrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13767206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxuFF-0003AI-Ax
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxuEG-0002Qn-ID
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:30:52 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:43087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxuEC-0006ry-LD
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 11:30:52 -0400
Received: by mail-oo1-xc42.google.com with SMTP id t12so3993176ooc.10
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0QQ9LSjKCX7WYfKLzfQabmF5yYVgASKsc0PsMjohddU=;
 b=S0AtwJrznVS77udcGXJ6C+rq3sgZI8k+bnHvUNZyX6VQqwZ1x/qJs1wNJUnzCXb92/
 1OpxsqwN5mvqE8srAHyaK1sWp4v9C6VVKXq6Vjynf7I53FZFd1kNiZoK5bfs/UMeMmSe
 5eUQQPkIbx59CTCfSCOrvZzg3Jq58Eoz65TlBMUcoxwHtmU+C0FiFQW9aLRITpM6B3Qo
 8VywssrIkMCr/SFfBJyI8BoYwkXFHwX7fEVeEmkugvjBoaYK6OndodGuSeL7rudzBhnz
 N3Tkmb5xV7K0LrrD0B1zlw9tbtZo0868QA93/q23DC6MWjS+7ZgzUfBgyZIvqZKZswur
 q7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0QQ9LSjKCX7WYfKLzfQabmF5yYVgASKsc0PsMjohddU=;
 b=HIynKmC8c8ptz23dfyCt5BongaglbBqEgl45YyqYaXxMrDtsuOy/09c6Y20X92r/8M
 PtAeGYaIQfBkEVvKi7bvSoc0uznFBe7XI2F08c2qRaLvo6EuCM6aZ6vyDpzIgSqCFUQK
 krTiedCtdN6n1Ip7mMOO4x5xlpk2yMIyOm8Z1YQEf89G5V34gLnmXnVAhsQB0NuSQ0GF
 uNxtUmdJjZTIEWgT4qeXrbKpFC96e1Va/z3DBv7o7u6dKJxW5gyPhJEHkNfJrZ4fM7vw
 Ku345gwlKVAalNtoPg5zESowrjCG9EuSZnE5lqREUBY6kYN4Y/M3Cmu0UIJtpJfoNITQ
 BbRw==
X-Gm-Message-State: AOAM532FB+uFrJSgYVibTpGr8Hyw2UtvPEN7msw/3sy5W6/L+vbhBeqI
 zmEJYe4jTZG8Azxigx777k1LUt18OXxNyb27grq7PA==
X-Google-Smtp-Source: ABdhPJwEjUKRlt7/9Vtm0V732JItyLB8ucoLbon6TSCrWXVf40El/VPo4d24LA7VfHXNFRChdTBcy2hmqZ5DTtAE/KY=
X-Received: by 2002:a4a:a685:: with SMTP id f5mr14420256oom.85.1595345447041; 
 Tue, 21 Jul 2020 08:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200721133742.2298-1-zhiwei_liu@c-sky.com>
 <CAKmqyKMPrwkxhXgfWqEofGUdKTJ3jAi7hQ7h6hEP-zFDN3Yt9w@mail.gmail.com>
In-Reply-To: <CAKmqyKMPrwkxhXgfWqEofGUdKTJ3jAi7hQ7h6hEP-zFDN3Yt9w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 16:30:35 +0100
Message-ID: <CAFEAcA87pws6QNEoJk4B-+vQiE3Pe7munfJiWgQZuTDZ+uBZwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Quiet Coverity complains about vamo*
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 16:19, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Jul 21, 2020 at 6:38 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
> >
> > Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Interestingly Coverity's latest scan has decided all these
issues are 'fixed', even without the assert. I guess that the
online version of Coverity has had an improvement to its
checking and so is now able to figure out that it's not going
to overrun the array? Still I think the assert is worth having.

thanks
-- PMM

