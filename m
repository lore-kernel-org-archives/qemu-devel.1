Received: from eggs.gnu.org ([209.51.188.92]:55479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu0Ep-00020A-6K
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu01t-0004BN-9C
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:17:10 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gu01t-00044T-1S
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:17:09 -0500
Received: by mail-pf1-x441.google.com with SMTP id b7so1619835pfi.8
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 11:17:08 -0800 (PST)
References: <20190213143322.31371-1-david@redhat.com>
	<20190213143322.31371-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a82798bc-f0ef-bfe1-7768-5f32202cb398@linaro.org>
Date: Wed, 13 Feb 2019 11:17:03 -0800
MIME-Version: 1.0
In-Reply-To: <20190213143322.31371-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/15] s390x/tcg: Fix TEST DATA CLASS
 instructions
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
> Let's detect normal and denormal ("subnormal") numbers reliably. Also
> test for quiet NaN's. As only one class is possible, test common cases
> first.
> 
> While at it, use a better check to test for the mask bits in the data
> class mask. The data class mask has 12 bits, whereby bit 0 is the
> leftmost bit and bit 11 the rightmost bit. In the PoP an easy to read
> table with the numbers is provided for the VECTOR FP TEST DATA CLASS
> IMMEDIATE instruction, the table for TEST DATA CLASS is more confusing
> as it is based on 64 bit values.
> 
> Factor the checks out into separate functions, as they will also be
> needed for floating point vector instructions. We can use a makro to
> generate the functions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
