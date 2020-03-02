Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE16DC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF72217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvyR82LY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF72217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8khe-00036m-QD
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 08:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8kgH-000218-V9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8kgG-0000Em-KP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:00:21 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8kgG-0000Ei-EG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:00:20 -0500
Received: by mail-oi1-x242.google.com with SMTP id g6so8456232oiy.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 05:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xby5q01aLjHzvujUl/skvG3fkUFiPGKQcXWLdOtmXJY=;
 b=YvyR82LYdiePfLGTczPdlG1fLmn3MAUpZXg0kVjq4AeBVux57mGJV4e/Ts6fgJZXWY
 px6LseBsTt/75iK0skAiIyq5Pq/r/giRADd99q4n3Xw4RdbpABmglz7dhF0MwFWya85a
 BYTFp7acD6Bx6hnvjZoTPjB98F7DD1nv7p5ceKBC7Zgtx3e4rmc56U6JL3p7zJJjhwaZ
 qEJWY+v798sqo38oPuF+b2qXcfxJOE0ersgVPOVxB1YeZuw+rjKxE7/FMz3Onl0AJm4N
 0ZenLyGFItZpQtgnq859ltaTYODwpWLJE/XMVWmlvIZmAfgwNx9mKm2QII+b0e6YbTQg
 zemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xby5q01aLjHzvujUl/skvG3fkUFiPGKQcXWLdOtmXJY=;
 b=udrLOZzWfM+GPoz4LhqTpf1DitcHQ1bWClaUohQD76dDA2stMTCGiXU+FhElf99LPn
 uArTnCQ1drx1gtK4s8MX9rYaqrM86rPYdmDatRnv/u47waMs/AdRKiav0Sfrrs6GEDYz
 yJMO6MiT6fNg59sdj6XSBNdQ4myNvidm9qDgbdq9mTyazT4wxDj3rRI2QtydjBzzGC2F
 7LyhE1+rw6yub93K2BQde2SIepMigVP4svkoaySVKMg0mgNuMTEP2uODUuMDgIqrvNv+
 PcY1zZppYsH6HxPYcHfOmhBMO5WDbSCZrxFtvwKPmrpPJvrAZO1hmA5IwHzJCBFhJu1v
 Mseg==
X-Gm-Message-State: APjAAAUorly8hpSeTprFVs/tBnGWCPLuGzQWeGF07+WSoGTYmfVhoC9B
 3oKfL0jp0HeJzT7Nl3bZBgx2N8EdXtm4Fi1xwXYosw==
X-Google-Smtp-Source: APXvYqzMs/U1HArR5TFrm2hQ2pt7ZborUdssDPX9Jcjodr7OBrtvVhqG+pIKeiWoFtm5vgTkiSSlRcve1wUxn51uAQI=
X-Received: by 2002:aca:b2c5:: with SMTP id
 b188mr11565585oif.163.1583154019338; 
 Mon, 02 Mar 2020 05:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20200229024347.22826-1-richard.henderson@linaro.org>
In-Reply-To: <20200229024347.22826-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 13:00:08 +0000
Message-ID: <CAFEAcA-V1gjaq37P5secqnBe9_gH3na8CQU7WJ8NsNG+HX_b0w@mail.gmail.com>
Subject: Re: [PULL 0/8] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Sat, 29 Feb 2020 at 02:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit e0175b71638cf4398903c0d25f93fe62e0606389:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200228' into staging (2020-02-28 16:39:27 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20200228
>
> for you to fetch changes up to 600e17b261555c56a048781b8dd5ba3985650013:
>
>   accel/tcg: increase default code gen buffer size for 64 bit (2020-02-28 17:43:31 -0800)
>
> ----------------------------------------------------------------
> Fix race in cpu_exec_step_atomic.
> Work around compile failure with -fno-inine.
> Expand tcg/arm epilogue inline.
> Adjustments to the default code gen buffer size.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

