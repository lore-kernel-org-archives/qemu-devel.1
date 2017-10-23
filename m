Received: from eggs.gnu.org ([2001:4830:134:3::10]:33247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6amJ-0002Fz-3W
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6amD-0005es-FW
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:20:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6amD-0005e1-8V
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:20:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6204587649
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 11:20:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171019063200.19048-4-peterx@redhat.com> (Peter Xu's message of
	"Thu, 19 Oct 2017 14:31:59 +0800")
References: <20171019063200.19048-1-peterx@redhat.com>
	<20171019063200.19048-4-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 23 Oct 2017 13:20:04 +0200
Message-ID: <87a80i9km3.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/4] migration: clean up xbzrle cache
 init/destroy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Let's further simplify ram_init_all() and ram_save_cleanup() by abstract
> all the XBZRLE related codes into their own functions.
>
> When allocating xbzrle cache, we are always very careful on -ENOMEM;
> which makes sense.  Replacing the last g_malloc0() with g_try_malloc0(),
> then refactor the logic a bit.
>
> This patch should be fixing some memory leaks when some memory
> allocation failed for XBZRLE in the past.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
