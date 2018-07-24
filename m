Received: from eggs.gnu.org ([2001:4830:134:3::10]:40728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhz7D-0001rz-0z
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhz7C-00071S-3v
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:20:42 -0400
References: <20180724121753.5753-1-lbloch@janustech.com>
	<20180724121753.5753-3-lbloch@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f31f05de-08a5-b756-0e41-70bcd1812c58@redhat.com>
Date: Tue, 24 Jul 2018 10:20:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180724121753.5753-3-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] docs: Fix an inaccuracy due to recent
 changes
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
>   docs/qcow2-cache.txt | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
> index 8a09a5cc5f..a0a1267482 100644
> --- a/docs/qcow2-cache.txt
> +++ b/docs/qcow2-cache.txt
> @@ -97,9 +97,9 @@ need:
>      l2_cache_size = disk_size_GB * 131072
>      refcount_cache_size = disk_size_GB * 32768
>   
> -QEMU has a default L2 cache of 1MB (1048576 bytes) and a refcount
> -cache of 256KB (262144 bytes), so using the formulas we've just seen
> -we have
> +QEMU has a default L2 cache of 1MB (1048576 bytes) or 8 clusters (whichever
> +is larger) and a refcount cache of 256KB (262144 bytes), so using the

Looks suspicious; isn't the refcount cache size also dependent on the 
cluster size?

> +formulas we've just seen we have (assuming the L2 cache is 1MB):
>   
>      1048576 / 131072 = 8 GB of virtual disk covered by that cache
>       262144 /  32768 = 8 GB
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
