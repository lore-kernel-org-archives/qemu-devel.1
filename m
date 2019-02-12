Received: from eggs.gnu.org ([209.51.188.92]:54658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVs8-0006xP-66
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVs6-0004d3-GO
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:05:03 -0500
References: <20190212110308.13707-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ff61e018-af71-a275-7332-0ac4c01ddc75@redhat.com>
Date: Tue, 12 Feb 2019 12:04:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190212110308.13707-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x: Add floating-point extension
 facility to "qemu" cpu model
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

On 12.02.19 12:02, David Hildenbrand wrote:
> The floating-point extension facility implemented certain changes to
> BFP, HFP and DFP instructions.
> 
> As we don't implement HFP/DFP, we can ignore those completely. Related
> to BFP, the changes include
> - SET BFP ROUNDING MODE (SRNMB) instruction
> - BFP-rounding-mode field in the FPC register is changed to 3 bits
> - CONVERT FROM LOGICAL instructions
> - CONVERT TO LOGICAL instructions
> - Changes (rounding mode + XxC) added to
> -- CONVERT TO FIXED
> -- CONVERT FROM FIXED
> -- LOAD FP INTEGER
> -- LOAD ROUNDED
> -- DIVIDE TO INTEGER
> 
> For TCG, we don't implement DIVIDE TO INTEGER, and it is harder to
> implement, so skip that. Also, as we don't implement PFPO, we can skip
> changes to that as well. The other parts are now implemented, we can
> indicate the facility.
> 
> z14 PoP mentiones that "The floating-point extension facility is installed
> in the z/Architecture architectural mode. When bit 37 is one, bit 42 is
> also one.", meaning that the DFP (decimal-floating-point) facility also
> has to be inidicated. We can ignore that for now.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

This is the same patch as 15/15, refer to 0/15 as cover letter instead.

-- 

Thanks,

David / dhildenb
