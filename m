Received: from eggs.gnu.org ([209.51.188.92]:56594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu0GO-0003dP-Og
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu0GN-0005fz-Bo
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:32:08 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gu0GN-0004iS-1v
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:32:07 -0500
Received: by mail-pf1-x444.google.com with SMTP id b7so1640725pfi.8
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 11:31:53 -0800 (PST)
References: <20190213143322.31371-1-david@redhat.com>
	<20190213143322.31371-13-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <634cf76a-f1b9-138a-2ed4-e666c4be35f1@linaro.org>
Date: Wed, 13 Feb 2019 11:31:49 -0800
MIME-Version: 1.0
In-Reply-To: <20190213143322.31371-13-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/15] s390x/tcg: Implement XxC and
 checks for most FP instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

On 2/13/19 6:33 AM, David Hildenbrand wrote:
> With the floating-point extension facility
> - CONVERT FROM LOGICAL
> - CONVERT TO LOGICAL
> - CONVERT TO FIXED
> - CONVERT FROM FIXED
> - LOAD FP INTEGER
> have both, a rounding mode specification and the inexact-exception control
> (XxC). Other instructions will be handled separatly.
> 
> Check for valid rounding modes and forward also the XxC (via m4). To avoid
> a lot of boilerplate code and changes to the helpers, combine both, the
> m3 and m4 field in a combined 32 bit TCG variable. Perform checks at
> a central place, taking in account if the m3 or m4 field was ignore
> before the floating-point extension facility was introduced.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +static inline bool xxc_from_m34(uint32_t m34)
> +{
> +    /* XxC is bit 1 of m4 */
> +    return (extract32(m34, 4, 4) & 0x4) != 0;

Better as extract32(m32, 6, 1);


r~
