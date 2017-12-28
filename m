Received: from eggs.gnu.org ([2001:4830:134:3::10]:52059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eUUwI-0001lZ-39
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 04:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eUUwE-0007n4-4P
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 04:57:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eUUwD-0007lx-UW
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 04:57:22 -0500
Date: Thu, 28 Dec 2017 17:57:16 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171228095716.GC4423@xz-mi>
References: <20171228091616.7999-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171228091616.7999-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] migration: finalize current_migration
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, dgilbert@redhat.com, quintela@redhat.com

On Thu, Dec 28, 2017 at 12:16:16PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> current_migration has .instance_finalize callback, but it is not
> called, because nobody unrefs current_migration. Fix that.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
