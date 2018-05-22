Received: from eggs.gnu.org ([2001:4830:134:3::10]:37077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLBLv-0007tt-Ar
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLBLs-0000qK-7K
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:45:39 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-16-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9de4e541-6f68-5e24-273c-d7a61c31c1f8@twiddle.net>
Date: Tue, 22 May 2018 10:45:32 -0700
MIME-Version: 1.0
In-Reply-To: <20180521140402.23318-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/27] iommu: Add IOMMU index argument to
 notifier APIs
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
> Add support for multiple IOMMU indexes to the IOMMU notifier APIs.
> When initializing a notifier with iommu_notifier_init(), the caller
> must pass the IOMMU index that it is interested in. When a change
> happens, the IOMMU implementation must pass
> memory_region_notify_iommu() the IOMMU index that has changed and
> that notifiers must be called for.
> 
> IOMMUs which support only a single index don't need to change.
> Callers which only really support working with IOMMUs with a single
> index can use the result of passing MEMTXATTRS_UNSPECIFIED to
> memory_region_iommu_attrs_to_index().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
