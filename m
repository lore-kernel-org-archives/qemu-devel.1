Received: from eggs.gnu.org ([2001:4830:134:3::10]:42589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMGsG-00062M-FS
	for qemu-devel@nongnu.org; Fri, 25 May 2018 13:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMGsB-00032j-KO
	for qemu-devel@nongnu.org; Fri, 25 May 2018 13:51:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57948 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMGsB-00032D-Ft
	for qemu-devel@nongnu.org; Fri, 25 May 2018 13:51:27 -0400
Date: Fri, 25 May 2018 20:51:22 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180525205051-mutt-send-email-mst@kernel.org>
References: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
Subject: Re: [Qemu-devel] [qemu PATCH v4 0/4] support NFIT platform
 capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>

On Mon, May 21, 2018 at 10:31:59AM -0600, Ross Zwisler wrote:
> Changes since v3:
>  * Updated the text in docs/nvdimm.txt to make it clear that the value
>    being passed in on the command line in an integer made up of various
>    bit fields. (Rob Elliott)
>  
>  * Updated the "Highest Valid Capability" byte to be dynamic based on
>    the highest valid bit in the user's input. (Rob Elliott)

Igor could you review pls? I think your comments have been addressed.

> ---
> 
> The first 2 patches in this series clean up some things I noticed while
> coding.
> 
> Patch 3 adds support for the new Platform Capabilities Structure, which
> was added to the NFIT in ACPI 6.2 Errata A.  We add a machine command
> line option "nvdimm-cap":
> 
>     -machine pc,accel=kvm,nvdimm,nvdimm-cap=2
> 
> which allows the user to pass in a value for this structure.  When such
> a value is passed in we will generate the new NFIT subtable.
> 
> Patch 4 adds code to the "make check" self test infrastructure so that
> we generate the new Platform Capabilities Structure, and adds it to the
> expected NFIT output so that we test for it.
> 
> Ross Zwisler (4):
>   nvdimm: fix typo in label-size definition
>   tests/.gitignore: add entry for generated file
>   nvdimm, acpi: support NFIT platform capabilities
>   ACPI testing: test NFIT platform capabilities
> 
>  docs/nvdimm.txt                       |  27 ++++++++++++++++++++
>  hw/acpi/nvdimm.c                      |  45 +++++++++++++++++++++++++++++++---
>  hw/i386/pc.c                          |  31 +++++++++++++++++++++++
>  hw/mem/nvdimm.c                       |   2 +-
>  include/hw/i386/pc.h                  |   1 +
>  include/hw/mem/nvdimm.h               |   7 +++++-
>  tests/.gitignore                      |   1 +
>  tests/acpi-test-data/pc/NFIT.dimmpxm  | Bin 224 -> 240 bytes
>  tests/acpi-test-data/q35/NFIT.dimmpxm | Bin 224 -> 240 bytes
>  tests/bios-tables-test.c              |   2 +-
>  10 files changed, 109 insertions(+), 7 deletions(-)
> 
> -- 
> 2.14.3
