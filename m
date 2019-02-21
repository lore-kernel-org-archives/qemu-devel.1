Received: from eggs.gnu.org ([209.51.188.92]:51836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gwpgR-00006p-24
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gwpgP-0003aQ-Au
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:50:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gwpgN-0003Du-Ax
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:50:40 -0500
Date: Thu, 21 Feb 2019 15:50:04 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190221155004.010f7b7a@redhat.com>
In-Reply-To: <20190220005124.24224-1-richardw.yang@linux.intel.com>
References: <20190220005124.24224-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] PCDIMM cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, xiaoguangrong.eric@gmail.com, philmd@redhat.com

On Wed, 20 Feb 2019 08:51:21 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> Three trivial cleanup for pc-dimm.
> 
> Patch [1] remove the check on class->hotpluggable since pc-dimm is always
> hotpluggable.
> Patch [2] remove nvdimm_realize
> Patch [2] remove pcdimm realize-callback
even though this series doesn't break anything, I disagree with it
conceptually as it makes device less abstracted and make it more
dependent on how existing machine code uses it.
I'd drop whole series.

> 
> v2:
>   * fix warning in Patch 1
>   * split Patch 2 into two
> 
> Wei Yang (3):
>   pc-dimm: remove check on pc-dimm hotpluggable
>   mem/nvdimm: remove nvdimm_realize
>   pc-dimm: revert "introduce realize callback"
> 
>  hw/acpi/memory_hotplug.c |  5 -----
>  hw/mem/nvdimm.c          | 11 -----------
>  hw/mem/pc-dimm.c         |  5 -----
>  include/hw/mem/pc-dimm.h |  3 ---
>  4 files changed, 24 deletions(-)
> 
