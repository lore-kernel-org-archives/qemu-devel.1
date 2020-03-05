Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86386C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FA220637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5TToqXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FA220637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tpx-0000Lt-GE
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tek-0005Ao-PU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tei-0003iy-Hi
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:47:30 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:42342)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tei-0003hs-Be
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:47:28 -0500
Received: by mail-ot1-x32f.google.com with SMTP id 66so6322032otd.9
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2Vs3+vxqqfqra1gTsyMmNaGr82QmpEWN3Vd9kytqUXs=;
 b=u5TToqXXKskLUsnodniy4JkTrknJFeGXIEltGNvU0VcC9hVbOoiXXyEYPtEnYMqIMv
 ngSHKONckO0FzzzPUimB3amwLABpPQlNAP4F6C+3qe/8tTwVvcfFSCeh0HdeoIWduyFe
 hr+W+CAnAar4HQIiF/1940CJozorxRz9ZDA74jePBheAX6OzgX08jbvGEm/CDPszqreb
 wN4iZLcKn2Fy/FCb8ylToKm2mRLQXEgpHnNAxPYe4+4nCye4vVRJnKifLv/4GdLkT6nI
 xVXYuflg8nYdt2M8gt5Yx4Rk8Z/VQFozomoECly5oVKKhxiBL8t6STy/9+Z6BggcIERu
 qCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2Vs3+vxqqfqra1gTsyMmNaGr82QmpEWN3Vd9kytqUXs=;
 b=LfZl6X6DFhc6gCHnMBQ7znj8vCtlB5kEAe2Xq2aNshzoqu3wjL5qhysm0g4rjFakBF
 zVbs302GFnCliE7IYPi4Z1qx2rzDT1hTZFeFSwmNhvc2ijvlHN74n+PfU+Gk4MVUKh8C
 QlAIKeIsls/uPUwU+kQthy/nZTePpvlW5fSioLM4rwYUNSegSJGJb/U5ERSaS024LuUw
 MidiOOsJEeA5dsbalzXjHb3m1Yn1C69v2s1Ub01NhJOi1Q6WiCUzJTqxyJ5MA4Y7yrjb
 ATY4uEP28jyUCP6/Vj4UHwaIrZu706dX4gRCkb/U5iWQNnhpyTBgHBfbz1ufsRcC0hO3
 l0tA==
X-Gm-Message-State: ANhLgQ1FwQr8mQgYLRGCzwNStFGu1+5hjAvIAbrCtmYKzALy6BxeQHRY
 /a+yEswdM1uvSi5H3TxySWKms2o3QqE/s3OPN7b5Hg==
X-Google-Smtp-Source: ADFU+vt5DmoO22IZeE2Cufy1vUIONw97BJh5Anrm91WLf3JPgCSD/pHEQB57cHQCGnvzpJKrzn2mz3h6tFX+0C/xkvQ=
X-Received: by 2002:a9d:75ca:: with SMTP id c10mr7015148otl.97.1583426847436; 
 Thu, 05 Mar 2020 08:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20200305124346.22053-1-armbru@redhat.com>
In-Reply-To: <20200305124346.22053-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2020 16:47:16 +0000
Message-ID: <CAFEAcA9_WZ=4OuW71isc+w5EHw7_SUR9tkWjeCh4AnsTUSBsyw@mail.gmail.com>
Subject: Re: [PULL 0/4] QAPI patches for 2020-03-05
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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

On Thu, 5 Mar 2020 at 12:45, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit abfa865014ab17941eb1fcb7cc2fa293a25843c4:
>
>   Merge remote-tracking branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-20200303' into staging (2020-03-03 15:20:12 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-03-05
>
> for you to fetch changes up to 8ec0e1a4e68781f1e512af47fd6ab46ec76326e8:
>
>   qapi: Brush off some (py)lint (2020-03-05 09:24:11 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2020-03-05
>
> ----------------------------------------------------------------
> Markus Armbruster (4):
>       qapi: Inheriting from object is pointless with Python 3, drop
>       qapi: Drop conditionals for Python 2
>       qapi: Use super() now we have Python 3
>       qapi: Brush off some (py)lint


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

