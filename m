Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0870CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F1C20748
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4d1z4+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F1C20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqg0L-0008Kn-KN
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqfza-0007lB-0c
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:53:50 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35]:36066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqfzY-0005ax-BD
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:53:49 -0400
Received: by mail-oo1-xc35.google.com with SMTP id z127so1453641ooa.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 09:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G0YDtel2+4amDgDy+g6yLLU/PrAyUYJbvLciqhWoWn0=;
 b=Q4d1z4+5Pw2Iirk+6ZJCFbWOjCQcQXGG03dkNjn/N9qqhxYgS4anAnIuTY7orZ1/LH
 bSRu5sEBtSE58PLLt2liMqXVdDGGVTWcdE5Ng7pgTX7mq2AQL2IMjy2oLJpi235Mbea+
 9b3Z3YlLAiAW89day7moThG0NGkYNASRxrFGQP6eJSwVik8bgrUVR5kUcWAjqGNHKEQU
 agbaoo1T+jeT1p8uq2zJnVIFNL1yK9QSPxgRvWuNK+SgtgKKRjEQ7DZcDvjNYQ+ar1DD
 aQRMhnKfl2rC3yDF4H7PVZYA75XQyg9Zt+//42u2RrUCqWwdggfMcecmdpyuY5xJeWxr
 CdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G0YDtel2+4amDgDy+g6yLLU/PrAyUYJbvLciqhWoWn0=;
 b=ooy/Ob/tLIhPK+TLB7fDzUwU8Ziq1CZjdhYo/lJm2tpHcIr1i0rtTgE8NekdkLCftd
 8uz7Rcddftpj00Dp5X5PNFzP9B4KSdzHToNXfVlx5kKGocoLwITQmfLMt6CitRgHgtij
 1nWi6SUKi3Vf23JFk939POFIhTcUdL/MsTmMAzx6BRX/K0kAMLfbY2oqVLz2SDsZ+U9l
 kfIbZp+PhkxrKYr7GaY2234YNjrAobrfYL1AhG8tdPzGwRjeAxZzieg66GLmh+BEoHWB
 nzaGlEH10K79i7w5gr+zknuTR2vwFaf1i214OJeHKsfRcLwP+S7+v4p98uTGx2wnX6kG
 ikNQ==
X-Gm-Message-State: AOAM531HzRSjk7WWdkyMMNfagCcFuvJQ89WXLZ7thL1/p8M8AHieCIHo
 DAvkruXhOEWhlmElLthnjMFE9DdQJS5JApDNd2lqiA==
X-Google-Smtp-Source: ABdhPJwI1s4A+70zOFSBr9VLTl6/i9Fj9j8VFyi/9Fosna5D8Okjw1Eiam1cNztYQwEta/OOfi0xARg/N+6mWFS9aeo=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr1317397ooi.85.1593622426520; 
 Wed, 01 Jul 2020 09:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqzjjrfxXeSENBQuHzTe4TRMWV5GOdqPkD3bo17T3ufR1A@mail.gmail.com>
 <1058ccbd-b4bb-9413-abc5-ae89076a58e1@redhat.com>
 <20200630082301.6vybzwmg4pviuwob@sirius.home.kraxel.org>
 <CAFEAcA8jkzf8+d5AyAVH2HJ544TyHsM4xP5tpWsKiJbJtWMjKw@mail.gmail.com>
 <20200630165356.2ka2ltwmrfjb5msn@sirius.home.kraxel.org>
 <3eb3c266-1a83-9f40-4760-1ab2578ae5d6@redhat.com>
 <20200701151524.wogl4ihbdevgf4bt@sirius.home.kraxel.org>
In-Reply-To: <20200701151524.wogl4ihbdevgf4bt@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Jul 2020 17:53:35 +0100
Message-ID: <CAFEAcA_ik-vD7N62kK2PY-Seepkgr2SsYPAj71KPJ6D1nCjgTw@mail.gmail.com>
Subject: Re: [PATC 7/9] Skipping drm build, unsupported
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc35.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David CARLIER <devnexen@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Jul 2020 at 16:15, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > Ah, that is the problem.  Yes, DT_CHR is an non-posix optimization which
> > > allows to get the file type directly, without another round-trip to the
> > > kernel.  If that isn't available you can stat() the file and check
> > > ((st_mode & S_IFMT) == S_IFCHR) instead.
> >
> > Even when d_type and DT_CHR is available, there are filesystems where the
> > Linux kernel reports d_type of DT_UNKNOWN, and where you are best having
> > that code also falling back to an fstat().
>
> Given this isn't perforance critical at all it is probably simplest to
> avoid non-portable d_type altogether and just to the fstat
> unconditionally.

> @@ -53,6 +50,12 @@ int qemu_drm_rendernode_open(const char *rendernode)
>              g_free(p);
>              continue;
>          }
> +        fstat(r, &st);

Don't forget to check the fstat return code in the final
version of this patch :-)

thanks
-- PMM

