Received: from eggs.gnu.org ([2001:4830:134:3::10]:43907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlfZ-0007W1-Ev
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlfY-0007ap-FW
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:16:13 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-20-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2c7f82a8-8b19-4f2d-b6d5-3c77258edf91@redhat.com>
Date: Tue, 27 Feb 2018 14:16:05 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-20-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 19/21] blockjobs: Expose manual property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/23/2018 05:51 PM, John Snow wrote:
> Expose the "manual" property via QAPI for the backup-related jobs.
> As of this commit, this allows the management API to request the
> "concluded" and "dismiss" semantics for backup jobs.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockdev.c           | 19 ++++++++++++++++---
>   qapi/block-core.json | 32 ++++++++++++++++++++++++++------
>   2 files changed, 42 insertions(+), 9 deletions(-)
> 

> +++ b/qapi/block-core.json
> @@ -1177,6 +1177,16 @@
>   # @job-id: identifier for the newly-created block job. If
>   #          omitted, the device name will be used. (Since 2.7)
>   #
> +# @manual: True to use an expanded, more explicit job control flow.
> +#          Jobs may transition from a running state to a pending state,
> +#          where they must be instructed to complete manually via
> +#          block-job-finalize.
> +#          Jobs belonging to a transaction must either all or all not use this
> +#          setting. Once a transaction reaches a pending state, issuing the
> +#          finalize command to any one job in the transaction is sufficient
> +#          to finalize the entire transaction.

The previous commit message talked about mixed-manual transactions, but 
this seems to imply it is not possible.  I'm fine if we don't support 
mixed-manual transactions, but wonder if it means any changes to the series.

Otherwise looks reasonable from the UI point of view.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
