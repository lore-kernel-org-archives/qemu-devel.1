Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC6AC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397C3218A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fn9nW2gj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397C3218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4Vl-00061u-H0
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46294)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4Ti-0004Fm-C0
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4Tg-0002RE-LD
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:20:58 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj4Tg-0002Qd-GI
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:20:56 -0400
Received: by mail-oi1-x242.google.com with SMTP id w196so5267937oie.7
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=BwhG8KcrMXQjto6vQ6OI3DjRwTyFjLxyzB45zGSdUNA=;
 b=fn9nW2gjxe2cY68rjztEf+Sx0MxX5Od+cKiaEz/YKN27MAWc8Ukdlh6DbG+GS+zLgm
 zB9CmvF41WLSjvOybQ0uIiiuWsh9VTVrkrOmEUY52O9XY0HjRRPRDid895kgCkQQNDY6
 krjrOzJak60UxH6cnp/I13y0fbY0lJ0EoxinJSWVzpYsR2AknSvy/vm/uVeE6sDIp7JE
 h/D2mvlAG+EwR1jMez4Sos7RqsCUUjo2MEgOWUVNIfuHkkLXT047gqDKeNA9XgeFe31o
 61Bky0hMQFb3AZdkjqAwfHSO/d7n6JgEbN+PEACJVBl+Cctt5tw+3C6H82UlScagkdD+
 2mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=BwhG8KcrMXQjto6vQ6OI3DjRwTyFjLxyzB45zGSdUNA=;
 b=W6xBQxioEoIUZHvFth40QyZPsWzgsGqDBjElG2qaD6HBj1IXydGTl0gZGq1onZR4gP
 yAxCBTLhhxXtPUlMbmSk0NIQ16zFEhL/aIUYsaBrvvecJkEw8r/by9g1yAXc1hBL4oO9
 lBOpHM0XZkUBalwM/gAztNEUn3xcR+y8NaIwRn6+xVU74EYYllRTLDfef98NXAFTstDS
 dh/u0JY2sHZQK2pCXo8PV6d7mZ/juuFXvAZZthPf5pHuKffU3tR1/B6mx6uHhDI/rJz1
 y8kcpYoZYrBxuq8UIvn3hMKUOHBv10nFsh5omlp5YRbI44KNHu5AM/15AVjYMN/U0Zbn
 36oA==
X-Gm-Message-State: APjAAAUxnKMi83MAYfxCnX77yQBd+tTCciVB8ZBWEjtcU4R4U+vAEiXc
 xaGmoL1BIXXg2vHywl5VD1BEV2j6qFbLCXVuB8eIiffBDTA=
X-Google-Smtp-Source: APXvYqwW5Tb3QfFzC+xyAqbfkDg7kg40s3UmpO9j9cmYKYneE1KhFextptZewnHd8LKeOx0u9bjZGzK8qA1M6GFg2Vs=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr226853oie.48.1562257254740;
 Thu, 04 Jul 2019 09:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190704160802.12419-1-peter.maydell@linaro.org>
In-Reply-To: <20190704160802.12419-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 17:20:44 +0100
Message-ID: <CAFEAcA9jg78fK07i13Cicqm+g5vfw5VX2LsSO-jQu97Uavggzw@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL 0/9] target-arm queue
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

On Thu, 4 Jul 2019 at 17:08, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> A last collection of patches to squeeze in before rc0.
> The patches from me are all bugfixes. Philippe's are just
> code-movement, but I wanted to get these into 4.1 because
> that kind of patch is so painful to have to rebase.
> (The diffstat is huge but it's just code moving from file to file.)
>
> thanks
> -- PMM
>
> The following changes since commit 234e256511e588680300600ce087c5185d68cf2a:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-build-2019-07-02-v2' into staging (2019-07-04 15:58:46 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190704
>
> for you to fetch changes up to b75f3735802b5b33f10e4bfe374d4b17bb86d29a:
>
>   target/arm: Correct VMOV_imm_dp handling of short vectors (2019-07-04 16:52:05 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * more code-movement to separate TCG-only functions into their own files
>  * Correct VMOV_imm_dp handling of short vectors
>  * Execute Thumb instructions when their condbits are 0xf
>  * armv7m_systick: Forbid non-privileged accesses
>  * Use _ra versions of cpu_stl_data() in v7M helpers
>  * v8M: Check state of exception being returned from
>  * v8M: Forcibly clear negative-priority exceptions on deactivate
>

Oops, this crossed in the post with the qapi header reorg, and
the move to m_profile.c doesn't build from clean (incremental
was fine because the old header was still lying around in the
build tree). v2 coming up shortly.

-- PMM

