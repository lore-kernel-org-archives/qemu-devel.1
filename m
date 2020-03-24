Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24434C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E132020786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rB12ynGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E132020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhhF-0003Yi-15
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGhga-00030v-Hn
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGhgZ-0001Y3-G8
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:25:32 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGhgZ-0001Xu-5u
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:25:31 -0400
Received: by mail-oi1-x244.google.com with SMTP id q204so10273449oia.13
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 04:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KxKboEm9QLXd87sYdvBbq6mBT5HFQybg4oQ8APEdl7g=;
 b=rB12ynGslvEM2MJO3Yx3MpvZbsTOe2hyBYvcubx4NDayB5MH7jYYDxE89NmRAjpHJo
 CGD0Vdw9d/taBPqI9WdoaYUBMUmBgl6Av091Hmts9m+ppk+mfrUyOzS92spJHUN4qzBh
 l61e4ZDp1H0ZHi42OjHRCebPVzXTsHb571HZXfgzbKGz5BmvTtHoQvpQV9kgqo9qrHWM
 n+BGMxAAJ4XBlMQgxD+wy49WX0SDzXJaK/6qtjwNHSfLzzRMxw/BbtUxp2ulAP1ghC4q
 gHWTuazqgm6c4uYz/U/seh7m2246iyvT7OeyD3Qk5hfZmmGASCwWaW+F9KqOhmJhtO7S
 teTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KxKboEm9QLXd87sYdvBbq6mBT5HFQybg4oQ8APEdl7g=;
 b=Tlj8D4nhqYILIv2PWCXsXRwKUihD8kI6+FxQhHCX2o1noqapsDHvoLpapJOmnG4pqz
 NAJU/yph7h1E21FnqKkEySNSSrXWpIGw3xRn8X2LTWyx9mCf9/NK3168Wx5Y88k8Fguo
 km36xSzYbR0HvDdthhQYAfupbXbfbKo8oTUTfbWZyIK+1XkXGGamKqAjEFOhUSJeeJH9
 YwV5mf1TvY6+bZfn8TGMNY4QgCEb9/N7orJyZM5pZ4ZpuIDoFIfh/rKFzHO0k9rYHvCj
 SIwKa295QYef2vjE/P/jX6nFKYtOqv3WD2wvlEQ9wLjxeF8+nxbBhJPSNhBrsZHmwEaV
 09ug==
X-Gm-Message-State: ANhLgQ0EGuqPCv54AszgukUCpe2JrFz7S4tSXHqD5YuDcnvyEhZ0N0Mv
 HL+knIELg75CgJaR70TC+ipKwPs3NRENTkWOrRz8NQ==
X-Google-Smtp-Source: ADFU+vta8Ua1LPG3d3cgeIfedsJ9U5A/X4J/8OSXKr1dx20N8ZH9TrqSEOpCG6tSFM45mxvUIRgLWaOOeaQsvePS/cw=
X-Received: by 2002:a54:4614:: with SMTP id p20mr2858931oip.48.1585049130006; 
 Tue, 24 Mar 2020 04:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200324105356.7998-1-yuval.shaia.ml@gmail.com>
 <CAFEAcA_D3ykX2mJwtJhvdQg3psCX9NdcG0xq4qmP3CkqHtnY8Q@mail.gmail.com>
 <72691a5a-8992-ec54-f2de-6209cafcc426@gmail.com>
In-Reply-To: <72691a5a-8992-ec54-f2de-6209cafcc426@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 11:25:17 +0000
Message-ID: <CAFEAcA-YC7qBBt7Omakgk9-nA3EP-m3M7f2YGEt3PM4f8YFe7A@mail.gmail.com>
Subject: Re: [PATCH] hw/rdma: Lock before destroy
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 at 11:18, Marcel Apfelbaum
<marcel.apfelbaum@gmail.com> wrote:
>
> Hi Peter,Yuval
>
> On 3/24/20 1:05 PM, Peter Maydell wrote:
> > So I think we require that the user of a protected-qlist
> > ensures that there are no more users of it before it is
> > destroyed (which is fairly normal semantics), and the code
> > as it stands is correct (ie coverity false-positive).
>
> I agree is a false positive for our case.
> "rdma_protected_qlist_destroy" is called by "mad_fini" which in turn is
> called by "rdma_backend_fini"
> *after* the VM shutdown, at this point there is no active lock user.

Also, the function coverity queried was rdma_protected_gslist_destroy(),
not rdma_protected_qlist_destroy().

I notice that the gslist_destroy function does not destroy
the mutex -- is this an intentional difference ?

thanks
-- PMM

