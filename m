Received: from eggs.gnu.org ([2001:4830:134:3::10]:44292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkWrS-0002PK-En
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkWrQ-0004UA-0i
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:42:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dkWrP-0004TK-Qi
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:42:23 -0400
Date: Wed, 23 Aug 2017 15:42:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170823144217.GD16760@stefanha-x1.localdomain>
References: <20170822170212.27347-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822170212.27347-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Report when bdrv_inactivate_all
 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, christian.ehrhardt@canonical.com, peterx@redhat.com, lvivier@redhat.com

On Tue, Aug 22, 2017 at 06:02:12PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> If the bdrv_inactivate_all fails near the end of the migration,
> the migration will fail and often the only diagnostics in the log
> are an I/O error which you can't distinguish from an error on
> the socket connection.
> 
> Add an error so we know when it's actually a block problem.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/savevm.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
