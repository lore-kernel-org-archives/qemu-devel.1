Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE54C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC76E2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2Wkc58I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC76E2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFXH-0005SZ-3x
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFWO-0004OL-KL
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:40:36 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:44911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFWN-0007wf-4g
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:40:36 -0400
Received: by mail-ed1-x544.google.com with SMTP id l23so8644049edv.11
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 09:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bU5adYFn6VGH+ZlZBqqHM4QXFs3I/8qMSj1Y6LFjslk=;
 b=W2Wkc58I8XEpUhFDa9ZFj1ub5uW13H5yfJHh6oFfU7ZxUxjntlDfvqNXMzpOBhUjCe
 Etv9aZGAbZ7kOMegPIkresiDU8gg1HHqNMFLReIbr8i/kaBdFowTrKC+/CoIECIDbb2k
 45qmlNzr+xWz9YDHufF61YldjIg8HvZyhbYMe2yzeHD1zgMgCNq1KmLLGGb/UEKBkOiR
 vQcUg4FsQHaK/nZvP0/a8AEWMMfcYaE1w1XFfEqPz8ltoQhnAe9V2zy2aEd3RnuUA2Tb
 J+kBBGlHJSznGPaEm3PgVLcIfz90/EbjlOKUvWG5KCoEI1QwLahcCQLT74OkKKHuzDeS
 JDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bU5adYFn6VGH+ZlZBqqHM4QXFs3I/8qMSj1Y6LFjslk=;
 b=anLs4faBqzLB+iFvGD/M/VaYWjDyPqw1wcRz7tMgz3WjxYPYWavkCVgI0obvCI6mgL
 GejLJxJ2fCXfe9yR0lx1w8DVRhy3PPkhDYS7C1/0pksbagNhuYgxRU9BVMjXKZizzDRA
 Q0Ck3tFyc5VtMXvV0FgsN4Ll1POW6KaW8IgoTQRvj1Mtm6ZFP9tbSMRPfzXh2yMw3YA9
 1KeOS0Jg6vDrJRwJl/MUyaqqnV6SyplGrPeWepXMOKpGY3E9rroqlwAEsvfuCpwjEpG4
 HUpbKho/BK1EXQ4TjNMFVvgcdeX7sy4gWPV+9yxPksMTrDI1aGzB+Jg85qzKWg5qZIJS
 xoKQ==
X-Gm-Message-State: AOAM532FUfvVClGbwJo//WFJtFyz0EKlHycoLYsKVXEOIM5SLWRYdhFk
 Bf2O173VFEvOCrqOPE9aioGdCHliiv8Ym7/I3xfTG5w2/sOhuA==
X-Google-Smtp-Source: ABdhPJxppyDz0VpGDm+YxkhdaN/hEvXKk5M7+a0LCeiCnvjqvT+fgRdg27ffoL2FYigsOnunFHTke8unyRrW20MiFK4=
X-Received: by 2002:aa7:ca14:: with SMTP id y20mr2350147eds.100.1598287233729; 
 Mon, 24 Aug 2020 09:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-3-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 17:40:22 +0100
Message-ID: <CAFEAcA8YKKASp9V_KmLgjNJDSysSBxFDYQ80zfvqLm-7qSimZw@mail.gmail.com>
Subject: Re: [PATCH 02/20] target/arm: Split out gen_gvec_fn_zz
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

On Sat, 15 Aug 2020 at 02:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Model the new function on gen_gvec_fn2 in translate-a64.c, but
> indicating which kind of register and in which order.  Since there
> is only one user of do_vector2_z, fold it into do_mov_z.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

