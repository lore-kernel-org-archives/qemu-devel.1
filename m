Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC47C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87332078B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMcoCKPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87332078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJZ5-0005iH-Vf
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJJAu-0000It-W3
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:23:53 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:45345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJJAp-00064f-23
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:23:51 -0400
Received: by mail-ed1-x52f.google.com with SMTP id l17so6592993edq.12
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RlWbjW9GVqAevWQvn9I49YN5ZZCXz/CF82ncos7FIlU=;
 b=aMcoCKPQB3KUN6KmtU9Dde1vKmCB20wsKoAo81mMUuncONTiYw6DXJncYPIPjSUqU1
 fNUT8Bb9D+Mxd2BpWsRYRogX4vQkwk0F+zTx3o7LvNCY180a03iDJjHvEclOg6Egvg8f
 +jZE9V45z4ZvH4QhliWij/iflel8XH5TkK/+POFGCleXhFI8vELILZqQ0oyHbV/gXI+r
 Ei1Ccj3TpIcczJZzROofygg+UrTCc1rcMVznV+Oq2lDwphfNmiwUUtf9gDGAX4BHIl1q
 OMMS32wa04hJWxecKBm2HONpP5ekFC2UkzJyeoHjsDvDT7JDGODhYDKLwE0blcojVFr3
 NbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RlWbjW9GVqAevWQvn9I49YN5ZZCXz/CF82ncos7FIlU=;
 b=PHa0r7ptdmarr3ZnB3BonkiOO9KcxIsXMrog+el1813l7qG4f1pktSoHt1lPH1U/S1
 1TDtsKyjavHOKbbO+4Pu1/cHLtOO8S5ddHswMhukuliZIlFbr+morHpjTtVhhQLTGLxl
 eJt4ues4+BFeozaURlYRkgRZFm+REcIuJKgS1b4IdJzuROExkHWThFTXrc6PfFQe38m+
 yUguTaq4UhKdvSMINal4HNr6ChuRsip+hfSTP/17zuZvmgpGsYfYBEPfqDjgtMvKRzFf
 VsEZLSl630ZWsNyyquO8KcdxGWbRMFyWq5uEJF9tZ72Uc35hs/iNh8Z6P4jfbRHvw2L6
 LGmA==
X-Gm-Message-State: AOAM532E6pIzsMDic9kL953/mjEQII3ZIIsRH2mwTk0aRiX4gl2msqEZ
 2Hn3rtoV7R+/0i/cOv5ZXc82TarUbw+8JWwQufjX0g==
X-Google-Smtp-Source: ABdhPJycHUYHrnT6DJEzoyfPd8mzcqWWpaj9akpbyUgagF2GS82Jt4Ql2vnYD8Ke+fEF56jV9DeGQ24hZNoF0EY+tT4=
X-Received: by 2002:a50:f28b:: with SMTP id f11mr38738478edm.44.1600446224289; 
 Fri, 18 Sep 2020 09:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200918152207.157589-1-philmd@redhat.com>
In-Reply-To: <20200918152207.157589-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Sep 2020 17:23:32 +0100
Message-ID: <CAFEAcA_gHC3FnPou_vtChOLCdBQLopw+Usn7ZpQy9QTTghyjXg@mail.gmail.com>
Subject: Re: [PULL 0/1] fw-cfg patches for 2020-09-18
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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
Cc: Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 at 16:31, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> The following changes since commit e883b492c221241d28aaa322c6153643609053=
8a:
>
>   Merge remote-tracking branch 'remotes/legoater/tags/pull-aspeed-2020091=
8' into staging (2020-09-18 13:36:42 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/fw_cfg-20200918
>
> for you to fetch changes up to 4318432ccd3f7fb69b7169f39dcae3d4ee04f5ea:
>
>   hw/nvram/fw_cfg: fix FWCfgDataGeneratorClass::get_data() consumption (2=
020-09-18 17:18:18 +0200)
>
> ----------------------------------------------------------------
> fw_cfg patches
>
> Fixes a bug in the recently introduced fw_cfg_add_from_generator().
>
> CI jobs results:
> . https://gitlab.com/philmd/qemu/-/pipelines/191714875
> . https://travis-ci.org/github/philmd/qemu/builds/728288784
> . https://app.shippable.com/github/philmd/qemu/runs/869/1/console
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

