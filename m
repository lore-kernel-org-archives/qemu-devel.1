Received: from eggs.gnu.org ([2001:4830:134:3::10]:42027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQPHn-0000vT-K6
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQPHm-0005lo-QZ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:38:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42194 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQPHm-0005la-Lc
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:38:58 -0400
Date: Wed, 6 Jun 2018 11:38:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180606033853.GC2606@xz-mi>
References: <20180605162545.80778-1-dgilbert@redhat.com>
	<20180605162545.80778-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180605162545.80778-2-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: Fixes for non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, clg@kaod.org

On Tue, Jun 05, 2018 at 05:25:44PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> There are still a few cases where migration code is using the macros
> and functions that do all RAMBlocks rather than just the migratable
> blocks; fix those up.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Indeed...

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
