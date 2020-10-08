Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D57C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E2521789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k74rKnBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E2521789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQXAJ-0004cq-6t
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQX9M-0004Bx-PA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:44:08 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:43393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQX9K-0008Ps-F5
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:44:08 -0400
Received: by mail-ej1-x643.google.com with SMTP id md26so8463851ejb.10
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9HCJItZffsmaghw9lXUa1Ky63aXUcsE4dy13sbC6QRc=;
 b=k74rKnBfJJD8k8v+xmcrjYctkEQiDFvq+ncZjD2NGd9/BOy7HI5X9vMtY6ZpHsOhjI
 lOqaXkctWpt/igW7rpSDSYenyLDArX9/JvhM0/muh61OtRwD2dq0oELYfI7M1iaSjsYY
 oLvt9STHNkn3BMt5VMtNKdMM7/fWmbLcVbdgWcmZT6TelmwrnuZoKNGUPBaBVYEIWJB8
 18YzJbyAh9l4BwnjJr+xlFBjN8vhsJRTznWG9w2zkxvPlaYyM03YqSmD/OrwfRPsd8zk
 4WHrqg8c8wu1+w5sum/Lc7DZxMpwG+aEjA7F/J/83wPcLzw2quyULljEfaNLf/KXSq+n
 M1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9HCJItZffsmaghw9lXUa1Ky63aXUcsE4dy13sbC6QRc=;
 b=sByeZo8WbeqZ5yVGvVJ/rJQwa/tWHDiqS9Vd8/814LZjGln1d71pGFx467G2pVcPhC
 7sSJW4413JiY42hM8N8eYS+Wr6ZYRRlizteAX/1a0rdPId7QntU8lIohwG/Ha0UVT6KC
 DiOie1OzMvAESSaDeJwwt8fVfHMWEtOGifQEKWE+JITTg7fuzQb1msrYQirMPU9PeQUZ
 utTXwgj581Mwyu0GNlbCHVXEtcCCgu+l55wDyjEAhzfvrCsziEsGSLZSAXiJP28FPS2c
 twoSe4TiS0znZnWNndaHBc2S78/hiG3avgWaAJ4yit/Py1qe+1fmoti957QN/tf7WscG
 TPdg==
X-Gm-Message-State: AOAM533i5rAl+/f80gD9ixynUgR/9pAedyV/5+oJ5DQlHVoMfLlc01eK
 cVILmKdIDrDIB5v6gs0DvSHJkLx0FoQ+HzrHseQz+g==
X-Google-Smtp-Source: ABdhPJyA0v1AHJGr+bso0zObvz1sNR6MmTBy38yQOQZPsvr9q99B7IifB9/sZ7/j67EnFs9SWCrY6qKitEd9de+ATpM=
X-Received: by 2002:a17:906:ce21:: with SMTP id
 sd1mr9363004ejb.4.1602168244274; 
 Thu, 08 Oct 2020 07:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201008143951.820084-1-marcandre.lureau@redhat.com>
In-Reply-To: <20201008143951.820084-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 15:43:53 +0100
Message-ID: <CAFEAcA9hzbqmxmqLk_7nuBDUfLhXuKWsfeYFbzs1TM36SR8Upg@mail.gmail.com>
Subject: Re: [PATCH] mingw: fix error __USE_MINGW_ANSI_STDIO redefined
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 8 Oct 2020 at 15:41, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Always put osdep.h first.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  migration/dirtyrate.c | 3 ++-
>  tests/test-bitmap.c   | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 68577ef250..47f761e67a 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -10,8 +10,9 @@
>   * See the COPYING file in the top-level directory.
>   */
>
> -#include <zlib.h>
>  #include "qemu/osdep.h"
> +
> +#include <zlib.h>
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "qemu/config-file.h"
> diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
> index 2f5b71458a..0a5775fb37 100644
> --- a/tests/test-bitmap.c
> +++ b/tests/test-bitmap.c
> @@ -8,8 +8,9 @@
>   * Author: Peter Xu <peterx@redhat.com>
>   */
>
> -#include <stdlib.h>
>  #include "qemu/osdep.h"
> +
> +#include <stdlib.h>
>  #include "qemu/bitmap.h"

osdep.h includes stdlib for you, so you can just delete
this #include line entirely.

thanks
-- PMM

