Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ABDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 19:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42D1207DE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 19:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXnrz+9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42D1207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTVBD-0006u5-MC
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 15:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTV3w-0003LC-Dd
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 15:06:48 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:45876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTV3m-0005BS-I9
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 15:06:45 -0400
Received: by mail-ej1-x641.google.com with SMTP id dt13so4635407ejb.12
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 12:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=brkRF7azR74jCW0zC/oVYnTZweYf1g93g91HwOvS/cE=;
 b=cXnrz+9B5LBBnoVo/k1IqElXCdxIfGJfHZdoriBhrT63tt+zEgK8ubbRHM4Mx3Vw+2
 86RIBL+O+aw1M06/ayJrZEZxM8yHM6RYmb+udpNc30YRqCMDgzQwj7pZS14rBzJ0ExU5
 AtZWIrNSMmNbH2XbYRvwJSt3m5yqsoffkTVjoAwplCKU+m2PF1QlY3SnaN4WZ2qMp/Tp
 A2Jmg4RjmxEDGaOxIJC6H56ginAieOcPLEs1AuOMKyUziGHdIdvpFPHDYm18rA5BjDXT
 9Xv+vPTZUSdCyvMdxbotfKgu1mP8V4gNoLMmxPC1GeFkjFKUwKeyzh8GlmoZOW7aaWkW
 ofkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=brkRF7azR74jCW0zC/oVYnTZweYf1g93g91HwOvS/cE=;
 b=ilvylhLGjmdezoEtfbXVDb62+WmDg8lBKbIOwhMHOYvU87oBzYKR5hmn6mVZMrYSXg
 XNbEpExx8fBcSvutDYCjUE6VZz7n8C1N1Syd1neF+wiVdX0fHQQ7eyDbQopNvdwPO8tT
 ttnVB912/ApHQcUeyR/f0e7PDVkaZ4Osv99juVBYpxOJCzi/MUUdnjsG9RkTaYITfkWO
 02ZBykEkIjQJ2wQDJgqBbU7XQZqX/QvmRNj0R3KAu4YaylLr1JUkrrc/tEQmSdcQyX1M
 Bb7ufQCQuicdMC6CE0Tx3qz7HYwHupuPcxkiUz3ym6Dv57GzI+INzLFmf2IQ0UgWhgSP
 E5EQ==
X-Gm-Message-State: AOAM5317zahY1YgvjzKrS7/eWMJbsH3fzhciEdkW63YM0NdD/jZ2LiJq
 cvyxWq0MPrc/uIS3qNFwK6DRM1LqE7rvyJvd8PdjZA==
X-Google-Smtp-Source: ABdhPJxTvDK8C/ct9YMs8jBuzr37ZZYgAyrgSL6VW0q/oQPMDQ1wQ/9VeTrTnCCEmuy4njILbLk8aNbgT0VXxMDn7Pw=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr5222690ejb.482.1602875195344; 
 Fri, 16 Oct 2020 12:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201015144952.388043-1-kwolf@redhat.com>
In-Reply-To: <20201015144952.388043-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2020 20:06:23 +0100
Message-ID: <CAFEAcA-jODPXpYiAjYe326_=y5oDLBV9BigO0RPOHGnELaL0=w@mail.gmail.com>
Subject: Re: [PULL 00/10] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Oct 2020 at 15:50, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 57c98ea9acdcef5021f5671efa6475a5794a51c4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20201014-pull-request' into staging (2020-10-14 13:56:06 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to e1c4269763999e3b359fff19ad170e0110d3b457:
>
>   block: deprecate the sheepdog block driver (2020-10-15 16:06:28 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qemu-storage-daemon: Remove QemuOpts from --object parser
> - monitor: Fix order in monitor_cleanup()
> - Deprecate the sheepdog block driver


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

