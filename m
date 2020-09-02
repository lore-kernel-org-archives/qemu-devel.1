Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB41DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9265220773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mOV9C22P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9265220773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDTjJ-0000VX-OY
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDTik-0008Ve-Fw
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:26:42 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:44486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDTii-0001PH-Hz
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:26:42 -0400
Received: by mail-ej1-x644.google.com with SMTP id a15so4268053ejf.11
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MftKUPPqtjnNBL6LEpTPl94GshXucKux/uZIoDp6OXM=;
 b=mOV9C22PMhB/iG0CO1ridurc89H9Osc77qhpnLH3JnZgFag7e1NCE7zRSeMR2g6ZHj
 76bBOb/4ivXEwB50Bd87v/xMy8KhHlbUVrvjQtvoVuUVKzC1dnegKESQ8OT5giB6jnT7
 L5HO4PLfUH1eo5uEIJWmwsoXxd3Qwh+1xZrMEXjMfxixopDBTSoidlOGsSOnDohw46TO
 CJixv9DTCbgu/r7nhSIpsYE+jlvgzYJaci+0PfrG3KB1YGQPAw2R2LZ/Uddp9mxMLrgf
 Dh9fW2z982/fPUon9Zq3JRLFu4YJKRCW5fuOtR7iHhUaGpJP8CK8haw8CgOfOHpkx9HH
 JLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MftKUPPqtjnNBL6LEpTPl94GshXucKux/uZIoDp6OXM=;
 b=qUuEvrVlb6c71w+hG5cwmF+BRnHsqytXtADYfK5OQYXlAojccQDHO8W8584VyI5oWF
 rNKibzdjl+NRNN3/ppo775VheAPlMQdZO8JD/0rRrq2yU3RopM9+JUidknFD9tCTchFr
 7cq76HvAMtWJTbd9UdoN45xsrd7BJG5bJJ88/b/uvUacWGVvs2QGbYfN1cWZQO6Oa2dy
 ThMC/QzM2CPo8EhGYJiD95JUt8VFLb/cWwbLIkDWKwWY2OgegMXUmedECErpX35ErsLx
 7OqqI7cneEs3UKMqeaZEp6yi2ed6cFMSc0/glAaTpokHApB33Qi2upTyuYguswrWpYiF
 oyrQ==
X-Gm-Message-State: AOAM530JaJEmbu55NxQlhMZAn1S1GdgEizWZjWHgPl+15znQU3nFtN1W
 6mYqvQTD8PBUWz96no6ki7mmliqY5tPSPTMqjZQUyQ==
X-Google-Smtp-Source: ABdhPJzrvEPPbEnJ1jWy9S4UZioSbY6ZMABXBMn82Gf4vGHi7QBn9YFMGjxHmBeQ2I+0ABDihLM7BhFnP8B9a3yFtTQ=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr271308ejr.482.1599056798636; 
 Wed, 02 Sep 2020 07:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200901152054.922595-1-richard.henderson@linaro.org>
In-Reply-To: <20200901152054.922595-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Sep 2020 15:26:25 +0100
Message-ID: <CAFEAcA9XA8vEStsiHT1Niyx+uT2eQLwSt6mS6g9n+non2fwucQ@mail.gmail.com>
Subject: Re: [PULL v2 00/76] target/microblaze improvements
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 1 Sep 2020 at 16:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Version 2.  Serves me right for not testing 32-bit host
> when I knew there was a patch that mattered.
>
>
> r~
>
> The following changes since commit 2f4c51c0f384d7888a04b4815861e6d5fd244d75:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200831-pull-request' into staging (2020-08-31 19:39:13 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-mb-20200901
>
> for you to fetch changes up to 19f27b6c2493472fe2790cf08d7b0140d57bdad5:
>
>   target/microblaze: Reduce linux-user address space to 32-bit (2020-09-01 07:43:35 -0700)
>
> ----------------------------------------------------------------
> Convert microblaze to generic translator loop
> Convert microblaze to decodetree
> Fix mb_cpu_transaction_failed
> Other misc cleanups
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

