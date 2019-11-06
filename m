Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8BAC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FF321882
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVkAO9EZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FF321882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSLV2-00081X-58
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSLU5-0007R4-N7
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:36:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSLU4-0000Xa-Ag
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:36:29 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSLU4-0000X5-50
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:36:28 -0500
Received: by mail-io1-xd41.google.com with SMTP id c11so26952890iom.10
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 05:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o+/gcmf8XPazkthWJaoh2pwFyoejLH7moNkFrL2XzrQ=;
 b=gVkAO9EZ8ez1N4klYB3WDHnRzN7UdUE3XgBKKaO2mJWsxgw8qZ0Z49M/G69ee2t2Jm
 yJfAfMMQFD07+vQ+0rLtB6+4xAoo/+1GfwsPhmHWV6QlXFoWLe5ivrGA1JewP3nVHBUv
 /SYot9bAo/ZUA2/mcOpXtGLst1Hg6UvHpt1EeKcJsFih2A+0n2hxJl7t2wKpWliPfAu4
 opLHGsBhAdwTE5rTBM4mUkpQJTikLlfI3RuNWT7C/mWgZxmsIq3x4i3QjWdCr+cBDMEv
 48MQFWRAuIF8GMNi5NikQcrMEgmNZlOFvzJ+wPH/wgVnKU3KG1vqj1Ra/UqSA8f/ABcE
 9HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o+/gcmf8XPazkthWJaoh2pwFyoejLH7moNkFrL2XzrQ=;
 b=jydg2iVxdhwFAz6DiTqQzNZ53JzXaxginCEO5HD+xticC1ZcpjSmNqt7oZbjY27gCU
 82Onzdcn06iRIGI4+uphAsdXq4pRKkYn9Ho6vpptheFOf+1T/WiNg6NZsC/q4xwgovAI
 2ae4GsNnQg2mrkHHLCOgFU6hiCPrg8e+zPz5/RDNWAQohFjo62NUHbd9n3dcchqOczNJ
 8D9eRd/syIqFfQIy8S8NV4NKs6s6lfvECnJFaxoZ29PUFu4m6/sZ87DxXGJLxBnTvNIy
 JphU8eEUIRw9a8fEQ2aRqVdqraXUFxo6pDma2UJ8gvV4IvSWkk/FzJKoGwOcOxBS1jaO
 YQOw==
X-Gm-Message-State: APjAAAXgTm3/lu6mMeDK5NYSJuK1HKEvKkCsr8BMxJ3/b08QO0hUu6oh
 tpJiGsXmdt0ad/mlWZ1BIqdHSJ4eKrjzTbBIpN4gag==
X-Google-Smtp-Source: APXvYqwrGAs2kH0bCXKlui9AR6FkAY8Inti7G3n0cwKCWq8j5919ZAgyDE7l1+q07GNHoMPw1PxePKiHv7mU58G0nvQ=
X-Received: by 2002:a5d:93d9:: with SMTP id j25mr5437652ioo.93.1573047387187; 
 Wed, 06 Nov 2019 05:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20191104173017.14324-1-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20191104173017.14324-1-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2019 13:36:15 +0000
Message-ID: <CAFEAcA-K=PEuHqryo+n=qkLzjBMH5HwL9YcAdWhhW7R7VYWrAg@mail.gmail.com>
Subject: Re: [PULL 0/2] qemu-ga patch queue for 4.2-rc0
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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

On Mon, 4 Nov 2019 at 17:30, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>
> The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-sf1' into staging (2019-11-02 17:59:03 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2019-11-04-tag
>
> for you to fetch changes up to 28d8dd355be98da6239bd5569721980c833df6a1:
>
>   qga: Add "guest-get-memory-block-info" to blacklist (2019-11-04 08:50:54 -0600)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for hard-freeze
>
> * fix handling of Chinese network device names in
>   guest-network-get-interfaces
> * add missing blacklist entries for guest-get-memory-block-info for
>   w32/non-linux builds
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

