Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDE8C31E50
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560C82084B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKNFSbJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560C82084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsM5-0005ab-KA
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38828)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsI7-0002HB-7X
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsI5-00075c-TT
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:07:22 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcsI5-00073j-EB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:07:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id f17so6759340wme.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=13AWnY4Y5z0b6FtuhcGOf9GwQM6FKI05sHlXE+6dqrs=;
 b=mKNFSbJpLK+hAiCwXNQqJbL9REURTfFc1ecAXqNamSndLX/uUxRExLH089LbN8ccSG
 jEW+84Ltf9Aemyqt6uIX8/N+6ZoklcyDjiUbhW3NH3GwmlzxX6gGQcNi38MvEeoa+CJt
 O42HIv2v9O0yDuKldgfpyznevyFUKF7OeE2pb0ZwSVT/tTnWwR/5oHtGqktY8aHViVvM
 8Gc4YTzI2yXuL2WzZgc+OaP/yyWrYZvQhi1SEQOSmhyFBd5l7U+6D/WxTbMcKKdP53q0
 x9ErJI5vQauQjIIAY7YxcQJwry2pAzBRfiHu/UZXIqXbIjX12wMCN+9o31yU/rhc6q9N
 rtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=13AWnY4Y5z0b6FtuhcGOf9GwQM6FKI05sHlXE+6dqrs=;
 b=uU/mHmakJQNbyxnJ71lQ1Xt/5hnGAi4zfcozY7icyXOsKVI0fY9ioHgpRm/oMzBL0F
 z+EQzKKT7jnVrfNqbNjXsvi5bPtbATatRHD7DkjCxcDEHvS7VNMqUzeQWGeqA9+GL7N8
 fAHN/ogCeRwHjtVTYfAk7DcOXnf+L+pY39QdEtzo0YPXrXfkscGwgvxMPOPMJkvZ/nun
 HpdEOuNPJrdiR1c05szwsCOpdn3ePg/Mam2SgwvnJuHPUv1NOkZlxhRxguNtnZLtfjEL
 84P0SMK792PDL4i5eOf1GDJ5tRlEVYERexpmKBI6PQkN7zL7DxW4/AJ0lKNQRcfewstk
 eDtQ==
X-Gm-Message-State: APjAAAU1ZDFTwJH6zinfZrawCf+GBKXzi5OiZD+mPUGw/AeHYT6rjB/R
 YYHN2iz1sMw8Zfw6+QLHzYkanA==
X-Google-Smtp-Source: APXvYqzuqYy6aJRNxET1zJdeYKd62yla/WSrN6qJefIgswbPVMm7pyecYhh127fMdTzEOy8Z6/GYFQ==
X-Received: by 2002:a1c:e718:: with SMTP id e24mr19975344wmh.104.1560780439634; 
 Mon, 17 Jun 2019 07:07:19 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s188sm12550457wmf.40.2019.06.17.07.07.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 07:07:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9EE0C1FF87;
 Mon, 17 Jun 2019 15:07:18 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-23-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190615154352.26824-23-philmd@redhat.com>
Date: Mon, 17 Jun 2019 15:07:18 +0100
Message-ID: <87wohk9ug9.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH v2 22/23] target/arm: Restrict
 semi-hosting to TCG
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Per Peter Maydell:
>
>   semihosting hooks either SVC or HLT instructions, and inside KVM
>   both of those go to EL1, ie to the guest, and can't be trapped to
>   KVM.
>
> Let check_for_semihosting() return False when not running on TCG.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8b7ce0561b..a3843a5508 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -20,7 +20,6 @@
>  #include "qemu/crc32c.h"
>  #include "qemu/qemu-print.h"
>  #include "exec/exec-all.h"
> -#include "arm_ldst.h"
>  #include <zlib.h> /* For crc32 */
>  #include "hw/semihosting/semihost.h"
>  #include "sysemu/cpus.h"
> @@ -30,6 +29,9 @@
>  #include "qapi/qapi-commands-target.h"
>  #include "qapi/error.h"
>  #include "qemu/guest-random.h"
> +#ifdef CONFIG_TCG
> +#include "arm_ldst.h"
> +#endif
>
>  #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable =
*/
>
> @@ -8270,6 +8272,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *=
cs)
>
>  static inline bool check_for_semihosting(CPUState *cs)
>  {
> +#ifdef CONFIG_TCG
>      /* Check whether this exception is a semihosting call; if so
>       * then handle it and return true; otherwise return false.
>       */
> @@ -8345,6 +8348,9 @@ static inline bool check_for_semihosting(CPUState *=
cs)
>          env->regs[0] =3D do_arm_semihosting(env);
>          return true;
>      }
> +#else
> +    return false;
> +#endif
>  }
>
>  /* Handle a CPU exception for A and R profile CPUs.


--
Alex Benn=C3=A9e

