Received: from eggs.gnu.org ([2001:4830:134:3::10]:51615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fB3E1-0006OM-RI
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fB3E1-0001XW-44
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:03:37 -0400
References: <20180424085240.5798-1-stefanha@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <11a50e7b-4bfe-2c90-37b4-de25b58d09a1@redhat.com>
Date: Tue, 24 Apr 2018 15:03:20 -0400
MIME-Version: 1.0
In-Reply-To: <20180424085240.5798-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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



On 04/24/2018 04:52 AM, Stefan Hajnoczi wrote:
> Commit 8119334918e86f45877cfc139192d54f2449a239 ("block: Don't
> block_job_pause_all() in bdrv_drain_all()") removed the only callers of
> block_job_pause/resume_all().
> 
> Pausing and resuming now happens in child_job_drained_begin/end() so
> it's no longer necessary to globally pause/resume jobs.
> 

neat!

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
