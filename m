Received: from eggs.gnu.org ([209.51.188.92]:55462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwrgG-0006yj-CP
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwrgF-0006HJ-P2
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:58:40 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gwrgF-0006H8-Ji
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:58:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id b8so32233398qtr.9
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 08:58:39 -0800 (PST)
Date: Thu, 21 Feb 2019 11:58:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190221115747-mutt-send-email-mst@kernel.org>
References: <20190220005124.24224-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220005124.24224-1-richardw.yang@linux.intel.com>
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
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, philmd@redhat.com

On Wed, Feb 20, 2019 at 08:51:21AM +0800, Wei Yang wrote:
> Three trivial cleanup for pc-dimm.
> 
> Patch [1] remove the check on class->hotpluggable since pc-dimm is always
> hotpluggable.
> Patch [2] remove nvdimm_realize
> Patch [2] remove pcdimm realize-callback

Please copy Igor on ACPI patches.

Thanks!


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
> -- 
> 2.19.1
