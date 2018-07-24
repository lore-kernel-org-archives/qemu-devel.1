Received: from eggs.gnu.org ([2001:4830:134:3::10]:41353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhz8Q-0002dq-Nn
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhz8P-0007rv-JB
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:21:58 -0400
References: <20180724121753.5753-1-lbloch@janustech.com>
	<20180724121753.5753-4-lbloch@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b2636b3-6871-c68a-f103-0f2f150d3e7e@redhat.com>
Date: Tue, 24 Jul 2018 10:21:50 -0500
MIME-Version: 1.0
In-Reply-To: <20180724121753.5753-4-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] docs: Document the l2-cache-full option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 07/24/2018 07:17 AM, Leonid Bloch wrote:
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>   docs/qcow2-cache.txt | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
> index a0a1267482..43c0faaddb 100644
> --- a/docs/qcow2-cache.txt
> +++ b/docs/qcow2-cache.txt
> @@ -110,11 +110,12 @@ How to configure the cache sizes
>   Cache sizes can be configured using the -drive option in the
>   command-line, or the 'blockdev-add' QMP command.
>   
> -There are three options available, and all of them take bytes:
> +There are four options available:
>   
> -"l2-cache-size":         maximum size of the L2 table cache
> -"refcount-cache-size":   maximum size of the refcount block cache
> -"cache-size":            maximum size of both caches combined
> +"l2-cache-size":         maximum size of the L2 table cache (bytes, K, M)
> +"refcount-cache-size":   maximum size of the refcount block cache (bytes, K, M)
> +"cache-size":            maximum size of both caches combined (bytes, K, M)
> +"l2-cache-full":         make the L2 cache cover the full image (boolean)
>   
>   There are a few things that need to be taken into account:
>   

Worth mentioning that the first three can be combined (although usually 
you'll never specify more than 2; as specifying all 3 requires that you 
perform the correct addition), but that the third is mutually exclusive?

> @@ -130,6 +131,9 @@ There are a few things that need to be taken into account:
>      memory as possible to the L2 cache before increasing the refcount
>      cache size.
>   
> +- If "l2-cache-full" is specified, QEMU will assign enough memory
> +  to the L2 cache to cover the entire size of the image.
> +
>   Unlike L2 tables, refcount blocks are not used during normal I/O but
>   only during allocations and internal snapshots. In most cases they are
>   accessed sequentially (even during random guest I/O) so increasing the
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
