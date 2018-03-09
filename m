Received: from eggs.gnu.org ([2001:4830:134:3::10]:46252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOR4-0007t9-CR
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOR3-0002Z3-HO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:16:14 -0500
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bfa97e2b-6a2a-eadc-d48d-e36ad9bc8985@redhat.com>
Date: Fri, 9 Mar 2018 14:15:58 -0600
MIME-Version: 1.0
In-Reply-To: <20180309172713.26318-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] luks: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

On 03/09/2018 11:27 AM, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to luks, which enables
> image creation over QMP.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json | 17 ++++++++++++++++-
>   block/crypto.c       | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 524d51567a..07039bfe9c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3452,6 +3452,21 @@
>               '*preallocation':   'PreallocMode' } }
>   
>   ##
> +# @BlockdevCreateOptionsLUKS:
> +#
> +# Driver specific image creation options for LUKS.
> +#
> +# @file             Node to create the image format on
> +# @size             Size of the virtual disk in bytes
> +#
> +# Since: 2.12

Well, as long as we make it by Tuesday :)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
