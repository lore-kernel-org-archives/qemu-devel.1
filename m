Received: from eggs.gnu.org ([2001:4830:134:3::10]:55614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dz6OK-0006Xc-Ej
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dz6OJ-00048R-NY
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:28:36 -0400
Date: Mon, 2 Oct 2017 15:28:31 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171002192830.GB22777@stefanha-x1.localdomain>
References: <20170930195345.23338-1-eblake@redhat.com>
	<20170930195345.23338-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170930195345.23338-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/4] block: Add blkdebug hook
 for copy-on-read
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Sat, Sep 30, 2017 at 02:53:43PM -0500, Eric Blake wrote:
> Make it possible to inject errors on writes performed during a
> read operation due to copy-on-read semantics.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json | 5 ++++-
>  block/io.c           | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
