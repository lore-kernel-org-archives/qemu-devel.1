Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87DCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDD420709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LcD6ZbX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDD420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jazy5-0002Xo-Ub
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 06:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jazxZ-00027L-KK
 for qemu-devel@nongnu.org; Tue, 19 May 2020 06:58:57 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jazxY-0001E2-Ef
 for qemu-devel@nongnu.org; Tue, 19 May 2020 06:58:57 -0400
Received: by mail-oi1-x241.google.com with SMTP id x23so5324862oic.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 03:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0TsB2AqXvLCK+0MglM3a9hduq89KV26cpMF+pwW6QWw=;
 b=LcD6ZbX3/4hvTZSsh8sVVmReZ+NnVJobuzQG+xYxNVGvUCdjTbM++VzJBpdod6I2nt
 vwgTBfc1+ZCBg2TGzNoOC1lWLIr0UTgkpvQRMjuHv+SPRMTQEYlJlNX02+x/TYxsaErF
 Mbn88YUbjwPB4QWvMt+DI3AEsqrAID8sD3khHbxXRN3NJCWLTtyOhNvU6S3MLg4Q7to1
 9w5TCT/tu/gra+z/iwD1ep+OHjX8jpkGpSMac8Hj23YsjHwL1+Al1OUmypUPK4S2n9us
 ezKHj4He32g/qo5trcDOEptU1tEjQ9TNgisAEYPgw7mO3+Jl3Xe0tgJGrMu57YOwoi1p
 aqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0TsB2AqXvLCK+0MglM3a9hduq89KV26cpMF+pwW6QWw=;
 b=X5w5i+KzxItOJz0M10PW8dvljUnnqBjDIqqgNsHxQ3yjAvcEZFmgXoaukcBPVclVgY
 qMOoQbeNLFqZhJjPhlFsIgFcgVxEMlStp7QjpS36a5ac0JrMqoLXhLcDFYUvEUYCkQ7T
 AalZqVwjVlCtqw2AiYcCmGXvIy2hfkS6RotKxLuM3wRk2EcBHNIMGj2T5mrSA+JGOSDS
 Z14F+YHZCabM6zk/zKcZpQGn6Ii4/DgUcshqTJ4AhIvWV7+LQGjim31OFX8YbKFVw+Qf
 /pYXiFbli712Tn1ZpJt3znWQu2kHC60xxK36+9/oKm+w4iQpRRqbD1BMHDH8isXRpc6D
 fP8A==
X-Gm-Message-State: AOAM530iuGrPqwlQ0EGDexnsN2j4KJgdHdfpdEJsvk+MWsrtzGu0vzru
 DPwNaDur26whDNp3y6TwOoOrz0upTrFuFeLuHgMI6g==
X-Google-Smtp-Source: ABdhPJxN4AsKDQ1Yr7tmTrHMuYdl1eK5uQaUHAeGAJM6agPv02tBn4chQMIltoFi01v2YdTZkyeIYRnlem5aS4l4sdM=
X-Received: by 2002:aca:895:: with SMTP id 143mr2691696oii.163.1589885935193; 
 Tue, 19 May 2020 03:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200518163218.649412-1-eblake@redhat.com>
In-Reply-To: <20200518163218.649412-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2020 11:58:44 +0100
Message-ID: <CAFEAcA-6=je-OTmGTKGHJ4dmqib-ogJ3dok1Nwm6uqEWZMWHcg@mail.gmail.com>
Subject: Re: [PULL 0/6] NBD patches for 2020-05-18
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 17:38, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit debe78ce14bf8f8940c2bdf3ef387505e9e035a9:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-fpu-20200515' into staging (2020-05-15 19:51:16 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-05-18
>
> for you to fetch changes up to d8154b0945f795177511ea0e2212bd5c749fe84c:
>
>   iotests: Enhance 223 to cover qemu-img map improvements (2020-05-18 11:02:05 -0500)
>
> We've got a couple of first-time contributors included in this one :)
>
> ----------------------------------------------------------------
> nbd patches for 2020-05-20
>
> - fix stranded fd in 'qemu-nbd -c /dev/nbd0'
> - add 'qemu-img map --start-offset --max-length' options
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

