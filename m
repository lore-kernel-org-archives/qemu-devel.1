Received: from eggs.gnu.org ([209.51.188.92]:42515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h3BQ6-000448-Mp
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 23:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h3BOg-00070X-Ax
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 23:14:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1h3BOg-0006zx-3W
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 23:14:38 -0400
Date: Mon, 11 Mar 2019 11:14:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190311031433.GF16479@xz-x1>
References: <20190308185124.28467-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190308185124.28467-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: Check
 qemu_rdma_init_one_block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peter.maydell@linaro.org

On Fri, Mar 08, 2019 at 06:51:24PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Actually it can't fail at the moment, but Coverity moans that
> it's the only place it's not checked, and it's an easy check.
> 
> Reported-by: Coverity (CID 1399413)
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
