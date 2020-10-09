Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559DFC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD702076E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sr6pUWN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD702076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQwZv-00015S-Qb
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQwYH-0007zS-VE
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:51:33 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:34704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQwYF-0007I8-4v
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:51:33 -0400
Received: by mail-ej1-x636.google.com with SMTP id u8so14326409ejg.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1YplCQGGpub2zlaw7ENhKq/CRFojJ27h9P4zlJkUHQw=;
 b=sr6pUWN0OWDHodVv8ykgx+XTwDO1lWO+ihseEVkxd1kLH/J1ZS1yOqBhXmyELCFFKw
 2CoZQiE32wU1P0YVYzdOwD4UfFwF0FF17de9XoAWjskcDsONYnz7WXPwgWYkmz5cNI84
 Kd7dDy3ZoF4XfVxKdKicQ3nNh3sllX6SQ5oxjbIve1T8HomS1P65s7GNtmBlpz0YHNwn
 JXBioc9rDOKAQSOTXK6dJQsPOcG0239jlL+3IlGLOj2oQHyaVD5+GQlQDZzMoveXx33L
 m0/ETrtHpXsGZoKvB6dHCBYMHhibhBWwqoNTxymqprTI7Y996nAitQ4gd9Uy/9OiA8OC
 IHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1YplCQGGpub2zlaw7ENhKq/CRFojJ27h9P4zlJkUHQw=;
 b=uQtFyEM84j4OGVX15i7Rx9ait1TEnO+47aEprQs8DZvfgJ8Ycst6HGKrS0Fi48ClF8
 LjXgZHp7JwohA6MTuIrHloYIpjFuPRWG5OM9QpZ06fWpa0NjinxFoeuJw7ooMioTYSSN
 UXjNyw7gUSb1KoqcX4BUFhjm5xU9khgcw0g3MzuDXWbEpjYw/Xi74fT18t7hIfTObnh2
 CCjPFoH2WcvaJZgyWD6cL8UpdUFj5kHTIpq5m6OuaFwpAdKA0mHyqKf6cX39vWrFyjFs
 LObGBxsfAqvnqvUH7TgEvZEcp3kmdjiYme2dyrz1RnJRf1h1BCrWnY9aOp704/bRNFhp
 OMhw==
X-Gm-Message-State: AOAM5322waQaZe9ZIk9I8ksCFGU2kjLtEcomr72z/2BDCJmRbUgOW7By
 nHz+nxblwWuTIfhFy1gdLee7eteJJcDcLwk6Z7Ma0w==
X-Google-Smtp-Source: ABdhPJzTWeV6AK9+mL1Tby+YKsYMm+t9rYm1XXN8dlhp6d76qPKaZ0dnwgi5dpebP+PH5xpima2qI9oxC8VqaYR48ms=
X-Received: by 2002:a17:907:4365:: with SMTP id
 nd5mr15773807ejb.56.1602265889313; 
 Fri, 09 Oct 2020 10:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <74151CBD-4750-4E68-9127-21076C019036@getmailspring.com>
In-Reply-To: <74151CBD-4750-4E68-9127-21076C019036@getmailspring.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Oct 2020 18:51:17 +0100
Message-ID: <CAFEAcA9cZPgaHGuCs0J20YJ48V2eXHFFRsb9a56xFULjtFtn3g@mail.gmail.com>
Subject: Re: Re%3A [PATCH v4 1%2F2] hw%2Fwatchdog%3A Implement SBSA watchdog
 device&In-Reply-To=<CAD8XO3YmTC7fzxttg%3DQLMpJbg7uLogatxN7q7vf-iGZjyQLjjQ%40mail.gmail.com>
To: Shashi Mallela <shashi.mallela@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Oct 2020 at 18:30, Shashi Mallela <shashi.mallela@linaro.org> wrote:
>
> The value being returned here is 0 (initialized to 0 at the beginning of read function).
> I have seen similar practices being followed in other qemu implementations like for example bcm2835_dma_read() in qemu/hw/dma/bcm2835_dma.c,a9_scu_read() in qemu/hw/misc/a9scu.c.
>
> Please confirm if you would still like to add specific value like 0xdeadbeef for bad read offset.

Judging by the subject line you've mangled the headers on this
email so I'm not sure exactly what this was a reply to,
but in general QEMU doesn't do that kind of "return
specific marker values for bad register offsets". We
typically log it with a qemu_log_mask(LOG_GUEST_ERROR) and
return 0 (unless the h/w does something else).

thanks
-- PMM

