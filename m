Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20362C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08032250E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGFjBk4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08032250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3H4n-0004oW-6C
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3H40-0004Il-MK
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:54:28 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3H3y-00085N-Tw
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:54:28 -0400
Received: by mail-ot1-x342.google.com with SMTP id 93so22813851otx.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 03:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F7wzELlCfZcRTt52z7FPzNvGaGnfFHLckxUEbGaXhrA=;
 b=UGFjBk4eZAamT+cwV7BTy0VmQnXWofg5JuvkDyPyzojdSek0eeswKJXUZFVxYyjY3K
 CTrVkQvNK0/9rUKg0NcHXTikNjwyf0yKlou3hfZBMb7J3bttvPyrX3JNd+AlJpziEQrV
 g4EEBPuTT5Ncr6Dmi4kfPdUo4ykgkZm3kBAYSp8uC5i/EsoMkzG28CnRSEGkFxjmNT1B
 p2OgfDPUanyBVJbTpqjrcs886SsQkQOR8fCWrklOUMTUfj3C9gCjosNPTXwdwdfFXsae
 sjHyp3z0Oo3XTbNcmdmzz5UgkP9R9UfB2ebynd9S2ECoX/nZir+DtXbY7GB1sck0LCP1
 mLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F7wzELlCfZcRTt52z7FPzNvGaGnfFHLckxUEbGaXhrA=;
 b=YRlwhZk1qJrIOkP2GF7OcqcO7Ft6e/traGizSb/wz4Bw2j42WUSPY8xGfmQuFmdgvy
 iPeAM/XMnlvhMERzRxtWNQRN6fBiDa2FbV4+6COdCIOm8rHvBkuCMpbY1qi10R2HLXq4
 KN5SFNeD/IspFHk2xJwR3W5MZNEAAB2ejVG8FUdjlOK03H3cNyyIftO6Wde+Bo6r4Ifp
 0xG273X4GNcc89r71K8ydsTkeoYrm3b3F9cU+DPDkntGdyWzahHd9KFdeHj9ACkb/a/8
 8ROWO4VnRm629klUu4DPVBiCNbye0idvIbU1BXLMoZDTwtU5UYtYSClbMJiylVc+s3g9
 14Bg==
X-Gm-Message-State: AOAM533ZA1K+wu0pJ1WPYyGP4ZRYPzGbppN1WP/FMowB2qYr/PDurk0+
 30Ra/Kq/AQfZXexzjb2Upagx9PDZqbJqKC5MEov9wg==
X-Google-Smtp-Source: ABdhPJyjbZIaOUr/ys2a7sfDhs9dxfRAXDXJ6R8XpXQlOF7n/SL2uY4H3dRhzMEgWh6+SLdH+Nca1HXqiob2LEkHC4g=
X-Received: by 2002:a9d:5504:: with SMTP id l4mr1978585oth.221.1596624865497; 
 Wed, 05 Aug 2020 03:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200805095755.16414-1-thuth@redhat.com>
In-Reply-To: <20200805095755.16414-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Aug 2020 11:54:13 +0100
Message-ID: <CAFEAcA9EWjP3rczthEGu1NS8XCzzpixwCoC+e5hqL6edb5Quhg@mail.gmail.com>
Subject: Re: [PULL 0/6] Improve gitlab-CI and fix a compiler warning
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Aug 2020 at 10:58, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit fd3cd581f9dcd11286daacaa5272e721c65aece8:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200804' into staging (2020-08-04 18:20:32 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-08-05
>
> for you to fetch changes up to d2a71d7474d4649eabe554994a3fcba75244cce3:
>
>   Get rid of the libqemustub.a remainders (2020-08-05 11:45:43 +0200)
>
> (I know it's late in the 5.1 cycle, feel free to ignore this if it's
> too much for 5.1)
>
> ----------------------------------------------------------------
> * Test rx-softmmu, avr-softmmu, Centos7 and Debian on gitlab-CI
> * Fix compiler warning on 32-bit big endian systems
> * Remove remainders of libqemustub.a
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

