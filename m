Received: from eggs.gnu.org ([2001:4830:134:3::10]:40924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fBKR2-0004tv-Db
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fBKQz-0001sf-Ak
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:26:12 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180424085240.5798-1-stefanha@redhat.com>
References: <20180424085240.5798-1-stefanha@redhat.com>
Date: Wed, 25 Apr 2018 15:26:07 +0200
Message-ID: <w51zi1rquxc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockjob: drop
 block_job_pause/resume_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 24 Apr 2018 10:52:40 AM CEST, Stefan Hajnoczi wrote:
> Commit 8119334918e86f45877cfc139192d54f2449a239 ("block: Don't
> block_job_pause_all() in bdrv_drain_all()") removed the only callers of
> block_job_pause/resume_all().
>
> Pausing and resuming now happens in child_job_drained_begin/end() so
> it's no longer necessary to globally pause/resume jobs.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
