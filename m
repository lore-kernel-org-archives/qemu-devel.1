Received: from eggs.gnu.org ([2001:4830:134:3::10]:43398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fDo1K-00043v-9f
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fDo1H-0006k9-46
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:25:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45712 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fDo1G-0006jy-UO
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:25:51 -0400
References: <20180501085939.6201-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c338d0d3-2b02-26e7-f745-fbc5c1893453@redhat.com>
Date: Wed, 2 May 2018 11:25:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180501085939.6201-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/12] iommu: add MemTxAttrs
 argument to IOMMU translate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eric Auger <eric.auger@redhat.com>

On 01/05/2018 10:59, Peter Maydell wrote:
> As well as the SMMU, I'm also thinking about using the IOMMU
> infrastructure for the v8M Memory Protection Controller
> (though that is a bit trickier as I also need it to support
> TCG execution in an IOMMU-controlled region, which is an
> orthogonal bit of work to attribute support).
> 
> Based-on: <20180430122404.10741-1-peter.maydell@linaro.org>
> ("memory.h: Improve IOMMU related documentation") but
> only for textual reasons.
> 
> v1->v2 changes: only adding the patch 1/12 that I forgot
> to include in the v1 posting...

This is going to conflict with the MemoryRegionCache patches (review
welcome :)), as they add a new function address_space_translate_iommu.
But apart from this it seems like a no brainer.

Paolo
