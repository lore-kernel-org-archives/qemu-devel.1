Received: from eggs.gnu.org ([2001:4830:134:3::10]:60228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eZ0Dt-0001X2-Ul
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eZ0Ds-0005FO-NG
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:10:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eZ0Ds-0005ED-Gy
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:10:12 -0500
Date: Tue, 9 Jan 2018 18:10:05 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180109201005.GE18022@localhost.localdomain>
References: <20171211072806.2812-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171211072806.2812-1-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v4 0/3] nvdimm: fixes for
 (non-)dax backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, Stefan Hajnoczi <stefanha@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Richard Henderson <rth@twiddle.net>

Queued on machine-next.  Thanks, and sorry for the long delay.


On Mon, Dec 11, 2017 at 03:28:03PM +0800, Haozhong Zhang wrote:
> Previous versions can be found at
>   v3: https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04785.html
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01203.html
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05919.html
> 
> Changes in v4:
>  * Document new memory-backend-file option 'align' in qemu-options.hx. (Eduardo Habkost)
>  * Add endian conversion when setting the unarmed flag in NFIT. (Stefan Hajnoczi)
> 
> Changes in v3:
>  * Add an option 'align' to 'memory-backend-file' to address the
>    failure when mmap device dax (patch 1).
>  * Remove device dax check, which needs to access sysfs and may not
>    work with SELinux.
>  * Add a boolean option 'unarmed' to '-device nvdimm', which allows
>    users to control the unarmed flag in guest ACPI NFIT. I don't make
>    it as OnOffAuto, because of the remove of device dax check.
>  * Document new options added by this patch series.
> 
> Haozhong Zhang (3):
>   hostmem-file: add "align" option
>   nvdimm: add a macro for property "label-size"
>   nvdimm: add 'unarmed' option
> 
>  backends/hostmem-file.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  docs/nvdimm.txt         | 31 +++++++++++++++++++++++++++++++
>  exec.c                  |  8 +++++++-
>  hw/acpi/nvdimm.c        |  7 +++++++
>  hw/mem/nvdimm.c         | 28 +++++++++++++++++++++++++++-
>  include/exec/memory.h   |  3 +++
>  include/hw/mem/nvdimm.h | 12 ++++++++++++
>  memory.c                |  2 ++
>  numa.c                  |  2 +-
>  qemu-options.hx         |  9 ++++++++-
>  10 files changed, 138 insertions(+), 5 deletions(-)
> 
> -- 
> 2.14.1
> 
> 

-- 
Eduardo
