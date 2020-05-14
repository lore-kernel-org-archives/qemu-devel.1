Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85583C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479512065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypVTyL7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479512065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDFE-0007WH-Dt
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 08:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZDDE-0003k2-Ig
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:43:44 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:35998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZDDC-0007s6-V2
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:43:44 -0400
Received: by mail-ot1-x336.google.com with SMTP id t3so2221890otp.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 05:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1oyf3cwa4ysv0F+1gus4rSNb6qxm3CMa4cO5H6tMf2I=;
 b=ypVTyL7cDMoH7l0+bEz1PvWvRoTGnmzkwEhJMemYlViCP3ME+po2WXRtzCrH32ibpl
 Ms1yBFDXmSRlg2HsqN3ggloNRmZX4sDaqv+xAxgUqSM2vy1YLHlp4SotmgxRIgTfY9DK
 fUADazs7u19X1vHtN60EuwZXjpXIu0967bUwxdxWeS5JqLMUMqEQ/rcDPQaKGCRlHoEW
 MwLACr1ieJwkDjSJ6KCi/S2fsjhrTTDHj+0t7Ok+BOnI6+kp6CxAIyLdKw3Zo0/gKqtg
 HMYrOxcfSIR7MoHdK6lIzPzr515j5C1m1i1jHJ9oIKz85OTsEnofgAqDAcPWsRv67Kvk
 iZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1oyf3cwa4ysv0F+1gus4rSNb6qxm3CMa4cO5H6tMf2I=;
 b=UkVlAas0eqWZMENL9Nj/DVvhxoP0GeM/itBIIaKVTb8r8iMlt5y8cOik3VBRrm13TT
 t5lRxE+ubr5Q26lmQo+LfEQDTB2l67ykDtsbj9xcGY8evuPPf0xS8v2NKnnwvtBedWB/
 Cr0KxxECNoEi9vHvlbU4cdnelGKBHk17ycLU6A6+LNknCfa0pUtXvulM5y5v8adH8G82
 Ovu+piN4+vP3kOGk0ybL4+KtPCvdPDX/tcKzL0a9BKV+y9SP8vwodwGr2KlbZkeEigEM
 jXLwot/rfiZgGJ9cFfkshQTVZucl4zmiSvZnooSzy15ePw2X2fpLm/M+eJCOlIC/At9m
 ljNA==
X-Gm-Message-State: AOAM530yDW/gm0G8n/Tiz0+PNu/25oJtjJn49KipsjAPmlSRsMpAvZ9J
 4ShYyP72Dwy71j4vMEGmvJIGS3bkOR83BxDX44RlSA==
X-Google-Smtp-Source: ABdhPJzsGeeWbjUJG9PoslK7o66IiZMjfHK16DUSK/odnSdg1A2Ox7po60O/De7mg3D9WmiN52KawZNa3lVmWXgJEPg=
X-Received: by 2002:a9d:398b:: with SMTP id y11mr3378687otb.135.1589460221598; 
 Thu, 14 May 2020 05:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200514122334.25089-1-kraxel@redhat.com>
In-Reply-To: <20200514122334.25089-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2020 13:43:30 +0100
Message-ID: <CAFEAcA-Hmh+SygS7eWfYWsHSYnTFWFccz1GrXDbX=UHqOH38mA@mail.gmail.com>
Subject: Re: [PULL 0/7] Usb 20200514 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x336.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 at 13:23, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit d5c75ec500d96f1d93447f990cd5a4ef5ba27fae:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2020-05-08-1' into staging (2020-05-12 17:00:10 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20200514-pull-request
>
> for you to fetch changes up to 8b2b45c506f4d71b831473d8de93b3cedaea4844:
>
>   raspi2 acceptance test: add test for dwc-hsotg (dwc2) USB host (2020-05-13 11:06:37 +0200)
>
> ----------------------------------------------------------------
> usb: add dwc2 emulation for raspi machines.
>
> ----------------------------------------------------------------
>
> Paul Zimmerman (7):
>   raspi: add BCM2835 SOC MPHI emulation
>   dwc-hsotg (dwc2) USB host controller register definitions
>   dwc-hsotg (dwc2) USB host controller state definitions
>   dwc-hsotg (dwc2) USB host controller emulation
>   usb: add short-packet handling to usb-storage driver
>   wire in the dwc-hsotg (dwc2) USB host controller emulation
>   raspi2 acceptance test: add test for dwc-hsotg (dwc2) USB host

Could we wait til we've had the patches reviewed first, please?

thanks
-- PMM

