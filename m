Received: from eggs.gnu.org ([2001:4830:134:3::10]:37498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6b4S-0000G7-4A
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6b4O-00067Q-O7
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:39:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6b4O-00066c-IS
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:39:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 854CE883A4
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 11:38:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171019063200.19048-5-peterx@redhat.com> (Peter Xu's message of
	"Thu, 19 Oct 2017 14:32:00 +0800")
References: <20171019063200.19048-1-peterx@redhat.com>
	<20171019063200.19048-5-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 23 Oct 2017 13:38:54 +0200
Message-ID: <871slu9jqp.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/4] migration: new ram_init_bitmaps()
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
> Rearrange the bitmap initialization and the first sync.  Since at it,
> make sure the locks are taken/released in correct order (I moved RCU
> unlock upper - though it may not affect much).
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
