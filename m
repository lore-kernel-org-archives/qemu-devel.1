Received: from eggs.gnu.org ([2001:4830:134:3::10]:41465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG3bM-0005y4-6v
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG3bL-0005OE-BC
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:28:24 -0400
References: <20180508135436.30140-1-stefanha@redhat.com>
	<20180508135436.30140-3-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64ac20a9-00ad-722e-9682-2428743123ba@redhat.com>
Date: Tue, 8 May 2018 09:28:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180508135436.30140-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] blockjob: do not cancel timer in
 resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>

On 05/08/2018 08:54 AM, Stefan Hajnoczi wrote:
> Currently the timer is cancelled and the block job is entered by
> block_job_resume().  This behavior causes drain to run extra blockjob
> iterations when the job was sleeping due to the ratelimit.
> 
> This patch leaves the job asleep when block_job_resume() is called.
> Jobs can still be forcibly woken up using block_job_enter(), which is
> used to cancel jobs.
> 
> After this patch drain no longer runs extra blockjob iterations.  This
> is the expected behavior that qemu-iotests 185 used to rely on.  We
> temporarily changed the 185 test output to make it pass for the QEMU
> 2.12 release but now it's time to address this issue.
> 
> Cc: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   blockjob.c                 | 22 +++++++++++++++-------
>   tests/qemu-iotests/185     |  5 +----
>   tests/qemu-iotests/185.out | 12 +++++-------
>   3 files changed, 21 insertions(+), 18 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
