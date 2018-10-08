Received: from eggs.gnu.org ([2001:4830:134:3::10]:56175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9OU2-0002mV-Eu
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 01:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9OTx-0008KJ-V2
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 01:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1g9OTx-0008CI-Bu
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 01:53:29 -0400
Date: Mon, 8 Oct 2018 13:53:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181008055318.GC18728@xz-x1>
References: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
	<1538423049-29524-6-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1538423049-29524-6-git-send-email-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH v5 5/9] x86_iommu/amd: Prepare for
 interrupt remap support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>

On Mon, Oct 01, 2018 at 07:44:37PM +0000, Singh, Brijesh wrote:
> Register the interrupt remapping callback and read/write ops for the
> amd-iommu-ir memory region.
> 
> amd-iommu-ir is set to higher priority to ensure that this region won't
> be masked out by other memory regions.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Regards,

-- 
Peter Xu
