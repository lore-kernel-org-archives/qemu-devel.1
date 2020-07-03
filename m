Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80357C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF8D20870
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mf78nj9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF8D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrM9s-0008In-If
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrM79-00045v-3Z
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:52:27 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrM76-0000Wx-D0
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:52:26 -0400
Received: by mail-ot1-x344.google.com with SMTP id n5so26784701otj.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XPJsWCIrHF39xH7oRa7xgSt2AymTiJs4Z8j99EMpnQ0=;
 b=mf78nj9pNLBxKEUJID7pVG5rzyJXGQNeYgN7zncKhFnWb4O4AXQQxIJeLtBqhTnIHP
 66ueDgP0/WZMYnfoFJNSlM7Q8L+cIhC1lyl2dK9ILI9s3riEsOEs94REWdQkg9EsqWse
 Gozr5YfCDRmTrOPHta3SvwRqg5Y47bT/yUDCTzGYhQnx/qRBQRbskarC4ZCQeOcWZ6LJ
 DJEQOxYycNLL+oROI3XfSvMbhuDemkIAnv+y0TYWYV3+Pf9itlpveoqrhGgfiYx7sq75
 IXagF2nue9hL4zSUzaTgEJiOqXQ5u7IbBPYITTFodSc3GkbI4pTWhbAnYDM54arYAtQi
 FmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XPJsWCIrHF39xH7oRa7xgSt2AymTiJs4Z8j99EMpnQ0=;
 b=eE7atQe/KlqXZ0TU5RoCg8kkaiGfRIpFUspTzMvl/pEp8qL1a7hlcGJFWRp5QleIV/
 Fj3BHSVejzkNAlLp4G5XpexN3ct3JMy9/0yMTPnPT+EkXixPTCpp9dfmc4FgM8i5iv0D
 j2k7dY51ulQXYG0ncQ/iAmMWZA8TUG7iiwKWEjPcLdR4LPwd4eRmcFmhy8uiiZrBqDO+
 uv2W/bAv3adgTvTA0NTJ3kkVpF0/cCtfHFeIdk1dtyE8boXA6hM9nBYYfa+gRQ652CRS
 BG3cZfZj3b+6Jiq4+Ym39S2/t7q3yB6uiOvW30DFObGDScRfO42L3XOr+TvUZX4pdIwg
 WDTA==
X-Gm-Message-State: AOAM533ScI7BIw1i8YbawFabPQ5TfBmMpF7ycI3K1ZoZSbppD3pAmM8Z
 Bt147u/extGDBzh/msLyGZAyH3Ye6m9ZeQk3272NjA==
X-Google-Smtp-Source: ABdhPJx7qZ23Xx6FbBpO/xw7CRu/6RTm7/Pj62z6RrHrWU0Acvksq18+vZuTz3idktWpDnGQCXSQs/HmqGYYVlA0z1w=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr24570302otk.221.1593784343129; 
 Fri, 03 Jul 2020 06:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqy6B_mtdwCYDAw0ZRAsmKROMw4hbw8pRznj9yPH2TwtPA@mail.gmail.com>
In-Reply-To: <CA+XhMqy6B_mtdwCYDAw0ZRAsmKROMw4hbw8pRznj9yPH2TwtPA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:52:12 +0100
Message-ID: <CAFEAcA98566jHbGuWWFO+bpQMmOTrkYZmBoB9KWSWzz2aT_O2w@mail.gmail.com>
Subject: Re: [PATCH 6/9] Including endian.h for bswap operations
To: David CARLIER <devnexen@gmail.com>
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

On Tue, 30 Jun 2020 at 01:46, David CARLIER <devnexen@gmail.com> wrote:
>
> From 2f65cab41a8f4508532b3893815f222bf2293463 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Mon, 29 Jun 2020 22:19:34 +0000
> Subject: [PATCH 6/9] Including endian.h for bswap operations.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  include/qemu/bswap.h | 2 ++
>  1 file changed, 2 insertions(+)8

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

