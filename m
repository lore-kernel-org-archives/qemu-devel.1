Received: from eggs.gnu.org ([209.51.188.92]:41178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkTyE-0003Mx-8a
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkTyD-0005OQ-LD
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:14:02 -0500
Date: Fri, 18 Jan 2019 14:13:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190118141356.6394f5b1.cohuck@redhat.com>
In-Reply-To: <20190118124614.24548-3-marcel.apfelbaum@gmail.com>
References: <20190118124614.24548-1-marcel.apfelbaum@gmail.com>
	<20190118124614.24548-3-marcel.apfelbaum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] hw/rdma: modify struct
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, yuval.shaia@oracle.com, qemu-stable@nongnu.org

On Fri, 18 Jan 2019 14:46:13 +0200
Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:

> Do not initialize structs with {0} since some
> CLANG versions do not support it.
> 
> Use {} construct instead.
> 
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> Tested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> ---
>  contrib/rdmacm-mux/main.c | 6 +++---
>  hw/rdma/rdma_backend.c    | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
