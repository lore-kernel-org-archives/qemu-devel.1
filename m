Received: from eggs.gnu.org ([2001:4830:134:3::10]:40376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGSv2-00005A-7m
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGSv1-0007YY-GG
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:30:24 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-8-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <540b21a8-d32b-f10e-62f1-b52b3f123ac2@redhat.com>
Date: Wed, 9 May 2018 12:30:16 -0500
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/42] blockjob: Remove
 block_job_pause/resume_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On 05/09/2018 11:26 AM, Kevin Wolf wrote:
> Commit 81193349 removed the only use of block_job_pause/resume_all(),
> which was in bdrv_drain_all(). The functions are now unused and can be
> removed.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/block/blockjob_int.h | 14 --------------
>   blockjob.c                   | 27 ---------------------------
>   2 files changed, 41 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
