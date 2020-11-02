Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC22C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467BE208B6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iiORGlQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467BE208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZaH4-0001tY-CH
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 08:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZaFv-0000gP-Ue
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:52:19 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:42491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZaFt-0003D4-1i
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:52:19 -0500
Received: by mail-ed1-x534.google.com with SMTP id a71so9050551edf.9
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 05:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=thmx3fbAgG0mnpQQP8zL9hNtgxeIoF2KXGtL0QPyUu8=;
 b=iiORGlQ2mL4piLFvaCdiQ8RDr1Dy5dCK4456+d/fbro+Mzv9LVj7hQbsJgSZbCXTaI
 vZUZ4kmKn6UhlPO3vd4Fu07R9TWT8tk9UwNH/t3GP/WrYCNQWeeVgkbb7LXa61e4Llyp
 s8KxiXS2J1YMkvJGg/ipN5EZBYsYN03FesqgfjLHrmK9//L9nYVewO7oRZXywPbsMJsE
 Y1TstnM4NtxGX7R2i6ggtAIr+iIxBFroTbAv8m78Dfztc9h+n9PF/S4d9PvvYfJRLZw7
 xrSk5MWQunVVPirLG0ECU9kFWGKOZuX7humHo5bGJ5b2sJfAxkcEbjKTh9NedCQMPRye
 ypYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=thmx3fbAgG0mnpQQP8zL9hNtgxeIoF2KXGtL0QPyUu8=;
 b=HAwlIuRDHs4e2UXsC3zvNcjNlmABD8eNs4GhDcu/pACS7kfZHoQnwWmtywr3940YDi
 W8xzqUzGhYiuL2vqtvBA9JuBKw1Jft9f3a66EDQeJHuqsmdR3I3Wku8X+bT9Ty/5UY4Q
 jGFa9Rxc4xagvoZvNJaOFIV3tYVaRJ861vxul9Q8RiyqiWnoaE0KoIm9yvYAtN4FZLWe
 OL2pgl3bSQl+EZ1tR/aJKmwOflYDN772c3pFrMtx/HHQ42TPRf5M+U4mErkzCyLu6fSg
 MlGRrjRdl5rvElyP+8jSjdcvTGyJuToXVeCR7enoI08Q2rlJTitnfOokNn+SnhL7WYFF
 B6IA==
X-Gm-Message-State: AOAM532s6qbdXyA4R4DV6OgTgncwUIxDBvgB79n7ylRJ3E+8ATKqxu67
 V39SsK6l331z+y4NWU34Mi71Wd/SORFQe4yrNCXtAg==
X-Google-Smtp-Source: ABdhPJyVg8kRcgb5Cq+85y8wyJcx8tORxYt2g6wG7K64TDotmlUp5vwd5VRTlXBztdiJL+mZ0D9w00ghsxIJr3LfSs4=
X-Received: by 2002:a50:fc87:: with SMTP id f7mr5206445edq.36.1604325135555;
 Mon, 02 Nov 2020 05:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20201102130926.161183-1-berrange@redhat.com>
 <20201102130926.161183-5-berrange@redhat.com>
In-Reply-To: <20201102130926.161183-5-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 13:52:04 +0000
Message-ID: <CAFEAcA8RS2h5V-pSN2B35B-eV4-+wjj2Cdd=PvFTF_qnib9OfQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] docs: add "page source" link to sphinx documentation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 13:09, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> Add a link to the top of the sidebar in every docs page that takes the
> user back to the source code in gitlab.

This doesn't exactly link back to the source code, which is a bit
confusing I think. Eg the 'page source' link in
https://berrange.gitlab.io/qemu/system/quickstart.html
goes to
https://gitlab.com/qemu-project/qemu/-/blob/master/docs/system/quickstart.r=
st

which is a gitlab rendered version of the rST, not a view of
the actual sources. Is it possible to link directly to an
"actually the source code" view?

thanks
-- PMM

