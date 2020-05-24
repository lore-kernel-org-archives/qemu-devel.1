Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABE4C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 13:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5AE206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 13:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H3TL+C3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5AE206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcquE-0002SU-M6
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 09:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jcqti-00023J-7Q
 for qemu-devel@nongnu.org; Sun, 24 May 2020 09:42:38 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jcqth-0008Ak-Dy
 for qemu-devel@nongnu.org; Sun, 24 May 2020 09:42:37 -0400
Received: by mail-ot1-x341.google.com with SMTP id d26so11973335otc.7
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CmCh7P1mfvmHffwghYt0wsTyOMiKjFDhwoNEYkiSwy0=;
 b=H3TL+C3tOitVKg3kH1W1bpfqx51wkRXGv4SBZo4mxBP8Mifd5jnb3YCFvVM8H+//7z
 WGl7gblovgABgubV4lqDv2USySgmFzF8bICseSq0261VUMVQ3ToU81Wo9YT19zbJH2sL
 BccAFd/gSJ6tKYkveF0PBK8mWyxa9vR99DfcGXq0W+4dsEd72T0EJhC21fPFrWobSgdq
 7+vQjcZGuYh1PTiJsWDFvOTO1Lo505KIh6pCWQwubb/E8MuNBbZBBGq7vlxLkY+AHV2H
 sM1t6BXXJqCRt5obQLfmikioieZtA/V+UA7Jxo8Hsv6b53PCEQNv+ZzupgZGsVL0brFt
 FFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CmCh7P1mfvmHffwghYt0wsTyOMiKjFDhwoNEYkiSwy0=;
 b=PchuymO44BqDyYEB7OKMTq3F2ZWIYNXOPqMyWX0KK3u5UWWJ1Rs1JLHvL2XqZ0eaRl
 NZvpqgkr3lbUTHYQ71e9aRguGwtCAklNCEN6DHX9tcjuR/PU/48BcxQO2jK2uuLTdm3G
 v54Pjhyh4cpc4Hu7podAw6uifSIAzLZy0F0EdV8Uov6JutuFQnHXgu2IjtcK8uWBYXWh
 1EkWn0288ENn0VGcXrrE5nOUH1uT2viQID35/r7MfIEqTf2QcUE8JmL4uTOxgKo7qSQ7
 DuJW8MFXZWys8j9UwMHzoYyuGZ8HltJ3eZzYio92V1erpnKqwDucXnS+AKQkkT+67yyU
 3Q/A==
X-Gm-Message-State: AOAM531WRNiUFAxt4kDlEjIqjZndKCRM98bvjguGFO72pTWEGY1UIPew
 pYvvoJDhmGskq1y3itIZTdr+1l7AKh9go7EJNqXHe2Zi
X-Google-Smtp-Source: ABdhPJxECnYjoCtetvnBQTYBqsizt/JC1S2HzhM4Yu4nXvZvHsZAhJ0N7juRTV8yUqDYVyG6ie6/Z+72plM3RVlFa9k=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr16957338oth.221.1590327756248;
 Sun, 24 May 2020 06:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200522174524.29152-1-philmd@redhat.com>
In-Reply-To: <20200522174524.29152-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 24 May 2020 14:42:25 +0100
Message-ID: <CAFEAcA9h-wG50ekZaZzS+zpKEMPfZvB1W8VbdPfMviNfBj-fzA@mail.gmail.com>
Subject: Re: [PULL 0/4] pflash-next patches for 2020-05-22
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 May 2020 at 18:47, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> The following changes since commit d19f1ab0de8b763159513e3eaa12c5bc681223=
61:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
0052=3D
> 1-1' into staging (2020-05-21 22:06:56 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/pflash-next-20200522
>
> for you to fetch changes up to 1857b9db49770590483be44eb90993c42b2a5a99:
>
>   hw/block/pflash: Check return value of blk_pwrite() (2020-05-22 19:38:1=
4 +0=3D
> 200)
>
> ----------------------------------------------------------------
>
> - Remove unused timer in CFI01 flash,
> - Clean up code documentation,
> - Silent a long-standing Coverity warning (2016-07-15).


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

