Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E94C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6892204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWapsl79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6892204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRNh-0001Oa-6W
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 08:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRN6-0000pa-Lw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:52:52 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRN4-00026d-3H
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:52:52 -0400
Received: by mail-oi1-x243.google.com with SMTP id a3so4854719oid.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TRmR5jxbbH/BD3vaeRPCJmypThe5SmJR6ikhO7kPtlQ=;
 b=rWapsl79pfwmxqonKF0dxwWxkSjE8ualxWXEfXzGUTJ4RuylsSUc3EX9oQhwR1IvJO
 Bir0TiVYp9LSpFcK6n18Q8n2zcmfLOcE0F8NFtMpygcDfpM4IBAUXzqHJTph93MhxWTd
 bffgytpZUBfKRkyJ6VEEYIp/ZsyMZqxzaxkP+Hkjy+UWz3DyIkgtLqB6YPViCxPV1i2m
 K6as0JxFRm4sN6Al/b5tB/I7B79T4YgLdczBXM18M8TifqF6Uc0m6229uH8pVSYi66u1
 gxRCVYP/JgPe7sSXvQywbciYbpQwZdZZEPb4biJLM4zcbllG0JKjQR6fJJX6yIWNnA45
 Ycww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TRmR5jxbbH/BD3vaeRPCJmypThe5SmJR6ikhO7kPtlQ=;
 b=PGt3UydSH2w+OyusnXHODgkdKvggvhOyNQMH8oY4RKWJB9nOVtRV8A15M+XharhieL
 v7LUghj47VURnMMZwKtaMkqqe4FsDDBujkaYBTur8AAomqRlnm6niF1nniloq3mci8hk
 DYkpuKQz8mnUt3Cd4LYwz9qJSW9OrlafAlAfps7sE8N+MVh4++hEKgkntnvNwMUf6gQg
 eIwnE7+vGtuI4tviBaTOFr6v5dvf0LCI9Hob5DVnPLeElJjNbLBYSzzzq5f+5YjVcfbz
 8LzURy0RC54Kk0NjuNhbj/TFd1yvAk/SWQ7V2+E1XSNJtMIXq4w1tbh50NC9bNoUUi2P
 /eyA==
X-Gm-Message-State: AOAM532PfyDIEame9rt29Nm5DGatx81dRlW6W+sb4pvbNpna+hupOdcf
 FYXGrfMU/SsboLSfP4DEX2I/OkpTKEGS/8C5mXppvw==
X-Google-Smtp-Source: ABdhPJz6p3V5pZ2EQ9MvpyqseeUdzeGNecRKmqPN20uzp8Llbo87kFpxP4ZFPXpZboEKUydHy6fozWcnbt91cTBGzG8=
X-Received: by 2002:aca:568c:: with SMTP id k134mr1868783oib.48.1593089568750; 
 Thu, 25 Jun 2020 05:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-39-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-39-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 13:52:37 +0100
Message-ID: <CAFEAcA8xy_Q-6zXexBEHLR=WSYTXVvttL9V4HqiMPmtRm__TEw@mail.gmail.com>
Subject: Re: [PATCH v8 38/45] target/arm: Complete TBI clearing for user-only
 for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There are a number of paths by which the TBI is still intact
> for user-only in the SVE helpers.
>
> Because we currently always set TBI for user-only, we do not
> need to pass down the actual TBI setting from above, and we
> can remove the top byte in the inner-most primitives, so that
> none are forgotten.  Moreover, this keeps the "dirty" pointer
> around at the higher levels, where we need it for any MTE checking.
>
> Since the normal case, especially for user-only, goes through
> RAM, this clearing merely adds two insns per page lookup, which
> will be completely in the noise.

Can we have an assert() somewhere suitable that TBI is set?
That way if we ever do have an SVE-capable linux-user which
doesn't set TBI for some reason we'll get a useful reminder
that we need to fix something.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

