Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A606C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6104F207BC
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0WhKyrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6104F207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5Fb-0002e7-Gq
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5Ef-0001xM-LZ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:18:01 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:41482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5Ed-0006Ob-Ot
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:18:01 -0400
Received: by mail-ej1-x62d.google.com with SMTP id lo4so1307280ejb.8
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 05:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6YJU2+q8a3UHPg4tVdXaqhjRvE2M5bl/vRebXFNvQww=;
 b=g0WhKyrmxNoA7JHwU/n7HBkb7Zs+JLUdglS+ZbisPhgHD5Ak0LDILfXUb1/cMLINwm
 O/3dQsc7LLdEL742i4amZFRVsR1PFlKPaWUVC+iGNwqPiw8pndc/0ZOpgILt4BEKR+qr
 xg2YuusWi7ulO0ANlhtpi7YljGi+g2VZzt/9QANgzAey82e+x+c+oQBQWZb7jpz3TxaF
 h8M1PaZK/Dm6Xvw6fzZELM9NWNwN918gXnh79OHMXKmexf99O7wx+Kuzg/rh9r2rQMXa
 D+mvDwcaHSJGY/x9hK28s0gkhcg1OT2fJPiMbcG68IRtWBaTqb450u+rxccmOXCxIoQp
 KTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6YJU2+q8a3UHPg4tVdXaqhjRvE2M5bl/vRebXFNvQww=;
 b=r70ASakORgHWqG1vYVc/aEIfwNsptucNdZNmoMAEkA5xpk1fnSpj8WinfxSLCW8+qR
 gtheyUQ5DMYiuAlLah7LnLmiNq8Uxu0IyYiH6xFvx1pMSSUqVE+GoZEQjDB2SSeGRBwJ
 KSGKYzK2dp6jH9BI+C3a5cRVLxrFbh1o7DPaF+ti6NPZCz1NScJRcP9+gNlolhnFZy0o
 R9ex9eFZuwnm5lMr3RC0X/BFQNraVtw5al1uOXK8G3rDuzyXEmTpXMnbYeI/yPbrZX9g
 m+0xHT4u0Be259BndRSr5Bt+sC8eYK/rWhNd1kqp+FVeM1HTca1gUFk/ICNfKkfWLhFv
 PJ5A==
X-Gm-Message-State: AOAM533fEd8n6kVt9S92Q1lAOwD6ZbflpvxASc2g4Jf0PvdhCYbIbgoB
 p+3azMPFXR1yPcGD+aTkc00gcN6W1gtYFwkGd0fhVg==
X-Google-Smtp-Source: ABdhPJzb3eAsNlXnX7v5CBBKmDvCAbvYgSH2ifzYEGrQjIehSgNxxTYIOD5CzceqgeFPisSYc0bUsndI/ec+1vWv4NI=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr1162707ejb.85.1598962677716; 
 Tue, 01 Sep 2020 05:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200831160601.833692-1-richard.henderson@linaro.org>
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2020 13:17:46 +0100
Message-ID: <CAFEAcA-kSyymHxDjH=0yszvfp12s03uLGZbAcsKQeMAMZqUufg@mail.gmail.com>
Subject: Re: [PULL 00/76] target/microblaze improvements
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 31 Aug 2020 at 17:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> At Edgar's request, generating the pull-request for this.
>
> r~
>
>
>
> The following changes since commit 39335fab59e11cfda9b7cf63929825db2dd3a3e0:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pull-request' into staging (2020-08-28 22:30:11 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-mb-20200831
>
> for you to fetch changes up to 7233c0d0b0f5b65fcf6d6423de069ddf9f916392:
>
>   target/microblaze: Reduce linux-user address space to 32-bit (2020-08-31 08:45:45 -0700)
>
> ----------------------------------------------------------------
> Convert microblaze to generic translator loop
> Convert microblaze to decodetree
> Fix mb_cpu_transaction_failed
> Other misc cleanups

The patchew complaints about shifts greater than the width of the
type look legit -- could you fix them and resend, please?

thanks
-- PMM

