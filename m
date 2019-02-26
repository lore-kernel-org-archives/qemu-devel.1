Received: from eggs.gnu.org ([209.51.188.92]:34666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gye7x-0008Ju-9a
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gye7u-0005n6-Ft
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:54:37 -0500
References: <20190218122710.23639-1-david@redhat.com>
	<20190218122710.23639-9-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e07aa75c-f71d-926e-012c-9582a67ba948@redhat.com>
Date: Tue, 26 Feb 2019 15:54:21 +0100
MIME-Version: 1.0
In-Reply-To: <20190218122710.23639-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/15] s390x/tcg: Handle SET FPC AND
 LOAD FPC 3-bit BFP rounding modes
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
> We already forward the 3 bits correctly in the translation functions. We
> also have to handle them properly and check for specification
> exceptions.
> 
> Setting an invalid rounding mode (BFP only, all DFP rounding modes)
> results in a specification exception. Setting unassigned bits in the
> fpc, results in a specification exception.
> 
> This fixes LOAD FPC (AND SIGNAL), SET FPC (AND SIGNAL). Also for,
> SET BFP ROUNDING MODE, 3-bit rounding mode is now explicitly checked.
> 
> Note: TCG_CALL_NO_WG is required for sfpc handler, as we now inject
> exceptions.
> 
> We won't be modeling abscence of the "floating-point extension facility"
> for now, not necessary as most take the facility for granted without
> checking.
> 
> z14 PoP, 9-23, "LOAD FPC"
>     When the floating-point extension facility is
>     installed, bits 29-31 of the second operand must
>     specify a valid BFP rounding mode and bits 6-7,
>     14-15, 24, and 28 must be zero; otherwise, a
>     specification exception is recognized.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>


Here as well,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


-- 

Thanks,

David / dhildenb
