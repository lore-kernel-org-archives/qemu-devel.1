Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA52C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7812C208A9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBi7xNSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7812C208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLkK0-000781-CA
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 05:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLkIw-0006iB-5x
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:46:14 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:45493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLkIs-0003cs-3x
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:46:13 -0400
Received: by mail-ej1-x642.google.com with SMTP id i26so2728519ejb.12
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 02:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nllgYNxPyMxg+9Eqs8GL0RX7gm8gWfOiUDf/cZ/QpCU=;
 b=NBi7xNSHGfjV8qKFKb26qv0zN8aCehLPUiTOE4Lw10f1WhRNaLq/N6h6gQWeJ8/E/u
 ym3Gztn2U5MXd5a37M9g+okg1hQd6CIcjg4Rq6t4qD+Y/eBvfXE83GlYIoVSq7LPdhyL
 yi9Yo4q72U6wJBPhwqaH942iiwj4t0OXLuaAAISpVwQdVRFORzCaL1OLfqK8W6yTJInF
 LDpRtOgDGsbV7EIwiPu3No/nmsZcYYfo4qPHCmdkObj412Xcy3pTGqM//WqA+wEghGiK
 wrcGaZkYUtXjn1mB/sPBgbB+Git/V81ADKDqD2iLzz97wntGMkgMfmUMIDczxjngMmYG
 kTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nllgYNxPyMxg+9Eqs8GL0RX7gm8gWfOiUDf/cZ/QpCU=;
 b=ViFwRMIpPL9wp6u0Ufp5Lc8Z90W7CyeODkdicchnptnqQ4jl6eD9mZGBoNm3/j2zZY
 B1/Eqm/une8VUrv86R+6PsKBAy5/nnmJpvf547rkNpehVKiPAwmtB+qeniX6b81Kz2xG
 eq40dgTyoEG86zXemkK7gs3jSgqJQs/eoBD345y1s8FN0YmtA+tbNkNd86RKuhztaO4g
 zOaccvjCYnH6YR7v16Hf0UP9WuxVy6QBcPwU50Cci7kRjAHwT4zDdbUKePfvkIrZMe7z
 u6Gajd87KvNisWf7TcomMfSUPBCz+nZ6f2rm58YwhC2PrWCRoNVGVRTLaZQTEQtfLybN
 S9xw==
X-Gm-Message-State: AOAM533qaNgmqj9pH9pyDirPu3vhntKfeLYhTiwQ1yrgrE93DreAK4e1
 ajxuokTqUpSTDHo5hLOk9iLGOTQU+R+ydQB/0raguw==
X-Google-Smtp-Source: ABdhPJwXo3Yxwfa+xEr7LCIuE9bpHvumENmsheAHNwYITPgIijoRLftMvEl2zXk4a5V5Gd/NI7pvZd13kYT6WxUHUfY=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr1756098ejk.407.1601027165438; 
 Fri, 25 Sep 2020 02:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200925024143.26492-1-maxim.cournoyer@gmail.com>
In-Reply-To: <20200925024143.26492-1-maxim.cournoyer@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Sep 2020 10:45:54 +0100
Message-ID: <CAFEAcA_wU73U6eaHU0mwccr-E0EHSKzFJ1yiR++YEKv=1LneJQ@mail.gmail.com>
Subject: Re: [PATCH] build: Build and install the info manual.
To: Maxim Cournoyer <maxim.cournoyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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

On Fri, 25 Sep 2020 at 07:27, Maxim Cournoyer <maxim.cournoyer@gmail.com> wrote:
>
> Take advantage of the Sphinx texinfo backend to generate a QEMU info
> manual.  The texinfo format allows for more structure and info readers
> provide more advanced navigation capabilities compared to manpages
> readers.

Not providing an info manual (or indeed any format other than HTML
and manpages) was a deliberate design choice. The rationale is that
checking that multiple document formats all ended up rendering
correctly is more work than people will in practice put in (as
demonstrated by various errors in the old HTML rendering, for
instance).

That said, maybe other people will disagree with me.

> * configure (infodir): Add the --infodir option, which allows
> configuring the directory under which the info manuals are installed.
> * docs/index.rst: Include the top level documents to prevent
> warnings (treated as errors by sphinx-build).

This isn't the right thing. You should be pointing sphinx-build
at each of the individual manuals (system, interop, etc) and
generating one info file for each. This is because we generate
manuals for each of these including the 'devel' manual, but
we don't want to install 'devel', because it's developer-facing
and not needed by end-users of QEMU. If you do that then you
won't find you have problems with the orphan top level documents.

(We really need to move those orphan docs into the right places
in the manual structure at some point.)

> * docs/meson.build (sphinxinfo): Add new target.

You've forgotten your Signed-off-by: line.

thanks
-- PMM

