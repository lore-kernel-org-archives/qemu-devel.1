Received: from eggs.gnu.org ([2001:4830:134:3::10]:46917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJju2-0005eu-QL
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJju1-0008Bf-SZ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:14:54 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-38-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a49c1a09-dea4-8490-6d24-1c0b43910144@redhat.com>
Date: Fri, 18 May 2018 13:14:48 -0500
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

> +#
> +# @current-progress:    Progress made until now. The unit is arbitrary and the
> +#                       value can only meaningfully be used for the ratio of
> +#                       @offset to @len. The value is monotonically increasing.

s/@offset to @len/@current-progress to @total-progress/

> +#
> +# @total-progress:      Estimated @offset value at the completion of the job.

s/@offset/@current-progress/

> +#                       This value can arbitrarily change while the job is
> +#                       running, in both directions.
> +#
> +# @error:               If this field is present, the job failed; if it is
> +#                       still missing in the CONCLUDED state, this indicates
> +#                       successful completion.
> +#
> +#                       The value is a human-readable error message to describe
> +#                       the reason for the job failure. It should not be parsed
> +#                       by applications.
> +#
> +# Since: 2.13
> +##
> +{ 'struct': 'JobInfo',
> +  'data': { 'id': 'str', 'type': 'JobType', 'status': 'JobStatus',
> +            'current-progress': 'int', 'total-progress': 'int',
> +            '*error': 'str' } }
> +
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
