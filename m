Received: from eggs.gnu.org ([2001:4830:134:3::10]:57556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g0z3L-000885-Je
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 21:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g0z3E-0000AD-7C
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 21:07:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1g0z3E-00008n-1E
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 21:07:08 -0400
Date: Fri, 14 Sep 2018 22:07:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180915010700.GA16677@habkost.net>
References: <1536949623-23564-1-git-send-email-brijesh.singh@amd.com>
	<1536949623-23564-2-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536949623-23564-2-git-send-email-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/8] x86_iommu: move the kernel-irqchip
 check in common code
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

On Fri, Sep 14, 2018 at 01:26:56PM -0500, Brijesh Singh wrote:
> Interrupt remapping needs kernel-irqchip={off|split} on both Intel and AMD
> platforms. Move the check in common place.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
