Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD32FC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1104321D79
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KmchpE3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1104321D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGnJw-0006it-VH
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 13:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGnJO-00067f-Kp
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:58:14 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:46268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGnJM-0004fA-V1
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:58:14 -0400
Received: by mail-ed1-x544.google.com with SMTP id a12so10894913eds.13
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wtvKDRIRnxvpC2FNZL41r/9u5ApW78WKZHN3t/U/iss=;
 b=KmchpE3+MMsrj0vjs0zSG7609WMtID05yPT3vUU6ZpnyO2xSLminqtAlMiLvByxEDk
 ln2LUslgx/5dHwZK5+V6SH8VvmF9dWmOrOTv5wfUz4C+bKLGtVUG+ke+wMbsXI7BuVTX
 k55iZvhwpgwMNBKcK48PnL8Zi/nl4ECB5R8x6sVqgoWYvMn6eRrwiRdgYvUFyNHwJe75
 PsMd9Vp89jnDbmMGixozXd5LWci/EoN9Q/9BrD/ndXHd3XEtAWeJm96yV7H6zltSfaSa
 nFY5CJF6xEOzVbrAhV9wbwBIudrJeDRhVSgXe/D/swlFmVRoE2xJmrbI4KLhzHQ663Us
 pXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wtvKDRIRnxvpC2FNZL41r/9u5ApW78WKZHN3t/U/iss=;
 b=Nf/yARahjCeo+F+Ehh6S4QIG70v1tRVs6RdWJPRE/vbgwWzVjuzSnjxIf2fNdCaOy1
 LvO7K9tN+Tfc3TuMd6s46OifA/je1AuXL3pcBJg5g2JufUEYzQ/Knj6QJDNJemou8wIo
 951a+d3QTixmdIOl+gfO5PtvHaGEgmWi7m30JOzjUzBToxJeVEvYNelBhWRSwgikD8aY
 K6C2SkCKkEWnwom8T7+X2u0ydHt8lqe3+0iyPQsqBQNbDui23s9sCsaftk1CAhg1KgaT
 IvTMseOAwVPPRPDrCR3xw70Rx9v/4g5AxGxGLC76oov7lVHQF+OFtrg4qGPXMJAsI6/p
 OZcA==
X-Gm-Message-State: AOAM5327QPzr2jJT7xDKySJQ9f5VNyXsjBw24jijr28mfEGqDn77EQIw
 NqS9KBr2ijJf/ZtL17l1ck6geBoexPVWKgwtr08NhA==
X-Google-Smtp-Source: ABdhPJxHkSOVTL+p8StHxXP4oZ8WeDYCk+X3FB8N3UmuONweEcl2RnfwxxDwEgxyLX846uIt8YiuLXg+onG6aU+Awns=
X-Received: by 2002:a50:f1cf:: with SMTP id y15mr3540983edl.204.1599847091339; 
 Fri, 11 Sep 2020 10:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200910091509.14196-1-kwolf@redhat.com>
In-Reply-To: <20200910091509.14196-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Sep 2020 18:58:00 +0100
Message-ID: <CAFEAcA-wqOazkG9BgzDVzZMtAm=Jbor3jKvGpMD-LJigoYkpXQ@mail.gmail.com>
Subject: Re: [PULL v3] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 at 10:15, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 7c37270b3fbe3d034ba80e488761461676e21eb4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20200904-pull-request' into staging (2020-09-06 16:23:55 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to b9be6faed1a069526efdc80df7318b16afc6e116:
>
>   block/qcow2-cluster: Add missing "fallthrough" annotation (2020-09-10 11:11:13 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qemu-img create: Fail gracefully when backing file is an empty string
> - Fixes related to filter block nodes ("Deal with filters" series)
> - block/nvme: Various cleanups required to use multiple queues
> - block/nvme: Use NvmeBar structure from "block/nvme.h"
> - file-win32: Fix "locking" option
> - iotests: Allow running from different directory
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

