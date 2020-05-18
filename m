Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F95C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8911A20758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hT+q/9gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8911A20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jai4R-0001yr-PR
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jai3d-0000hK-3B
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:52:01 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:41840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jai3c-00085T-Bj
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:52:00 -0400
Received: by mail-ot1-x335.google.com with SMTP id 63so8437648oto.8
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gog7LbqPLJlQIGcKTtldEJY+yyEyl5mUoBn9cpg2lvM=;
 b=hT+q/9gwp/cDao2svfD7TbOD8oKd1ALjrb3HdDqNkmvPg4WL4QLNm2RaqtiD7xPFGz
 JObmb/ZHxdxhhXZJahX9X3p05ySE28DOTu3xuG/xv/Vo8iRUxU2WPLnz9cVvvLYzENVI
 nByADin9b0Fa2KZP8gGQaTMTgOEUEOgWAKb2ZTOxbJqywcqFDG8Hzi5I+06pFHBUwPGc
 ubANQ1JTwaX05z9QByxQkM3MRMg8K1S3AL1ev0IQwI77i4JVWTVo8lvlYM9C0E+ZfRFm
 9arNnsqeICTr0LJvoYoVGOjeoWgm7FULnDyi6pNadABPhA8BXe+qahg6HtaxN45f0FCs
 4WmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gog7LbqPLJlQIGcKTtldEJY+yyEyl5mUoBn9cpg2lvM=;
 b=gK5VZ4+BWGhi10r88vJI/ODKceBZ3bA0TKZ1bGKwPpGk4jKnVtOtp1tB5tccW/2mUX
 zFhnq/t0pBY5gVYfoRSF0hqeL8brdsghVbluLxPWJQ+90C653xJ/C+9tg0bXDPRK5edp
 gtaksYqUpjGw7ysnyxW66Qc9ejNenV0wp0bgmB2XWMOcGlozjdR2Nd5kVPoXA37JN3Fv
 J4QUDwF+LOyyezO7NVPmIWRIlwXrQr3HM+De0++UI2Y1dC78WANCZ05+AJWF2dThU0Sk
 inBJF0HKuIbP4Oer5/XW+zxN/EB32QxnY8qNehcheKtXCMQVdIQyONDYiuz31fyofgDm
 8S8g==
X-Gm-Message-State: AOAM530zSocq8M5Pnm/5eL+JEr02bMXz6XzW2Ggs1Dyoss3NQzTneTRP
 hZZrts7Zltmis/q6j7sYAAE//g8l4pPXTiJqLoeBBA==
X-Google-Smtp-Source: ABdhPJwfxxTaX5LQiCeY9+ltARQG5XOFNvZdbmXHMuJCF+p8RHk3sq6uNkg2pyEPdj0usWe1Ag2k/GRlJvik6tFFYhU=
X-Received: by 2002:a05:6830:158b:: with SMTP id
 i11mr3219775otr.135.1589817118904; 
 Mon, 18 May 2020 08:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200513180953.20376-1-richard.henderson@linaro.org>
 <20200513180953.20376-3-richard.henderson@linaro.org>
In-Reply-To: <20200513180953.20376-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 16:51:47 +0100
Message-ID: <CAFEAcA8XhiDpVDzg2z7JadA98uecG=hbVaJhJiR0wZy=FgERaA@mail.gmail.com>
Subject: Re: [RISU 2/9] Unify master_fd and apprentice_fd to comm_fd
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x335.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 May 2020 at 19:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Any one invocation cannot be both master and apprentice.
> Let's use only one variable for the file descriptor.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  risu.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

