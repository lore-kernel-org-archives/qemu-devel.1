Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C860AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9258F20885
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZTBT0Sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9258F20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrMAG-0000hk-RP
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrM86-0006NC-IF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:53:26 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrM84-0000yc-4K
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:53:26 -0400
Received: by mail-oi1-x241.google.com with SMTP id k6so22667840oij.11
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6n/DStbs/HviDJef2CMucQhuRQbYKDJCyHYaau13jGk=;
 b=tZTBT0SlxB2wTmDU9Y/cOvPFvrnByRlEVrkgHXTeLH5JQ50nDLH1CVmeeEGl/gtmw4
 itKeNYi9siFOsWlLzfFMazFo2A4IbuN1ES2Ej1WC5xewGd9nMVcfafnndhNwvcB/WxHT
 Vk6YQmcKKzSxjnqSrP2EXrKietbD8wog+LxH0sCBPzadlCViJHbyodMQvD6U71gNvIx5
 03Wgex0euekm1Kc2eyHf9bHfjZ+KnHJNidxb54SSNHrJqQDwgBh2bjy3xks4joojSFTg
 ESb6vZMkDYVmERK7OjDs0OiGXnW3wZ9WtCVhdA4Mjf93N4Y+R7znfY97gej9beZnnWCE
 j3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6n/DStbs/HviDJef2CMucQhuRQbYKDJCyHYaau13jGk=;
 b=cWzLJ5G78atnkT12n5A4Yxluw4B8Gk9mXVNuFPNXltmKLcnhX4l4gyXtxw28UZBXRj
 zGKco2RW+okQVNzbYLGjT1wu0U3eemdVVHMOJjF7I2Rp4eX5WIG2moXL0ZnbNoL2Tz41
 rgaXjBRnXfinm6o5dvUDPOdjiuZQfKBQf/cD3vQ/kyesO57lif/GmFOO+IQ05qZFNKnR
 KoE9THGJbySWLgvGdeht3Kl5Zyd2aJ/zSkmxtSryl373zBVi+y60OzvC9q4W9RNDmnn+
 wQcrEvy8eP6xGD9CdRJzLDeP7ToRxuoRr8WlhR2V7peoqUgJcRr1mvg8lUAHffXKM3T0
 fpIg==
X-Gm-Message-State: AOAM532X8rp9zYzHpK+qrJQ5fNsRklyI+WZ/i2THSIenaor4aDQ61h4w
 wU/9OOto3e68ZFyBP7awcQQoLQwkRjsP7UBNfuP6Vg4y9F4=
X-Google-Smtp-Source: ABdhPJw6ZbajBPQc/43SNCgSI0eBJfJU2cjJZgAUwUPOMze6x07JLwkGDUT2wT5aLNx45ir2AfyglEP/6A6WQpBTcQA=
X-Received: by 2002:aca:2819:: with SMTP id 25mr21203626oix.48.1593784403074; 
 Fri, 03 Jul 2020 06:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqxuYwkJLbCRZpAM7pM14CbLzx3BZ=n6FW14cg344xsFJA@mail.gmail.com>
In-Reply-To: <CA+XhMqxuYwkJLbCRZpAM7pM14CbLzx3BZ=n6FW14cg344xsFJA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:53:12 +0100
Message-ID: <CAFEAcA8M6Cu=Fk7emJGwEqPpkqNKh8nfyncvAFLbW9hfM8srPA@mail.gmail.com>
Subject: Re: [PATCH 1/9] Enabling BSD symbols
To: David CARLIER <devnexen@gmail.com>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 01:44, David CARLIER <devnexen@gmail.com> wrote:
>
> From 5c6022f21289eb6e78e93d584c766db82165dced Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Mon, 29 Jun 2020 22:13:35 +0000
> Subject: [PATCH 1/9] Enabling BSD symbols.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  configure | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

