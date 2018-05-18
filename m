Received: from eggs.gnu.org ([2001:4830:134:3::10]:43299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJjb9-0003zy-NE
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJjb8-0007Vw-M2
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:55:23 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-36-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c2263684-d5fa-4eb5-6bc9-2b7c816e9321@redhat.com>
Date: Fri, 18 May 2018 12:55:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-36-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 35/40] job: Add JOB_STATUS_CHANGE QMP
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

On 05/18/2018 08:21 AM, Kevin Wolf wrote:
> This adds a QMP event that is emitted whenever a job transitions from
> one status to another.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/job.json                 |  14 ++++
>   job.c                         |  10 +++

> @@ -157,6 +158,11 @@ static int job_txn_apply(JobTxn *txn, int fn(Job *), bool lock)
>       return rc;
>   }
>   
> +static bool job_is_internal(Job *job)
> +{
> +    return (job->id == NULL);

The () are not necessary.  In fact, you could use !!job->id for less 
typing, or even rely on the compiler to auto-convert a pointer into bool 
by just 'return job->id' (although the latter feels a bit too terse to me).

Style is minor, so
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
