Received: from eggs.gnu.org ([2001:4830:134:3::10]:32921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6aky-00017n-1j
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6akt-0004dU-Vp
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:18:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6akt-0004dJ-Q5
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:18:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E205A13AAE
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 11:18:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171019063200.19048-2-peterx@redhat.com> (Peter Xu's message of
	"Thu, 19 Oct 2017 14:31:57 +0800")
References: <20171019063200.19048-1-peterx@redhat.com>
	<20171019063200.19048-2-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 23 Oct 2017 13:18:47 +0200
Message-ID: <87inf69ko8.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/4] migration: provide ram_state_init()
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
> The old ram_state_init() is not really initializing the RAMState only,
> but including lots of other stuff that is RAM-related.  Renaming it to
> ram_init_all().  Instead, provide a real ram_state_init().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
