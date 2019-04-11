Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10BCC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845E1206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845E1206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45338 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWPR-0003z5-QM
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:54:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWOB-00037Y-P6
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWOA-0006fv-I9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:52:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWOA-0006fI-8m
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:52:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so6513475wrp.0
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=TUxPRAUluTvAnTHxv57v0NOLWb7K/HpHWUgipakNcXs=;
	b=MazXAfNNEv+bpZs9sM2iIQewZ2le0+eHRLH0EjXMTAEwnPg9fw/23TIVL24n2/dETg
	rjn023ZiLTKqttkukjDEmWvJvueTp1o6lxgIuo0zGodxMHFrS6mh/NRWpwDJ8IepVXOZ
	PHKydXmJ4/WE13EaPoAOVukua5XaEECbevc924RDmRwBvhCOEkojAyumzRsZZKRjYNkv
	cajr6/ryWZ0NCOFsbfrG+JqfzsiEETRbjzjpzyPZoXQxpK/xywAXJuthN3Jbe+C2t9PQ
	ZO5/HZWLmGg0U1RxXpGmDoL39G+7V5pkaHmMyKvoZktaA7hYAsSscaNW7maffvTYTuJj
	WJgg==
X-Gm-Message-State: APjAAAX/hzmrbsmL6yj1O+PFyy3ooBIj7yF40qWINrF6fFKxOoiqo9UA
	1jGo/B3Jm2aoUtQtqfLqfqWmPK+nVlw=
X-Google-Smtp-Source: APXvYqzpU8vlbiVHZtAE+6aikSZqdawEbO1epVZ7kDwJ5qfY09IXX+ljBY6YkzL8am5e/xkUqLg2xw==
X-Received: by 2002:adf:e40b:: with SMTP id g11mr29289053wrm.207.1554976377309;
	Thu, 11 Apr 2019 02:52:57 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	f11sm48579184wrm.30.2019.04.11.02.52.56
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 02:52:56 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <86c380e4-de29-2ab7-1107-74b8ab2a5b34@redhat.com>
Date: Thu, 11 Apr 2019 11:52:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v3 18/23] hw/misc/bcm2835_rng: Use
 qemu_guest_getrandom_nofail
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
Cc: qemu-arm@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411095256.q9QI-n3kl1pOZuJ6iEtXg2ew3R7NPRADdFwgKgiZ1OM@z>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> The random number is intended for use by the guest.  As such, we should
> honor the -seed argument for reproducibility.  Use the *_nofail routine
> instead of rolling our own error handling locally.
> 
> Cc: qemu-arm@nongnu.org
> Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/misc/bcm2835_rng.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
> index 4d62143b24..fe59c868f5 100644
> --- a/hw/misc/bcm2835_rng.c
> +++ b/hw/misc/bcm2835_rng.c
> @@ -9,30 +9,26 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> -#include "qapi/error.h"
> -#include "crypto/random.h"
> +#include "qemu/guest-random.h"
>  #include "hw/misc/bcm2835_rng.h"
>  
>  static uint32_t get_random_bytes(void)
>  {
>      uint32_t res;
> -    Error *err = NULL;
>  
> -    if (qcrypto_random_bytes((uint8_t *)&res, sizeof(res), &err) < 0) {
> -        /* On failure we don't want to return the guest a non-random
> -         * value in case they're really using it for cryptographic
> -         * purposes, so the best we can do is die here.
> -         * This shouldn't happen unless something's broken.
> -         * In theory we could implement this device's full FIFO
> -         * and interrupt semantics and then just stop filling the
> -         * FIFO. That's a lot of work, though, so we assume any
> -         * errors are systematic problems and trust that if we didn't
> -         * fail as the guest inited then we won't fail later on
> -         * mid-run.
> -         */
> -        error_report_err(err);
> -        exit(1);
> -    }
> +    /*
> +     * On failure we don't want to return the guest a non-random
> +     * value in case they're really using it for cryptographic
> +     * purposes, so the best we can do is die here.
> +     * This shouldn't happen unless something's broken.
> +     * In theory we could implement this device's full FIFO
> +     * and interrupt semantics and then just stop filling the
> +     * FIFO. That's a lot of work, though, so we assume any
> +     * errors are systematic problems and trust that if we didn't
> +     * fail as the guest inited then we won't fail later on
> +     * mid-run.
> +     */
> +    qemu_guest_getrandom_nofail(&res, sizeof(res));
>      return res;
>  }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

