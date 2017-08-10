Received: from eggs.gnu.org ([2001:4830:134:3::10]:58140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dfk3H-0003mR-PC
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dfk3E-0002IB-Jz
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:46:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:37130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dfk3E-0002GZ-By
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:46:48 -0400
References: <1502311882-11038-1-git-send-email-tianyu.lan@intel.com>
	<56f411f0-1e7f-1d06-01d4-2f16e6039444@redhat.com>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <f4edbb4d-0f62-9264-7c2c-d3970d25da01@intel.com>
Date: Thu, 10 Aug 2017 17:38:49 +0800
MIME-Version: 1.0
In-Reply-To: <56f411f0-1e7f-1d06-01d4-2f16e6039444@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Qemu: Add Xen vIOMMU interrupt
 remapping function support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: anthony.perard@citrix.com, ehabkost@redhat.com, marcel@redhat.com, mst@redhat.com, rth@twiddle.net, sstabellini@kernel.org, chao.gao@intel.com, kevin.tian@intel.com

On 2017年08月10日 17:04, Paolo Bonzini wrote:
> On 09/08/2017 22:51, Lan Tianyu wrote:
>> This patchset is to deal with MSI interrupt remapping request when guest
>> updates MSI registers.
>>
>> Chao Gao (3):
>>   i386/msi: Correct mask of destination ID in MSI address
>>   xen-pt: bind/unbind interrupt remapping format MSI
>>   msi: Handle remappable format interrupt request
>>
>>  configure                     |  4 +++-
>>  hw/i386/xen/xen-hvm.c         |  8 ++++++-
>>  hw/pci/msi.c                  |  5 +++--
>>  hw/pci/msix.c                 |  4 +++-
>>  hw/xen/xen_pt_msi.c           | 52 +++++++++++++++++++++++++++++++------------
>>  include/hw/i386/apic-msidef.h |  3 ++-
>>  include/hw/xen/xen.h          |  2 +-
>>  include/hw/xen/xen_common.h   | 25 +++++++++++++++++++++
>>  stubs/xen-hvm.c               |  2 +-
>>  9 files changed, 83 insertions(+), 22 deletions(-)
>>
> 
> Non-Xen parts look good (though I cannot ack them).
> 
> Paolo
> 

Never minder. Thanks for your review.

-- 
Best regards
Tianyu Lan
