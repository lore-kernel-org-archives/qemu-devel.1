Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7FEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:46:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DCF022400
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kc7Y/gZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCF022400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4hO-0001fJ-L6
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX4gB-0000H8-Vg
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:45:03 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX4gA-0002sv-70
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:45:03 -0400
Received: by mail-ej1-x642.google.com with SMTP id gs25so14310438ejb.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dfyPxWsY/ClcaYOXGTCrEyosp1SlX/TZrjT5/qz1DWM=;
 b=kc7Y/gZZrO1nf5y0n3GalzKJioW1vn0vDCr6Yhl4+BR8gjqpaP/E072LWWD72Z3wss
 j7lxKq45nV1yT3hrMEnokMNfXwo79CgWaRI2tMm1NNEBp1hEZ3o+KIr9dev2mugC9mMU
 bhwWg+iy1aTbImhsa23JThRDwfkWDt+MGmHc2jxJqVo81KEQisQkB2oafl8X4Pk4ZkST
 t2tYBGHwfJickz92oJej83mECQHosPq6Sl/gx0ILZbdhr7cGhXoYYOGw8cJZMMbg9ALC
 NQMdJWhDcqytrX+8ROE/zoG8qFPesi6Jn6+EtdOAjAQjgMdk8n7/5w7MTsoiDvzUc3L5
 Rs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dfyPxWsY/ClcaYOXGTCrEyosp1SlX/TZrjT5/qz1DWM=;
 b=mpiOMRtHO4RszMzcrsftC3VanmUXYAYYnGfR3kSNwFoWIkHDg+VIyMHx+GRXN9pofR
 zpLaYrESl6G9QFsjeD0CaUmjPjDPzORPDA3PnvKi64ESpkpfpR12hSXhJzv1JqlmgLBM
 GrZkMVjnyDhDMoARMvHf4ljeQh3+XiT6NO6woE+lxBF5Ia3rtySlMqWZMKqbLe3QRPlz
 wjAyudevkH8+cQjCLjvtMy7bkmINtLHb+WwPdchpI/wADnJJw2QE94RgZR7eMh5JFZLo
 vkcT8RwneRrRZqF89OyEWDu9iAlypCLBUiYOOS5T2LNrBbFg6ooF7wYELlGuEaFr+rb0
 QIwQ==
X-Gm-Message-State: AOAM5315eRbJSJoMw6uxwrZciCyLkl4YwoyS9+CryH8K5cOQsYbJwQDg
 XyxnYOKPvwL4N4SEsubAGocFJ/Mi8o3P5pxt5p0kUg==
X-Google-Smtp-Source: ABdhPJxIlBhJQDSMzTfNQXD8Nif1KXPylhuw3kDkCqESQnJIooko17OkNBDfacKxjSYi045OpBkchebHIdKbrdJ/T+g=
X-Received: by 2002:a17:906:ce21:: with SMTP id
 sd1mr16569080ejb.4.1603727100114; 
 Mon, 26 Oct 2020 08:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201022162843.1841780-1-jsnow@redhat.com>
 <576a881d-2c64-3e40-31b7-43680a1988f8@redhat.com>
 <22839fc4-a1b9-0510-ff19-3a713fd8a187@redhat.com>
 <88ac9998-51fb-0cca-8b7a-a2204ee0f9b2@redhat.com>
 <35df91c4-49e5-bc9e-e153-a27b7f443ffd@redhat.com>
In-Reply-To: <35df91c4-49e5-bc9e-e153-a27b7f443ffd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 15:44:48 +0000
Message-ID: <CAFEAcA9mx033XOUbdez+bKZ5Xr9aBa+1eVnzj_gwU-jCgdX83w@mail.gmail.com>
Subject: Re: [PATCH] CHANGELOG: remove disused file
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 15:23, John Snow <jsnow@redhat.com> wrote:
> My point in removing it is just getting rid of the runaround. If we
> don't have the changelog information in CHANGELOG, why have the file and
> pretend like we do?
>
> Moving it into README.rst makes it visible on github and gitlab to
> people stopping by for the first time.

I'd agree with this, I think.

thanks
-- PMM

