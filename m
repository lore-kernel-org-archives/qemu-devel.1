Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72282C5517A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F76622265
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l9F20NEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F76622265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6B9-0001gH-V3
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX676-0005Ps-DR
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:16:56 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:35502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX672-0008AD-TB
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:16:56 -0400
Received: by mail-ed1-x533.google.com with SMTP id w25so10243701edx.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BHvjmRW36opP6fRGjg2aSmK/k1J/rM5sk+EbpicADBQ=;
 b=l9F20NEBhBeSOCZWmCT765OzQKQxWjeLkrrGrsvLCTmrK2rPIWzIPwmnkC4b2UYkEC
 zUQZr+w+EpOK4oBlbed9OTfcZKTsJrLc4oXc8whVyBMjssMMSIZIhZn2IWoMD+Yd5raK
 BtKa7sCsDzGM5vg2ZZ81rzgc+QrevJnB2fmbAnMBE3Uui6QL8a40Vh3jhwbXKvQoXS2A
 rJQ0i1fb6mzEgLBFucJmF3Z7XeGWJBfgQua47AOz52C8rbpNcSs6AhEaPTdfspXxmqWi
 Cy7MQppf6tWp6Hcf009coFbBvaXd/WGbki1JT8R+8RXsC+R42/JIk4VDetS1mjxIYU24
 gKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BHvjmRW36opP6fRGjg2aSmK/k1J/rM5sk+EbpicADBQ=;
 b=EGDxW8xHas2OrkQiDYE7369ue4tMwo2uXOVK32raYvmkjHkhppXdWZGxy9oMMcFVWj
 JHWGtkuc0tXifIblFglQZRBE6aw+QbijvQJQvYTXU5+gV6HzZgFjKWb0ujXNgiv/zFOn
 Fpl043zMD4rH9zzxAj98dqKaMON7p+/7s0qe5iHIhRNKz73r/Zro4FksX9ujMZstO/k/
 2M4H4hnIbcFZj2paDnDEKc7mb7x/yiCtlEWsOhVo/txENAwSWcJVo7D44Rs7EuZf7b56
 josMInabwsAVX5YNdGJoQ8EmICHnDL+nFhCpNDaKjdNcQgHkeMcmovMyf2eKRagHeMGG
 Vc4g==
X-Gm-Message-State: AOAM531UASt/CQDWdA5XxheaRbGYjkLyKmCk5Hat5j2hDLMgwOOmtxKH
 vB/ofqbBXEQDjKk9TMW1k2yQG402MvVhlLHFnvzNHQ==
X-Google-Smtp-Source: ABdhPJxyiXnh6ALukPl8rzH8uiY9M7zBRzopq+Sr441n4bnhTe9ug8gNB+9ufwhYppe84DXFMO9yeSW+WVvUXldTCdw=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr16461024edq.146.1603732611257; 
 Mon, 26 Oct 2020 10:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201019091508.197-1-yuzenghui@huawei.com>
 <8afdbde3-5b5f-0237-d311-32974cf58a14@redhat.com>
In-Reply-To: <8afdbde3-5b5f-0237-d311-32974cf58a14@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 17:16:39 +0000
Message-ID: <CAFEAcA-281bGKytZEZSSYsnVBmRUzgQ8HPg=eHH+vYgR7TSqVg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] hw/arm/smmuv3: Set the restoration priority of the
 vSMMUv3 explicitly
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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
Cc: Zenghui Yu <yuzenghui@huawei.com>, wanghaibin.wang@huawei.com,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 17:03, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Zenghui,
>
> On 10/19/20 11:15 AM, Zenghui Yu wrote:
> > Ensure the vSMMUv3 will be restored before all PCIe devices so that DMA
> > translation can work properly during migration.
>
> Sorry I missed this patch. good catch!
>
> Acked-by: Eric Auger <eric.auger@redhat.com>



Applied to target-arm.next, thanks.

-- PMM

