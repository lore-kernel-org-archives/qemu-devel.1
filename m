Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE7EC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 21:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3237621D81
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 21:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uT2VBie4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3237621D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG854-0002XL-5B
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 17:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG84O-0001jN-8k
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 17:56:00 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:33701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG84M-0007XV-81
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 17:55:59 -0400
Received: by mail-ed1-x531.google.com with SMTP id g4so4259140edk.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 14:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mwWHP4F9lJu7lVATf6KUNXVKGBl4QTFsNwA68OU+TEQ=;
 b=uT2VBie4t9/FJ/99g5Mp/eG3I+JT9/3Uj28VZUlj6Hlv+8FnTZCz0pHDHI+wNKLtd0
 em+hmxplEemiaK4OhvOYjD3fwGTdMzIluJSc5KBKyRZi5xTbY6Le3vxcqvWanZRilTHa
 rMyQKQJKWWradSN7iNiqUl1zZydUNh1auvcZ9f7oCqPgX3+jjirfIThjWSRN2elTgfUJ
 obvLM+AIs+ySOv5lEzoT9gq6By7WRdWiSxxgHkaHOQv19wDjuzzUF1ypApB6HW5Sjgih
 ABp/poUQW+SLkOJ6ciYEJKeYGIimLxeKXC95EkR0mzldso4upWZbG9r59Qe0IWvKl8us
 SOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mwWHP4F9lJu7lVATf6KUNXVKGBl4QTFsNwA68OU+TEQ=;
 b=UreV3wKg6tQPMYVOUoHHo9nfhzuBa1ZEcLZc6FTx51IOaCx/9Kym4Q7BxWs+/Np0iF
 CnIpfCn4iV6T7FsgQF/HSQPGSnDrRYtGzcbG8v2qB3FeuBz/UF8vQqzXJ59/5qtd8kqV
 eeK4CQRzwM6D7QB0qiaJ/7V88cBC99J3YeoYBroGnRGqsmI2gEMSJTm45aaIZIOomnxc
 edp4U4KzFk9aKUWEcmWfPKS7tQayBEbsKb5pz2EbILC4MqUVGSVDGPK8zeJiZAD+2O6/
 WVftY2hjKX+kySOqPv6Mc6Cm3CWs4HmFVUzyD2bUNkGCwp4T93HtV3x53T9KDV4guUEV
 0LHQ==
X-Gm-Message-State: AOAM530ZdQXXRGZHjjjb9W33uPBX8Es/O54xMKtyHNiSOs3/HTt6u8eZ
 rzMASvkkU41U/Xc8CShd+/s+JBm15hbt/XKlUg9OxQ==
X-Google-Smtp-Source: ABdhPJwBu+Sm1uK3DYx58cgk8HyebW2n5CA37gzciH6Uk9+8noZf/8yRdTIPtUg6DP9OYKLz0vwlZNuPCD7Da3z1or8=
X-Received: by 2002:a50:f28b:: with SMTP id f11mr6171223edm.44.1599688556358; 
 Wed, 09 Sep 2020 14:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200908115322.325832-1-kwolf@redhat.com>
In-Reply-To: <20200908115322.325832-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Sep 2020 22:55:45 +0100
Message-ID: <CAFEAcA-wrgOC9oqdqBuVSTiidaRcwbgQWF08zD=TSetSwn_tjA@mail.gmail.com>
Subject: Re: [PULL v2] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Sep 2020 at 12:53, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 7c37270b3fbe3d034ba80e488761461676e21eb4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20200904-pull-request' into staging (2020-09-06 16:23:55 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to c984095a47c30e0952d34e77decf9f4c0f8d5a19:
>
>   block/nvme: Pair doorbell registers (2020-09-08 13:40:53 +0200)
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

This fails 'make check' on NetBSD and OpenBSD:

./check: line 47: realpath: command not found
./check: line 60: /common.env: No such file or directory
check: failed to source common.env (make sure the qemu-iotests are run
from tests/qemu-iotests in the build tree)
gmake: *** [/home/qemu/qemu-test.vcb7nz/src/tests/Makefile.include:144:
check-block] Error 1

thanks
-- PMM

