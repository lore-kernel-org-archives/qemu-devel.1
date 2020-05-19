Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E566AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4CD2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOz40HL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4CD2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4GL-0006dR-UI
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jb3y8-0001v5-AN
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:15:48 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f]:37090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jb3y5-0000Di-54
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:15:47 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id r12so25948ool.4
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vyn95KK1NMQspYmTv8auTi7KSHfmGwhOAo8wBZBidRA=;
 b=uOz40HL0kuqb11x39XRKMHNGXMYUfGT5fAZn4PtQag+hwfaYTHeY8nL03+YSxT3t3P
 iktTylQB/1XVwt0EQj/CcW/2Q3apsGTuJhvpzTUwJA6EGG/VQalxbZimOPMBoEMCLLct
 aOQdCTdvgZZSX4FxMrU6C8J6INH7K/CkS/1eUStcSy5qSNTNbfs89xUhGF3LVFD3LIkp
 t+hSEYdvQVxHIVrayXz0OLI77ItZw01+rHs0lYm8y5alpi/MvwqfS2zPrl5cTzVKuIzC
 jyzP5vGU4u1X/jV6K+6HxSD9zGkHCR6kNETdrV6zJhnddLkq3LA4+qzv7htuIP/OHdDu
 Mbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vyn95KK1NMQspYmTv8auTi7KSHfmGwhOAo8wBZBidRA=;
 b=t89Hc8QRtZKLigigaoIqylbPh3Gc6SR6lgxv3U4OpDjxmnY8+AfqcFamKu5pyjoePh
 NcD1rg4OggFnLHZ45/keAtTr0OIjtR6PcHX/+KcNRPoOPl9MUq5yO4eVymiiXmp0tfV2
 ZiTM+lo8pR5K1riRNTgo47ly03AlrsW1/CUnlt8RJ5rdlg41ytkM1FwrJgpGMIpADmyb
 sgYNtgD0NdT7ufisZqUlcPOVVv8Uo/mOiDp4Gw+2xIhnlYRn6Lb8g+mcnH5KIbLgm/VE
 RrdewK2R4irVQyriJ1ZjhllsGQ1wf+taGs/13FcllFstMCUcMo+UCQiVjRCOgIQvMFws
 bU6w==
X-Gm-Message-State: AOAM531+AjhsUvNZdT67zMifHS6Nx1WCV0bQDfgUSNl4sn5SK9Ym9bH+
 MWZ0uBkGIwj3hx2A/6hN4icf6pBbSbxxKqHZ+YxD6A==
X-Google-Smtp-Source: ABdhPJzZ9b94NRgDWY4kdTR/XBu8vgsJKhQTtO76t2lgMGrdTU3ozBH7PlKsaR7H9U0Zp0Q0meyLNuG+hp8nEhjYLgc=
X-Received: by 2002:a4a:3556:: with SMTP id w22mr16977354oog.20.1589901343680; 
 Tue, 19 May 2020 08:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200519080054.146495-1-stefanha@redhat.com>
In-Reply-To: <20200519080054.146495-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2020 16:15:32 +0100
Message-ID: <CAFEAcA_fwbJ162ziqtApS=6Om3xMiTFfHM-i6wfcSApuLs8UFg@mail.gmail.com>
Subject: Re: [PULL 0/8] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2f.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 May 2020 at 09:01, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 013a18edbbc59cdad019100c7d03c0494642b74c:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-2020051=
> 4' into staging (2020-05-14 16:17:55 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to ba607ca8bff4d2c2062902f8355657c865ac7c29:
>
>   aio-posix: disable fdmon-io_uring when GSource is used (2020-05-18 18:16:00=
>  +0100)
>
> ----------------------------------------------------------------
> Pull request



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

