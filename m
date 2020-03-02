Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B9EC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C502B2080C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1wa/Oc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C502B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8loD-0002Co-Sg
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 09:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8lnW-0001dx-23
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:11:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8lnU-0008TO-Qg
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:11:53 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:44717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8lnU-0008Rp-K2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:11:52 -0500
Received: by mail-ot1-x331.google.com with SMTP id v22so5264459otq.11
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 06:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x3Rchj6s1GT6sF1eevKWrS7Ek8JZSTTSgxi2gLjgXGE=;
 b=S1wa/Oc/rjzGG9lDoPOghE3ckfAb2pWNKz5azteKfkOlVHI1SgFNDtj7NqyigHhqko
 ZgBl7xV6yBrA1cELzlQHCS1bHtuO3xt3XC4zbOc+LoSBVH8fbuXVc/EzCWCaapx78fkF
 HQd4TZOVGYqQQiBCktHgY+3A5cNARkIgaE0OzB7GtxADQNHjULNzo4YM6Cf+6BiNah9C
 rSYORtyAEOpV+ej1gqswvnCy4b6kubO13MDy1eF8QxyOrlkAFyT+9f9darN0ycXPitmT
 FP525pAj0NJGmXDzOmky+l1ULrq69TnXAfLepE+vBRyAFgxJ+giVar5G1vSLFqfJWfr4
 0guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x3Rchj6s1GT6sF1eevKWrS7Ek8JZSTTSgxi2gLjgXGE=;
 b=EAQoh9rEPAMmZisUXiyND7AvWwM5EAbln/DmW8KnVKElBdNaA0U4Eio9DrOsigaLCs
 x2F82X5uzp4h/4jPgDM60B7s5uccWxp38jRLx1JxUwKQGgIb9nBHZSgqffFiZO5w8sti
 pn1JPgcYsFQ/NPSCJVSSe/VIPyt+IdP6RQPzK4FJE5Ck6TeqLryHSgGYCTlIIR1VVaCy
 tmeBSNAt649BrNlwdpck1jwWqjHeTqlqEwQqN7l1dd9Kie1FyVVCbpOe4x4vuXQB1A+W
 mfB+nFq8XKSN3qENd5ZU5ixtN89cGS2Q8jLaPTATeudlXyTpx07zKj+y3Ao0CcnqhRN2
 h0uw==
X-Gm-Message-State: ANhLgQ0gfTJBOKv/dwT8X7wGIhMIuhN3q75F85xOM5WYV9ac1HhE6CUS
 2ae7RoLfDOBie4Ma04m/AZUewZDV0HMMOLLBVoiGiQ==
X-Google-Smtp-Source: ADFU+vu7GZnHAb/mQBnuPzdHgXohKbM8D0NfM98eHCtj81sgByz/Pq6ZbtQrBrvA/w/Ois3am7gjQ3/+6OpGEY5VOOY=
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr5069731otq.91.1583158310876;
 Mon, 02 Mar 2020 06:11:50 -0800 (PST)
MIME-Version: 1.0
References: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 14:11:39 +0000
Message-ID: <CAFEAcA9JEDW7XDx_uxyhoJdinXR6nK-_jz+HM9_9n=P9wwZeXg@mail.gmail.com>
Subject: Re: [PULL 00/23] Net patches
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
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

On Mon, 2 Mar 2020 at 07:40, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit e0175b71638cf4398903c0d25f93fe62e0606389:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200228' into staging (2020-02-28 16:39:27 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 41aa2e3f9b27fd259a13711545d933a20f1d2f16:
>
>   l2tpv3: fix RFC number typo in qemu-options.hx (2020-03-02 15:30:08 +0800)
>
> ----------------------------------------------------------------

Hi; at least one of the commits in this is missing your signed-off-by
as the submaintainer. Could you fix and resubmit, please?

thanks
-- PMM

