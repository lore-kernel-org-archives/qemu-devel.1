Received: from eggs.gnu.org ([2001:4830:134:3::10]:41900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eEsJA-0006PN-2S
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eEsJ9-0005Hu-8k
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:40:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eEsJ9-0005Gp-2E
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:40:27 -0500
Date: Wed, 15 Nov 2017 15:40:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171115074018.GG6821@xz-mi>
References: <20171114231350.286025-1-prasad.singamsetty@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171114231350.286025-1-prasad.singamsetty@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/2] intel-iommu: Extend address width
 to 48 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: prasad.singamsetty@oracle.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, imammedo@redhat.com, konrad.wilk@oracle.com

On Tue, Nov 14, 2017 at 06:13:48PM -0500, prasad.singamsetty@oracle.com wrote:
> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> 
> This pair of patches extends the intel-iommu to support address
> width to 48 bits. This is required to support qemu guest with large
> memory (>=1TB). 
> 
> Patch1 implements changes to redefine macros and usage to
> allow further changes to add support for 48 bit address width.
> This patch doesn't change the existing functionality or behavior.
> 
> Patch2 adds support for 48 bit address width but keeping the
> default to 39 bits.
> 
> NOTE: Peter Xu had originaly started on this enhancement
> but it was not completed or integrated.
> 
> Unit testing done:
> 
> patch-1:
>    * Boot vm with and without intel-iommu enabled
>    * Boot vm with #cpus below and above 255 cpus
> patch-2:
>    * boot vm without "x-aw-bits" or "x-aw-bits=39": guest boots with 39
>    * boot vm with "x-aw-bits=48": guest boots with 48 bits
>    * boot vm with invalid value for x-aw-bits: guest fails to boot
>    * boot vm with >=1TB memory and "x-aw-bits=48": guest boots
> 
> Prasad Singamsetty (2):
>   intel-iommu: Redefine macros to enable supporting 48 bit address width
>   intel-iommu: Extend address width to 48 bits

Looks quite good to me!

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
