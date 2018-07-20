Received: from eggs.gnu.org ([2001:4830:134:3::10]:41363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgTrr-0004AD-Q6
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 07:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgTro-0006nh-OD
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 07:46:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55342 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fgTro-0006nW-JL
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 07:46:36 -0400
Date: Fri, 20 Jul 2018 19:46:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180720114630.GD16910@xz-mi>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
	<20180718154200.26777-11-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718154200.26777-11-dplotnikov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v1 10/17] background snapshots: adapt the
 page queueing code for using page copies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Wed, Jul 18, 2018 at 06:41:53PM +0300, Denis Plotnikov wrote:

[...]

> @@ -1003,13 +1008,18 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
>      } else {
>          pages = save_zero_page(rs, block, offset, p);

Now save_zero_page() is not called by ram_save_page().  I'd suggest
that you rebase to the latest master in your next post since the code
base looks old.

Thanks,

-- 
Peter Xu
