Received: from eggs.gnu.org ([2001:4830:134:3::10]:35729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIcb2-00007d-EZ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIcb1-0004Bj-Et
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:10:08 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIcb1-0004As-8M
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:10:07 -0400
Received: by mail-wm0-x22e.google.com with SMTP id x70so60035199wme.0
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:10:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170607095926.1834-1-quintela@redhat.com>
References: <20170607095926.1834-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 16:09:45 +0100
Message-ID: <CAFEAcA8PB57rS2at+mXgV100r5JEieDvCJsLAP=RxY3ggNKmMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Migration PULL requset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 7 June 2017 at 10:59, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> This is the migration pull requset, it contains:
> - fix for segfault of io tests (QingFeng)
> - half of make consistent output
> - Make RAMState dynamic.
>
> Please, apply.
>
> Thanks, Juan.
>
> The following changes since commit 65dfad62a176f5265f801683be64149c5ad55f7d:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20170606-xtensa' into staging (2017-06-06 17:00:12 +0100)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20170607
>
> for you to fetch changes up to eefff991d059d299b917627d2a95bce34d2f97f3:
>
>   qemu/migration: fix the double free problem on from_src_file (2017-06-07 10:20:56 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20170607
>
> ----------------------------------------------------------------
> Juan Quintela (6):
>       ram: Unfold get_xbzrle_cache_stats() into populate_ram_info()
>       ram: We only print throttling information sometimes
>       ram: Call migration_page_queue_free() at ram_migration_cleanup()
>       ram: Move ZERO_TARGET_PAGE inside XBZRLE
>       ram: Use MigrationStats for statistics
>       ram: Make RAMState dynamic
>
> QingFeng Hao (1):
>       qemu/migration: fix the double free problem on from_src_file
>
>  migration/migration.c |  59 ++++++-------
>  migration/ram.c       | 233 +++++++++++++++++++-------------------------------
>  migration/ram.h       |  15 +---
>  migration/savevm.c    |   1 -
>  4 files changed, 114 insertions(+), 194 deletions(-)

Applied, thanks.

-- PMM
