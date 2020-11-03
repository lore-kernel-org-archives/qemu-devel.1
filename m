Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AA5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED65320663
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GsdobSG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED65320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZtMb-0001EO-Tc
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 05:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZtLf-0000jN-OW
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:15:31 -0500
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:41318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZtLe-0005op-4s
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 05:15:31 -0500
Received: by mail-ej1-x642.google.com with SMTP id cw8so9734050ejb.8
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 02:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z4wgo89ml5eirsaQqj0zoNUPYZPMiyabBFQs6dGJs40=;
 b=GsdobSG4weqgm1rWDU55JtAdqpFfSFkdNm0GhDcJQuzf5KMlf2y/Fsu2Z6AMgW+6w4
 4hasH9OKIh01yTrZZYQ/WdOb5QoSd0LhIkqjeAQRXGArawCdiXq/iZCqc5hfTsOD2AGm
 VnfbNJLEUxlAJGLFOs2HpZ6ByMfn4ymigj/JzwXpAN+GnER4UT0MNUYNFxnZRxcNXosY
 RH/FNFc9I9VrM293eof2sot6VtFkTY1RXgIP6eT5jsNYQTT1Ovhz5204SreR7bcLVdGJ
 z9h/0SYubNoPMeCQ7YGF/YXfW+WZJvauhYQr9ZzIsE41r2edBRY93LAH2jwxFQg97Rlb
 RaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z4wgo89ml5eirsaQqj0zoNUPYZPMiyabBFQs6dGJs40=;
 b=I6zaukxj2F0eTzk0NlZl1hv7tSw0SUmSsfxXKWISg/GGOlY7uRJWn88Dk5f+kYpmjR
 iNpgrOVT7CZ5ilFVhgs4dRnXo5fc3FdYr6kOTyx1N7gJ4VXW7jJFLxKwBuYEf+YFGZeM
 MMljy8Le8vWS61l7ihPtdTDdiqTsGK/VI1TV/4smz+q05Ko0NocT26og/AKgQgir+pEt
 8LXdjvPKUNIckT+CYKfhmxlhDiIZR2/WSY+0sy1gFAA4+IWbMNe4+BVUFbC87XoMp2y8
 u5f9FJl/V3npV6qpFqvK5hx8UYj3QxMZz5oXCStIdUX8Ad9tBBgEURFjiJ7vbFnjzs5W
 4vIQ==
X-Gm-Message-State: AOAM532lEKyejmTn8OHsHYLptp95yKqW82dU03PbPZ+BH9UdJ9vlvOgN
 FQ53o9eDsmR8m4JM+EDTCGsvq/lj5zjs/N0+DXiJ/g==
X-Google-Smtp-Source: ABdhPJxnxEoizVY0rh69WmRSFUqQNmh3NFVNS1wvbzddOdfKH3ibeYgT8BsltAIe2dshPLh6OUkDpmqERX2SqfflFXo=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr18525559ejk.382.1604398528163; 
 Tue, 03 Nov 2020 02:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20201103015228.2250547-1-kuhn.chenqun@huawei.com>
In-Reply-To: <20201103015228.2250547-1-kuhn.chenqun@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2020 10:15:16 +0000
Message-ID: <CAFEAcA-P8iM1PpKajNv7R3EOtFrM6_bWg9Lo_YRY87E+D2uKZQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] fix uninitialized variable warning
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gan Qixin <ganqixin@huawei.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 at 02:07, Chen Qun <kuhn.chenqun@huawei.com> wrote:
>
> Hi all,
>   There are some variables initialized warnings reported by the compiler,
> even if the default CFLAG for the compiler parameters are uesed.
>
> This serial has added some default values or changed the assignment places for the variablies to fix them.


Hi; if you're reporting/fixing compiler errors/warnings please
can you include the compiler version that produced the error
in the commit message? This is helpful for telling us whether
it's a problem with older compilers or whether this is a new
compiler that checks for some things more carefully.

thanks
-- PMM

