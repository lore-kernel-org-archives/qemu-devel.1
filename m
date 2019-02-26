Received: from eggs.gnu.org ([209.51.188.92]:34287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gye6T-0007Un-JZ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gye6S-0004pk-3i
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:53:04 -0500
References: <20190218122710.23639-1-david@redhat.com>
	<20190218122710.23639-2-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <50c44a16-b3a4-1feb-289d-7adfdc4ca32a@redhat.com>
Date: Tue, 26 Feb 2019 15:52:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190218122710.23639-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/15] s390x/tcg: Fix TEST DATA CLASS
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 18.02.19 13:26, David Hildenbrand wrote:
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

Seems like I forgot

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

from Richard (sorry!)

-- 

Thanks,

David / dhildenb
