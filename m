Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D461BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 20:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6382073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 20:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoVn+BU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6382073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfr8z-0001aO-SI
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 16:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfr8I-00019G-G1
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 16:34:07 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:37837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfr8G-0007Ab-Hh
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 16:34:05 -0400
Received: by mail-ot1-x331.google.com with SMTP id v13so2300584otp.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 13:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iAZGUaL28S360Ho/ETw3e8PEYnL/vFN5NKQ4VNXBQDQ=;
 b=OoVn+BU9WI35t2dytpt0e0PaCN/Qglv9+ArWwDfMb6Ly7+b6kkZvxy0v73Y1qjsF4a
 7doVdmiSca3j2yuSQCPD5s7b/ppJDQOvQy9f5PGUU++4Qvcy52f2MBM9cy9YuLECKNm7
 FP/phk1f3rdnw8PPjh0WKFCEW90vGY023gy+JQZX6YLUyEWsS9XeVxt9DaL1g0QRpbIZ
 rVWSFbQYGpVXace8zAHTuS6wLVspn6iGuyC5BJbM0S76D8IgjOm8ICq4LZtvOz0bF6fW
 RzE+F5OE1k+TMTt9T4UbAly7drkvLPi0AwFy2C5Ojc+RWzNkknABSYVlx8MyMjPQFR3e
 zNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iAZGUaL28S360Ho/ETw3e8PEYnL/vFN5NKQ4VNXBQDQ=;
 b=DHXpBR0msBPrTrUd6FlJCp7+fKklBa2Zu2YuHAhTNtbiULoNkTAPv34jpOlY74iV6k
 DaIcUd5g+79cliJyyhxSvQat3GXJN+xpodk9udTl18R0X2rL9hr8JH/fFPmHJ8a2hSFW
 3wZj+WYL7dA1OMbHUfQ3LLfr4rTvage6kdqgXrLrcC7AZSxeBy7ielpomGZIaW5aYv5F
 9au2Bo9+qduQkC1OtvuCcsHIASuCc4Q5wA7QV/XTKbIQaWKVi5VLrPB4Xayco6PCjnP/
 PZ3+PKb5yz2n1QqMR1bPWXXsw03y0V/SbXmrgSIrqtxKLKDevdDI+Q+CfgpCEXrhZKhO
 Mc7A==
X-Gm-Message-State: AOAM531uaFtr8yU0oNMayl4TfAU9tO2OLqo560vdF+aZE0ZOVM/SW+ZY
 XLejSKKP/0e9emISYcHSaxlBmKZ9OW0377IZM7NdTw==
X-Google-Smtp-Source: ABdhPJxm3nKErNdV8wK6w+L8J+H7Quhf7VW2hEd7YQCo3D8DwXomKujbcVZinP78U283UG+nst5cC+pyWTS0MbsFXTY=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr17711775otb.91.1591043641978; 
 Mon, 01 Jun 2020 13:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200601151119.33196-1-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20200601151119.33196-1-kbastian@mail.uni-paderborn.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jun 2020 21:33:51 +0100
Message-ID: <CAFEAcA846P4HSFGJMTNe557AhL4WZgx3NHGav8CGuKDnuQwVvA@mail.gmail.com>
Subject: Re: [PULL 0/5] tricore queue
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Mon, 1 Jun 2020 at 16:11, Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
>
> The following changes since commit 7ea32024c6b3ad9c88d6200e73dbf76c8e160024:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-june-01-2020' into staging (2020-06-01 13:43:59 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/bkoppelmann/qemu.git tags/pull-tricore-20200601
>
> for you to fetch changes up to d127de3baa64d1cabc8e1994e658688abb577ba9:
>
>   target/tricore: Implement gdbstub (2020-06-01 16:55:13 +0200)
>
> ----------------------------------------------------------------
> Remove ctx->env ptr, add TriCore gdb stub
>
> ----------------------------------------------------------------
> Bastian Koppelmann (5):
>       target/tricore: Don't save pc in generate_qemu_excp
>       target/tricore: Move translate feature check to ctx
>       target/tricore: Raise EXCP_DEBUG in gen_goto_tb() for singlestep
>       target/tricore: Implement tricore_cpu_get_phys_page_debug
>       target/tricore: Implement gdbstub
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

