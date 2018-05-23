Received: from eggs.gnu.org ([2001:4830:134:3::10]:54697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLZmL-0004jz-01
	for qemu-devel@nongnu.org; Wed, 23 May 2018 15:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLZmK-0005mb-7N
	for qemu-devel@nongnu.org; Wed, 23 May 2018 15:50:33 -0400
References: <20180523131155.12359-1-kwolf@redhat.com>
	<20180523131155.12359-42-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dafb7549-5426-4923-5332-228cad6b3cc9@redhat.com>
Date: Wed, 23 May 2018 14:50:20 -0500
MIME-Version: 1.0
In-Reply-To: <20180523131155.12359-42-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 41/46] job: Add JOB_STATUS_CHANGE QMP event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

On 05/23/2018 08:11 AM, Kevin Wolf wrote:
> This adds a QMP event that is emitted whenever a job transitions from
> one status to another.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---

> +
> +##
> +# @JOB_STATUS_CHANGE:
> +#
> +# Emitted when a job transitions to a different status.
> +#
> +# @id: The job identifier
> +# @status: The new job status
> +#
> +# Since: 2.13

We'll probably have a few straggler commits like this that interleave 
with Peter's patches to renumber things to 3.0; let's make sure we don't 
forget to clean everything up before the release.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
