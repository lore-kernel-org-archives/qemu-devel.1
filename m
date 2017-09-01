Received: from eggs.gnu.org ([2001:4830:134:3::10]:34359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dnkKI-0001oa-9x
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dnkKH-0001jB-KU
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:41:30 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170830100605.22694-1-famz@redhat.com> (Fam Zheng's message of
	"Wed, 30 Aug 2017 18:06:05 +0800")
References: <20170830100605.22694-1-famz@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 01 Sep 2017 13:41:19 +0200
Message-ID: <8760d28x40.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] block: Cleanup BMDS in bdrv_close_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, peterx@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Fam Zheng <famz@redhat.com> wrote:
> This fixes the assertion due to op blockers added by BMDS:
>
> block.c:3248: bdrv_delete: Assertion `bdrv_op_blocker_is_empty(bs)' failed.
>
> Reproducer: simply start block migration and quit QEMU before it ends.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

This stub stuff is crazy.

Fam, you were right (a.k.a. I was wrong).

Sorry, Juan.
