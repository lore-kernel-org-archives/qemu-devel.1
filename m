Received: from eggs.gnu.org ([2001:4830:134:3::10]:46699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ0zn-00055y-RS
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ0zn-0008Ci-4v
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:17:51 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-15-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ecc2431e-ee7d-13b7-319e-e69d499330f8@redhat.com>
Date: Wed, 16 May 2018 13:17:45 -0500
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-15-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: mreitz@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On 05/09/2018 11:26 AM, Kevin Wolf wrote:
> This moves reference counting from BlockJob to Job.
> 
> In order to keep calling the BlockJob cleanup code when the job is
> deleted via job_unref(), introduce a new JobDriver.free callback. Every
> block job must use block_job_free() for this callback, this is asserted
> in block_job_create().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/job.c

> +
> +void job_unref(Job *job)
> +{
> +    if (--job->refcnt == 0) {

Should this be free()-like and allow an incoming job == NULL as a no-op?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
