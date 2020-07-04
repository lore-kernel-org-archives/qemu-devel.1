Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF79AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 17:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5FB2070B
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 17:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVpUfN3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5FB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrmEQ-00049v-1U
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 13:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrmD0-0003eP-Bv
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 13:44:14 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrmCy-0001bD-ET
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 13:44:14 -0400
Received: by mail-ot1-x344.google.com with SMTP id d4so28799996otk.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=2J4MWY4ilWZ4kITdCWvnsk/ufO3VnRC1q24yjm+BDl4=;
 b=BVpUfN3Yq325cFLYSrxXI/PbV8gMb1/GrKoysKrQRNVwLQ1jb8PeIvk1VhvYoDg7tK
 /+kBNN0v6reyzv94Jj8TP1/+JR1W1XwyII3NWGTbEtqifzX+MQdXCcjZjv+OCeehbCcd
 Au1hWjTQ2bLxHX54Xg4AO5jjeusrPWD/vQvhGY8BBc7lB8kIwl9MGm8F49ZB3a1tEeGX
 yOfFXaGpzc0VnTvLiP0Wuu3QrG0F7vCkXZiMv94ums9b9Y/i/WrfYCjICCXTKx0rjf5b
 PdUbr1oA7lvksHEWk4LzduGw61pMGR1qWmoNOfe3IRcze7YSdCF7bTqsGZjEYDn7Fn2o
 dWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=2J4MWY4ilWZ4kITdCWvnsk/ufO3VnRC1q24yjm+BDl4=;
 b=kD9s/IVgVD+frGyFDKNHmzxakPlfFIQkbuKCEooguGokawaHeEL1ONbaQRMV7e97gX
 htYSHjRj1tg31vggrndYb760WTW/uufSny22OEKhB6YdQzLlb9jNNDGQ1eRCJ+7wigY6
 v2Y/6SOWohb9BPIdEf/+P8lOIQimz4f96cH6mXAYbUP+P+EPEM8o6zIrKLo48fyGHsyd
 G49d/EOQ9z8tJmTdrEGQpBigr1ZM3igNXWCizI3CimMzjbgxF0KvmxcnuNd2jeNjnKto
 zuUUsjGnbD+fUuZhVrymFTAC1zI8NWX3VbRE+nsjGA/h7T182n6vIwWhXRC/vsS+YTxt
 /H8g==
X-Gm-Message-State: AOAM532bloD/WeSbtt4Om+VswWhFLayMlah8WnuhTpyWbJIej2SR/REE
 69Ozc+bow31BF/RZho5G6y+6TpuXnYzo0k1rXzvhTbiaj6k=
X-Google-Smtp-Source: ABdhPJxS820Q/zxPme7oOayVU3yE2/CJ5ES5n/6wpVcqV4E6l2nZvCljqKd1j1n+GG3w/wzSUgOXJroTRBpDlZwhcSo=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr32833792ota.91.1593884650898; 
 Sat, 04 Jul 2020 10:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200703165405.17672-1-peter.maydell@linaro.org>
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Jul 2020 18:43:59 +0100
Message-ID: <CAFEAcA_+T9Ggd8HTb7XrxTW7Lw4KBKuHDwUqdWA3KT8hbmoUKw@mail.gmail.com>
Subject: Re: [PULL 00/34] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 17:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> I might squeeze in another pullreq before softfreeze, but the
> queue was already big enough that I wanted to send this lot out now.
>
> -- PMM
>
> The following changes since commit 4abf70a661a5df3886ac9d7c19c3617fa92b922a:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-06-24' into staging (2020-07-03 15:34:45 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200703
>
> for you to fetch changes up to 0f10bf84a9d489259a5b11c6aa1b05c1175b76ea:
>
>   Deprecate TileGX port (2020-07-03 16:59:46 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * i.MX6UL EVK board: put PHYs in the correct places
>  * hw/arm/virt: Let the virtio-iommu bypass MSIs
>  * target/arm: kvm: Handle DABT with no valid ISS
>  * hw/arm/virt-acpi-build: Only expose flash on older machine types
>  * target/arm: Fix temp double-free in sve ldr/str
>  * hw/display/bcm2835_fb.c: Initialize all fields of struct
>  * hw/arm/spitz: Code cleanup to fix Coverity-detected memory leak
>  * Deprecate TileGX port


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

