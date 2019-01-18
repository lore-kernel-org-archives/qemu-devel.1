Received: from eggs.gnu.org ([209.51.188.92]:33980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gkTXm-0003W2-B8
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gkTXj-0008CI-KU
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:46:42 -0500
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Fri, 18 Jan 2019 14:46:11 +0200
Message-Id: <20190118124614.24548-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/3] contrib/rdmacm-mux: fix clang
 compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, qemu-stable@nongnu.org, marcel.apfelbaum@gmail.com, cohuck@redhat.com

v1 -> v2:
 * Use {} construct instead memset to make both gcc and clang happy (Cornelia)
 * Rebased on master
 * Added Yuval's RB and Cornelia's Tested-by tags (thanks!)

Fix Commit a5d2f6f877 (contrib/rdmacm-mux: Add implementation
                       of RDMA User MAD multiplexer).

The above commit introduces a new contrib target, adding a global dependency
to libumad library in case pvrdma configuration option is enabled.
Clang forbids it:
    clang-6.0: error: -libumad: 'linker' input unused
              [-Werror,-Wunused-command-line-argument]

Fix by limiting the scope to the rdmacm-mux target itself.
Fix related clang errors while at it.

Marcel Apfelbaum (3):
  contrib/rdmacm-mux: remove Wno-format-truncation flag
  hw/rdma: modify struct initialization
  contrib/rdmacm-mux: fix clang compilation

 Makefile                         |  2 ++
 contrib/rdmacm-mux/Makefile.objs |  1 -
 contrib/rdmacm-mux/main.c        | 12 +++++++-----
 hw/rdma/rdma_backend.c           |  8 ++++----
 4 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.17.1
