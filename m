Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3599BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CA52075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LerhkIzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CA52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97Is-0004un-9W
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k97IL-0004Ug-IZ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:41:25 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:39327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k97IJ-0000yI-RI
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:41:25 -0400
Received: by mail-ej1-x62c.google.com with SMTP id md23so1539828ejb.6
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=54kEgOfpLCq8NLjPIEC76Qfkc+513XVGe8a4r6u+r78=;
 b=LerhkIzz8qKr+EJQAon3dGOI5Ig9RuprDYYHvJMYIYOdj3CP2hSv6Lr1MJHxmvqfBc
 s0FqB2rQYFhqBDSU6IHNijMn8ABeNyf7iNlyZ2PpBjwtNsNdwsey+0Z14rq7Fx2m8Qan
 mLRY6t1rZIryoawpVGipMIt27JOBt70zJ9D/mZYmyH+MNGPAROQwcHxEkaV7oMNxBWzX
 kPQd/3fy0s7cuqWEc0xBhrFcoImEsLsk949w+jcdGrTFFPg7sIoSp7lmGhIaO+1h2dkn
 F0U/sj5Q4tvajDkj3rbIWQM4J1gnoptm8rVQbo/JvNNDWODMb8jsf2H5W/8ywsB2HctX
 uKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=54kEgOfpLCq8NLjPIEC76Qfkc+513XVGe8a4r6u+r78=;
 b=raeuXy9Pg3xDC5V0iTzc+QIZV9DvZGh+HwxJSZMt1RAz9iHv4YXbSC5Aguc53BVJQ7
 Xh8SN01XS2WU+p9zzDyk+ZHsUHoCCBT/9W7DsxN46oHcsvZLqBLA6CWhscQxQM3gjZ0V
 Q/AV9yc125UUn28VbiFC08yzcnhOu8cbEygrJYMplOzT8NQ4wOkfj+qiflg6RGg048Zp
 QU2GlGJy3xqDSaB/NlQKA1vAwVWzI36dt3RBVdsPKCiZacMTPXvSXabSoKoG8dxB0b9s
 cqcY27abTJHF1IQL2Lm2WWMLd4TqYtSU78ZVmHFrMG6Sd9ak/kZDzw3ona3wj1iaUGsc
 FRmA==
X-Gm-Message-State: AOAM532lwp0gFEIh8LVwgsBpsMK1w//0CeiNBPv7eSLeK5utRGVLrJ6e
 I6zDsUTsszntXJQqFmxUhnIongD1FOm41wTOltmjmg==
X-Google-Smtp-Source: ABdhPJx+ETs72kBMI5HBzKsEMhQfMRCTlJQfnC8lW/2uIz2AW0n8L5TEMh3AAmawmWVomn/d8f1BkECE+vCFg6zk89E=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr2868726ejr.482.1598017281989; 
 Fri, 21 Aug 2020 06:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200821103509.7670-1-pbonzini@redhat.com>
In-Reply-To: <20200821103509.7670-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2020 14:41:11 +0100
Message-ID: <CAFEAcA8kkdPW8Q+2AJtCgSGPF8aBnht3Ao34FPKObDxmjDoCCg@mail.gmail.com>
Subject: Re: [PULL v9 000/152] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

On Fri, 21 Aug 2020 at 12:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 1d806cef0e38b5db8347a8e12f214d543204a314:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-08-11' into staging (2020-08-19 22:19:11 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to a14f0bf1657adef0328a3a756637b93f53ec0220:
>
>   docs: convert build system documentation to rST (2020-08-21 06:30:45 -0400)
>
> ----------------------------------------------------------------
> New build system, with "fake in-tree builds" support.
>
> Missing:
> * converting configure tests
> * converting unit tests
> * converting some remaining parts of the installation
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

