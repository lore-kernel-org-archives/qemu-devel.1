Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E921FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B76372065F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+fe8ALG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76372065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFdr-0000qM-VJ
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZFcN-0005hh-Ky
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:17:51 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:37541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZFcL-0002lD-SD
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:17:51 -0400
Received: by mail-oi1-x22f.google.com with SMTP id r25so24834455oij.4
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FYtiFn5hsdhRghFJZUw+0Ak8FyrvCYuKBT5Nok0qyBA=;
 b=k+fe8ALGm2vn4zmIR8d/x9HVJQKV7YymgIb36aPLzHJCJLjr6aixZMgk0D3FtyKQPz
 AEClD8DlXmiyxP1vG6AN+FAzCZXELgaEUMurceU/YlYkW+cDbxWhUffDGZY0plfSl69N
 ukqf2pgH9ojOHZ5qTgEi2IAAVSUfBSIbeKvJidFsIAD+2Sel3KKrYx7C/mU1DUZai7N8
 TeS69Rq29IMJMaLZqsCDKmJpbtfE/csWMIx3gxPwJbr1wK7MLHgf7dkn1jemgsisj2xQ
 RXbc6lEwrIjYkWnX8AVd5mA6HWOQZ3PrdzOM+I01p+fP34Gu1JEHC4j99D0BVrl5yAzd
 cFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FYtiFn5hsdhRghFJZUw+0Ak8FyrvCYuKBT5Nok0qyBA=;
 b=gmJ0mUEEHsWt24cPPfNM1oIYwYpt2csjtfFRpvJ6kKZmMpv4IBBKgxlJ88FAtQ/pcM
 kxctlT2Io2rT7wUnXvIkvmUUZZZiPMA7LGMkA1KvHC5D4uwpOXE9gpVUCGJcwtdV3ktr
 xtkG2SOrOwZf+hrN0MFf0RUk9OUEsWHIrXL/dATCPN6FbEIfqL5iSJpuJNTW6WtMc9+C
 eWp+YFU6gVqsPGOkrC9SZVgdVpH2awY26tY9qyixJO6xeKJFnB5FqM+AoRXLcxfg+mzD
 9kCDh0pQJ5mLx6gCgsuYc3E7LAS/1tERvggXJt3vj0foHgdIlkfhJ/X+g6E4UORYdHtK
 VR3w==
X-Gm-Message-State: AOAM533L5tjWWcImgGep+XYwtCBOAWOaSU5H/ISkPtLmlein4zGitcP0
 Pfd+arEs/St7ED9EVKYRZrmW/nv5+NAD50594UiqJw==
X-Google-Smtp-Source: ABdhPJwhEmFIqxZ9YEbzkO9kQue6sSrPM8Mq7npbTzLkNSHD59hin4fHBfJWQni3Gk7TOis8Wa2TqzFrFbUsH01Jvz8=
X-Received: by 2002:aca:eb96:: with SMTP id j144mr1487784oih.48.1589469468254; 
 Thu, 14 May 2020 08:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200514141402.12498-1-edgar.iglesias@gmail.com>
In-Reply-To: <20200514141402.12498-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2020 16:17:37 +0100
Message-ID: <CAFEAcA--MpxaXXZGqMZUC=pYwuRT-TD-tFEuB2kX=731xeMAnw@mail.gmail.com>
Subject: Re: [PULL v1 00/14] Xilinx queue 2020-05-14
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22f.google.com
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
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 at 15:14, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> The following changes since commit 035b448b84f3557206abc44d786c5d3db2638f7d:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-14' into staging (2020-05-14 10:58:30 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2020-05-14.for-upstream
>
> for you to fetch changes up to 2ead1b18ca1bbc41c09a82d980e1e5f53afa08eb:
>
>   target/microblaze: monitor: Increase the number of registers reported (2020-05-14 16:01:02 +0200)
>
> ----------------------------------------------------------------
> Upstream
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

