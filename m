Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF43C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F1D206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MqFSq/pQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F1D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTrT-0006PC-Lp
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtTql-0005ut-4f
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:32:19 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:37962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtTqj-0000KI-FS
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:32:18 -0400
Received: by mail-oi1-x236.google.com with SMTP id r8so1488008oij.5
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 03:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A0QhFbFxcIIuhO/urbNNC19h3fpqR1KgvzQMwrt8WBs=;
 b=MqFSq/pQ8YqFPoQ7EntTR1jkDgV1Q4vgDxzVHzQnrd/8Pi6io6VhCZrBsA2FXxc9KD
 dRnfUT2LJmNOJt/D8OtRuWu/5FIn+LHUtqhV3wGaRz+Xa0+zWmuziYeTjvBZJ3/kMbDh
 CmhzDOkTOxvVurYVthlZbn87TchQ6k5HEqblWsoujOw3tj5HoR9eLM8ddKf0oV7C7VHT
 vSATdDk6jMOU5j2tUAFPgxkc/jFH0978EjQZBVbh6o3qn053jlcINYZK0k6yiNbUKeah
 fzSqdp1WZvuS9WLsBbEWX1ttxXW3NciEyKXEun/HjzJSup6Ujk5iKgoMxT01xoKx+2UK
 KQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A0QhFbFxcIIuhO/urbNNC19h3fpqR1KgvzQMwrt8WBs=;
 b=P0WWeRkQdO0gjMQgjG/NcqVxlhqnHMRgJ5m2zrutskMp0usqABF5WJV5oYOtSLkx33
 NE4bKrslXNFte2VHcjlIE3n+4bpRR7s1ku0q/4BWWkyHCwYwe/1k6ZnOQj3aEwNA2bjL
 FnVTCNvsUS3XXu6gQSD+rfjyM6o3M0WSKRMtH43/N/pt4qCNrA9sY71BE3nB27R8PK7F
 pz2HfxSS1WQgc0mAKCms2L77atjLkVQ3MpBYHYuKryFA85LP2WO3bUvE6VR47GM456ZA
 DCrK2ERVXOHqJyNeXvU6xXhBgQPNlgFjt6A6SlTRe71WtA6ct9XFI32SqfkULMvZXKwA
 hoyQ==
X-Gm-Message-State: AOAM530a8RlITRuD0Z/DZTuydL2mz70VXxzLj7QPVW3vidDZ8VCIhZNT
 V49pZWtYef8nK1HfylCNjZvmHKlXgPSSqNY4g3eoYA==
X-Google-Smtp-Source: ABdhPJxPnmUPgOZDycAb8RZdMVAcuLM9sg63+Oj2C1xXrGx63689rItxbYqbzWd1FG0ZC1T+cSPWlG6BF0Lcf534jB4=
X-Received: by 2002:aca:1706:: with SMTP id j6mr10124935oii.146.1594290736325; 
 Thu, 09 Jul 2020 03:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200704182750.1088103-1-mst@redhat.com>
 <CAFEAcA_LrhvLmbwsSrhHUYZ+z9EZoDZwct+s3xfoaGLyLkOPfg@mail.gmail.com>
 <20200707080049-mutt-send-email-mst@kernel.org>
 <CAFEAcA_th3hhXcnyt2qV+rQNV1PgF62B5+=sEWzJKfHYj2=ooQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_th3hhXcnyt2qV+rQNV1PgF62B5+=sEWzJKfHYj2=ooQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 11:32:05 +0100
Message-ID: <CAFEAcA_sD0ZPJ7YNk+2bdhwqAFdoKipEPfg-E-xQQh-ukUsiUA@mail.gmail.com>
Subject: Re: [PULL v2 00/41] virtio,acpi: features, fixes, cleanups.
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x236.google.com
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

On Tue, 7 Jul 2020 at 18:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 7 Jul 2020 at 13:04, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Precisely. Sorry about missing this.
> > I made this change and pushed to the same tag - don't want to spam
> > the list for a small thing like this. Can you pick this up pls?
> > Commit 849c48004df0e123b53fe9888770cb4f6eb5e8ab now
>
> Sure. (You can always just resend a new v2 cover letter without
> all the patches; that's what most people do for minor respins.)
>
> Applied, thanks.

I've just noticed that the commit that got merged was not the
one you quote but 1e0a84ea49b68b7cf60e -- can you check whether
anything was missed or the wrong version ?

thanks
-- PMM

