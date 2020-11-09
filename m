Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A180DC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067DB206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xMmYOwl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067DB206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc5a2-0004S8-41
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc5ZL-0003VK-7P
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:42:43 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:36015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc5ZJ-0002B8-MP
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:42:42 -0500
Received: by mail-ed1-x52e.google.com with SMTP id o20so8392217eds.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 03:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+BooO+D9VaFv9YPGlIazao/4N9f+P9VGABPAaSjRg3k=;
 b=xMmYOwl2/eW/yEPY+/q2ZWQbSS6nZHAvpdkFlORjLQNo21aWO+szSwI9Fj/dXc5xLB
 bDdaYiNtlMeBCOFzE/qLPFXzxg6YqiDZdjGv6rsxWahdPCmmW1aGsJCEs5AlfJaSAFcA
 Fn0FMT1iORez+2FlSJteYpaqWp7ZKiD3+4NT/oe7qm0EwoRosDd/S/txk97tJqGRsVUY
 wb3EMO/q0KWWi2eMJv7cMeazI5KfOlLpRnzsk8ijL4MEHDq3G0iCqWOEUCKSOjBuVoPm
 EzFnVYWARJ94FHpTDt4YoRhum2vPGrd1gsW15CFdtXLTrsh8/PZ+B4qoZeGe8pn4Xwlf
 lBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+BooO+D9VaFv9YPGlIazao/4N9f+P9VGABPAaSjRg3k=;
 b=aIgCw1jK9I/3/qQs2F78gv/SbpJ4KDj0DHasVpN0QAgJgHGw9ngprXEjKbYBxUE9Rn
 xhgKJEKzrtNwzT6jBP7hB1yZq+dOSUD6t8b5FbbdhH2aeoB7+Xd5HEeEzj4kJMOVymMh
 U805Ov55196GhgPG+4WqxUIBL09kinmLB21SygkXfyUjjb4kd+ZbbOz9thp0D8ouPnwT
 Ovo5nfkh45iPpvUs7wHgzGIffdDtA++KPYgpx3w8kP+J8+0UFOI4neW3tHC/K4eRC75N
 l2ipfjziPej1rpuBxvLzhn+vLyuzgmj1Mj2TZzL+f4/er+SsGjlZNKVtvSlY0vjJEOem
 IVaQ==
X-Gm-Message-State: AOAM531eKYyaX6A//mgGnV91UvXq+f3G4UNjaX6wdPqGCkphEE9PzD17
 rM9bPoLiZ7/A7T9mEZVyLUgUUs2fjYqxhvBEGl0laStJud4=
X-Google-Smtp-Source: ABdhPJxsz1aybnpJc1QN/eXxNEnLIwxpIIW/CkgRx1CgRq2r874fdi1EWHYGavN2KkcMBPM3pWaD7HG4HKyAOF3LUoo=
X-Received: by 2002:a05:6402:30b5:: with SMTP id
 df21mr14533533edb.146.1604922160272; 
 Mon, 09 Nov 2020 03:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20201107114852.271922-1-philmd@redhat.com>
In-Reply-To: <20201107114852.271922-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Nov 2020 11:42:28 +0000
Message-ID: <CAFEAcA9PrBczdwk+vBXOVGgYsNykz2jVNQcqM9-y5BQSkkMjXQ@mail.gmail.com>
Subject: Re: [RFC PATCH-for-5.2] hw/arm/virt: Remove dependency on Cortex-A15
 MPCore peripherals
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Miroslav Rezanina <mrezanin@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 7 Nov 2020 at 11:48, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> When using a Cortex-A15, the Virt machine does not use any
> MPCore peripherals. Remove the dependency.
>
> Fixes: 7951c7b7c05 ("hw/arm: Express dependencies of the virt machine wit=
h Kconfig")
> Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> RFC because there might be some odd use case I'm not aware of
>     (like instantiating it via device tree?)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/Kconfig | 1 -



Applied to target-arm.next, thanks.

-- PMM

