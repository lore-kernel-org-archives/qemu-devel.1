Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B11C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 18:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9052067B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 18:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvXrm4D+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9052067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKRhb-0003Tp-V9
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 14:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iKRgQ-0002JB-Nf
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 14:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iKRgO-0000Q0-VF
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 14:36:34 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iKRgO-0000PC-8F
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 14:36:32 -0400
Received: by mail-oi1-x244.google.com with SMTP id k9so17738063oib.7
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=prRMgPowVaK5DwgNLNHoLH3NYPRz+y4gGlPpqYO28Ro=;
 b=xvXrm4D+KtjrOrbgeW+Y8ELNUGWdj3kyeD1qicz/iajJYJ7mFfYLFn+BoZSYrxOYy9
 xf2zKVPCInpXOjEGl9DD3qypDTUbguHMZdM8fNuX0j+K8EQaBwU1jwi7BhxUAWqtD3IR
 cnyxHvS/pTV4mlWtxjxGYAUz+qUIoxvnAaMSCYYaQlhO3EVzzrrIb/9BOC/Z89EAqkSy
 nXuw5Y2IoLa6Lf6ZyB0rSe8ZPCPqK/agTJ8t5C/NdzxqTHlAXe/l1+hAS3UlAFXoeYHv
 vnkO1jhOVb7NAAWSwPjEXdYg2Vd22WghbFi/Syq1H+PgwtnR5G2gJ71ZjIgJstbwI8XJ
 JmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=prRMgPowVaK5DwgNLNHoLH3NYPRz+y4gGlPpqYO28Ro=;
 b=g8Tbj+vK4E8RSyRSnZpP7H6tdI2Bg5SpDAjWYdqNP50pKq0Vh3768D+N9O9HmPRk/5
 LrZIzeeR0xOR8Mixllv5A9SpN7Cq6osVa8hJ4pL8ooYXcne/9rLDDC0aCVrr4dqxTH+q
 0SVmAXf2d7UYj5rwMF70oB+KpnBTGZfzvKcMB2mc9x3z4of8X5+X9qxKK1TbzbBGGd+7
 bwzOD+GxxQcpLk2R75OxZKZ8s2I3AnPDu/HhImpAltCb0zR3F809cQJPiFi1dTD2ov4I
 yc1dFo1t+LP3e2RHOP+i2uJ55eTWCKVTrjsvk5QxRNh7C4Lvj+i915l9dizS+pXwWd3l
 Iutw==
X-Gm-Message-State: APjAAAU9T3FQ9KDymUe1Ltd5mmMzPG2Sa2iwZy3KV6ow1iwMniaXdrDo
 hWYLELYEwBu3Q7fv6tH8zoI4pFPY2U2bkTA4dnaqtoU54zg=
X-Google-Smtp-Source: APXvYqw2X89gVn9Xm6NJGBc78TFywv4dD9my1eK+Rly+qkOTqPzAWtMWMa0r3EpdHr/MvrK9j0DYtj9yBwk+ceTUl7M=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr28608406oik.146.1571164589875; 
 Tue, 15 Oct 2019 11:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191015171537.12499-1-peter.maydell@linaro.org>
In-Reply-To: <20191015171537.12499-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2019 19:36:18 +0100
Message-ID: <CAFEAcA-U5t12YcX+wU9GzJmz+f_bUtHABHqf-JpnQBkiK2kvBg@mail.gmail.com>
Subject: Re: [PULL v2 00/67] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Tue, 15 Oct 2019 at 18:15, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> v1->v2 changes: dropped the patch adding the new ast2600
> board, as it doesn't pass "make check" on 32-bit hosts or
> low-memory hosts.
>
> thanks
> -- PMM
>
> The following changes since commit 3af78db68176a049e2570822f64604e0692c1447:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-10-15 13:25:05 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191015
>
> for you to fetch changes up to 19845504da1bdee4be7d0fba33da5be9efa4c11b:
>
>   hw/misc/bcm2835_mbox: Add trace events (2019-10-15 18:09:05 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Add Aspeed AST2600 SoC support (but no new board model yet)
>  * aspeed/wdt: Check correct register for clock source
>  * bcm2835: code cleanups, better logging, trace events
>  * implement v2.0 of the Arm semihosting specification
>  * provide new 'transaction-based' ptimer API and use it
>    for the Arm devices that use ptimers
>  * ARM: KVM: support more than 256 CPUs
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

