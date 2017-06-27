Received: from eggs.gnu.org ([2001:4830:134:3::10]:50508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dPydc-00015Z-Kg
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dPydb-0000zV-Sa
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:07:12 -0400
Date: Tue, 27 Jun 2017 15:07:02 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170621125249.8805-1-paul.durrant@citrix.com>
Message-ID: <alpine.DEB.2.10.1706271506420.24648@sstabellini-ThinkPad-X260>
References: <20170621125249.8805-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v2 0/3] xen-disk: performance
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Wed, 21 Jun 2017, Paul Durrant wrote:
> Paul Durrant (3):
>   xen-disk: only advertize feature-persistent if grant copy is not
>     available
>   xen-disk: add support for multi-page shared rings
>   xen-disk: use an IOThread per instance
> 
>  hw/block/trace-events |   7 ++
>  hw/block/xen_disk.c   | 228 +++++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 188 insertions(+), 47 deletions(-)

While waiting for an answer on patch #3, I sent a pull request for the
first 2 patches
