Received: from eggs.gnu.org ([209.51.188.92]:44783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gj0iZ-0002Hn-BP
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gj0iY-0000a3-Jz
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:47:47 -0500
Date: Mon, 14 Jan 2019 12:47:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190114124738.547739c3.cohuck@redhat.com>
In-Reply-To: <20190112150225.20294-3-marcel.apfelbaum@gmail.com>
References: <20190112150225.20294-1-marcel.apfelbaum@gmail.com>
	<20190112150225.20294-3-marcel.apfelbaum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/rdma: modify struct initialization
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

On Sat, 12 Jan 2019 17:02:24 +0200
Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:

> Do not initialize structs with {0} since some
> CLANG versions do not support it.
> 
> Use memset instead.

Can't you use {} instead? (See, for example, commit ebf2a499a5c).

> 
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> ---
>  contrib/rdmacm-mux/main.c | 12 +++++++++---
>  hw/rdma/rdma_backend.c    | 16 ++++++++++++----
>  2 files changed, 21 insertions(+), 7 deletions(-)
