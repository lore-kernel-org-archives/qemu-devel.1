Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7941BC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1CC221ED
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ReEAQ5zG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1CC221ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcmt-0000Y8-1b
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFcfD-0003aG-7b
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:23:55 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:33376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFcf8-00072s-8q
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:23:54 -0400
Received: by mail-ej1-x643.google.com with SMTP id j11so22288619ejk.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GDLtsYB99o1cQZjfnCzGMEPipE9c8fSmQs87SW11jwQ=;
 b=ReEAQ5zG0fsIzK37mi5dkTek+emQXtJxoTtOVLjEyL+mOxVqY3bZaoBxwM4d6eJEjw
 28/mDWF1iQMyQQfXYNQp3ceFoZoN0vmfhxCQuiihNfvIk6I8j25ALAlpoUWEZRXnWEh7
 aP9d2isCxvKz8L5gWHAAXRKxoIDBDmBojL29LzjFO0svvhCdi7bJBuziek7XgqnVMvCQ
 Ya/JVvHD9HzCWRGiMdpqj9OYIFf9P1bOab+j6c9P7xfAyZ/JBejmYJPrJnxAuHsY9yBa
 gsJ3tI6L53YnDCvgjfC3E0vh4rkF36iUam6mzH1ogDlavHu4M0tdA+VIQTI1OtMt0rVw
 pWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GDLtsYB99o1cQZjfnCzGMEPipE9c8fSmQs87SW11jwQ=;
 b=KY/f4gH60luQSufZRDA08l9mGldgCz0PjPU1I+9auaHRR44FuZFErX5l3C1RpqwkHt
 FG1gm/HPpM1greEHtQ97CGONEvg094VoTCAJ2Hr9pgadn7CqZVE4x6Lf5/r/DgEN5elk
 yXn0NPppT0UnAaexWF3+R7VAE5pQGTKCzByOOSUmTrEppff1G0F74v9RPFf5kk0UPTsV
 tH1qfz1I8FFgTf+HglQDTHrliBzFEY1G0xH8Nm++QS3IN1zsw1Of8CxHFeRIf8C5VtkK
 3n+7zOsZestC1LzQc2iNUNbKOk4OADXwOsBOdN6LOUn1zPAM7d2EXeP4Q+ILCTyTs8zv
 TPfg==
X-Gm-Message-State: AOAM532+9NsjRAqHdOj7qJZQzc5ImLX6/THDhW+hDnm8t5Iubw0vBVo/
 WbcrbWJtI/dnJBs8BznlQvH6cpQ8Vuq+B3PULJu1Wg==
X-Google-Smtp-Source: ABdhPJxzHNowPMlCI6/XFW+nipJXPMDeVLnOPT4IsLvUHQN6b8IXeh+2wXQDHVm1Lpy6PKdUqvfwjMiCH2oAyCmaiOE=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr8258720ejv.56.1599567828598; 
 Tue, 08 Sep 2020 05:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200903160746.27491-1-deller@gmx.de>
In-Reply-To: <20200903160746.27491-1-deller@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2020 13:23:37 +0100
Message-ID: <CAFEAcA-axxEdySD5hRq+7DFs6dMmcUYgqo2zyzzji3GzQF1Rfw@mail.gmail.com>
Subject: Re: [PULL 00/10] hppa power button support, graphics updates and
 firmware fixes
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 3 Sep 2020 at 17:07, Helge Deller <deller@gmx.de> wrote:
>
> hppa power button support, graphics updates and firmware fixes
>
> The following changes since commit ac8b279f13865d1a4f1958d3bf34240c1c3af90d:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200827' into staging (2020-08-27 13:48:12 +0100)
>
> are available in the Git repository at:
>
>    https://github.com/hdeller/qemu-hppa.git tags/target-hppa-pull-request
>
> for you to fetch changes up to 32a2b033f0a406c0dd4cc7375367ee63cc36789a:
>
>   hw/display/artist: Allow screen size up to 2048 lines (2020-09-03 17:30:04 +0200)
>
> ----------------------------------------------------------------
>
> Helge Deller (10):
>   seabios-hppa: Update SeaBIOS to hppa-qemu-5.2-2 tag
>   hw/hppa: Make number of TLB and BTLB entries configurable
>   hw/hppa: Store boot device in fw_cfg section
>   hw/hppa: Change fw_cfg port address
>   hw/hppa: Tell SeaBIOS port address of fw_cfg
>   hw/hppa: Add power button emulation
>   target/hppa: Fix boot with old Linux installation CDs
>   hw/display/artist: Verify artist screen resolution
>   hw/display/artist: Refactor x/y coordination extraction
>   hw/display/artist: Allow screen size up to 2048 lines


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

