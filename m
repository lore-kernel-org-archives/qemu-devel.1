Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF915C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 440E02080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yqXUGhDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440E02080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DIL-0006bI-1a
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DHM-0005jb-AA
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:16:16 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DHK-0001HC-EI
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:16:15 -0400
Received: by mail-oi1-x241.google.com with SMTP id a24so9932575oia.6
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SDATnU8TRIf4l0Xsbin4PWOGNutzKep3bJL5Mec+sSY=;
 b=yqXUGhDnOkoNedpKXAHUqRpduXZb+gMhi4SWh9Pk5EoQ8i65qr0CP46iUJJLl0DEce
 GAfXWYYshD8BejEYL24Sm43XAzhlFBN+l/CqxMdyePeme7LZ958QXC2Ws0VWXyP+tSCk
 EloHZRcCswTzspP8ygrTcVUcLxirRk6rj2EhVkD3qZ0a+wwm/n7veXtJYnR6u7PvpzWv
 ZAWZGC9DdScfJI2sF+csmQQLuw6NM2UiYdFFGaDXz5XzI3wdRxZsJwWNRXq8/pgxMLmw
 oHIqFnWyEWhtV5NjMF3IhG/1qHFvkZ+BBM5OqRb8V+sOhHvhnXLiXWmWEEguXVyusQO1
 W2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SDATnU8TRIf4l0Xsbin4PWOGNutzKep3bJL5Mec+sSY=;
 b=g2VeNhlftbWgezfcBgLjlAWktt9tLbhGqRIXI4QYD6qrekh8sQnDS8qly+AxzcLD3T
 p0av5kCSrX8NwdoTxcblCiL0VvgV/xOsX8zkizq7cg7FemyKVdIR8J2FZ08AHXpcgO+m
 QNfg5w1vZPZhCu5hDO4+jfQxnV9w54U9ET7DD7/D2UeqWOIybIufLgsIoJFTTr4oHVsp
 JHj1Ojj7dF18MEtMY8UltB12rCQhEpaVe3p4n8jMCOD+H/EV/CAYpQVFO1pht/7o9EXr
 ueA575NdiCiyiuV9rLzOH4Bgj1nNd6ZOL7x7ii0RcIFBWub/vfhRDO6enHk0CX+B9PGg
 RyRg==
X-Gm-Message-State: AOAM531l48vYriUnOKe1ukhKQAdkUPBCQIjE4WT+9FVyhXLyotYn8f33
 79pwbQXl7NrKSmwhwNlNWYInvdZFicMNOl3WLBDu2Q==
X-Google-Smtp-Source: ABdhPJxQhHTxquKFbMHXeNkceoY9OjZJ9tpfkA1F+2RLuGewRa8wcrvO3/25mHYlTWx9ZUdZ95ozlhk0i9+ryEkLN5c=
X-Received: by 2002:aca:50c4:: with SMTP id e187mr594849oib.146.1597086973011; 
 Mon, 10 Aug 2020 12:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
In-Reply-To: <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2020 20:16:02 +0100
Message-ID: <CAFEAcA8smstwpQUD9UJzMuE6Cq2WutQzBPrKLLs=3wvfXUmpUg@mail.gmail.com>
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 19:09, Peter Maydell <peter.maydell@linaro.org> wrote:
> The other hosts are still running, will report results as
> they finish.

And the remainders:

The tests/vm FreeBSD and OpenBSD setups succeed but emit this warning
(as well as the the usual ones):

WARNING: Gettext not found, all translation targets will be ignored.


OSX succeeds but has this extra warning:

../../meson.build:42: WARNING: add_languages is missing native:,
assuming languages are wanted for both host and build.

All other configs built OK (with the same set of warnings as
for x86).

thanks
-- PMM

