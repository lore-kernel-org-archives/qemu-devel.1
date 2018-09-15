Received: from eggs.gnu.org ([2001:4830:134:3::10]:59071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g0zAx-00014L-Kx
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 21:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g0zAs-0003Tx-Jr
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 21:15:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1g0zAs-0003SW-CR
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 21:15:02 -0400
Date: Fri, 14 Sep 2018 22:14:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180915011455.GB16677@habkost.net>
References: <1536949623-23564-1-git-send-email-brijesh.singh@amd.com>
	<1536949623-23564-3-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536949623-23564-3-git-send-email-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] x86_iommu: move
 vtd_generate_msi_message in common file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Richard Henderson <rth@twiddle.net>

On Fri, Sep 14, 2018 at 01:26:57PM -0500, Brijesh Singh wrote:
> The vtd_generate_msi_message() in intel-iommu is used to construct a MSI
> Message from IRQ. A similar function will be needed when we add interrupt
> remapping support in amd-iommu. Moving the function in common file to
> avoid the code duplication. Rename it to x86_iommu_irq_to_msi_message().
> There is no logic changes in the code flow.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Generic code match the original struct/function exactly.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
