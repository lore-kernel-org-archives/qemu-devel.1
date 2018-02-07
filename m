Received: from eggs.gnu.org ([2001:4830:134:3::10]:43893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ejTNh-0002IH-7e
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ejTNd-0007DP-6r
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:19:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ejTNd-0007D6-1P
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 12:19:33 -0500
References: <20180205102659.60552-1-marcel@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <4e2dfef0-bd22-9f1f-b527-f10e7bd6a8fe@redhat.com>
Date: Wed, 7 Feb 2018 19:19:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180205102659.60552-1-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/4] RDMA patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org

On 05/02/2018 12:26, Marcel Apfelbaum wrote:
> The following changes since commit f24ee107a07f093bd7ed475dd48d7ba57ea3d8fe:
> 
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180202-pull-request' into staging (2018-02-02 18:54:11 +0000)
> 
> are available in the git repository at:
> 
>   https://github.com/marcel-apf/qemu tags/rdma-pull-request
> 
> for you to fetch changes up to f172ba1b02724fb66dabd69cd553cfa625b413e5:
> 
>   MAINTAINERS: add entry for hw/rdma (2018-02-05 11:53:00 +0200)
> 
> ----------------------------------------------------------------
> PVRDMA implementation
> 
> ----------------------------------------------------------------

Hi Peter,

Sorry for bothering, I wonder if you saw this pull request.
Since is my first one, I just want to be sure I did everything right.

Thanks,
Marcel

> Marcel Apfelbaum (3):
>       mem: add share parameter to memory-backend-ram
>       docs: add pvrdma device documentation.
>       MAINTAINERS: add entry for hw/rdma
> 
> Yuval Shaia (1):
>       pvrdma: initial implementation
> 
>  MAINTAINERS                   |   8 +
>  Makefile.objs                 |   2 +
>  backends/hostmem-file.c       |  25 +-
>  backends/hostmem-ram.c        |   4 +-
>  backends/hostmem.c            |  21 ++
>  configure                     |   9 +-
>  docs/pvrdma.txt               | 255 +++++++++++++
>  exec.c                        |  26 +-
>  hw/Makefile.objs              |   1 +
>  hw/rdma/Makefile.objs         |   5 +
>  hw/rdma/rdma_backend.c        | 818 ++++++++++++++++++++++++++++++++++++++++++
>  hw/rdma/rdma_backend.h        |  99 +++++
>  hw/rdma/rdma_backend_defs.h   |  62 ++++
>  hw/rdma/rdma_rm.c             | 544 ++++++++++++++++++++++++++++
>  hw/rdma/rdma_rm.h             |  69 ++++
>  hw/rdma/rdma_rm_defs.h        | 104 ++++++
>  hw/rdma/rdma_utils.c          |  52 +++
>  hw/rdma/rdma_utils.h          |  43 +++
>  hw/rdma/trace-events          |   5 +
>  hw/rdma/vmw/pvrdma.h          | 122 +++++++
>  hw/rdma/vmw/pvrdma_cmd.c      | 656 +++++++++++++++++++++++++++++++++
>  hw/rdma/vmw/pvrdma_dev_api.h  | 602 +++++++++++++++++++++++++++++++
>  hw/rdma/vmw/pvrdma_dev_ring.c | 140 ++++++++
>  hw/rdma/vmw/pvrdma_dev_ring.h |  42 +++
>  hw/rdma/vmw/pvrdma_ib_verbs.h | 433 ++++++++++++++++++++++
>  hw/rdma/vmw/pvrdma_main.c     | 653 +++++++++++++++++++++++++++++++++
>  hw/rdma/vmw/pvrdma_qp_ops.c   | 212 +++++++++++
>  hw/rdma/vmw/pvrdma_qp_ops.h   |  27 ++
>  hw/rdma/vmw/pvrdma_ring.h     | 134 +++++++
>  hw/rdma/vmw/trace-events      |   5 +
>  hw/rdma/vmw/vmw_pvrdma-abi.h  | 311 ++++++++++++++++
>  include/exec/memory.h         |  23 ++
>  include/exec/ram_addr.h       |   3 +-
>  include/hw/pci/pci_ids.h      |   3 +
>  include/qemu/osdep.h          |   2 +-
>  include/sysemu/hostmem.h      |   2 +-
>  include/sysemu/kvm.h          |   2 +-
>  memory.c                      |  16 +-
>  qemu-options.hx               |  10 +-
>  target/s390x/kvm.c            |   4 +-
>  util/oslib-posix.c            |   4 +-
>  util/oslib-win32.c            |   2 +-
>  42 files changed, 5506 insertions(+), 54 deletions(-)
>  create mode 100644 docs/pvrdma.txt
>  create mode 100644 hw/rdma/Makefile.objs
>  create mode 100644 hw/rdma/rdma_backend.c
>  create mode 100644 hw/rdma/rdma_backend.h
>  create mode 100644 hw/rdma/rdma_backend_defs.h
>  create mode 100644 hw/rdma/rdma_rm.c
>  create mode 100644 hw/rdma/rdma_rm.h
>  create mode 100644 hw/rdma/rdma_rm_defs.h
>  create mode 100644 hw/rdma/rdma_utils.c
>  create mode 100644 hw/rdma/rdma_utils.h
>  create mode 100644 hw/rdma/trace-events
>  create mode 100644 hw/rdma/vmw/pvrdma.h
>  create mode 100644 hw/rdma/vmw/pvrdma_cmd.c
>  create mode 100644 hw/rdma/vmw/pvrdma_dev_api.h
>  create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c
>  create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h
>  create mode 100644 hw/rdma/vmw/pvrdma_ib_verbs.h
>  create mode 100644 hw/rdma/vmw/pvrdma_main.c
>  create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c
>  create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h
>  create mode 100644 hw/rdma/vmw/pvrdma_ring.h
>  create mode 100644 hw/rdma/vmw/trace-events
>  create mode 100644 hw/rdma/vmw/vmw_pvrdma-abi.h
> 
