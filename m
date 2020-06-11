Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699FBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA6A2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aI3MQ/gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA6A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQbc-0006T4-G4
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 13:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjQZ8-00057t-Ta
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 13:00:34 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38263)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjQZ6-0006Cj-Er
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 13:00:34 -0400
Received: by mail-oi1-x241.google.com with SMTP id c194so6037334oig.5
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+EADU/71WVoJhkjQqOzBMw/jiE1JIrYniS+CCIX5/6s=;
 b=aI3MQ/gZSEvIcrAN9XvC58RqKmqLVlzoGI5eISku1/hxMJjQLoyh036Ko3dG4LUKmi
 OmrFkWlxOzE7dDEiuTwT8KPy6vmOnWljTfwgSChIYaRJzt0SWyDxCpZymKkQ+JS9lbdZ
 Oe8qiH9AdiqEb4vMMHfWGfnsYc1pG7x/x6vzGyVxXLDEi/9VkRGRrkW4pNSGr0JVOfvD
 tNLsifd9Yopq9Ou9mbVEV8qRMUWdunH69YpiVrLaMeHw+IiW0wRXVuT1isKI7FitSHnw
 16oBckihvhf34CLocD7HrX20tlaqsyZyN0EweiPLWvrmsytH2tV8P72eYGZrx/cM/G5L
 P5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+EADU/71WVoJhkjQqOzBMw/jiE1JIrYniS+CCIX5/6s=;
 b=ZNWd2m45++pVzl9vg12PO8WirV7HaTy2UqmzEYBgiY69jESnEGvkaG+le5tfKvX4Qa
 dIiX4TLhrkBgVXdpTjJzQHyUX4SF7lyoX2sbgI3ba+96TdIMIH0LGwz4yA7CHpvJOnce
 jRWTDfjAiW/X25ACOfP6HeB+SH8QRuunIiRBYSqT51eVHE5WIO295OyrHQea1aonTpZx
 1TbAsg+bdUVqYUPdkvHBX9bnI/HS9brWgzPI3pUTkG9SFJE+GRIWpdIexjpg3Yqi9w4s
 +o6S9pZCxlKabdHVpU70Xl+1SxrXniTOSX3/IIME2qQ71TotKAD0zrh6aa/4Lk1broHp
 prcA==
X-Gm-Message-State: AOAM532Ygbbp8U31EZTdIyrNd1o0yIwGB/n7vaNoYUrK6Xm1HLkjCEyA
 QSo0HXOuEAU7HZq+2pZ7wztt645lHhXrqQxWgkOSgw==
X-Google-Smtp-Source: ABdhPJzuFe3v+ZgAyU00b+2EioeEn8OG3bPJUKkIPD8a9D7b302ajHZ2n5l/VX/t6zi2K2aYhklFPfjO/vzKI93NZEI=
X-Received: by 2002:aca:568c:: with SMTP id k134mr6584903oib.48.1591894821481; 
 Thu, 11 Jun 2020 10:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200609205245.3548257-1-eblake@redhat.com>
In-Reply-To: <20200609205245.3548257-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jun 2020 18:00:10 +0100
Message-ID: <CAFEAcA8wvdhs7VriU1JhfAhpCD55YvV7dyjcHvjpr2HfqiBwHA@mail.gmail.com>
Subject: Re: [PULL 00/15] bitmaps patches for 2020-06-09
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 9 Jun 2020 at 21:53, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 31d321c2b3574dcc74e9f6411af06bca6b5d10f4:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sparc-next-20200609' into staging (2020-06-09 17:29:47 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-06-09
>
> for you to fetch changes up to adf92f4645ba46726368735916fed763d3e5a09b:
>
>   iotests: Fix 291 across more file systems (2020-06-09 15:48:00 -0500)
>
> ----------------------------------------------------------------
> bitmaps patches for 2020-06-09
>
> - documenation fix
> - various improvements to qcow2.py program used in iotests
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

