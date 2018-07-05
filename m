Received: from eggs.gnu.org ([2001:4830:134:3::10]:55849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb6ma-0002gr-6S
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb6mZ-0001is-8i
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:07:00 -0400
References: <20180705102604.4986-1-kwolf@redhat.com>
	<20180705102604.4986-10-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <baf76d34-88bf-5ac6-cce0-b63a15e0bbe5@redhat.com>
Date: Thu, 5 Jul 2018 11:06:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180705102604.4986-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 09/12] block/blklogwrites: Add an option
 for appending to an old log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Ari Sundholm <ari@tuxera.com>

On 07/05/2018 05:26 AM, Kevin Wolf wrote:
> From: Ari Sundholm <ari@tuxera.com>
> 
> Suggested by Kevin Wolf. May be useful when testing multiple batches
> of writes or doing long-term testing involving restarts of the VM.
> 
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json |   3 +-
>   block/blklogwrites.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 135 insertions(+), 15 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index a9eab8cab8..d1753a2ae7 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3062,7 +3062,8 @@
>   { 'struct': 'BlockdevOptionsBlklogwrites',
>     'data': { 'file': 'BlockdevRef',
>               'log': 'BlockdevRef',
> -            '*log-sector-size': 'uint32' } }
> +            '*log-sector-size': 'uint32',
> +            '*log-append': 'bool' } }

Missing documentation (including the default value) of the new member. 
Since this is already pulled, please submit a followup patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
