Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CBBC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FB120BED
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFqOUgxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FB120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7ub-0003Ev-Kw
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD7gM-0005rP-Kz
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:54:46 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e]:34272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD7gK-0001ch-UP
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:54:46 -0400
Received: by mail-ej1-x62e.google.com with SMTP id d26so2119307ejr.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 07:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lMRN5sWr/UE11rJ/A1OXPMu5tKqDrmEaA2nfrCVk/io=;
 b=RFqOUgxNYwberug2DRNwWvh8soNDbJXqDZ9+hkvoouuyfi6As/7MqgUO+KVBQgoAO0
 74VIWsP07vO6/2OLMRqUndNBuV8Hr65x3uRMY8m7PGIma/O4R8l/d5nT4jZAoCb5Bzy4
 US2cXdHXYX7s9YFObnLitRpClaY0xAQwhGyOseyK8Z9CviAI/y1GPUOhth8KzFbgtlbu
 ONUmdWQ9JXo2zwoZDfyEpDfCZQTRlhYqAi3+m/2/Ys3Kn/z27WXHR6RITogNFkavv3/O
 1y5QWooZD+ACgcYB9akJbormQyK3bBzsWnze5OoRHC/LTxHW4PhO+z1UcTSTxxdCJkju
 Q12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lMRN5sWr/UE11rJ/A1OXPMu5tKqDrmEaA2nfrCVk/io=;
 b=hYyARWeefXFfRRxjoO5v2uskvLTZ0Z9y3AmJzYgqvSHGuX7bBuCqr5BUOgYqKQYaxj
 +Ljz+ri1upc6RIms4ONJIUa2HmWdv4GYP8vABkWLp+v71Dsc4l1LwHroMgJhL8RW4aja
 zWhNDPxwoMySAdKQsIxALbr6UiWLIvpC7GvFroAmIHGf2KzgrOSs1CQuevOUJhDRz8FX
 cfMyQUSyjKK4dTGSZJnSwPAdZEkqZLX5qtSGbwz6vJeqFYtiZHOuUzXNiZH8uzgBVAv+
 Pz30BWJg+2O7/hbJo7DH/EG7mw80LzRcyk1dYPmegsFl7DYL4n6PRvyTkT0I8zhSjN4a
 UuHQ==
X-Gm-Message-State: AOAM532eoc8lodzEB/NCFyYkMaX+/QPzeTQU2TG+E0dI8BkC5sLxsTtv
 UNCxt6GRQJoj75oU+amMs3iEqr2aeWXSJYLfDGCpYg==
X-Google-Smtp-Source: ABdhPJynlm0u1cRwMzFLQGMmRdd2s1/t3pWM2TlMIdPF/2c57I+ymK9g1LbC4c678AeU7VQr1tKZaUMquiQIQo+qT+E=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr1722560ejb.382.1598972083403; 
 Tue, 01 Sep 2020 07:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200831110416.15176-1-kraxel@redhat.com>
 <CAFEAcA99xWV2=12YeZL2Aq+U5kDGLx9eC2vfEVtbqs=Avz78Pw@mail.gmail.com>
 <20200901141628.nfvsojjje2d7vgfa@sirius.home.kraxel.org>
In-Reply-To: <20200901141628.nfvsojjje2d7vgfa@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2020 15:54:29 +0100
Message-ID: <CAFEAcA90KpnJF2kF7QmVE3DJCSk7W_RriM6TbT3oweRjNUJSvA@mail.gmail.com>
Subject: Re: [PULL 0/5] Ui 20200831 patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 1 Sep 2020 at 15:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > Generating ar with a custom command
> > cp: '../../pc-bios/keymaps/ar' and 'pc-bios/keymaps/ar' are the same file
>
> Hmm, strange.  No failures in gitlab ci:
>         https://gitlab.com/kraxel/qemu/-/pipelines/183769485
>
> Any chance this is an old build tree?  Specifically created before
> commit ddcf607fa3d6 ("meson: drop keymaps symlink") was merged, and the
> symlink is present still?

Yeah, mostly my build trees don't get regenerated. We like
incremental builds to continue to work.

thanks
-- PMM

