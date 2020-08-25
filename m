Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A901C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6496620738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z1trUuVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6496620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZT8-000447-NI
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 09:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZSE-0003dW-Pt
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:57:38 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:43907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZSC-0000Vv-Ri
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:57:38 -0400
Received: by mail-ej1-x643.google.com with SMTP id m22so16629520eje.10
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+5d85nLtmd6b8/lYuSri51a7vH2Umdb7lsjifgguoRQ=;
 b=Z1trUuVvbjzKMS6ottg307wzRSynVCl6y6TqsiP2O0JJ1iwxOp/6xq/usaUnxKOxty
 zKjbDDn4aDf6klw6IQB+oA5jjrXD8b3DuG1ALDvyps5kwI/GvnSamDCU2fkunak6NW7c
 Cjvtis5ka2JtaEcsivhA6MuG//vLofAIccYZUMJljT9K1jhUsUvk0uYuD8fKA02phMtf
 4w/VSH4IZBKdiZZ28ppyyDiyNa9lEW0TtU5Xbk1lNK2y3tDR3edP3eW6p+PNEVO2AatP
 1nLWSf2UroyZDc49wPAQqiXq8GioSMJBO+ghkh8GenEbF83pmvXSuLE2hIa4d6Oyddmb
 yPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+5d85nLtmd6b8/lYuSri51a7vH2Umdb7lsjifgguoRQ=;
 b=G9P27/ovloD5isaPGsCCqJiPSvYfhppIQXsOo/9oTZ9lOaL2Upg3sqirdCs15+wKha
 sKvitsbl9VeKnxhzYCh+pXatVWAZt8vTx+HPgElBmVEoFJDWV6kJdoUhOZ3VaJEAbikq
 BN3CsjaTilHkV98wUdqlv7yMj3vSTvoGccuTr9a5plh5cGKbfSnwAzzeLhQEk1rHp/LV
 NFjsnMtUDCQ4t9XMkz6xN71CAnl/FDWk1m58PVWAtoPAFIqL1uA2iIB2yUvfZFy9sMuN
 vESmWYphk4+2tGXyCKLe5d8IRCz40v2v/3t1FW7tRvc0mTqgRjg/r0WClFUI0maGtduu
 GUTw==
X-Gm-Message-State: AOAM531aTPgWZ0Rkb1G5zALiH4DixLWxxAZBXS2z5HoF+V2ziA2BBLtX
 iXXENRO74mrRC4u2D8e22jj5RwofnBGfN2SJNBtAjg==
X-Google-Smtp-Source: ABdhPJwCWz799cQu0NgXg6SG2sc4ddUOCZp24KdbOM79SJTm4S1WZ9OgWuzySOSGr1yZYEAGNq4pvUYV/y6KV/5UO6A=
X-Received: by 2002:a17:907:2066:: with SMTP id
 qp6mr1609511ejb.85.1598363854287; 
 Tue, 25 Aug 2020 06:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-21-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 14:57:22 +0100
Message-ID: <CAFEAcA8ZfwEbkLyfg_g-6ea51JDOyZANafkKwSUocbWX2r4FiA@mail.gmail.com>
Subject: Re: [PATCH 20/20] target/arm: Convert sq{,
 r}dmulh to gvec for aa64 advsimd
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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

On Sat, 15 Aug 2020 at 02:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h        | 10 ++++++++
>  target/arm/translate-a64.c | 33 ++++++++++++++++++--------
>  target/arm/vec_helper.c    | 48 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 10 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

