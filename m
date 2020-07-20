Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1256CC433ED
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE0622BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PFDM5ebV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE0622BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVyy-00010W-3T
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 09:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVyF-0000Y1-Aj
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 09:36:43 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:38014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVyD-0004aI-N2
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 09:36:43 -0400
Received: by mail-ot1-x32f.google.com with SMTP id t18so12171233otq.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 06:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0WrRLTEXcopl+mM9Qcvu+50OuqR0QQmhAAjOw/lnh5U=;
 b=PFDM5ebVQUKQXOkFPHml0Kz3JcZ/fv5eeSlg7UaPrTkTYWJM9SWqTPj2AMCu9jowML
 HdZYCPM0zHaPIrmuRR+AiyC23bDO5YMMDp/uO8YgZjs8Z2TUgi4UI49gUsFi5VKsE9vd
 u/SoShnrZ+S3j1W3iNnsUzXTpc1v0PtH2um4VSxNMbALVAO9q4Braz88QnRD6/JBdxAR
 wO4u9TZ68SGhNZuPG7nSbsVTo3DWwEpynE5+lgI2DDkW2VS6ul5l8ubAu4lQIgbEscAj
 /Dx71f2qXIHNdI7sRCLuIyEhZc8jDTONkgJoHxp5bc2g6X/i7bRkGkRhs0yXQCG5tITd
 p6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0WrRLTEXcopl+mM9Qcvu+50OuqR0QQmhAAjOw/lnh5U=;
 b=VHMwZapJXqCr84F/BwELCmOFq0f1gRVQr8LF8GzrBzeWzXx8cW2KVoxm9TmoDZDui+
 TPJGsN4W5N/5XJPSuWNwuI0LfNNnGbbrT6UkBPKVbL2Q7q6J14NZkSdgIO1VumIrjsAx
 z2jBgzYhqRLf9Lx6zl/FG/wcRyJ5G8PNH12L/suCmXz7fckazeEvXd1gozG+KKkYKEkX
 KYK8ZVHY8w12rILCpu6gqsYTp7Y6Np1K47NRplHNV2D94dTq2uNdFsfKGMOnfbv9LNl3
 +b32HzP/RiPUQoymwH0g7hC7VEuULjxkh5y/XUPH0/cpykrFwhrAUzxcWzN/NuqOHq3C
 mK8A==
X-Gm-Message-State: AOAM533iyJKhD5b+6co5B/BU4jMt+d4ahysJ7Bdz9WARHFdlWHpWHhol
 09HJzC7tpHcwxlQMdM8DqypqeliTKjiO+Fwszt0ATQ==
X-Google-Smtp-Source: ABdhPJyi/wSVtxxWbXeJafznCSKv3n2QtQH4hRs65zx/6woqA8pTiWX+pjYWvvfApdoWfgY9KO0MTKDrvUh3JEUCjDA=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr19782791ota.91.1595252200203; 
 Mon, 20 Jul 2020 06:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <63109e68.7dc9.1736c073666.Coremail.13824125580@163.com>
In-Reply-To: <63109e68.7dc9.1736c073666.Coremail.13824125580@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2020 14:36:29 +0100
Message-ID: <CAFEAcA_CmNdmhFrJOxOpHsKCER2gXvqrq5DcQTdp42V+HLK1cg@mail.gmail.com>
Subject: Re: What is this mean of the comment?
To: tugouxp <13824125580@163.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32f.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jul 2020 at 12:52, tugouxp <13824125580@163.com> wrote:
>  in flollowing comment of tcg.h, it says every helper max need 6
> input argument and 1 output argument,
> but why here both multiply by 2  in here?

Because arguments might be 64 bits, and on a 32-bit host
a 64-bit argument has to be passed as 2 separate operands.

> what  is the 14 mean?

It's the maximum possible number of operands in the
worst case: six 64-bit input arguments which need to
be passed as 2 32-bit operands each, and a 64-bit
return value which also needs to be passed as 2
32-bit operands. (6 * 2) + 2 == 14.
The reason we care is described in the next part
of the comment: we keep one bit of information (liveness)
about the operands of each TCGop, and because 14 < 16
we can fit this information into a single 16-bit integer
per TCG op.

>  520 /* While we limit helpers to 6 arguments, for 32-bit hosts, with padding,
>  521    this imples a max of 6*2 (64-bit in) + 2 (64-bit out) = 14 operands.
>  522    There are never more than 2 outputs, which means that we can store all
>  523    dead + sync data within 16 bits.  */

thanks
-- PMM

