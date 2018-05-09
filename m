Received: from eggs.gnu.org ([2001:4830:134:3::10]:37778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGDMP-0005zE-0E
	for qemu-devel@nongnu.org; Tue, 08 May 2018 20:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGDMO-0003pA-9T
	for qemu-devel@nongnu.org; Tue, 08 May 2018 20:53:37 -0400
References: <20180508233659.13973-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9dc2a88a-3794-f106-2693-1142f54f442a@redhat.com>
Date: Tue, 8 May 2018 19:53:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180508233659.13973-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] blockjob: expose error string via query
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

On 05/08/2018 06:36 PM, John Snow wrote:
> When we've reached the concluded state, we need to expose the error
> state if applicable. Add the new field.
> 
> This should be sufficient for determining if a job completed
> successfully or not after concluding; if we want to discriminate
> based on how it failed more mechanically, we can always add an
> explicit return code enumeration later.
> 
> I didn't bother to make it only show up if we are in the concluded
> state; I don't think it's necessary.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockjob.c           | 2 ++
>   qapi/block-core.json | 6 +++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 

> +++ b/qapi/block-core.json
> @@ -1172,6 +1172,9 @@
>   # @auto-dismiss: Job will dismiss itself when CONCLUDED, moving to the NULL
>   #                state and disappearing from the query list. (since 2.12)
>   #
> +# @error: Error information if the job did not complete successfully.
> +#         Not set if the job completed successfully. (since 2.12.1)
> +#
>   # Since: 1.1
>   ##
>   { 'struct': 'BlockJobInfo',
> @@ -1179,7 +1182,8 @@
>              'offset': 'int', 'busy': 'bool', 'paused': 'bool', 'speed': 'int',
>              'io-status': 'BlockDeviceIoStatus', 'ready': 'bool',
>              'status': 'BlockJobStatus',
> -           'auto-finalize': 'bool', 'auto-dismiss': 'bool' } }
> +           'auto-finalize': 'bool', 'auto-dismiss': 'bool',
> +           '*error': 'str' } }

Yep, definitely material for the stable branch.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
