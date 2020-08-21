Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E111C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 21:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CD9207CD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 21:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cLxAbkf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CD9207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Er0-0005Fb-0I
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 17:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9EqJ-0004pA-2A
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 17:44:59 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:38331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9EqH-0007T0-Dz
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 17:44:58 -0400
Received: by mail-ed1-x533.google.com with SMTP id b2so2769311edw.5
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 14:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d2NSkNRqXhzbLDqCRw2ZU36ZaqCtFfo83voHvJ3kUZA=;
 b=cLxAbkf45NdYXWW/n0flOeaJNldI6kAdpOpCOk8yTEAzECC65g64haWVa24v8Dny/o
 yHNjPntKvglRO0c/gaeO5aFKQzG+F6uLIb1WNZCyb+gLSn7TBkUULGnv80YzA+7kQFg+
 0xFeuweRhj16hQL3zwtkwtd01OoB/DJC4OFfIBaUqSU1gw4AOSz5vgh89YPjrkoLOvgd
 kvWbKkmY2awvz+LQ6tM7xBVRRY09Pj93Iyppv+5nMlxfX+XE+M67h1Y+1/bVIsfzhoVQ
 wri3190hi+Id33Bq1BZ5HwqgvBbkO3C+RQFwBV+reQHiiW5pVyXbvd6BWIJfIQsC1NdF
 0cPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d2NSkNRqXhzbLDqCRw2ZU36ZaqCtFfo83voHvJ3kUZA=;
 b=G0gp/8FCQufKf5qJV6JJVmVKMn+f1cLXj64d/Y+JDdVgmTCFRJGiV9gh0LK/nbMXaq
 2xVVo145JK69t+dDk/loYXy9ciCC84NY/sam8VGjHuBctr8c1vhL7tOH1C1qb/G9DsOT
 03Q9Y3QVLRY3i1tl1zMT8qeKVmMRdnznJiLw6EdPoYUr+qwUsvs7xM0RLPmOaJ7VgwQG
 RbXCX4fVP80zPJcz6MWkWfjGShgb7pb9oPvoDdEhRDgZJv+GHYPzHmNRenOaraTSTTxy
 u+sA3yuUY900o4tJgJ5MD3LwAZBx9E5AozeOX7smseeNSEVJJDj92nqS/dm9uPogrRxh
 sQLw==
X-Gm-Message-State: AOAM531EtqnLMlSpjsOs+u6+rzvpMOF1aLdFXLSyATkeQk0lC050Huvq
 +Gd76emKsR4SCsqceKHkmcdRYFKb4/2DlzfGLgAxFw==
X-Google-Smtp-Source: ABdhPJxIXylGdwxZc+7iA93wWoy5/dyYGJCZiPNu+mtR0nx3+b/iKzQe0UdfVmBjjvVm1asA+87BgchkrASokZ0N3Uk=
X-Received: by 2002:aa7:d596:: with SMTP id r22mr4949785edq.204.1598046295125; 
 Fri, 21 Aug 2020 14:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200819054644.30610-1-kraxel@redhat.com>
In-Reply-To: <20200819054644.30610-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2020 22:44:43 +0100
Message-ID: <CAFEAcA9_=KW9jS8g0r_uN1y3YV-8vhmhUYjaHm8mMKO4K4FbcQ@mail.gmail.com>
Subject: Re: [PULL 00/17] Usb 20200819 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Aug 2020 at 06:54, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20200819-pull-request
>
> for you to fetch changes up to d7e5b2e1a4035fb81517a2034bb955e58f28d5b9:
>
>   hw/usb: Add U2F device autoscan to passthru mode (2020-08-19 07:35:27 +0200)
>
> ----------------------------------------------------------------
> usb: usb_packet_map error handling for xhci/ehci
> usb: add U2F devices (GSoC).

Hi; this conflicts with the meson buildsystem merge, I'm
afraid -- can you rebase and resend, please?

thanks
-- PMM

