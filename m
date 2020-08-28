Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A3AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B762086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpCHr+TI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B762086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnQu-0007CS-NV
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBnQ9-0006kJ-NC
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:04:33 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:45269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBnQ7-000463-VV
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:04:33 -0400
Received: by mail-ej1-x62d.google.com with SMTP id i26so838586ejb.12
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 16:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gXLJC6wTlNAA7Tvfuig79tyOmjObCV5q3ulQ0JoSn1s=;
 b=bpCHr+TIeQ76gZ38vI+Ekwb/lQerM1pi6XwG6gk3Mb/hcIzx5uCCCZhBj4zN0syO5S
 +ESItDw9a0jQtvLK/eV+hqKm/ZEdHd+dIfAJB505ar9xo/DmhUfSpqwKOIevygw15yuB
 /rEz43gYGouU4QS+Wprb7lzK9m5ggen7Y0DUsKO0vDQ3zd52/ZAhx5C3WaE+sF3pqEaQ
 wMXZlNZwlpM5bnXRKn+jgzLr9zlgETBPNfaycaas0DljVDqkirlTRzVaoziKSt31wmYP
 T1z6dAMeJuV2s/jgiWLHYe/Rp1KuNxrFHNVeNxAs9vnCcaGLV1Hnot3iCQ70YksUMlhh
 1agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gXLJC6wTlNAA7Tvfuig79tyOmjObCV5q3ulQ0JoSn1s=;
 b=Ed6+ApjS7IjsX2AU/ZbNh+oJABmYI16svTYIw+P4XWZAOwUGI+PDkQL1iv65ouoQda
 jruNnJNno6jwu1m2Rp5VrqQ7F0T4BpYhHv2m+BnESWykZsWwN/qTZhaZYCcSRlESy+m0
 TZKTLtSgvjI1++UEwOhJn1NfImaNL7kzf719rir1H4ttikUIrN0lwUhz4RS9xepnpUmW
 CkZQEO6EU58xq44yAJeTUqXNh7KUnc98PWL7Kce+15/C4esVj3GNpBgJWhnOk9/Kx+10
 rmIafCuP1bz6rAYBCnHzY1BcdaCxablXDZZ5P74yohm/SnUKMVz7mnEjsJSFjNmYup6J
 OYsA==
X-Gm-Message-State: AOAM533smhFRRsze8pnjukkeZH+a5YVUBIquCidVG73NtlKDUR08ASsA
 jLJO7cXgGriahJGZOyP4I/oH7yOThRYYDhKEuMYn1Q==
X-Google-Smtp-Source: ABdhPJwcbK89BU1x0BcnKAnJCQvQw4GjtSIHIYgYUr7vKxigDLyDyOHEu66KQLTrESs/5zbQAIjvyWWzIWfUg+wYpPI=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr1004570ejb.407.1598655870397; 
 Fri, 28 Aug 2020 16:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200828133753.2622286-1-laurent@vivier.eu>
In-Reply-To: <20200828133753.2622286-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 29 Aug 2020 00:04:18 +0100
Message-ID: <CAFEAcA_sCGWuHuca4LwwQ0MSODUH5hShC=NEyYo7zFgo5ENHgA@mail.gmail.com>
Subject: Re: [PULL 00/18] Linux user for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Aug 2020 at 14:39, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 25f6dc28a3a8dd231c2c092a0e65bd796353c769:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-08-26' =
> into staging (2020-08-26 10:28:36 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request
>
> for you to fetch changes up to cac46eb021fbbac77f1f98223b19608f31fc2236:
>
>   linux-user: Add support for utimensat_time64() and semtimedop_time64() (202=
> 0-08-28 15:24:42 +0200)
>
> ----------------------------------------------------------------
> add utimensat_time64, semtimedop_time64, rt_sigtimedwait_time64,
>     sched_rr_get_interval_time64, clock_nanosleep_time64, clock_adjtime64,
>     mq_timedsend_time64, mq_timedreceive_time64
> fix semop, semtimedop, clock_nanosleep, mq_timedsend, target_to_host_timespec=
> 64
> fix tembits.h
> add more strace function
> Add upport DRM_IOCTL_I915_GETPARAM
> detect mismatched ELF ABI in qemu-mips[n32][el]


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

