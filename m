Received: from eggs.gnu.org ([2001:4830:134:3::10]:34556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ24j-0006Yi-2m
	for qemu-devel@nongnu.org; Wed, 16 May 2018 15:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ24i-0006XW-5C
	for qemu-devel@nongnu.org; Wed, 16 May 2018 15:27:01 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-39-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b50aa3d-24eb-53cd-bc0b-14165ae73784@redhat.com>
Date: Wed, 16 May 2018 14:26:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-39-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 38/42] job: Add JOB_STATUS_CHANGE QMP event
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
> This adds a QMP event that is emitted whenever a job transitions from
> one status to another. For the event, a new qapi/job.json schema file is
> created which will contain all job-related definitions that aren't tied
> to the block layer.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/qapi/job.json

> +##
> +# @JOB_STATUS_CHANGE:
> +#
> +# Emitted when a job transitions to a different status.
> +#
> +# @id: The job identifier
> +# @status: The new job status
> +#
> +# Since: 2.13
> +##
> +{ 'event': 'JOB_STATUS_CHANGE',
> +  'data': { 'id': 'str',
> +            'status': 'JobStatus' } }

Is it worth also trying to list the old state that the transition came 
from? But that's new compared to what block jobs are currently doing, so 
if we can't come up with a strong reason to add that, I'm okay.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
