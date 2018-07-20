Received: from eggs.gnu.org ([2001:4830:134:3::10]:38093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fgQv6-0000EO-EA
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fgQv3-0006u5-B1
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:37:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42900 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fgQv3-0006tu-5s
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:37:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 944FA72643
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 08:37:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180720034713.11711-1-peterx@redhat.com> (Peter Xu's message of
	"Fri, 20 Jul 2018 11:47:13 +0800")
References: <20180720034713.11711-1-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 20 Jul 2018 10:37:36 +0200
Message-ID: <87r2jywbe7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: fix potential overflow in
 multifd send
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> I would guess it won't happen normally, but this should ease Coverity.
>
>>>>     CID 1394385:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>>     Potentially overflowing expression "pages->used * 8192U" with
>>>> type "unsigned int" (32 bits, unsigned) is evaluated using 32-bit
>>>> arithmetic, and then used in a context that expects an expression
>>>> of type "uint64_t" (64 bits, unsigned).
> 854         transferred = pages->used * TARGET_PAGE_SIZE + p->packet_len;
>
> Fixes: CID 1394385
> CC: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

a - I hate C promotion rules
b - why gcc don't warn me
c - it don't matter.  If the size of the package is bigger than 4GB, we
    have other problems already.

Thanks, Juan.
