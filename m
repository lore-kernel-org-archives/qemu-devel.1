Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FE1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334AC20725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XcvakxNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334AC20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtpOU-0001hB-FW
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtpNh-0000fE-6X
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:31:45 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:44888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtpNf-0004ez-1t
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:31:44 -0400
Received: by mail-il1-x143.google.com with SMTP id h16so4492728ilj.11
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 02:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l52sAvcIm5tmQUlv8CvRIOI7WmSWL5PO4yCvHNh3kCA=;
 b=XcvakxNWDtWH0vZPrYNPYgFjLaQz8KP/UnFhbgRjDXVGrPnbgfUeL5SYuWdNpBx1nZ
 ME0xao82HEIRpTgH0moeup9k1LpWsiemiT4a20Jwhb4MYVBT+JCXoIWUjd1vtzoSq2Wp
 CENauk2bM/ZUM93DT2+UjUIRHYWCaTE1R8FwV+IlBmWNTnKz+FTdVJiYVejD0RnVptdQ
 QiGTsLetNtuOHEh0HFAZHElWZ92oMYY9cko/Ob+14V/ldc8bWacTxNKGupShayG2oCGJ
 Wn8DeB8my1GZlLyAcijnopghSdd+561XlL2ZBrLExKCc4YXcFd3je55DZxm9BqPO0aCX
 L+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l52sAvcIm5tmQUlv8CvRIOI7WmSWL5PO4yCvHNh3kCA=;
 b=DXjD4+YBwqIzZwLfjj6O/yURtgrBWkP4EPjNLG3ybgjApRWK9kTLjMUi0xSyWmTM0N
 9QHAzyeQMUa8uANZcbQhWuLNCEQ8L6CVaHOsKU0v342uJ94tpn01a/nf/UKuC5/I90Qs
 sfO6FYRHdyfrJgFHw2zaDT1cL2kbNlWHvU2nOi1qqvh0gsheYRJZJAgFCRBevEGsqI4N
 +h2Au++dpsodppkySAxcQxE9h29KzArYlIKYMixI0PwKrybBm9oqYTjjMCoPUYp7J59J
 pliCpBv4oQf5Xaa21QCm5hMy2+JSjrwEFvgkwYTFHybm8Yopn8krqRzsiAN3gSDvGHeQ
 uZeQ==
X-Gm-Message-State: AOAM532D5vEcWkg6QhuaVKPah7bEtOtEpLqrf1ZuMUqswynwPtQMLiiF
 y8NP4R+m979UV1ik4zYUGykCK7HbBcOPMR+mP8IWdQ==
X-Google-Smtp-Source: ABdhPJwL32TcCqLOhyook1hRB2weJfpTNHyp5i9pgJzYeaAFnaL0Ou0jSU8+L8tgGIeuydP7mIb+UdxK95vPzsCqSRQ=
X-Received: by 2002:a92:404e:: with SMTP id n75mr10624672ila.203.1594373501717; 
 Fri, 10 Jul 2020 02:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200708141856.15776-1-eric.auger@redhat.com>
 <20200708141856.15776-11-eric.auger@redhat.com>
In-Reply-To: <20200708141856.15776-11-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 10:31:30 +0100
Message-ID: <CAFEAcA-ZS4YQkSCLqryf+7CDD-KTCLREtu_NRi_UjEG3_KWpww@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] hw/arm/smmuv3: Support HAD and advertise
 SMMUv3.1 support
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=peter.maydell@linaro.org; helo=mail-il1-x143.google.com
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 zhangfei.gao@foxmail.com, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jul 2020 at 15:20, Eric Auger <eric.auger@redhat.com> wrote:
>
> HAD is a mandatory features with SMMUv3.1 if S1P is set, which is
> our case. Other 3.1 mandatory features come with S2P which we don't
> have.
>
> So let's support HAD and advertise SMMUv3.1 support in AIDR.
>
> HAD support allows the CD to disable hierarchical attributes, ie.
> if the HAD0/1 bit is set, the APTable field of table descriptors
> walked through TTB0/1 is ignored.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

