Received: from eggs.gnu.org ([209.51.188.92]:44784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBGJX-0004fO-FB
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBGJU-0001ly-TZ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:06:42 -0400
Date: Tue, 2 Apr 2019 12:06:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190402100631.GC5352@localhost.localdomain>
References: <1553678622-17295-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553678622-17295-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0] tests/qemu-iotests/235: Allow
 fallback to tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Am 27.03.2019 um 10:23 hat Thomas Huth geschrieben:
> iotest 235 currently only works with KVM - this is bad for systems where
> it is not available, e.g. CI pipelines. The test also works when using
> "tcg" as accelerator, so we can simply add that to the list of accelerators,
> too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Do not remove the test from the "quick" group, since there was no
>      real consensus about that change. We should maybe introduce a "ci"
>      group instead later where this test here won't get added (since it
>      currently does not work with accel=qtest)

Thanks, applied to the block branch.

I think the real solution would be to do some debugging and make the
test work even with qtest. But for 4.0, your patch is fine.

Kevin
