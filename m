Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBA9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3849C2075B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lp0hR5gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3849C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBF2P-0003is-FL
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 06:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBF1u-0003JW-0v
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:21:14 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:45206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBF1q-00026Y-CR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:21:13 -0400
Received: by mail-ej1-x62b.google.com with SMTP id si26so6885347ejb.12
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 03:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NKWU+OOoiWBZuTEoC2pKTGjZu2CnQ+eY3iKC/pkfVxw=;
 b=Lp0hR5gwxkP80IiW63Z4ulV5senJkyTBuH1aA8xUHBEUIlWaxGRRV2iBb8GRLcXjsl
 0pppg6owMPDrkpnWqQpeqHp7ZzzlQRfVBFm5gk8U9NL09sNMGMHXRU1ywSzX+bys+7Hy
 yh0LvQCRKe8UkUfcf5DFNS8uZaHwL8w42aypICvAC+TAyug6etS9coIJOe6GxrFxI2OV
 ay2rvQfwTTEi5QOiJj1Feno4iyCngNd5Hqa5uaCiLOmR5SmBJA7yj8oB9+ffYVHIMdc6
 G6ZsSGkX9F1wbnc6wEDajsLbW7uzrai/F/cmtUfZYjWrDNdIVQQEeYfqzqCoDeTIj/Wv
 2uHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NKWU+OOoiWBZuTEoC2pKTGjZu2CnQ+eY3iKC/pkfVxw=;
 b=NBT+Ug1tL9LbqmGhY87ZTN8jR25g1ZUjy5MA+URGq2S9qoaXBMWFp1yuNkKZe8xebF
 fB17B2U1dqZr9Q+X65C9TKk41czKh6Hij7lslQSLlCW7p/dzFR8SjG5H+25+Z8GIoznY
 OW05P+5CgZ9CjwaD7WP0GVAzcYftSJdJVqx7hFLAqJfp2F4axrLJnnnbL3G342qnZ7iJ
 /CkM3rFZnXa0A8Y+LM4Y/RPouFkCd2Ju+XbmJeobjwBmx088AtkxKbtfm7kqiP3e64KY
 irzPaJ6wcrVWLinNQv8/Hdho8SgDoQMqyoTpZu7L4LO4LA+9P1RPqmH+Udm2UdnQ/2P7
 seGA==
X-Gm-Message-State: AOAM532HUtYsbAeoPlBmKCMZ2O3CbNMia7BnWhYXCvZ3NZYXIpx5lXtC
 1k2cqmM+FkN+HgA/DZiEZ7a0jXnUyRHLqko4BUKKmw==
X-Google-Smtp-Source: ABdhPJzGUTjMiNxv0+090avTXk6Bn9d6otwHJw6WByrNp4xcqdol4v0M97rmP/H3reF59LRUNrY7ceccPCI9rYmKfDU=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr19619000ejb.407.1598523668731; 
 Thu, 27 Aug 2020 03:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200826211345.14295-1-deller@gmx.de>
In-Reply-To: <20200826211345.14295-1-deller@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 11:20:56 +0100
Message-ID: <CAFEAcA8bGLdjfJFd0WFWozv=6_wALSO7pz-AVNAKt3dZ38_sXg@mail.gmail.com>
Subject: Re: [PULL v5 00/12] The following changes since commit
 3461487523b897d324e8d91f3fd20ed55f849544:
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Aug 2020 at 22:13, Helge Deller <deller@gmx.de> wrote:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200727' into staging (2020-07-28 18:43:48 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:hdeller/qemu-hppa.git tags/target-hppa-v3-pull-request
>
> for you to fetch changes up to 2f8cd515477edab1cbf38ecbdbfa2cac13ce1550:
>
>   hw/display/artist: Fix invalidation of lines near screen border (2020-08-26 23:04:00 +0200)
>
> ----------------------------------------------------------------
> artist out of bounds fixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

