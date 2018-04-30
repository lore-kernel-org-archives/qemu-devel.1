Received: from eggs.gnu.org ([2001:4830:134:3::10]:54255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD8K9-0002G4-Ng
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD8K4-0004Sv-UC
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:54:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fD8K4-0004Sd-O9
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:54:28 -0400
References: <20180430122404.10741-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1c3c88f-75c6-44f2-684c-d9d179bb128c@redhat.com>
Date: Mon, 30 Apr 2018 14:54:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180430122404.10741-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory.h: Improve IOMMU related
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 30/04/2018 14:24, Peter Maydell wrote:
> -    /* Set this up to provide customized IOMMU replay function */
> +    /* Set this up to provide customized IOMMU replay function.
> +     * Optional method.
> +     */
>      void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);

replay is needed if you want to support IOMMU notifiers.  After
memory_region_register_iommu_notifier you're only notified about future
changes to the mappings; memory_region_iommu_replay calls the replay
method so that the IOMMUNotifier is called for each existing mapping.

Paolo
