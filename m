Received: from eggs.gnu.org ([209.51.188.92]:35019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gye8w-0000Zy-Qk
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gye8v-0006hb-Qe
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:55:38 -0500
References: <20190218122710.23639-1-david@redhat.com>
	<20190218122710.23639-13-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ffcfc40e-fa0a-5f24-6aa9-8711995478c0@redhat.com>
Date: Tue, 26 Feb 2019 15:55:29 +0100
MIME-Version: 1.0
In-Reply-To: <20190218122710.23639-13-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/15] s390x/tcg: Implement XxC and
 checks for most FP instructions
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

On 18.02.19 13:27, David Hildenbrand wrote:
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
> ---


Here as well (from v2 review)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

-- 

Thanks,

David / dhildenb
