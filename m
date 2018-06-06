Received: from eggs.gnu.org ([2001:4830:134:3::10]:42930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQe9N-00087D-9b
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQe9M-0004j5-Bn
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:31:17 -0400
References: <20180606190628.8170-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c14d67c-227b-25c6-aa49-a2847e8e9048@redhat.com>
Date: Wed, 6 Jun 2018 14:31:08 -0500
MIME-Version: 1.0
In-Reply-To: <20180606190628.8170-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] iotests: Fix 219's timing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 06/06/2018 02:06 PM, Max Reitz wrote:
> 219 has two issues that may lead to sporadic failure, both of which are
> the result of issuing query-jobs too early after a job has been
> modified.  This can then lead to different results based on whether the
> modification has taken effect already or not.
> 
> First, query-jobs is issued right after the job has been created.
> Besides its current progress possibly being in any random state (which
> has already been taken care of), its total progress too is basically
> arbitrary, because the job may not yet have been able to determine it.
> This patch addresses this by just filtering the total progress, like
> what has been done for the current progress already.  However, for more
> clarity, the filtering is changed to replace the values by a string
> 'FILTERED' instead of deleting them.
> 
> Secondly, query-jobs is issued right after a job has been resumed.  The
> job may or may not yet have had the time to actually perform any I/O,
> and thus its current progress may or may not have advanced.  To make
> sure it has indeed advanced (which is what the reference output already
> assumes), keep querying it until it has.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
