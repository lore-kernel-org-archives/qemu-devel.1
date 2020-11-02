Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F73C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 12:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D4B22226
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 12:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQFfAZrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D4B22226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZYZ5-0008Jh-KV
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 07:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZYY0-0007JZ-Id
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 07:02:52 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:43350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZYXy-0004yn-0K
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 07:02:52 -0500
Received: by mail-ed1-x543.google.com with SMTP id b9so3881197edu.10
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 04:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZUh6tw4vkKcL1e3Q2RpJx9ksZT0Egtkx4AiT6xT1qZ0=;
 b=BQFfAZrmD4AskGyzVxj7jaqz2k69u3f3cn9YLbudVWq/tyotbCbk0TO456nK7feG1v
 hwqCAno6QSRuspiPSjRggIfjX31FHS9iTgiON+1ofGi9axHWt31Rd84Ui448mR/T9hNH
 R0civsIjmxfCCkwt8j9epdHBLqGlDUkRI3hNDpbuKqmm5SxFHBhmsmhCg8N0xM+KQDl7
 UZ8eyQx6BMzvMWtOxUCYaDrgWxSABChHvw2yditiObvK7Wb+PxFfDwOOmEhuDuHub0b9
 ZhNd+SrGZC3RzKaBC+8AUN7ktvP3hYmTMEKe1+mp+9vjuGqynGTNds9DHVSKCriF2mBE
 xavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZUh6tw4vkKcL1e3Q2RpJx9ksZT0Egtkx4AiT6xT1qZ0=;
 b=iY6uj6I07LlnjsUgEDYYubFs67XBEwx8W0HFZpfg1XR3yvBV4DmBPAtv3xXp+i91br
 cOifgRBmi4DvYsBWCe6Qa92w6odvEoWiUma8M4LSNcOsVS/DMr3WwHldjOgCiPgPERWF
 Ud+gMd7uHW3Hh+/O0FJgYg8eMPz/k/hAIXI2kptGz0LfkSztK6oIEIhhDJ4Q3D1ht8CT
 xKCXdl+botGW/3w+X28hYaFw+eOG8dPOrivBIrxUpHKbc6x8PhXy3hPpaRneZsiT+8yM
 uK1+JYFyLtK5tqRDq4wZxA2Ns0MVhHwXoyFf/ESSclJiwoesy9M7bi0LhyxhKlUAFfbd
 K/HA==
X-Gm-Message-State: AOAM531An30oIzEUE+iEl9yM2RtYPjWgkBYHB4nPqmrx1D7gJvj9o5m/
 T8Pq8iMkVkYQcAFcRa0M9ePM31t+GcqvSnIHSSsmqA==
X-Google-Smtp-Source: ABdhPJzFM3aEZMXODS8ONMHeL+pV/twCgPam3FFX59LXpPZO6zJUuiR29UafYqmZ8vMjGhCRoFE+un6nXd6c3AFRSvY=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr15794824edq.146.1604318568546; 
 Mon, 02 Nov 2020 04:02:48 -0800 (PST)
MIME-Version: 1.0
References: <5F9F8D88.9030102@huawei.com>
 <b2945df0-186e-e670-bdfc-34104d8ddf2c@redhat.com>
 <5F9FDBBD.4020607@huawei.com>
In-Reply-To: <5F9FDBBD.4020607@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 12:02:37 +0000
Message-ID: <CAFEAcA8Ra9ZMxrJy4UY2C7V71jASweZ45kAfkuUr0fC3AdTNeg@mail.gmail.com>
Subject: Re: [PATCH V3] hw/display/exynos4210_fimd: Fix potential NULL pointer
 dereference
To: AlexChen <alex.chen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 10:13, AlexChen <alex.chen@huawei.com> wrote:
>
> In exynos4210_fimd_update(), the pointer 's' is dereferenced before
> checking it is valid, which may lead to NULL pointer dereference.
> So move the assignment to global_width after checking 's' is valid.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Alex Chen <alex.chen@huawei.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/display/exynos4210_fimd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM

