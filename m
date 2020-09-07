Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56820C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 14:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A077B20714
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 14:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iru6NiHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A077B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFIBp-00044K-Lx
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 10:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFIAo-0003VN-Lo
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 10:31:11 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:39425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFIAj-0007ns-Oh
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 10:31:10 -0400
Received: by mail-ed1-x52e.google.com with SMTP id c10so12996107edk.6
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 07:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1Q6XxMCIeDTgixyndiYvcyKE8nNIba0UzlROspXeYZA=;
 b=iru6NiHFg/M6M9Pwkt43RNsACVHkSqw6n9obHZkJJiw6A2B074CnlH8vmBHaxAKv2b
 QvJGnFeoRydcpXlCuaOr0udhuRCb/PC5fFt5n7GHedFlIuWEq8MkktyXFuBvki4iKNM+
 mhbjA7KrcRgnutZmF5N84tn6Gdt4Yxr8CCVnrz6e7ax/86ar5Nn9WByNQoOMfP7DkO7s
 zv8jI+uqRfz9bzjj6NTk1rPr4+E5eqgLGqMmpE5rw9I1hE5q4MhJjQWxv9CXus+F8QjD
 Nh7ieDHFVr2Tosyy5uTb9s6vowbgKN7VS0FSN4WmawSwTy7GJS13p6dpTybI5Xaa+bnL
 4/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1Q6XxMCIeDTgixyndiYvcyKE8nNIba0UzlROspXeYZA=;
 b=d/aKCIilLZ4veCJlodulE3xDfhkUygyX6okED9M3sqrDxtgUpNGZGL7ZOCbKc187qt
 vnMPGGiXiUxcyviKtDE8XuDL6bgfreucGbhduolFiFRJnwaO0oz8TRsXRhiDAK2+knod
 /Qrp399ID4OqTZUoZmBL0ENNeVSaiK7UNPRKREXbmZf5M8Wnui2ecy3ymuYrUxgGqXg7
 Qr/mp45G5OGNg5QXlPW5b2BxoPYbq9GEYOjwBj9ueN1J2jhZerdEPQ/iM/Sa3BR1txDR
 BjxBHcJ+Sh6tOgMXuHNWcZrxnuGcwow3ksIx5sDDbxWYdfmSN2L8sdUZgKxakVC4HloJ
 +Vcw==
X-Gm-Message-State: AOAM530lmpz6O8xY0mkRiXQiHSNaSRFsfUDPZYmBv/Xn/1zm/u+lVH9S
 A70oPWb097UMOdqCZWSFCHWGrpjGuKShLUZuyNlNRQ==
X-Google-Smtp-Source: ABdhPJyNT1ywVqT+bxTidbbdk+EXygVH1S6siRA9rBGp6Bnh6BqodJjopcFjqdxwKdM396P6lNBALj6IFygoKYjofrk=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr15826021edw.251.1599489063730; 
 Mon, 07 Sep 2020 07:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200904112648.10259-1-kraxel@redhat.com>
In-Reply-To: <20200904112648.10259-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2020 15:30:52 +0100
Message-ID: <CAFEAcA-eqVtY1-vqtvTCvX_CGECK_QbG0RjqxFEDXXtxREBSxQ@mail.gmail.com>
Subject: Re: [PULL 0/2] Vga 20200904 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Sep 2020 at 12:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 67a7bfe560a1bba59efab085cb3430f45176d382:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09-03' into staging (2020-09-03 16:58:25 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20200904-pull-request
>
> for you to fetch changes up to 5fcf787582dd911df3a971718010bfca5a20e61d:
>
>   cirrus: handle wraparound in cirrus_invalidate_region (2020-09-04 10:12:56 +0200)
>
> ----------------------------------------------------------------
> vga: fixes for cirrus and virtio-gpu.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

