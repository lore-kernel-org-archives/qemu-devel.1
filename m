Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD85CC433F4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75DDD206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/MYT8EF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DDD206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0QwE-0003Hp-Jb
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0QuV-0000lk-V7
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:48:57 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0QuR-0003vW-P3
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:48:54 -0400
Received: by mail-oi1-x243.google.com with SMTP id w17so17685768oie.6
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TYO8PxIlsAos8N3ZFVn4wdERpcO0kCR5BgucFdzBHW8=;
 b=h/MYT8EF0MYviPSaKJeSNnF7cG+eRxR8pmGQ+tjMAfQwLLqUoOhQTDnwSBjBU/4q7b
 /byFQra6os4Z3UUdFhdQalK6xtPjksi7+cfuU8MgaJ6bRGdRyj8OZH3SqjSltlDAwVga
 c4t30hQdQTWa3YlX73VxHwPhOG76dTdN2NFmZCfNeNUKlKyruaUdJG4LhsGi0ktNBmZL
 nv5Encfg8sz8drcb6foHp4gtqTnudO+2jh9jAFGetoObEiYUWfyKOgYOaEcxbzGT2COV
 RjUpP0S2IMTZ6TGmNpKl7/1sZETxf4yJVdisKPhEtbEbIUJDCBQLk/GON4Cxd3s1RYAU
 npPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TYO8PxIlsAos8N3ZFVn4wdERpcO0kCR5BgucFdzBHW8=;
 b=j/Lm+em79ZTnbqOFVbibDZoNGdUQSN1A/nP0BZFWwUfBj8MWnLAD4YxektOpsCL4Y4
 lF958FQRpiWFTVaP+h49+bleDS8jgox03BDk0TsruoklplJOxo+IpSP17K2JTEu5juFC
 pPQMPaTDH1ppusM3Kk30DBpd8v5IBQZnO2mvtBXSYixLpHO9X60P+WAU88BmZ2mV2Wa+
 HwJqnYqaKb2DY8SQv3RFfIuplM5wBvzlZ9h8Pv4/Z259id4uTqlY54Upf0EfsRc/hNTY
 QxSB+PsNrmFMKbSPSCpi95MMWvkqq2y1i9MRL9skMFnuHUlBq226YfJJqYdSmI+9Suol
 tmmw==
X-Gm-Message-State: AOAM533/K2p+CNKzjcKUhSGOw1T51SDN0bdSPuJI9nokYtJJSAX60ov1
 +r6k4P1HL3Hfi+RArgxt+D5vMl2/UXuddYAJk9zKLQ==
X-Google-Smtp-Source: ABdhPJzmrL+8dH0Q7wX4FVU/nmrN81VDBvep7WmUrJc5rurbNrO647H+55OJSKmPCwLiqOMslLiG5OIrCk5UAeeGz7o=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr3755145oia.163.1595947729499; 
 Tue, 28 Jul 2020 07:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200709024657.2500558-1-crosa@redhat.com>
 <CAFEAcA9qdYm+a-PTPE-Vbhmp4iZ5Bo0Gt-2RcCrO7CS2yp9_CA@mail.gmail.com>
 <20200720172210.GA3987025@localhost.localdomain>
In-Reply-To: <20200720172210.GA3987025@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 15:48:38 +0100
Message-ID: <CAFEAcA8BD3BoJB9FAmeuZc8fKFNZywJT2LdGON670uM8ATdhZw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jul 2020 at 18:22, Cleber Rosa <crosa@redhat.com> wrote:
> Sure.  It's important that PATCH 2/2 in this series is included in a
> branch that you need to push to the "staging" branch on the
> https://gitlab.com/qemu-project/qemu repo (it could be just that one
> patch).  Then, you can run:
>
>   ./scripts/ci/gitlab-pipeline-status --verbose -w
>
> And that should be it.  You can drop '--verbose' if you just want the
> final outcome as the result.

I tried this (local branch named "staging", pushed to gitlab
remote "staging" branch), but it said:

e104462:bionic:qemu$ ./scripts/ci/gitlab-pipeline-status --verbose -w
ERROR: No pipeline found
failure

It does seem to have kicked off the pipeline on gitlab though:
https://gitlab.com/qemu-project/qemu/-/pipelines/171671136/builds
OTOH I can't see anything on that web page that suggests that
it's submitting jobs to the s390 or aarch64 boxes -- is it
intended to?

thanks
-- PMM

