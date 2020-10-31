Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825E0C388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 09:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69112076D
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 09:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2iu+eJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69112076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYnWF-0002FK-1x
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 05:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYnUi-00010r-7C
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 05:48:20 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:46828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYnUg-0008GO-Ff
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 05:48:19 -0400
Received: by mail-ed1-x535.google.com with SMTP id t11so9097221edj.13
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 02:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WKjy4zTPF8MPHXnmYBu/S/pBDzC7/K19N3g8ih0+X2s=;
 b=x2iu+eJTI0fJBK1L+SltiaEqBQydWEezOTreLLxCHfKn9FCjGcBpSZ3PyozhACH4SG
 LrV6ZGzHZeLLZjPS2bdJRth4pcPdoF4dyYDAGJSS8QYrMHyVM91v7+cnuunk96/WNZ5Q
 S+r6bXNdcrsIMMcjwv+v7BqKl2ca57rbi1w3s4ON1mb7/1uwUevJ7zu7sm3z6epywllF
 DtEYqSXL/fVKlsTPYex2FXsTfPN0RqWGbX0D9Dl0CyjqEERr0L9mQei9ZmQepf8chgKI
 ZQ0HhBWogLl3WOOJ2J5sK276a9CtWVz2WqqYQzguxyZ9rTZtBdIahE+6ISdWwig6DDtb
 /xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WKjy4zTPF8MPHXnmYBu/S/pBDzC7/K19N3g8ih0+X2s=;
 b=c29lziLLDeT5/LMVWtv1Jt0n4q9a/4COmf4+MEMH7+az3w4+qYSBT1bJol4zog2PCJ
 LgH7Eyf09SSL+mZhnaf/qHPYosCpGmuvP/hEQyNUNZF15zJWQR0qwA4S8KwiIjhlmBaU
 WjWRWAbhxUTilymDbfKn2mQ0fIhx2q8LHzKc9e1Zoz5oCkeFVFNrtxs56zWQNNb2fr2B
 7zsaY4Ai9dhTIyv2sykJodyL9TjgO1omA0mtciiE29piLFZynGd28vz3rdrunUgm5+q8
 4J3IGYLuezJ7HlH0S+V0bHLkHOW5twcJ760JGkY6x0RhTmdOncL6X7nPlSC0bxsZ3GpX
 FXzg==
X-Gm-Message-State: AOAM532bi7H/6xWWsuVsdTFpv3rELm7jDVO/rbmzaVhF/Op6GGJ9v+uE
 3ghmRwdXQjZvOJrzo0ZhXG9SMv8E0YKsbnAzduaIUQ==
X-Google-Smtp-Source: ABdhPJydbW3gU926bK4YHywa4EPtDdcYlUOZ8QRbrrFPshh+pgvtGexjzkf/rbYVQjsSw5+4EDNgQN66EYsoC1qJDwM=
X-Received: by 2002:a05:6402:1482:: with SMTP id
 e2mr7069188edv.36.1604137697031; 
 Sat, 31 Oct 2020 02:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201027165114.71508-1-richard.henderson@linaro.org>
In-Reply-To: <20201027165114.71508-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 31 Oct 2020 09:48:05 +0000
Message-ID: <CAFEAcA_ZLojsYmmJNx3sGBe6CqFvJR5sM60qu5ES7zWhf5VGoA@mail.gmail.com>
Subject: Re: [PULL 0/3] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 27 Oct 2020 at 16:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 4a74626970ab4ea475263d155b10fb75c9af0b33:
>
>   Merge remote-tracking branch 'remotes/stefanha-gitlab/tags/tracing-pull-request' into staging (2020-10-27 11:28:46 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20201027
>
> for you to fetch changes up to 1d705e8a5bbfe36294081baa45ab68a9ad987f33:
>
>   accel/tcg: Add CPU_LOG_EXEC tracing for cpu_io_recompile() (2020-10-27 09:48:07 -0700)
>
> ----------------------------------------------------------------
> Optimize across branches.
> Add logging for cpu_io_recompile.
>
> ----------------------------------------------------------------
> Peter Maydell (1):
>       accel/tcg: Add CPU_LOG_EXEC tracing for cpu_io_recompile()
>
> Richard Henderson (2):
>       tcg: Do not kill globals at conditional branches
>       tcg/optimize: Flush data at labels not TCG_OPF_BB_END


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

