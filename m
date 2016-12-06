Received: from eggs.gnu.org ([2001:4830:134:3::10]:48015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEGmY-0002qk-Rw
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEGmT-0002oc-Vc
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:31:46 -0500
MIME-Version: 1.0
In-Reply-To: <20161206134211.GD4990@noname.str.redhat.com>
References: <1479555831-30960-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<20161206134211.GD4990@noname.str.redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 6 Dec 2016 14:30:40 +0000
Message-ID: <CAJSP0QX7_NbdcT5o4FjfV9frj-4NGLhCDrDQW4ucv1ahQVhSDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] migration: re-active images
 when migration fails to complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Amit Shah <amit.shah@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>

On Tue, Dec 6, 2016 at 1:42 PM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 19.11.2016 um 12:43 hat zhanghailiang geschrieben:
>>          Error *local_err = NULL;
>>
>>          bdrv_invalidate_cache_all(&local_err);
>
> So in summary, this is a horrible patch because it checks the wrong
> thing, and for I can't really say if it covers everything it needs to
> cover, but arguably it happens to correctly fix the outcome of a
> previously failing case.
>
> Normally I would reject such a patch and require a clean solution, but
> then we're on the day of -rc3, so if you can't send v2 right away, we
> might not have the time for it.
>
> Tough call...

This bug is not a release blocker because it was already in QEMU 2.7
and not a regression.

Let's take time to understand this fully.  There could be related bugs
that can be fixed if this area of QEMU is scrutinized.  We can merge
fixes in -stable when consensus is reached.

Stefan
