Received: from eggs.gnu.org ([209.51.188.92]:43725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gj0e2-0000jt-Be
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gj0e0-0005rt-BI
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:43:06 -0500
Date: Mon, 14 Jan 2019 12:42:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190114124246.6de38d67.cohuck@redhat.com>
In-Reply-To: <20190112150225.20294-1-marcel.apfelbaum@gmail.com>
References: <20190112150225.20294-1-marcel.apfelbaum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] contrib/rdmacm-mux: fix clang
 compilation
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

On Sat, 12 Jan 2019 17:02:22 +0200
Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:

> Fix Commit a5d2f6f877 (contrib/rdmacm-mux: Add implementation
>                        of RDMA User MAD multiplexer).
> 
> The above commit introduces a new contrib target, adding a global dependency
> to libumad library in case pvrdma configuration option is enabled.
> Clang forbids it:
>     clang-6.0: error: -libumad: 'linker' input unused
>               [-Werror,-Wunused-command-line-argument]
> 
> Fix by limiting the scope to the rdmacm-mux target itself.
> Fix related clang errors while at it.
> 
> Marcel Apfelbaum (3):
>   contrib/rdmacm-mux: remove Wno-format-truncation flag
>   hw/rdma: modify struct initialization
>   contrib/rdmacm-mux: fix clang compilation
> 
>  Makefile                         |  2 ++
>  contrib/rdmacm-mux/Makefile.objs |  1 -
>  contrib/rdmacm-mux/main.c        | 18 +++++++++++++-----
>  hw/rdma/rdma_backend.c           | 16 ++++++++++++----
>  4 files changed, 27 insertions(+), 10 deletions(-)
> 

This fixes building on x86 with clang 6 for me. On s390x with clang 7,
I run into further problems when building the s390-ccw bios (the
maintainers are aware of that), but the rdma-related errors are gone.

Tested-by: Cornelia Huck <cohuck@redhat.com>
