Received: from eggs.gnu.org ([2001:4830:134:3::10]:33042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6alU-0001Zn-7A
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6alQ-0004q6-5q
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:19:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6alP-0004pq-Ve
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:19:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A6484ACAD
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 11:19:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171019063200.19048-3-peterx@redhat.com> (Peter Xu's message of
	"Thu, 19 Oct 2017 14:31:58 +0800")
References: <20171019063200.19048-1-peterx@redhat.com>
	<20171019063200.19048-3-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 23 Oct 2017 13:19:18 +0200
Message-ID: <87efpu9knd.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/4] migration: provide ram_state_cleanup
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
> There are two Mutexes that are created but not yet destroyed for
> RAMState.  Fix that.
>
> Since we are at it, provide helper function to clean up RAMState.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
