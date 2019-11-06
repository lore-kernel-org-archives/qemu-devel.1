Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324A0C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F213B2067B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OVzG874q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F213B2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNmo-000821-Qw
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSNkL-0005qM-0E
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSNkJ-0006x0-JD
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:01:24 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:33977)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSNkJ-0006vx-9n
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:01:23 -0500
Received: by mail-oi1-x22a.google.com with SMTP id l202so21437387oig.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=spfvsbcLC2EwywxtjUIgs3CUc2kdgVjznJeVNZiKZxw=;
 b=OVzG874qaW3TxzPy45ZdWIP0cSfV62vHuebcctjsgc9qL5rLgRZ+uTHaV44ssm6jPp
 qSMavrd45zU+30c78ZFN6YJ9sewqIkKyGfTcSpIRETfBnb5SFoGXKZ9+7Cjt6ggHwBl3
 SFfRzYZO/Pd3fEdKJ0lHH8b6TzKeyf5EeI0D/UHFNbRhNZm6grubEku5UFtPd5FmgMqy
 y4fRLJzTAPAg4va2LQP2wth0NwPl8ohOBRMKQCUQy9p25R1SRLVd80G3F+CySd8U9IRK
 O7qBjLec7au9zpArVFdKN3rzIejXr67QKPe+KEIflGnjHGTiIsFnznxbn5KCqEgx8z0L
 dk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=spfvsbcLC2EwywxtjUIgs3CUc2kdgVjznJeVNZiKZxw=;
 b=ZUcGhKXy7OsHKjgTCPP4wCUJdXP2qMUku9+7IR3l8vKwczqOd2xerVqC/96BztJUPg
 byYXd5HUHtW+P2OUZs8OqRDDCzXTxNzQbjUZzd8wXHjciA6MWKi/y9Vfl+T5jCL4Y1b2
 BBYv0FIZPDv+uhwlPj5Li7BjGcwD0h9DkK+vIXVJQoEoMc6LgIeUJejmU5tctYo1SKFw
 NbnRwSGdmkf23yLlXDIWG2gLW87rJ+vu7qrEjhNJfu3Y+U/OUdOXRnfy0+epOgpcKpTl
 uwbF5T53kAGshg+I6q7DGSndjgsn6PRmTaIAt5QYnM10NgD4nR2pT40/f6UPXA/Z5N8J
 Bn/w==
X-Gm-Message-State: APjAAAUJACMXA11PMRKSA0in5nJ02Mx2neGQAYTT6JmIaUm4aePdRkAa
 R+Eohn03ZIDZrx2aJhQ19Mctp5/rZP95TS+ImE/87Q==
X-Google-Smtp-Source: APXvYqwY/RyfXB23UzONrar3VxVPNMG3YmcMP325Uu3TCrzt3C+f1pkZRtNrdbuzGa2FB4mx95SQSsvSY+9XcJDIeTo=
X-Received: by 2002:aca:451:: with SMTP id 78mr2940202oie.170.1573056081943;
 Wed, 06 Nov 2019 08:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20191105154332.181417-1-stefanha@redhat.com>
In-Reply-To: <20191105154332.181417-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2019 16:01:10 +0000
Message-ID: <CAFEAcA-83DrQkqjh_ztmyxGtOxYo6uLA3f7UO=Hz8bz-CzbL2A@mail.gmail.com>
Subject: Re: [PULL 00/11] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 Nov 2019 at 15:43, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-sf1' into staging (2019-11-02 17:59:03 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 9fdd7860adec188ed50d2530e9a819e8d953f9bb:
>
>   image-fuzzer: Use OSerror.strerror instead of tuple subscript (2019-11-05 16:36:11 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> Let's get the image fuzzer Python 3 changes merged in QEMU 4.2.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

