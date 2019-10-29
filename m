Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E254CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 18:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C6720874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 18:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpPYRdad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C6720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPWYL-00032k-0j
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 14:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPWVr-0001Sr-2c
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 14:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPWVo-00033g-RL
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 14:46:38 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44591)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPWVm-000328-QP
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 14:46:34 -0400
Received: by mail-ot1-x342.google.com with SMTP id n48so10666402ota.11
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qVT5slnw8IxU9mEhwtMZ1D8gxQUWTVD0toLJ8lomVh4=;
 b=TpPYRdadueduLqP8dOU8pJgckXDdbkf3NM/2VWpGS3gvUvgEAJ1nbdagFwx8Z8nly4
 iQGsODxhhVh5k664uTWJzBSMT0FBAk2cOfdDkyXWw1YcikMSbp20c3QUsB+FqAwOWtFu
 fjJXOarTR9KeuaseCku22Dfeov8o/YrMJ+C6CPHlAwTe0Uy65YnlK64f+xheZ3ELsG5u
 DhCOUANdXOv17rrAPNpnVq3myPKUqpF8n/VQeM/QhmQWYBmvsqTWexgoz/73QeP+HRGe
 zppJLoMWiR9dK8t+gdS/IRbGSV7rl4z80oFFgGClvZSZYp64ofn9LY4o8GAlwBUfT+i2
 XwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qVT5slnw8IxU9mEhwtMZ1D8gxQUWTVD0toLJ8lomVh4=;
 b=RErFbdAuF5DVflHPfo3aSQEKCzdN/KP7L0cxm6bgeGGyMqsp10D4efx2LBYZPZik/F
 Kihy7+VwSnDmqyEHJ0lUcHo6eiGAeXVHp9e3FbOsjbjdEp0wiHm6M60xUEUw0yetCm0j
 vaLf5PxOjsFPWF2CwoOXCtLspAvmj2iXkiUtICFUnWlC+2da1Ym8S7Bl6bzvvh88HiYd
 Vukfrz/IW+Ba+22zi1INePgoBlv744kTQvOdId8vuCV8JKTZ36EW4Jetw4JhGTo1S7X6
 EUOdcfI+7DwnAfXoBAe9lDqzrKPqwXjc7tNvGmzIraUNbt0i63N/dq3EUWORLRRJy+qO
 iPRg==
X-Gm-Message-State: APjAAAVbBWBFQoE3sKwXLK47hQ6n53k+DyUTyecVKZYghMJw8lqQPRJ9
 L16mVJ17O8zyVuXOAzfS89bK5wMS4LNpbIIl1+QIOnHuzHGtvg==
X-Google-Smtp-Source: APXvYqyHg8KnLcp+VSEqGpzFBFYCZhQXt3U/d0dt+luVV+RnnmzZuUgBUrxDSj82W1QzV0UDrvLnBVU12XALgTJgP+Q=
X-Received: by 2002:a9d:7385:: with SMTP id j5mr9399583otk.135.1572374793629; 
 Tue, 29 Oct 2019 11:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191028194000.29827-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20191028194000.29827-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2019 18:46:35 +0000
Message-ID: <CAFEAcA_qKf2=nQZaVwJXNP8D5GeKUNvBzTwxHyLa87dkqWzqcw@mail.gmail.com>
Subject: Re: [PULL 0/1] qemu-openbios queue 20191028
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Oct 2019 at 19:42, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> [This contains a last-minute bugfix for qemu-system-sparc which fixes the keyboard
> in OpenBIOS when booting in graphics mode.]
>
> The following changes since commit 9bb73502321d46f4d320fa17aa38201445783fc4:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-10-28 13:32:40 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/mcayland/qemu.git tags/qemu-openbios-20191028
>
> for you to fetch changes up to 9505edece7b7a331ae4bf009d7cf9dc206ddb2d3:
>
>   Update OpenBIOS images to 7e5b89e4 built from submodule. (2019-10-28 17:11:50 +0000)
>
> ----------------------------------------------------------------
> qemu-openbios queue


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

