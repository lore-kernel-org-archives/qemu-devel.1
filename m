Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C124C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB70206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXPuTKji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB70206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAXO-000409-CV
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgAWh-0003TR-JV
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:16:35 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:34036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgAWg-0001kp-MI
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:16:35 -0400
Received: by mail-oi1-x229.google.com with SMTP id b8so2042996oic.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hvj2wnYDyjs32bp0FgL5etwcSReOjjpJzGnpSirPh+0=;
 b=UXPuTKjisN2wKB5yj9JQq2FtA2VTPftG1rSyZMXbbSea7clJQ1+uPFK8NKz7qYKi0j
 TvwuMKr3vW9u2Yfgj46gDBYQpeTH+9/AU3VsCUL/AfO0KeJgmu+V6XUCHngW3KqLoF9J
 8bUT+4nFHfLwjHgWbs32bLJTisEfi1WQ3vMG56Mr2hUTOZGfyA1hjwKpclde67m3xW0j
 RrgIIX41h29tcxhJn3M5qu46mTaTyO0k238a0FtyRawNOvbiJYsmn27/bm+/mrOHEvLT
 qbuicuWritMep82mxNvAWb+oeMGezJXF87TjvouJ3K6ygn4CIKQbhfVJPbQOWv6VRXsc
 Qr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hvj2wnYDyjs32bp0FgL5etwcSReOjjpJzGnpSirPh+0=;
 b=YX0ADnxeCN6pmfGd3xFDXEM2+YZEy2KedotcyMmYqXIiIzEzdclAwhhhd3s8VwogBr
 Ab8Q7zJKn4aZZJLbI+gbomwfMK/eKihWJrt3NyHgmmqUM8kpRziyt2JVIkFe8Y5VWNo8
 LGRDX54OJEUGkTofXO9NVBAFFm2OSf1v1SZiEfFg5meDdbqz6BO79mSERyv1w2rlRkLu
 7Uc+pWUV56/0k7umMPfA3q2kreLeBy+kvG1++hxTvS75kYk36+zb9/XtIae+S/xBfiFj
 vgaTq0RvQodRcs570AkLdulZyt3GtJTA8X+mD0BK4YD/a3sPQ8f0j+JvU2G5Zdea4dcQ
 rhxA==
X-Gm-Message-State: AOAM53254A/g17Aaj9+OUpmOLenhLBeaHwuu9MtqIZKUMiiaRgyHBAkd
 52OsHpSXSYanTEi5jExmSQY0tsDnxsqkY+kb4hhpxa1hlZE=
X-Google-Smtp-Source: ABdhPJxMtOP/WCzqy0+SvyQOSL/GtCC0ukp98qhpy7AXwwjXwQYF3ZChpFGmLKZMgsB4P2qPCW+LnYM4uQGGRO9dhDM=
X-Received: by 2002:aca:5152:: with SMTP id f79mr3534915oib.146.1591118193250; 
 Tue, 02 Jun 2020 10:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200602152135.774894-1-laurent@vivier.eu>
In-Reply-To: <20200602152135.774894-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jun 2020 18:16:22 +0100
Message-ID: <CAFEAcA9VA+2ERJvppwA9ORn-07iDpO+T05_ZQWYtbSWq7eNaBA@mail.gmail.com>
Subject: Re: [PULL 0/2] M68k for 5.1 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x229.google.com
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

On Tue, 2 Jun 2020 at 16:22, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 853a60b87024b2f5d7c0c54a432d7798cb679900:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20200601a' into staging (2020-06-01 21:34:47 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-5.1-pull-request
>
> for you to fetch changes up to 250b1da35d579f42319af234f36207902ca4baa4:
>
>   target/m68k: implement opcode fetoxm1 (2020-06-02 13:59:02 +0200)
>
> ----------------------------------------------------------------
> Two fixes for the 68040 FPU


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

