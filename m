Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA3DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6072073B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e187l9xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6072073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVa9J-0002Wf-0O
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVZpy-0003PS-34
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:04:44 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVZpq-0006l0-JQ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:04:41 -0400
Received: by mail-ot1-x344.google.com with SMTP id z17so8633084oto.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mc2OiBAeuadvg7stvx74vegh5mSzJafd3UHWJqIoSzs=;
 b=e187l9xjj6PQbjOyV6L1iupjQMquEJaN5Kx5SevW4lkyTNsjVub/ZWNAmvC+cN+Bps
 RmsZiHnIFQPfzBz3at3f83ULzvZrorfcmccX3m5v0HQW1a7KLVs1miUwMP9VUKY2TjM9
 YunpEK6alP4ptRlFVT+XooAV4HfiAnths7FzhHvfi6GAEVl0+pve6UvXJjLSvbae/6E3
 lAa31YJK4LfPGxSWcJAfzpZN7l/GBJmFTeYly/nBr9H6bc3fcFIQ93/bJrbDLh370kTs
 8Umm/tBaMpRphiEBVkx4vgU+k430TI5+v19s3pZ1lf7e9Fn3hnW7PESlMnKw2mXrXhck
 RQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mc2OiBAeuadvg7stvx74vegh5mSzJafd3UHWJqIoSzs=;
 b=DguUP0POhJXauv9G7UQozzwWNoq6Bb9c1VTLWc15kPpwApWn0/YyAuOozVJcP5zopR
 nfToIs9P3tjp2+CW2MOuEmV81OtNp4XFVDxWxjP183hQF1uQwFiwe2dmRYzjERp5eMJa
 mZu/FdBxCg/yyL5orxndS97wPfagtAWvOfLr7fCycK3zSv9j3J34Zp+hDLjUnaZfeacV
 unyCyu1r61eTulxB/hrowexPvGnSVY+jTx8bycNQ9iaueSaZD/AHvByd6yvGKR+pQGtr
 S2fn2yyzN+gQuZXftxX6OhF/qRm1v26+8loy8MFlhlcbKEfNAiKz0Cip84DiO7obYvT6
 EiTA==
X-Gm-Message-State: AGi0PuZlKANgbH+XCcefShN1gbconcZFaIhSWpEcuATm5myjl8AXnFEf
 21ZLXWHMLIHRZOJnEL1du8imd1VQ6DmpFNCKUIsmzw==
X-Google-Smtp-Source: APiQypI9O9d8WiKBkg9EHKqKVf2P1BVTfXQTxq9ux/UJHZWm5X5EkW0Y4Gfp5pry7CzQBdUgBhEkImU43nL8byEfdIk=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr13706916otj.91.1588593873068; 
 Mon, 04 May 2020 05:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200430181003.21682-1-peter.maydell@linaro.org>
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 May 2020 13:04:21 +0100
Message-ID: <CAFEAcA_-yGrEqF5PEa+Lx0Cc1QuqSKkKHjZk4P-jJOxCWR1qsg@mail.gmail.com>
Subject: Re: [PATCH 00/36] target/arm: Convert Neon to decodetree (part 1)
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 at 19:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchseries starts in on the job of converting the Arm
> Neon decoder to decodetree.
>
> Neon insns come in three major parts:
>  * the 'v8.0-and-later' extensions
>  * the 'loads and stores' group
>  * the 'data processing' group
>
> This patchset converts all of the v8.0-and-later extensions
> and the loads-and-stores, plus the "3-registers-same" subgroup
> of the data-processing insns.
>
> I'm working on the rest of the dp insns, but this seems like
> a pretty large chunk of conversion patches to start with.

I'm going to apply patches 1-19 and 22 (that's up to
"3-reg-same VMUL, VMLA, VMLS, VSHL", plus the "move gen function
typedefs" patch) to target-arm.next as they've been reviewed.
That will leave the 3-reg-same in a partially converted state
but it is not too confusingly so (or at least not much more
so than having the rest of the neon-dp group unconverted) and
I think that it will be easier to deal with this series and
the rest of the conversion if we get the completed parts into
the tree sooner rather than later.

thanks
-- PMM

