Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C1AC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B275C20CC7
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RWns2rp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B275C20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWdFx-00041W-Ri
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 05:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWdFH-0003D8-3K
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:55:11 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:46069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWdFF-00018g-QS
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:55:10 -0400
Received: by mail-ot1-x32d.google.com with SMTP id e20so3954493otk.12
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y9OAXCF+hrV/h/YD2tN58cFguVCzsEFYOco8giLxdps=;
 b=RWns2rp34zDOCUm7wI7S3MVmMs30yMptLHq2VbD4h6lOfkwSdmXJDBynxg9ffGF4XE
 qM3AePlLs0olDzoPeF371eIKG6t18QqzC0uYAZ5Hla6hhWjh8+mkkGzbleUwBtFYJuBD
 DJ3tEC5uaf3Yh+oyy60BZ4RZCaD4/RHR9w5Uc7jVLyapO+/dDd5tlfBW9UMPXRcDm1Rx
 6OI0VQzL59FLtcfndnaVNh/dhqDCtONV/Z4IdubPcBIZeu4rcnlFx/nSTviXx1zOuSDm
 O0Z6b+DO76waj/awje9pGVwu6i20esBeVncn/YtE2H2faCSPrwWHvxTiJwnLGcjTtll/
 nnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y9OAXCF+hrV/h/YD2tN58cFguVCzsEFYOco8giLxdps=;
 b=Gd/CrqtXfBUrzgssQ5bthCXDy9y4IhlMkRwVcNf9859xm3MoWPIQsIstvJ89mJtalS
 9v5+/LGao+TItrqGsxwRCV5emnP8UUCczuRn82IyoCsnh3SOF7TmumG9MieAlkTZIiio
 wg8zX0hZfRSQTU6ot73sMUN0eeHAbhxJdZtwxd1XZDHfub6gmVWPINcdPjvC+hUs9EyN
 Fzy4kvvMQCNCJwPWlS3T9YJiRUJiGPIBDAI0wmlLYBPuMWr/VUVd9ej9ghNdZWIb9NQN
 shhCZ2p8LzJG5vFqnr4cG3Qk+TpfLgeZTCddLnlM5ZDmOHJgI86hW7OxsnTCrDabDr8q
 Bx2g==
X-Gm-Message-State: AGi0PuacvhwAMUW+1A51+6tQUIxxT8p0lI6bEBfJFEyeJtJjFANwDerx
 hWG7fOuIRpzp2LgOqmV69lX/vu4mtzG7Ol03DmCp0g==
X-Google-Smtp-Source: APiQypK7AhGjryuspcmwBsxiCWno1RbbA0iDTS+WtDP005Ppf5ICa1ADumkIE5st0/EW6Cuv7fkOz3er8nGx4mVxjII=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr9240316otc.221.1588845308219; 
 Thu, 07 May 2020 02:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200506183002.3192-1-richard.henderson@linaro.org>
In-Reply-To: <20200506183002.3192-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2020 10:54:57 +0100
Message-ID: <CAFEAcA8WTGv4f0ZWWLG6=XYmPgmx-Dfoc+Z-BL5SpC=-roE1dA@mail.gmail.com>
Subject: Re: [PULL 00/10] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32d.google.com
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

On Wed, 6 May 2020 at 19:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit a36d64f43325fa503075cc9408ddabb69b32f829:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-gdbstub-060520-1' into staging (2020-05-06 14:06:00 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20200506
>
> for you to fetch changes up to 07dada0336a83002dfa8673a9220a88e13d9a45c:
>
>   tcg: Fix integral argument type to tcg_gen_rot[rl]i_i{32,64} (2020-05-06 09:25:10 -0700)
>
> ----------------------------------------------------------------
> Add tcg_gen_gvec_dup_imm
> Misc tcg patches


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

