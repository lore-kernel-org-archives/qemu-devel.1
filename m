Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ED2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:01:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C612072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkRftS9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C612072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09J0-0005hI-Pw
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k09Hy-0004mV-JR
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:59:58 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:43497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k09Hv-0005nb-OQ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:59:58 -0400
Received: by mail-oi1-x231.google.com with SMTP id l84so2848119oig.10
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zg+1y4+2D4smFX9m4tEmf6VXptw05lqX7BqtWG0/O9U=;
 b=VkRftS9ReUb3eIPqXFwk3McGuupzqZHJj11UjpDwiVKOy2A7/Wra/wKaS6qbHrJd3R
 NYy6WeJdL282ynqw8JqeAMtrY4B0cJ8l9wPCuDkqVVKGxMzYkteGREN0h+GNjtQl9B9i
 R70hXWorTxkZJ7TylRDRUl1g0IIx/Yc0YgXFDsB2LFmv82J1ryrlqU9X1x+yxgYkLLSZ
 b8q9SxOo4pv6+nigyHGITXYOMgWNYro7QELkrhwvqd7TPARofDrfs9+cNmv60+Lqog2k
 ICN1h5anp7Z2n7uUb2ma3OWbjVlhqfflMZ2E3TOAELGJLof8hN2O7YK4smn4bv0yC1zh
 J23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zg+1y4+2D4smFX9m4tEmf6VXptw05lqX7BqtWG0/O9U=;
 b=QVpAp729b506VzW/b3SV+IHAcjvBMVewLrQ6TXcoUTtd7xxgnZzqqR9HjMhat6LYXq
 iOGYA3lmygw7S3/BUemZv8FsNEF/40Pd8hV9dbCU0h0ftCXY5nLTNFn3tuxlRzZ0y0Y+
 iTKtWywlXNypbQQD6KYUXw0tB9f7KB89CBkJKJ2IxgGDZ08el6zpEXk7kQmJxCu/J27J
 uMiGr0ZWD0CZzdaG7VFvivKNpv6RkWiJcKjHGWDLquGqlVFt1DX29tyhwzCDK3amfeYz
 GTyTdjK5Tfb+uU94N5mfBAn017OheKEOUpwHy270ClKjHghUIO7dlCCt53M4eUrDYSxE
 CVsA==
X-Gm-Message-State: AOAM530AVHuJcTxTR48DH6ybuEyPIHgdTSGjlFIlh0hdQuU9WJ0W7OXr
 hwu7O90iwuakLYWKvJ183GvPmgwoinpAHLmJ6Yk/EQ==
X-Google-Smtp-Source: ABdhPJy8UAr5GWMrWW488jEq4hMHTY7nSaALhy3mwW32S28hueWEQ0ESpS3Wu4rbXDvA6UPsOiqDO+ZKIU33nI/TciU=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr756534oia.163.1595879994417; 
 Mon, 27 Jul 2020 12:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200727140522.251815-1-cohuck@redhat.com>
In-Reply-To: <20200727140522.251815-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2020 20:59:43 +0100
Message-ID: <CAFEAcA-dUQjduVz=g6a=67Y+dQbbPHj1O6kxm+sEzv9=RZA3-Q@mail.gmail.com>
Subject: Re: [PULL 0/2] some more s390x fixes
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x231.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 at 15:05, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 8ffa52c20d5693d454f65f2024a1494edfea65d4:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-07-23 13:38:21 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20200727
>
> for you to fetch changes up to d6645483285feaa0aa26fe2b0c3bac6989250d2f:
>
>   s390x/s390-virtio-ccw: fix loadparm property getter (2020-07-24 08:49:53 +0200)
>
> ----------------------------------------------------------------
> fixes for protected virtualization and loadparm handling
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

