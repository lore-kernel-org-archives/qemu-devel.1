Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF818C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AA8208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odgyflXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AA8208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq1Ls-0002x1-Rd
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 17:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jq1Ks-0001sO-Lh; Mon, 29 Jun 2020 17:29:06 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jq1Kr-0004p6-4j; Mon, 29 Jun 2020 17:29:06 -0400
Received: by mail-oi1-x243.google.com with SMTP id t198so3118397oie.7;
 Mon, 29 Jun 2020 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=fXPp17oZmNt4iplEnqEV89hAH1HlrlZCaBNO43DqXlY=;
 b=odgyflXwmn9oq9+sx5rxBdQtvBgHM8rAnei9g0sFEidCWrO3wrm6o1lUQ/7HCVQa5p
 C0mhJxmHtWjh+bxQLiFSL1vW71lAsz6g1MjlBp5+D2/VRmWPzewHVlVy18+hLio/fQqK
 +Il5620vQdKBHbv3fIyvoP+NUTLr/LU2+baVJttG8oMDCRhOUPIaA4qChpRCeUnh9R1I
 wBByI5iVe8yqjLr2PNFakYLDd8t+HOG59Kvdfx9MSXk8PWQ00mrKQUK4JjjoFVQcja/Y
 qV/QFcCidnF0FPTtgRFmwdP/zcueTfJwQd+H7hYVPY6xBJwBatUFK/tqG+dZOwSWuBZ/
 dFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=fXPp17oZmNt4iplEnqEV89hAH1HlrlZCaBNO43DqXlY=;
 b=og2aMxw0t3VHB+IhTwAfnroS1UBx/FS8k+Dh0SKcq5LCyMt3GVpwFXN59W1MkNpe6J
 uTr9yySaHt02mw8YpCmzMk3Jcgs2GYctzxaBCm5XiYtClJSLkpvEuf5FhpAFJ5oa8UDi
 5Dwy5gXd+h7BlaQ3zwdpgJJpTJLm474PuMFXn1HC0KLv4p+BKRMdPZJ8eioT4wVp9f20
 a3/0mHHwHk16W4M8S9hXbh0cuqL80MPWqmfVvPdaTABL8c3QLC9FTMb27X9hecOlxTVl
 beSY7596P/UaosbLue0BhxMyN9C0nRmeCCQLs+UGHwFSYb6x8hC1Oi4RwtX441U9vvnh
 2wQQ==
X-Gm-Message-State: AOAM531lMZPuRQ/VdEc9+zwT1skKYGbWbnsohf4bwcn11PGxA06Ucq2e
 s95JP4KMxrVfZ4jekgydQw==
X-Google-Smtp-Source: ABdhPJwmhOTFQEHME37sEYpysq8NpWQyqVZrlt+Jp9UwjfVbVY9xLVKFnOQUqzj1wwJmd4Q2LGgDQQ==
X-Received: by 2002:aca:d889:: with SMTP id
 p131mr14145118oig.170.1593466142699; 
 Mon, 29 Jun 2020 14:29:02 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
 by smtp.gmail.com with ESMTPSA id a3sm217917oif.38.2020.06.29.14.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 14:29:01 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:9993:aaf8:7c5:309c])
 by serve.minyard.net (Postfix) with ESMTPSA id 743E818003B;
 Mon, 29 Jun 2020 21:28:58 +0000 (UTC)
Date: Mon, 29 Jun 2020 16:28:52 -0500
From: Corey Minyard <minyard@acm.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 0/5] hw/i2c: Rename method names for consistency and add
 documentation
Message-ID: <20200629212852.GQ3235@minyard.net>
References: <20200629173821.22037-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200629173821.22037-1-f4bug@amsat.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=tcminyard@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Reply-To: minyard@acm.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 07:38:16PM +0200, Philippe Mathieu-Daudé wrote:
> In commit d88c42ff2c we added 2 methods: i2c_try_create_slave()
> and i2c_realize_and_unref().
> Markus noted their name could be improved for consistency [1],
> and Peter reported the lack of documentation [2]. Fix that now.

Looking over these, I don't see an issue.  I didn't review the aspeed
device changes (patch 1); that's probably better for the aspeed
maintainer to review.

But I do like the improvement in consistency.

-corey

> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg07060.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08997.html
> 
> Philippe Mathieu-Daudé (5):
>   hw/i2c/aspeed_i2c: Simplify aspeed_i2c_get_bus()
>   hw/i2c: Rename i2c_try_create_slave() as i2c_slave_new()
>   hw/i2c: Rename i2c_realize_and_unref() as
>     i2c_slave_realize_and_unref()
>   hw/i2c: Rename i2c_create_slave() as i2c_slave_create_simple()
>   hw/i2c: Document the I2C qdev helpers
> 
>  include/hw/i2c/aspeed_i2c.h |  2 +-
>  include/hw/i2c/i2c.h        | 54 ++++++++++++++++++++++--
>  hw/arm/aspeed.c             | 82 +++++++++++++++++++------------------
>  hw/arm/musicpal.c           |  4 +-
>  hw/arm/nseries.c            |  8 ++--
>  hw/arm/pxa2xx.c             |  5 ++-
>  hw/arm/realview.c           |  2 +-
>  hw/arm/spitz.c              |  4 +-
>  hw/arm/stellaris.c          |  2 +-
>  hw/arm/tosa.c               |  2 +-
>  hw/arm/versatilepb.c        |  2 +-
>  hw/arm/vexpress.c           |  2 +-
>  hw/arm/z2.c                 |  4 +-
>  hw/display/sii9022.c        |  2 +-
>  hw/i2c/aspeed_i2c.c         |  3 +-
>  hw/i2c/core.c               | 15 ++++---
>  hw/ppc/e500.c               |  2 +-
>  hw/ppc/sam460ex.c           |  2 +-
>  18 files changed, 123 insertions(+), 74 deletions(-)
> 
> -- 
> 2.21.3
> 
> 

