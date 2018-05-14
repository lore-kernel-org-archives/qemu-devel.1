Received: from eggs.gnu.org ([2001:4830:134:3::10]:45733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIL6w-0007Bz-Gu
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIL6v-0007LL-PA
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:34:26 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-15-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <88a073ed-4dce-f102-0a93-4810abdcf01b@redhat.com>
Date: Mon, 14 May 2018 17:34:21 -0400
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-15-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/42] job: Add reference counting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 05/09/2018 12:26 PM, Kevin Wolf wrote:
> This moves reference counting from BlockJob to Job.
> 
> In order to keep calling the BlockJob cleanup code when the job is
> deleted via job_unref(), introduce a new JobDriver.free callback. Every
> block job must use block_job_free() for this callback, this is asserted
> in block_job_create().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

So far so good, though it does look a little silly that presently every
last job has the exact same free callback.

Also, I forgot to reply to #13 with this, but I suppose that the
approach you're taking -- of a fairly straightforward mechanical
refactor -- means we don't really have the opportunity to change any of
the pretty dumb names or existing peculiarities of design we've evolved.

I had hoped we'd be able to change a few things, but certainly keeping
them as-is makes the whole re-factoring process an awful lot simpler...

...Or maybe I'm getting ahead of myself, there's a lot of series left to go.

Ah, anyway:

Reviewed-by: John Snow <jsnow@redhat.com>
