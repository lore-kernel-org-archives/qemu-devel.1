Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D545EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E6120829
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTxdrfym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E6120829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTSn5-0004U9-8I
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 12:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTSky-0002bm-Kp
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:39:04 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e]:35869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTSkw-00035N-AV
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:39:04 -0400
Received: by mail-ej1-x62e.google.com with SMTP id qp15so4134242ejb.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I5cvgd46W0BTwnMudnJTH3UEOSmL5GKFOUwxFZ/IVV8=;
 b=HTxdrfymyPgK/UNuuaWfqlM+K59gH2XvgHHtRMGUREX1CI25PDQrY4jn+a8hsh5fT/
 xa89wOhQssy/xL2JZAwO2a1K+JdpC0HkC/dNE2qoU/4hupQf+dOpHzn46yVbNiIuM8NS
 nJUfAAOeG4Yx4ochLIMCilinwVCxdqiMMKkomolP69OVK5VisblM6eXMCYex1YOLHAvy
 0l25A3thBK60P3DqjYU02LnL5xqGBEoo3w+0+GteDJmo/rzD+9A4hVDUristBhOnDRh/
 RUgfbiWDDxebSDAqndK1r5WaDDxPQmGqnGE5vJUhRh9X6lk+a1Urdac/nTRZHtfxf7xL
 ocoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I5cvgd46W0BTwnMudnJTH3UEOSmL5GKFOUwxFZ/IVV8=;
 b=iQ3B71N2yZrfrR9DmNwAHZ8t6NOLUO3BKmTM2nMkp/d1wUIeNmNQPXVCihNpx6PAZk
 HUl2n4qMRcTU85yRwp4HnhvIjrMe6OTTEZ5atvxAWG2Ymzg+zdSFIU89KqB1jz9V36Lw
 rC4Ybfag1DbRmMYFbi0uWlU8Gy+wxYOQma0xCidnNG59N4T4vpbKcQM+B7+B/rp3e2A4
 ywapFY7HeWHmcCEBnONZ7qtyp50WMiMGf5K8wy/8MkGQp80zMptq+mIc6yjXA3UZAvE5
 weDyHPHMV3G3vHrKEv70xuWdgZBNRhUkbvW/e/m2A5Vk+t5+C00qbgXPsaIkmhK/7kZb
 fyCA==
X-Gm-Message-State: AOAM532pHehdZnI/SSrPnxYnEGMzvSihOT68loEqrmAzZuwoXqiwTw15
 27YP2T7+J/mZ1vg+UP6BYTSah8XDZnMW/jcr88hlyw==
X-Google-Smtp-Source: ABdhPJwR2psmXfocLTGCVmR0j+w6LcS03abWX/BAPTbG4rMfjfg9z6ZNRP4tn/lrBZIVQ8RfLPeIisLhP7akFeMm6Xg=
X-Received: by 2002:a17:906:ad87:: with SMTP id
 la7mr4656021ejb.85.1602866339087; 
 Fri, 16 Oct 2020 09:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201015125322.23648-1-kraxel@redhat.com>
In-Reply-To: <20201015125322.23648-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2020 17:38:47 +0100
Message-ID: <CAFEAcA_5WeWXsVhMP9xuK3WeSi-gK1AUrgU_J+fCaBo1qKAwxA@mail.gmail.com>
Subject: Re: [PULL 0/8] Modules 20201015 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Oct 2020 at 13:55, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 57c98ea9acdcef5021f5671efa6475a5794a51c4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20201014-pull-request' into staging (2020-10-14 13:56:06 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/modules-20201015-pull-request
>
> for you to fetch changes up to 23ebeaae4eb09a0d92dc7f22b41e5dd08485c390:
>
>   chardev/spice: build spice chardevs as module (2020-10-15 11:14:40 +0200)
>
> ----------------------------------------------------------------
> modules: misc fixes & tweaks.
> modules: build spice chardevs as module.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (8):
>   module: silence errors for module_load_qom_all().
>   modules: update qom object module comment
>   ui/spice-app: don't use qemu_chr_open_spice_port directly
>   chardev/spice: make qemu_chr_open_spice_port static
>   chardev/spice: simplify chardev setup
>   meson: add spice_headers dependency.
>   meson: add spice dependency to core spice source files.
>   chardev/spice: build spice chardevs as module


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

