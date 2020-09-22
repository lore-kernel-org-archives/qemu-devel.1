Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C72C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C846E23A1E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5M8i5xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C846E23A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlAk-0005yz-Fb
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 12:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKkPY-0003VJ-Hv
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:40:56 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:40887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKkPV-0000lz-OU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:40:56 -0400
Received: by mail-ej1-x62b.google.com with SMTP id z22so23517921ejl.7
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bxEFYgUY2cx5IyfVcmg6AKvwLa5SECy4vTVB6TWDcvY=;
 b=Q5M8i5xmb9LvuVb6GV3HTuBzvIBuGNyDy4jWhSgPGvAsTSonlfXgv72xVZksL/QjEW
 6cbMYlt2aaD0yalOieKdxYmq0CViBL7avjvxN3hvE1o/gANod+pr5XDwPoauuUAUWKzJ
 OpllQxYKN1lA9qY0z5k4v7DptUNoUwVGQH0zE1N7Uofq8RQMKvLdanRT/NGoKCZN+w9v
 r5Gtl3HiqGjEigoFBy/zn/EkD2Mio4ATNksek+2fCEYGXu5cqZJwRCKipH4idcizOVEV
 33iK2cu7PPmJLyffYZ778HUoElSJNagUBHxR1ssY2Vq+HNbtyT4qc4ep5eUl8Cig6v02
 /sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bxEFYgUY2cx5IyfVcmg6AKvwLa5SECy4vTVB6TWDcvY=;
 b=mMgV6Xl6G6RgtG599QT5lhyq2HEgRx8miPDVSZ8RQvrOrz7NvAoB1Z0u8gC0R02CRe
 K+kqHu+sX4iYdURXow/6y/ychIsTN2J+G3yj5D+GKf+5ToYQgMRhR25EP81XosUBIFKg
 ethMWoiGGPW5F9/+3kNJMWuPAghdgIzo2TNUfwiIpr1yOCeEVvhvX3seowA1jKB2jd4P
 81b9opiQZH8s0QEDwiFse4bhxYXPDhiUIXG9JtR2ld98tawQCqi53z6T27XlbKKPHGTr
 lEdQP9KJ23+c/HLiJcOsmSDfyUcks7oven08f8NrTrj2wwRU99mX7uAV1LpvXCIHp14f
 dztw==
X-Gm-Message-State: AOAM531Bzg3gneGoF5Ai8TwZtDHLy5wQ8ixhLlLTxP5PC+rWa9v7g7y/
 uzmbxuf7Oa/oWg+V2qEk4tHEhm7Pb5+cgoNgSAdI47nA59qiCA==
X-Google-Smtp-Source: ABdhPJxPs/pvW/EsgJEAqxAEyLkhiWZyeZ6kNU9qmst4wLo3TewhyB37M2M8nU7nF+UtrO/i1n9tfEuOKVd1yjUQuik=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr5498197ejb.85.1600789251128; 
 Tue, 22 Sep 2020 08:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200919184451.2129349-1-laurent@vivier.eu>
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Sep 2020 16:40:40 +0100
Message-ID: <CAFEAcA9g1uatatmumU5xEtuJ+wA8Zrk5aBvz6DFozVwjBWXUJg@mail.gmail.com>
Subject: Re: [PULL 00/17] Trivial branch for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 19 Sep 2020 at 19:48, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit de39a045bd8d2b49e4f3d07976622c29d58e0bac:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200915-pull-request=
> ' into staging (2020-09-15 14:25:05 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-request
>
> for you to fetch changes up to 639b090df52a4952262615328a3fdfae81234ea8:
>
>   contrib/: fix some comment spelling errors (2020-09-17 20:41:44 +0200)
>
> ----------------------------------------------------------------
> Pull request trivial patches 20200919
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

