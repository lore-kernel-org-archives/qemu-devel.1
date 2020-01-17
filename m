Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC8FC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 880552072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFeObxYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880552072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isVzT-0005bv-S5
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isVyg-00059f-Pl
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isVyd-0004xF-W3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:04:14 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46553)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isVyb-0004vB-Ua
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:04:10 -0500
Received: by mail-ot1-x342.google.com with SMTP id r9so23287517otp.13
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=7/LGar4y2gB5UPtxK9/O/StIJ6Ku0Ca+WQH9YzrOYfE=;
 b=XFeObxYVDuMJLy0PBl4DkIFXmyaP21wAogDoTZ1cJCkY7+7QZlAb996gYzG4yJK6W7
 RLbOKvPB0mURgDCgamQ05YAFHlDavV2mzjsgobKF7Ey2P6FJkkURRceVmMuXf0c3tDv5
 wy11Ff+fqIaYx/9OYElHQYGydWTqUBV/mATGbEMjvAdL90MCetajaoLQGJlc8BnJgNfO
 +LbYHuXAxt+18P2spo/URZ7Nyi8sXok+x6yB66YvQrhDz6g8PbkGkJfOX71zL4dsTnwI
 q2n6oUEmkcbAuAJheTDYhR5TQuaKPQu8onqJ3UZPCx6JWQF48jBdR4oxiAjQhrN93nIC
 gnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=7/LGar4y2gB5UPtxK9/O/StIJ6Ku0Ca+WQH9YzrOYfE=;
 b=r4/0Jqatz9BCIjlAUPGDZMMl53wLgDT9iaLZBllo/yEi5lJc5K1DCuIjxwPUb7owVz
 8u3Z0QnR8hSd5KQAYmul5xKngwIGvRnhzej4imkhP9Ho5Gufo3vdsM9tA74U48wUjB8m
 TYaZc63YHtl4CNC4JnrHN69ERYHOgtfb9J6STdFxNFzVoP8NzfGpJ+UsEz/Qqg34evus
 7KKvZ0mICVH2xEUaWBTYRCJCiCzAmj+z19kc6beZrC1zT3VmpTII1JjMN6xNoZaOrC67
 IWlaqdUigJl/CSsVTbLK84BlWeEKGfJd/sFtK0hd7hw9HNymBbrqae83pLoPH1Z/XuHY
 fHwQ==
X-Gm-Message-State: APjAAAVgfr8sMjbsUDrOvTAhx9AQ4N3duqvL+kP9r8i0H64xznWHjMUS
 ItGYwlUKmMR5HcohiOdUvarqLp3KmOkgiIutNy+Gn4YNYQM=
X-Google-Smtp-Source: APXvYqyBvARNxTTwZngVNUvOcj48CMiKZswZpxGhq7BQwdFtCQ/FzrGY3o8g87cqJoKoYhIrJz3U4vH+rPONwnLa9Gg=
X-Received: by 2002:a05:6830:1586:: with SMTP id
 i6mr6694626otr.221.1579284248834; 
 Fri, 17 Jan 2020 10:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20200117142816.15110-1-peter.maydell@linaro.org>
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 18:03:57 +0000
Message-ID: <CAFEAcA9pee6OM_FDW1JWmxuVX=Jzwhw7ZKaPVmKwOCnWF5UP0w@mail.gmail.com>
Subject: Re: [PULL 00/15] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Fri, 17 Jan 2020 at 14:28, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Latest arm queue, a mixed bag of features and bug fixes.
>
> thanks
> -- PMM
>
> The following changes since commit cbf01142b2aef0c0b4e995cecd7e79d342bbc47e:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200115' into staging (2020-01-17 12:13:17 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200117-1
>
> for you to fetch changes up to 1a1fbc6cbb34c26d43d8360c66c1d21681af14a9:
>
>   target/arm: Set ISSIs16Bit in make_issinfo (2020-01-17 14:27:16 +0000)
>
> ----------------------------------------------------------------
> Add model of the Netduino Plus 2 board
> Some allwinner-a10 code cleanup
> New test cases for cubieboard
> target/arm/arm-semi: fix SYS_OPEN to return nonzero filehandle
> i.MX: add an emulation for RNGC device
> target/arm: adjust program counter for wfi exception in AArch32
> arm/gicv3: update virtual irq state after IAR register read
> Set IL bit correctly for syndrome information for data aborts
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

