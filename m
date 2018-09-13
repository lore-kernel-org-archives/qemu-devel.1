Received: from eggs.gnu.org ([2001:4830:134:3::10]:50727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Suravee.Suthikulpanit@amd.com>) id 1g0Lrp-0004Oj-N6
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Suravee.Suthikulpanit@amd.com>) id 1g0Lrl-0005IB-3O
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:16:45 -0400
Received: from mail-bn3nam01on0075.outbound.protection.outlook.com
	([104.47.33.75]:43952
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Suravee.Suthikulpanit@amd.com>)
	id 1g0Lrk-0005HW-JS
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:16:40 -0400
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-6-git-send-email-brijesh.singh@amd.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <89321021-de13-0074-8791-988afb5dd21e@amd.com>
Date: Thu, 13 Sep 2018 14:16:11 +0700
MIME-Version: 1.0
In-Reply-To: <1536684589-11718-6-git-send-email-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] x86_iommu/amd: Add interrupt remap
 support when VAPIC is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tom Lendacky <Thomas.Lendacky@amd.com>

Brijesh,

On 9/11/18 11:49 PM, Brijesh Singh wrote:
> Emulate the interrupt remapping support when guest virtual APIC is
> enabled.
> 
> See IOMMU spec:https://support.amd.com/TechDocs/48882_IOMMU.pdf
> (section 2.2.5.2) for details information.
> 
> When VAPIC is enabled, it uses interrupt remapping as defined in
> Table 22 and Figure 17 from IOMMU spec.
> 
> Cc: "Michael S. Tsirkin"<mst@redhat.com>
> Cc: Paolo Bonzini<pbonzini@redhat.com>
> Cc: Richard Henderson<rth@twiddle.net>
> Cc: Eduardo Habkost<ehabkost@redhat.com>
> Cc: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
> Cc: Tom Lendacky<Thomas.Lendacky@amd.com>
> Cc: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>
> Signed-off-by: Brijesh Singh<brijesh.singh@amd.com>
> ---
>   hw/i386/amd_iommu.c  | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   hw/i386/amd_iommu.h  | 38 +++++++++++++++++++++++++++++
>   hw/i386/trace-events |  2 ++
>   3 files changed, 107 insertions(+), 1 deletion(-)

The commit message here is incorrect and/or misleading.
The GASup bit is essentially allow 128-bit IRTE format.
The guest virtual APIC support is really GAMSup bit.

Thanks,
Suravee
