Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A46C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C832084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C832084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45416 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWR6-0005Rw-54
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:56:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWP3-0003pz-Cn
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWP2-0007NG-Ek
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:53:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWP2-0007Mx-5y
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:53:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so5935036wmi.0
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=GhnvdPW8Kyb3+ZbpoR5J5xfFLEXwWw09MX0axWHfGao=;
	b=FBjznVeucus6RgkEb53xJ3u5Cq31+VFcRlL9GQR9JMe1qr0ZSVTdbrE+SxjgApwu14
	FjRCMc2zehD3Tt0SqRekY9zL6OiBqbSZ3UXT9XG2s30L/sfHtQOqQ+5of+Dd9aH0z+ON
	YmTDFVgMGuucK5jG+hCCNjpmvShoaxjR2GxfL4CPDyYsh1HrrUP0dfJFn7t1rhF5BX1z
	QulebPQxxF7BlQLX6aPFBRL9MaxWfIMd93GQFRXGoQVfqATcMJfQ4xQdzmIZMV+Hci3k
	b0QBSVgLpCRvXpg0CIBrKZIDiW38NXCoNedpxWvtfnzLpfAOh10afeqmZUYnLn5j5bIM
	AzSg==
X-Gm-Message-State: APjAAAUEtvcfPsG/KNcm5uB7HhW/csUaJI9mi2+wIlKyGCAeIAW5aGi/
	73VvTkHXKiIBSiyVue9gLF125g==
X-Google-Smtp-Source: APXvYqxPbVy/CysWjWXPUydT8+QeLb1Vc/CMoEYxTIF7elWNDupTtQ9YZVSLatJI5CswWDkSs72ACw==
X-Received: by 2002:a1c:4e04:: with SMTP id g4mr6223073wmh.127.1554976431329; 
	Thu, 11 Apr 2019 02:53:51 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	j22sm115724087wrd.91.2019.04.11.02.53.50
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 02:53:50 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2d327473-8763-f277-9bcf-4a77d2c3698b@redhat.com>
Date: Thu, 11 Apr 2019 11:53:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v3 19/23] hw/misc/exynos4210_rng: Use
 qemu_guest_getrandom
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411095350.PZHLGr3ryk_p77wfy63H2julywwgiJG9rs62Be5XYQA@z>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> The random number is intended for use by the guest.  As such, we should
> honor the -seed argument for reproducibility.
> 
> Cc: qemu-arm@nongnu.org
> Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/misc/exynos4210_rng.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
> index 4ecbebd2d7..0e70ffb404 100644
> --- a/hw/misc/exynos4210_rng.c
> +++ b/hw/misc/exynos4210_rng.c
> @@ -18,10 +18,10 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "crypto/random.h"
>  #include "hw/sysbus.h"
>  #include "qapi/error.h"
>  #include "qemu/log.h"
> +#include "qemu/guest-random.h"
>  
>  #define DEBUG_EXYNOS_RNG 0
>  
> @@ -109,7 +109,6 @@ static void exynos4210_rng_set_seed(Exynos4210RngState *s, unsigned int i,
>  static void exynos4210_rng_run_engine(Exynos4210RngState *s)
>  {
>      Error *err = NULL;
> -    int ret;
>  
>      /* Seed set? */
>      if ((s->reg_status & EXYNOS4210_RNG_STATUS_SEED_SETTING_DONE) == 0) {
> @@ -127,13 +126,11 @@ static void exynos4210_rng_run_engine(Exynos4210RngState *s)
>      }
>  
>      /* Get randoms */
> -    ret = qcrypto_random_bytes((uint8_t *)s->randr_value,
> -                               sizeof(s->randr_value), &err);
> -    if (!ret) {
> +    if (qemu_guest_getrandom(s->randr_value, sizeof(s->randr_value), &err)) {
> +        error_report_err(err);
> +    } else {
>          /* Notify that PRNG is ready */
>          s->reg_status |= EXYNOS4210_RNG_STATUS_PRNG_DONE;
> -    } else {
> -        error_report_err(err);
>      }
>  
>  out:
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

