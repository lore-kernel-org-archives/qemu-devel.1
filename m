Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3A2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4709F206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymYrsVav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4709F206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jom4K-0004L4-GM
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jom3W-0003j2-5d
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:58:02 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jom3Q-0005ML-Vm
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:58:01 -0400
Received: by mail-oi1-x242.google.com with SMTP id l63so7662971oih.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 03:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=anOpxB80ATNlOQn3eLckhfrVMdcal6uh7okRHELTG2g=;
 b=ymYrsVav+jGuiIHBSBLgrOzlV1pWfxJZibWGtv1SDYTROumJxJw8TIjwTq9D+LhuiB
 ZbolJQR188Ju9H6mOdj+qQM79Idutnh9KxuBXpS0mdCSEsEXGKkrlHAn3RsOYqHoUq2j
 YQKpYA+Ybzys1F3q07OIXP4abmXs4vjx1i9maZHVzXRk9b5lmz0mem/PYjtO3jB014Aq
 PfiyAFfH79VNXqBR5oWJE3dz2WDgExfybBrVpmUMXz9gm5KvCA24/LIvVpv1LiRPp3nw
 enmv06J32l9Xl1fVLInKad68/EqowRK3fOvqeHm0ZTRj02z3bWkJ+0GB5Dj3EVo3USEV
 HWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=anOpxB80ATNlOQn3eLckhfrVMdcal6uh7okRHELTG2g=;
 b=mW//86QuWUD6t+TuMxRu05h6ezMhIsrCuP157jVU/N2iaoDh92WsPRf8KUsFXlUXX7
 tWqbL6CVvyiBzh8wfko4deioVkrginiUV1crtixxImoA/u8RhxQ2UCfZiW+fvqO08v/b
 cvGV7GUswF/d0zEXK5dtFWgcnXpblykQMmfXXuJmHWyxmHSOCKiqpv7KNDLAKxRtKmtz
 3qTvMbjlHBR4MRiqBuK9qjlaS6ISLj1+DmXqQKKwd/I+6qSAXe44W5g08NSTg/h9wx5J
 m8D+rBoCWhglMqh1Lhy89OTQuffFdofXmyfVghDX75EAOF8MH/8q9eq5fYm3dPBQhcH2
 UU3A==
X-Gm-Message-State: AOAM533m+PE6IJ5w4WXp2DaOwAQqjO7kXe3glhmNkPBmVaJAhTBme7jd
 yqbPu1BICpIPCkHwJMBPFOtDExkMzUPaJ2m5G6m7NbNo5RQ=
X-Google-Smtp-Source: ABdhPJxlK2t/VzKwI1Pr7uzLCoGzhCW1C/qhZ1UFrDiYE0LyIa3ea4/pgJbJzo11IrHYbxntfSfPYgSI9937gmOoDeI=
X-Received: by 2002:aca:568c:: with SMTP id k134mr1792595oib.48.1593169075815; 
 Fri, 26 Jun 2020 03:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqxRDPotkG6ioYipzZNMLj-w1CbFbz2cd6BPet8GQ4r8oA@mail.gmail.com>
In-Reply-To: <CA+XhMqxRDPotkG6ioYipzZNMLj-w1CbFbz2cd6BPet8GQ4r8oA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 11:57:44 +0100
Message-ID: <CAFEAcA9fGG93SbNk9ASyzdy=QOt59JbeG1joTDgco=3bbZg=Qw@mail.gmail.com>
Subject: Re: [ PATCH 2/5] haiku build fix
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 11:10, David CARLIER <devnexen@gmail.com> wrote:
>
> From 19a41d406eda976001827d248398d7fb172d140b Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Fri, 26 Jun 2020 10:38:17 +0000
> Subject: [PATCH 2/5] Enable *pty API.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  configure           | 9 +++++++++
>  util/qemu-openpty.c | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

