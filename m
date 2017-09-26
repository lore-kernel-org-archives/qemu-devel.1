Received: from eggs.gnu.org ([2001:4830:134:3::10]:38945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=435882bd1=anthony.perard@citrix.com>)
	id 1dwr0J-0007Er-OE
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=435882bd1=anthony.perard@citrix.com>)
	id 1dwr0F-0006bf-P5
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:38:31 -0400
Date: Tue, 26 Sep 2017 15:37:51 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170926143750.GA17168@perard.uk.xensource.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 00/12] Patch Round-up for stable 2.10.1,
 freeze on 2017-09-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Tue, Sep 19, 2017 at 07:45:09PM -0500, Michael Roth wrote:
> Hi everyone,
> 
> The following new patches are queued for QEMU stable v2.10.1:
> 
>   https://github.com/mdroth/qemu/commits/stable-2.10-staging
> 
> The release is planned for 2017-10-02:
> 
>   https://wiki.qemu.org/Planning/2.10
> 
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.

Hi,

I'd like to add this patch:

a3fd781f653db4dc76635715207c9029208634bd
"xen-disk: use g_new0 to fix build"


And maybe these three patches to fix a regression compared to 2.8:

f5855994fee2f8815dc86b8453e4a63e290aea05
"hw/acpi: Limit hotplug to root bus on legacy mode"

ab938ae43f8a3a71a3525566edf586081b7a7452
"hw/acpi: Move acpi_set_pci_info to pcihp"

2bed1ba77fae50bc8b5e68ede2d80b652b30c3b8
"Revert "ACPI: don't call acpi_pcihp_device_plug_cb on xen""


There is also two more patches that are not commited yet, so I don't
known if they can be candidate for the stable release:

"xen: add a global indicator for grant copy being available"
"xen: dont try setting max grants multiple times"


Thanks,

-- 
Anthony PERARD
