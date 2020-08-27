Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F132EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6AD922CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2DOuKTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AD922CB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBFpx-0001J4-2L
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBFkL-0000ad-2L
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:07:09 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:38202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBFkJ-0007w1-9P
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:07:08 -0400
Received: by mail-ej1-x643.google.com with SMTP id oz20so7095451ejb.5
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 04:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NcFQCh/pwj5JpIFEsK0KeHer9AoG967avch5EL9zFHc=;
 b=r2DOuKTCUAvtmjIXOeXiU/nHsh/V+Jzdgmz0yUGw0cbEUqJJrce8W+zf82VZKGZhCp
 ZODgP153/5MYTR5GUsLydiAyZ1T1J6JyAfSGOOUTAncKNIq7oJ7wIyxyCxyiiR17oesF
 rjJ0vh6kzHAkf5HvDnTqyJs9rY5ElwtwcjvS41HSy8OlQbzzueqOIhk3qCFf8iCXj7Jg
 v+Om0SY4/Fs6fF5S93N+r1AvoiOnXQx3dRwtOUs+UcyU+Kx8KGHgcUrHGiacuhk1gQ7G
 0JwCz66HPx60gaKLYaiKZeSuyQ3dTfNXGSITAzmBWk1f1Uxg/3+OFGLKMm12wDbSXG3Q
 ORnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NcFQCh/pwj5JpIFEsK0KeHer9AoG967avch5EL9zFHc=;
 b=XBrFNupZ9aRB538lDa7Cg0eBD6KHP83YKLYa0VsB4sbcGlLC1fRGpNTCly7okVp1km
 0IVWNcHkfNXkkav7exHVlYM7XnW6+bC3DdzYnLIywN1uxY3Ew4vXzeQ3o8wOHOMlSvKg
 1Lju5zV3gRgvFWC91upOa+Q5y7lCwLmgk8qFb2lIaP4Q+hm9id58qQc0oF6AcfqePoU9
 V2A209KHfeFrWXpLjK0Np0p/MQ5GC/8S+UNA4vnRNaGuRJ3eXdfALY9DW/orhtRToSfq
 swQvlG4aakeyxhdLpYC2+nhxKO1KrHiXbgFtomzrFUBhh7PR9FRWLWeNKX4zZ6zFh6pn
 7QWg==
X-Gm-Message-State: AOAM532Plk4gd192nd6vbTUyV02afQIgfe8VWGJowvI0x8o3S4g1PAl0
 dsxv53uf5Gdit6lp2nM1qIPnGQTD1+ZMHDVZsIsxHw==
X-Google-Smtp-Source: ABdhPJzoSW5+SRJOixZA/zUjBv3z3x9KA0TcnrqzbsL3O9+YzXiMNyPvJ28B3sDB3NWkbeFsl8N0PsCW2CCqv2esSlw=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr20048873ejr.482.1598526425506; 
 Thu, 27 Aug 2020 04:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200827110311.164316-1-kuhn.chenqun@huawei.com>
 <20200827110311.164316-10-kuhn.chenqun@huawei.com>
In-Reply-To: <20200827110311.164316-10-kuhn.chenqun@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 12:06:53 +0100
Message-ID: <CAFEAcA8t1oo4B3KUm1kLzFV0R6L=_Z07cDcsSomP8UKRwMMjSw@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] hw/intc: fix default registers value in
 exynos4210_combiner_read()
To: Chen Qun <kuhn.chenqun@huawei.com>
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 12:04, Chen Qun <kuhn.chenqun@huawei.com> wrote:
>
> Clang static code analyzer show warning:
> hw/intc/exynos4210_combiner.c:231:9: warning: Value stored to 'val' is never read
>         val = s->reg_set[offset >> 2];
>
> The default register return value should be return 'val'.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

