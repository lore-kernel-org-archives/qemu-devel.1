Received: from eggs.gnu.org ([209.51.188.92]:55872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6Ko-0001sS-F3
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6Km-0000WV-8P
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:15:53 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6Kl-0000VY-Sy
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:15:52 -0400
Received: by mail-pl1-x643.google.com with SMTP id bf11so5839551plb.12
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:15:51 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-28-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0f53d073-92ba-87e3-2dd4-4e4629ead801@linaro.org>
Date: Fri, 12 Apr 2019 14:15:45 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-28-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 27/41] s390x/tcg: Implement VECTOR
 ELEMENT ROTATE LEFT LOGICAL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +#define DEF_ROTL(BITS)                                                         \
> +static uint##BITS##_t rotl##BITS(uint##BITS##_t a, uint8_t count)            \
> +{                                                                            \
> +    count &= BITS - 1;                                                       \
> +    return (a << count) | (a >> (BITS - count));                             \
> +}
> +DEF_ROTL(8)
> +DEF_ROTL(16)

We already have rol8 and rol16 in <qemu/bitops.h> for this.
Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

This does point out that I should go ahead and fill out the
variable shift and rotate patterns in gvec...


r~
