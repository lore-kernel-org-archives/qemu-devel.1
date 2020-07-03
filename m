Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80D4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A822520870
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OWuXsgZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A822520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrMBC-0002Lb-0X
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrM7g-0005Xu-Ak
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:53:00 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrM7e-0000wT-CD
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:53:00 -0400
Received: by mail-ot1-x342.google.com with SMTP id n5so26785922otj.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wpc26K4vIHW7s7G0jjwpwG5GXL2DZyAsm9Rh8wYBjkg=;
 b=OWuXsgZ6qUv8VQXPhEX+8AscWWs5PL3NntUQhLvZ4GuEpjGOlb63s6YYatjndc0M5N
 RK8Rgl7z2B3gzV3ukQIsrOUFGEgVepOfl2cGlWifOW1VoCBaCnDmQSRU50JZrHALoc25
 2LYg1kuvjKDYl/B2wqRLBLlrneLQCTrFcuHLpIEl7zpYJzeOP1d49F3yLu3kSWMRvZRm
 iBQ5LvK0iwgRj+iMGubkwDccQtuSL85idPCrN6sak8u7F0cQ/Y6V3m1c4B3W/z5qgUy9
 eD/Mnlun6Qa1EWxwAQC+y8h55BW8ge5ougjtX3qW3IOJtMtdLXL/0AozsKh7l6hXMZ0+
 M01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wpc26K4vIHW7s7G0jjwpwG5GXL2DZyAsm9Rh8wYBjkg=;
 b=JWHa+mn1XzzwXwVQyWTjZnmLITCXm09IOp/fCIQN2AYoDMI4I56/vQqCjMmOSU50Gw
 YQjpFPRXZkD10rfuWtC9CcA1EINboTZWXTs5zXt9hQpEfz0eK5PIPzYDOugfinLRFhBu
 gd+J59Op/cqEAD/kucM0MydHZDRK5Ubqas3mZ6xdTQ1CUbeMlvCC1sS/YdOyHESOWRwQ
 zkNijk3H6pCJYJ3nHD/ucVx+lGs+Z0/3lagCQhaoBd5pMcHcr37ynI0pH8AvtfML5VRX
 icw60IUFxX7V7F0JYCYUDywzC07eSIPB+B2O8lpC+ID1D0AiZOHWFR2V+9pWQ+qLJ3sM
 MvIg==
X-Gm-Message-State: AOAM533Q6MpktaWQYRsQpprtZ8lv/A9H0C6yrapQsgnV1g688ojA6qjx
 w3G6KZMZrPAW6N3KOLoKGKomihuH4gWewsM5Nsy3ZuzIj+M=
X-Google-Smtp-Source: ABdhPJznsJBmGYE4zSd/XdE2aIPEEd/jodkGDBzTkq1kv3V+w+EKHhDpkc5o834osixtxkFltZcEcJepCtzAW9MYyc0=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr28478686ota.91.1593784377356; 
 Fri, 03 Jul 2020 06:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqzmb0K5HaOBNy31rNU0F0O4kq+B6eeYCUXiJJE6ENDsYw@mail.gmail.com>
In-Reply-To: <CA+XhMqzmb0K5HaOBNy31rNU0F0O4kq+B6eeYCUXiJJE6ENDsYw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:52:46 +0100
Message-ID: <CAFEAcA_O0NZgjz=q8cG-wL6ZNMS6rt2kO5VwTr_KLMsh1v6BJg@mail.gmail.com>
Subject: Re: [PATCH 9/9] Implementing qemu_init_exec_dir.
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 01:46, David CARLIER <devnexen@gmail.com> wrote:
>
> From fcdb25804af98329b52a04e7a4e5191135aac4f6 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Mon, 29 Jun 2020 22:36:03 +0000
> Subject: [PATCH 9/9] Implementing qemu_init_exec_dir.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  util/oslib-posix.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

