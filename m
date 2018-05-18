Received: from eggs.gnu.org ([2001:4830:134:3::10]:48415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJk17-0001K4-OK
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJk16-0002zf-TM
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:22:13 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-38-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <34f3b470-614b-d836-c8ca-c6d4b81ecc1d@redhat.com>
Date: Fri, 18 May 2018 13:22:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-38-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 37/40] job: Add query-jobs QMP command
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
> This adds a minimal query-jobs implementation that shouldn't pose many
> design questions. It can later be extended to expose more information,
> and especially job-specific information.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/job.json      | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   include/qemu/job.h |  3 +++
>   job-qmp.c          | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   job.c              |  2 +-
>   4 files changed, 103 insertions(+), 1 deletion(-)
> 

> +##
> +# @JobInfo:
> +#
> +# Information about a job.
> +#
> +# @id:                  The job identifier

> +##
> +{ 'struct': 'JobInfo',
> +  'data': { 'id': 'str', 'type': 'JobType', 'status': 'JobStatus',
> +            'current-progress': 'int', 'total-progress': 'int',
> +            '*error': 'str' } }

Is it worth exposing whether a job is auto-finalize and auto-complete? 
Goes back to the issue of whether clients of the new job API would ever 
want/need to rely on the auto- features; while clients of the old 
blockjob API that get the auto- features by default will never be 
calling the new query-jobs command.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
