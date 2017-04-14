Received: from eggs.gnu.org ([2001:4830:134:3::10]:33818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cz6Fj-0007cU-RY
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 14:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cz6Fg-0008Bl-7e
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 14:47:27 -0400
Received: from mail.kernel.org ([198.145.29.136]:51542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cz6Fg-0008Ak-1F
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 14:47:24 -0400
Date: Fri, 14 Apr 2017 11:47:18 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1491434491-1765-1-git-send-email-anthony.xu@intel.com>
Message-ID: <alpine.DEB.2.10.1704141146580.23677@sstabellini-ThinkPad-X260>
References: <1491434491-1765-1-git-send-email-anthony.xu@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 0/3] move xen related files to
 corresponding xen directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Xu <anthony.xu@intel.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony.perard@citrix.com, pbonzini@redhat.com, eblake@redhat.com

On Wed, 5 Apr 2017, Anthony Xu wrote:
> 
>   move xen related files to corresponding xen directory
> 
>   move xen-common.c to hw/xen/
>   move xen-hvm.c to hw/i386/xen/
>   move xen-mapcache.c to hw/i386/xen/
> 
> Signed-off -by: Anthony Xu <anthony.xu@intel.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

I queued this series in my "next" branch.


> 
>  Makefile.target                              |  6 ------
>  default-configs/i386-softmmu.mak             |  1 -
>  default-configs/x86_64-softmmu.mak           |  1 -
>  hw/i386/xen/Makefile.objs                    |  2 +-
>  hw/i386/xen/trace-events                     | 17 +++++++++++++++++
>  xen-hvm.c => hw/i386/xen/xen-hvm.c           |  2 +-
>  xen-mapcache.c => hw/i386/xen/xen-mapcache.c |  2 +-
>  hw/xen/Makefile.objs                         |  2 +-
>  xen-common.c => hw/xen/xen-common.c          |  0
>  stubs/Makefile.objs                          |  2 ++
>  xen-common-stub.c => stubs/xen-common.c      |  0
>  xen-hvm-stub.c => stubs/xen-hvm.c            |  0
>  trace-events                                 | 16 ----------------
>  13 files changed, 23 insertions(+), 28 deletions(-)
>  rename xen-hvm.c => hw/i386/xen/xen-hvm.c (99%)
>  rename xen-mapcache.c => hw/i386/xen/xen-mapcache.c (99%)
>  rename xen-common.c => hw/xen/xen-common.c (100%)
>  rename xen-common-stub.c => stubs/xen-common.c (100%)
>  rename xen-hvm-stub.c => stubs/xen-hvm.c (100%)
> 
> -- 
> 1.8.3.1
> 
