Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FFDC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 20:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2DE206B2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 20:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wL86vLyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2DE206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO5KU-0007cx-MJ
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 16:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO5Jm-000779-QF
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 16:36:46 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO5Jk-0002nI-2Y
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 16:36:46 -0400
Received: by mail-ed1-x542.google.com with SMTP id g3so2723424edu.6
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/qFEDAy5XWaUVAAJYlPDbudkq2f3XxslP1UbJ3yTZUo=;
 b=wL86vLybqSYugxpiEO+BRGCUSdoXFvG+xW1lpQh7RKwVGrnkLwv0xOL1MoPiNZP9ty
 LlTiJezRkN+PB3s2Brn+kPDt3k8fyVaHi2LWEM7a0DIsuD5CL3E9D1a9lTPT7nipwfyS
 bmb0+/wXUpX7mER/qj7ZKZl7iXisLILqOTdv691jtnUpn7tUFO0aOdnmFhLyjms/mAMr
 M4vIyEbbJv0TEppL0jmRE5MPDvUY3CisIWTNE6uUOgE2eZBxPluQgZTwj63uOVDhYeUz
 u6WtsgIGyMDN6VsyNC+8xvlMiYxZaBgUAO7EU4RvvWsIPGqJHzDEz3QLi3UhLe4YSNJd
 Pnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/qFEDAy5XWaUVAAJYlPDbudkq2f3XxslP1UbJ3yTZUo=;
 b=mVaUcoc07CWheqKDidRqgw/4egEAyDzwzVynFySK3zbEjfCqd2CXh5ZjiXwyoi3Ge5
 hrlgCBbwcZKnM1vLbWyfbuCeda7P7hPfIeL8W0J+AZZxo+SBKVW1ujwT3WaEbmXzKKtD
 wHyx67B6JyRxLqpvpD+PraZ2XW8GhtpQ8xL+3aaPLKqrBg2x7d51ZD3Se27yMaTgAN4Z
 hMzggwmvjzREOjoN1s+1Loi9CpU14XP6YRGLyTf2UeoqtO9uB4kFbZyg5TTzuLWjXhf5
 lg3Ns6J8IaTcyNWWDDf4JYhFsMuV6V8oHvlGxUvXf99vv+63P10RsS3A5K0Ml3bx97KT
 LPzA==
X-Gm-Message-State: AOAM533wx31gnVTrZ9jwwITSaaoy2jSpqGIQSrcCKuIxCfZ+ypjKyjdT
 QIiafgr+ZMKO9cvoOQkrUZ6EAb+Zmv7SjiXe8PtgMQ==
X-Google-Smtp-Source: ABdhPJwyEWNxVoVBrC7mQiDooIQfx/4ISD/pCEg/93Bsy1M0z9jQtwwf6P78fsOLcnMbFjhtTi08YD1EtQLTagLvJoA=
X-Received: by 2002:a50:f1cf:: with SMTP id y15mr10358484edl.204.1601584601325; 
 Thu, 01 Oct 2020 13:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201001193659.21685-1-maxim.uvarov@linaro.org>
In-Reply-To: <20201001193659.21685-1-maxim.uvarov@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 21:36:30 +0100
Message-ID: <CAFEAcA_76y5DoNw3tirFFaC9FfE6NnxwAkdgV5eSv9NUeBxdhw@mail.gmail.com>
Subject: Re: [PATCH] hw: wdt: implement sbsa watchdog
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: Shashi Mallela <shashi.mallela@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 at 20:37, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> Initial virtual driver matching linux kernel sbsa_gwdt
> driver. Driver implements basic functionality and makes
> watchdog works on virtual machine and allows to reboot
> secure OS. I.e. atf->optee->efi/uboot->kernel. More
> information about that device can be found under:
> ARM DEN0029B - Server Base System Architecture (SBSA)
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>

Hi; what's the relationship between this SBSA watchdog
device model and the one that Shashi posted recently?
https://patchew.org/QEMU/20200929180410.33058-1-shashi.mallela@linaro.org/

thanks
-- PMM

