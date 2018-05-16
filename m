Received: from eggs.gnu.org ([2001:4830:134:3::10]:35903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ0d8-0004J2-5R
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ0d7-0003Bh-Fd
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:54:26 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-12-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f870bd47-1d1e-4a83-8250-ff68b42607e4@redhat.com>
Date: Wed, 16 May 2018 12:54:15 -0500
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-12-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/42] job: Add job_delete()
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
> This moves freeing the Job object and its fields from block_job_unref()
> to job_delete().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/qemu/job.h | 3 +++
>   blockjob.c         | 3 +--
>   job.c              | 6 ++++++
>   3 files changed, 10 insertions(+), 2 deletions(-)
> 

> +
> +void job_delete(Job *job)
> +{
> +    g_free(job->id);
> +    g_free(job);
> +}

Should this be free-like, acting as a no-op when job == NULL on input?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
