Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4608DC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 05:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B4920675
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 05:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTc4RygB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B4920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJt9g-0006IQ-CI
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 01:12:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hJt8f-0005Qq-MC
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 01:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hJt8e-0001iW-4E
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 01:11:09 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:46451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hJt8d-0001bm-T8
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 01:11:08 -0400
Received: by mail-yb1-xb43.google.com with SMTP id m5so825358ybk.13
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 22:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=sftgrnmdVJfqWgAt9LdjKSnkzD4I9y0JsUVs45BJ5mY=;
	b=tTc4RygBb2Ng8PkcYRwPHPDBwDIQVDBkomozIC6uHh+FFtGliyh6jMkMW0FyxtWFwH
	DQ/5W3/BwCqxpCWtlXZFUP//zCoP+7FHo6hfiDBKtxzyRZ5Zgnx8ti9yUZ76rqArqXBP
	yehcDfqguuu7/Sd+OlJ/BTWG+cNBGHGnessjubyGPCK/rOFiyoI5+XqnOAY/IkTavqm3
	tjH/LgVwC8+KxNEnv2U0ZN+J/W4bsPxjWGhGL5eXssCHET5oOxuRvqpliGW5csHu467a
	ZiO55U5UkWTD9FQbWzrZqbMUrywJH53cDscfHrEOtQWfWqnFcjJzfODExxTx2rCEjvRu
	qrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=sftgrnmdVJfqWgAt9LdjKSnkzD4I9y0JsUVs45BJ5mY=;
	b=jEwm9wiOwW7zd7TaDWp+7bDiIe/bXZznktFicFGxCCCsDreuye2DKs2tBwdRK7+4Pa
	uI8xVzIzO3JfEx8W3qU8EUareM7hRtR7zAC3TosppsZfzws7siULEqkJXPpleqCXBWOv
	0BcmFYEr+H2Mirbmw8R44KzVXyuOyBDT/hxrjSnjcZnNjhV0aRAo8qWioVI4CuvzvRMd
	YMyBgNe58p5ZvJz33kycLGF4r8yAceSVlh8g7qA8Nf/N1QiSuJQa39bLcmweIm5Kp3nV
	Y4eotzXddD2Nd18Vp0gep6OyVepaCrfGW3nq3Cu92YNVwh9I0E+XHYUPuiwzzhuzYO24
	rUbg==
X-Gm-Message-State: APjAAAVPiRFr/QTCPAZvsl/+YsXIMMFuCyQVEohsG4QLwOYpoCVoqgHg
	ZjvTjc96e7ofWMEoIJt0sf2/8oK13VhFejrUaRg=
X-Google-Smtp-Source: APXvYqyHq/XQuA1Jw/begBc6VMZHZrZU4vy+8K9DukOEjmFTohyo7/ulT5eglFqteIlLWpujun0gQP3WE1w58WH/fFM=
X-Received: by 2002:a25:14d6:: with SMTP id 205mr4904117ybu.452.1556255466286; 
	Thu, 25 Apr 2019 22:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <1556110623-655-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556110623-655-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556110623-655-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 25 Apr 2019 22:10:55 -0700
Message-ID:
 <CAMo8BfLGg7RLMR_wLhqrKz=hE-jhgUoLzUxjURwQES-s118xRA@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: Re: [Qemu-devel] [PATCH v2 1/5] linux-user: Fix support for the
 SIOCATMARK and SIOCGPGRP ioctls for eXtensa
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	qemu-devel <qemu-devel@nongnu.org>, daniel.santos@pobox.com,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426051055.RLsV_7NGHTCjfcPNqsuaiAhCL7GXukRMwGuV23so94c@z>

On Wed, Apr 24, 2019 at 5:57 AM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Fix support for the SIOCATMARK and SIOCGPGRP ioctls for eXtensa by

xtensa is the official name of this architecture, please fix the spelling
here...

> correcting corresponding macro definition.
>
> Values for TARGET_SIOCATMARK and TARGET_SIOCGPGRP are determined by
> Linux kernel. Following relevant lines are from kernel source tree:
>
> arch/ia64/include/uapi/asm/sockios.h:#define SIOCATMARK    0x8905
> arch/mips/include/uapi/asm/sockios.h:#define SIOCATMARK    _IOR('s', 7, int)
> arch/parisc/include/uapi/asm/sockios.h:#define SIOCATMARK  0x8905
> arch/sh/include/uapi/asm/sockios.h:#define SIOCATMARK      _IOR('s', 7, int)
> arch/xtensa/include/uapi/asm/sockios.h:#define SIOCATMARK  _IOR('s', 7, int)
> arch/alpha/include/uapi/asm/sockios.h:#define SIOCATMARK   _IOR('s', 7, int)
> arch/sparc/include/uapi/asm/sockios.h:#define SIOCATMARK   0x8905
> include/uapi/asm-generic/sockios.h:#define SIOCATMARK      0x8905
>
> arch/ia64/include/uapi/asm/sockios.h:#define SIOCGPGRP     0x8904
> arch/mips/include/uapi/asm/sockios.h:#define SIOCGPGRP     _IOR('s', 9, pid_t)
> arch/parisc/include/uapi/asm/sockios.h:#define SIOCGPGRP   0x8904
> arch/sh/include/uapi/asm/sockios.h:#define SIOCGPGRP       _IOR('s', 9, pid_t)
> arch/xtensa/include/uapi/asm/sockios.h:#define SIOCGPGRP   _IOR('s', 9, pid_t)
> arch/alpha/include/uapi/asm/sockios.h:#define SIOCGPGRP    _IOR('s', 9, pid_t)
> arch/sparc/include/uapi/asm/sockios.h:#define SIOCGPGRP    0x8904
> include/uapi/asm-generic/sockios.h:#define SIOCGPGRP       0x8904
>
> It is visible that eXtensa should have the same definitions as

...here, and in the subject line.

> alpha, mips and sh4 already do. This patch brings that to the
> accurate state.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/syscall_defs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

