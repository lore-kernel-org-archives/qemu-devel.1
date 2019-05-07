Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAE4C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E6B20825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E6B20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48808 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO2Ap-0007Yo-5K
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:38:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hO29Q-0006ju-3i
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hO29M-0008WD-Dz
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:37:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hO29K-0008Uj-HD
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:36:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 886F230832CC;
	Tue,  7 May 2019 15:36:56 +0000 (UTC)
Received: from [10.40.204.24] (ovpn-204-24.brq.redhat.com [10.40.204.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B46D3611C3;
	Tue,  7 May 2019 15:36:55 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190506173353.32206-1-richard.henderson@linaro.org>
	<20190506173353.32206-24-richard.henderson@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <67f60263-107e-1489-1384-26cae0f25c13@redhat.com>
Date: Tue, 7 May 2019 17:36:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190506173353.32206-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 07 May 2019 15:36:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 23/24] target/ppc: Use
 qemu_guest_getrandom for DARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/05/2019 19:33, Richard Henderson wrote:
> We now have an interface for guest visible random numbers.
> 
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/int_helper.c | 42 +++++++++++++++++++++++++++++------------
>   1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index f6a088ac08..9059e70b9c 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -23,6 +23,8 @@
>   #include "exec/helper-proto.h"
>   #include "crypto/aes.h"
>   #include "fpu/softfloat.h"
> +#include "qapi/error.h"
> +#include "qemu/guest-random.h"
>   
>   #include "helper_regs.h"
>   /*****************************************************************************/
> @@ -158,25 +160,41 @@ uint32_t helper_cmpeqb(target_ulong ra, target_ulong rb)
>   #undef hasvalue
>   
>   /*
> - * Return invalid random number.
> - *
> - * FIXME: Add rng backend or other mechanism to get cryptographically suitable
> - * random number
> + * Return a random number.
>    */
> -target_ulong helper_darn32(void)
> +uint64_t helper_darn32(void)
>   {
> -    return -1;
> +    Error *err = NULL;
> +    uint32_t ret;
> +
> +    if (qemu_guest_getrandom(&ret, 4, &err) < 0) {

sizeof(ret)?

> +        qemu_log_mask(LOG_UNIMP, "darn: Crypto failure: %s",
> +                      error_get_pretty(err));
> +        error_free(err);
> +        return -1;
> +    }
> +
> +    return ret;
>   }
>   
> -target_ulong helper_darn64(void)
> +uint64_t helper_darn64(void)
>   {
> -    return -1;
> +    Error *err = NULL;
> +    uint64_t ret;
> +
> +    do {
> +        if (qemu_guest_getrandom(&ret, 8, &err) < 0) {

sizeof(ret)?

> +            qemu_log_mask(LOG_UNIMP, "darn: Crypto failure: %s",
> +                          error_get_pretty(err));
> +            error_free(err);
> +            return -1;
> +        }
> +        /* Since -1 is the error condition, try again for that case.  */
> +    } while (unlikely(ret == -1));

I think you don't need to do that, according to documentation, this is 
done by the software:

"Programming Note: When the error value is obtained, software is
expected to repeat the operation. [...]" - PowerISA Version 3.0B

Thanks,
Laurent

