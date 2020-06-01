Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5598BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 05:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200EB206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 05:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBwdMxL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200EB206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfcx3-0006Cm-B9
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 01:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jfcwT-0005l1-Ui; Mon, 01 Jun 2020 01:24:57 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:45841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jfcwS-0006sW-Mb; Mon, 01 Jun 2020 01:24:57 -0400
Received: by mail-yb1-xb42.google.com with SMTP id j8so4562612ybj.12;
 Sun, 31 May 2020 22:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oO5HEGxOO8hw9wulKpnEyuvshIZSpuUxAt7HEHTx5iE=;
 b=nBwdMxL+9N7p6rgGopqKaBDdkd/cWqqFl2YpJyT0OJQC5nFh7AkJzmWOR4LEpUGKYd
 IpvlIo98WDfX0lqkKja14MzMFLBedOay9ZCm++Myp0HBv5OK88BXkmjA07+QsgI2yxzT
 73pHVsXqRxRoy6PeS7GzZawmET7Eig+TwurtDEImT9XgSHmbpv2u0mNY5sowVnZwLzxH
 6wBKuFDtWRVkxBtHJfno11s75R+A8CK8m9IENswX80xJ+AtvWStmdl/W4ds1bV1n4YwM
 T6Z7BwVgnoLzx3Wd2l2R6X6xp/9L5uZxtv9wtGdFdwTByICl/ZwYLfDiqQfLM+ggzS/W
 6ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oO5HEGxOO8hw9wulKpnEyuvshIZSpuUxAt7HEHTx5iE=;
 b=K1bwkpQXPKqnIA8ZhQPn5Q+Mn6SwDgbY0bRJAqv2Fwv4FNsRL9chSy9EkViNx2NXKF
 9I9gcW3jLLTjHaztKCv3hltEdg8MYKDAwhDFH5A94E/oDvj7YxXgvGjitsJoOoFQKjQH
 6OwVT9qpEdWYJCXrrydtygnWHyPHmvvB5xWTnZgEuHnDJhcoEeO6eT4s2b8dDZHuWpfh
 KwRP2TOC9/ntR4bUeyiCRPXiTOlp55k7hu4RgnDCT9aBUm+7uS1fOdkuXgu4dWGB216W
 2BNdnc+TXwBky22kVJcyBlEqsU76tZfiKKdb3LEjxjgK5YvGpwGfatMaCIydmnQGxb/J
 yXXQ==
X-Gm-Message-State: AOAM530QJphK/CdAOIVao3FW8tGHlLJMwbh5PdStZH4/Riv6zU9x4Z6s
 OZfGo9az9Kh4Hzgr1dI3g0lSRLm751liCQm0B1A=
X-Google-Smtp-Source: ABdhPJxBQJbb/d48HjnHLnrQS6vepdATGxmwkqhGleBIhiqohdEsLm6Xu3A9922LU/SkEXZ3tQBuWIVu6qiReYRKwVc=
X-Received: by 2002:a25:1645:: with SMTP id 66mr32053606ybw.332.1590989095466; 
 Sun, 31 May 2020 22:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590704015.git.alistair.francis@wdc.com>
 <3e5b7d781f56c7a625c7c8ca5e38a9544e2995c2.1590704015.git.alistair.francis@wdc.com>
In-Reply-To: <3e5b7d781f56c7a625c7c8ca5e38a9544e2995c2.1590704015.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 1 Jun 2020 13:24:44 +0800
Message-ID: <CAEUhbmU4-z8TCDo0h17GFaDf80_D_dS7T+FqoK=qAfgnW5WvEQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] target/riscv: Disable the MMU correctly
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 6:22 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Previously if we didn't enable the MMU it would be enabled in the
> realize() function anyway. Let's ensure that if we don't want the MMU we
> disable it. We also don't need to enable the MMU as it will be enalbed

typo: enabled

> in realize() by default.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>

