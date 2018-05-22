Received: from eggs.gnu.org ([2001:4830:134:3::10]:36025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLBIq-0006YG-EC
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLBIn-00085d-8w
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:42:28 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-15-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5655dec4-6d82-a02c-2155-300c4baf1adf@twiddle.net>
Date: Tue, 22 May 2018 10:42:21 -0700
MIME-Version: 1.0
In-Reply-To: <20180521140402.23318-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/27] iommu: Add IOMMU index concept to
 IOMMU API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/21/2018 07:03 AM, Peter Maydell wrote:
> +    /* Return the IOMMU index to use for a given set of transaction attributes.
> +     *
> +     * Optional method: if an IOMMU only supports a single IOMMU index then
> +     * the default implementation of memory_region_iommu_attrs_to_index()
> +     * will return 0.
> +     *
> +     * The indexes supported by an IOMMU must be contiguous, starting at 0.
> +     *
> +     * @iommu: the IOMMUMemoryRegion
> +     * @attrs: memory transaction attributes
> +     */
> +    int (*attrs_to_index)(IOMMUMemoryRegion *iommu, MemTxAttrs attrs);
> +
> +    /* Return the number of IOMMU indexes this IOMMU supports.
> +     *
> +     * Optional method: if this method is not provided, then
> +     * memory_region_iommu_num_indexes() will return 1, indicating that
> +     * only a single IOMMU index is supported.
> +     */

The mispatched callback has been discussed, but would it be equally useful to
simply have a variable here instead of a callback?  Perhaps max_index instead
of num_indexes so that zero-initialization of the structure does the right
thing for existing iommu's.


r~
