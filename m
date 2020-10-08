Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95BAC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7292083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QITGun6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7292083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVdH-0005pi-CV
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQVaX-0002Fv-FS
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:04:05 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:41367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQVaV-0002sA-JI
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:04:05 -0400
Received: by mail-ed1-x544.google.com with SMTP id l24so5746187edj.8
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c+1D4f03yVA463ZeH3DdyuLhiwzm+9v0rsGvKpr+4wM=;
 b=QITGun6giRJzKt1HzgtoH1XWyakzw9Xek9TQRqAKyaX+ymWY+I6oQlQXwf1wPb453W
 EGYQHYEVixTzK8t0ZxCkImR8Tdrj4KIXr0iqosj9UDwTKOwhwQBEMYp//B8DHxLX+vyT
 Dc73jP1zrmcjl9E0QxEzr2B8SvekRrKNFlceiWjr2jKvjsiBWvf6+ZjWcYmekNFURxXj
 ZBUaNixS/N+cofa/e/qns575fDJ32WfqKyBIZPXxejX8QCjl/JRDqT6+2KG6UTXRZ6Bz
 R6ZXNw20g4p0SlZq99Lk+B4bWuoiz1Laiuvrid0kcuTcv1P2IhYKz6oCkO77II2Hvo8S
 WBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c+1D4f03yVA463ZeH3DdyuLhiwzm+9v0rsGvKpr+4wM=;
 b=aF+XAv3Eso2Nw9sR1sH3hvR4SvNvjZlGINL+j1jNtzZw0sZ3Swb3gOL6sAhuFQU/Zn
 H/6tLNLGzJXfVHW+fzOo+8VSjhaGnNJUvKlf2Rv3+E+IgX7R9dTqkAe69CeW4gUk3YQ6
 WaYsmSE2+U7kDoqgw0ql7w+KY+VDdu4q7vh/RdV4DPoO19/PSyX0nu5FcoM9Ap304aRH
 gOji/UpBCWnkBU+yeewsDQI2s24if7U+b/FnNRS2CmlXSKg0Pd43haWSg8MAJEG1IAoY
 12AP8y+NyR6klSjGaPqftAS3mXqnwNcZVxulkz5cK9m9qABR21fgu8cgZie4XierEQPQ
 iKxw==
X-Gm-Message-State: AOAM530C1ceyomhWMhMDJFOcpuFBh5+izkbQwKNYd+pGrRA29YEXamox
 0ZGHBtcI8rrPAGE3VSLbUCzcq/yvplqmKj1DS/Mpsg==
X-Google-Smtp-Source: ABdhPJxHE57IWwlHyOtwYV/KvG51MmSnf4JRnEHkWSUT/UI0f0hEvw66pbxn9mQOKjFEW4jjqo/0vqg7RKaCTd/Lnxo=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr8685420edw.251.1602162242124; 
 Thu, 08 Oct 2020 06:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201002215955.254866-1-richard.henderson@linaro.org>
 <20201002215955.254866-6-richard.henderson@linaro.org>
In-Reply-To: <20201002215955.254866-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 14:03:50 +0100
Message-ID: <CAFEAcA_oOGrLAWDPOn=PEaoixYb+MdU-6BbW1uuoLC0ij7WXeg@mail.gmail.com>
Subject: Re: [PATCH v10 5/8] linux-user/elfload: Adjust iteration over phdr
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 23:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The second loop uses a loop induction variable, and the first
> does not.  Transform the first to match the second, to simplify
> a following patch moving code between them.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

