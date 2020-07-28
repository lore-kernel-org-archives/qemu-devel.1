Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82D0C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 20:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4382070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 20:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mg6OVv69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4382070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0WY8-0001Zg-V0
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 16:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0WXE-0001Ab-LH
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 16:49:16 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33]:41266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0WX6-00081B-Oq
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 16:49:16 -0400
Received: by mail-oo1-xc33.google.com with SMTP id z23so4090695ood.8
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 13:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q83IdVA0joLaRazLS4Nao3JxvlIwyMgzB21Ivrmd4mc=;
 b=mg6OVv69f2pnrGvFxUBs9ZTSUlrUxxo/ThzQ3CL4p6LOrBXtgjuIq6QNWitG0zw0n+
 hrdaqi+/0qB9P874/vcTnRdQMbWQTJ8cUGJlMwu++rOX5lbplYi2X3XpYAqTOMGiO7bQ
 CkGqJ5L+6ozJ7DwEDPBKdn3iLDQtodUTIh5u8YWmLhEUxvvnFP1boDSiCBliQC3+ZvSD
 59PpiXLEd4j4Um/LB2wwCqfqXjTLqhXVxOxPVMP2RFNxgHJv6trkPFHwQ80bg/r4hpwM
 6BwzVgo9hsDoibFeUA0IXAJgE1Nm5GCf8Z2tV4PQh2CQWvB5fthUPiCh/VE0X9WmDyY3
 nZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q83IdVA0joLaRazLS4Nao3JxvlIwyMgzB21Ivrmd4mc=;
 b=Ql7pT+YmmKYROYu0nPEivDUdvwiuuNVVv+xFDOzLw8RAZHzd4VlLxGepgYvorzYjTg
 ecIvnGnE+N7SgMHmfdmWY1KuV4HSyRHLwkKE4vJ5MLRu9w3vZ0yEDLm16T0IbLi8g4xC
 qO6G98QSMfPOwPkayS7B9TmeDVV8FRY4rYTOMA9MYbPyt5gk6Y5QwQfklLealJWXyUzV
 6x10k7HdDsSvJmt0tqESBP29ynvdEGlZqhEZJ8rWxqtxJvM+LbuA7lYZ33MqzmJ2SVG2
 avc7mYXdHX5RtLh51l5Um4+qwy3SSiCllDzgjThuxEfprRLAc/F1F5ppDwq/6S6RVzEE
 l1CQ==
X-Gm-Message-State: AOAM531fZR7yae3lqsHlo0zX3jdboRli56oXdsJiu/jq1EOryJCb7Gro
 8ZHLSAi2/DWrI30NNVMZLlzApmXfDwGkmSleYQAjdw==
X-Google-Smtp-Source: ABdhPJxzwFhnOC8gsixFOPO4g2kLLyn6Ka6MwYJRjCCfAJ2TMLH0wY0X6Ouyr21yEjA1nvlWo/yjYRdws/jE3APlNOw=
X-Received: by 2002:a4a:8dc1:: with SMTP id a1mr22890684ool.69.1595969347224; 
 Tue, 28 Jul 2020 13:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200728150408.291299-1-eblake@redhat.com>
In-Reply-To: <20200728150408.291299-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 21:48:56 +0100
Message-ID: <CAFEAcA9=exU8rRTJR-NuXwoiFYk0eaPS-MbmvGpvzDJAM29v+Q@mail.gmail.com>
Subject: Re: [PULL 0/9] nbd patches for -rc2, 2020-07-28
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc33.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Tue, 28 Jul 2020 at 16:06, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 1b242c3b1ec7c6011901b4f3b4b0876e31746afb:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-20200727' into staging (2020-07-28 13:46:31 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-07-28
>
> for you to fetch changes up to 12c75e20a269ac917f4a76936d7142264e522233:
>
>   block/nbd: nbd_co_reconnect_loop(): don't sleep if drained (2020-07-28 09:54:43 -0500)
>
> Sorry this is down to the wire, Nir's patches were a pretty recent
> discovery, but still counts as a bug fix worthy of having in -rc2.
>
> ----------------------------------------------------------------
> nbd patches for 2020-07-28
>
> - fix NBD handling of trim/zero requests larger than 2G
> - allow no-op resizes on NBD (in turn fixing qemu-img convert -c into NBD)
> - several deadlock fixes when using NBD reconnect


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

