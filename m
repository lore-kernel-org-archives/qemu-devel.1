Received: from eggs.gnu.org ([2001:4830:134:3::10]:53602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0SuT-0002bA-Ra
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0SuR-0008GS-6X
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:47:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0SuQ-0008GG-Uh
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:47:55 -0400
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-3-git-send-email-brijesh.singh@amd.com>
	<20180912035214.GC3829@xz-x1>
	<9ecccc2d-9274-36c1-c0a5-56a24836d075@amd.com>
	<20180913031503.GC10763@xz-x1>
	<c6d1e6be-18ba-a078-3464-2f7f539dc626@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <77de31a5-6783-fa7d-efd6-6ce58f52b189@redhat.com>
Date: Thu, 13 Sep 2018 16:47:38 +0200
MIME-Version: 1.0
In-Reply-To: <c6d1e6be-18ba-a078-3464-2f7f539dc626@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] x86_iommu/amd: Prepare for interrupt
 remap support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Peter Xu <peterx@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On 13/09/2018 10:15, Suravee Suthikulpanit wrote:
> However, if you prefer to keep this option,
> we probably should rename this to "intremap_sup", in which if the
> default value should be 1.

The main reason to have the property and to leave it off by default is
that it is incompatible with kernel_irqchip=split.  A second reason is
migration support, where you would be able to migrate from QEMU 3.1 to
3.0 and interrupt remapping would disappear.

It's okay to call the property just "intremap" even if it's ultimately
the guest's call to use it.  It's the same for e.g. a PCI device's MSI
support, properties for that are called just "msi" or "msix".

Thanks,

Paolo
