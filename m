Received: from eggs.gnu.org ([2001:4830:134:3::10]:45930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g6zIG-0007Jr-Uj
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g6zIF-00041d-Sp
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:35:28 -0400
References: <20180929095454.32066-1-lbloch@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd15dbb9-6aaa-ab5a-9105-8cf49e76cc27@redhat.com>
Date: Mon, 1 Oct 2018 09:35:10 -0500
MIME-Version: 1.0
In-Reply-To: <20180929095454.32066-1-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix cache-clean-interval
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

On 9/29/18 4:54 AM, Leonid Bloch wrote:
> Fixing cache-clean-interval documentation following the recent change to
> a default of 600 seconds on supported plarforms (only Linux currently).
> 
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>   docs/qcow2-cache.txt | 19 +++++++++----------
>   qapi/block-core.json |  3 ++-
>   qemu-options.hx      |  3 ++-
>   3 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
> index 59358b816f..1778312e09 100644
> --- a/docs/qcow2-cache.txt
> +++ b/docs/qcow2-cache.txt
> @@ -202,18 +202,17 @@ Reducing the memory usage
>   It is possible to clean unused cache entries in order to reduce the
>   memory usage during periods of low I/O activity.
>   
> -The parameter "cache-clean-interval" defines an interval (in seconds).
> -All cache entries that haven't been accessed during that interval are
> -removed from memory.
> +The parameter "cache-clean-interval" defines an interval (in seconds),
> +affer which all the cache entries that haven't been accessed during it

s/affer/after/

Maybe s/during it/during the interval/


> +are removed from memory. Setting this parameter to 0 disables this feature.
>   
> -This example removes all unused cache entries every 15 minutes:
> +The following example removes all unused cache entries every 15 minutes:
>   
>      -drive file=hd.qcow2,cache-clean-interval=900
>   
> -If unset, the default value for this parameter is 600. Setting it to 0
> -disables this feature.
> +If unset, the default value for this parameter is 600 on platforms which
> +support this functionality, and is 0 (disabled) on other platforms.
>   
> -Note that this functionality currently relies on the MADV_DONTNEED
> -argument for madvise() to actually free the memory. This is a
> -Linux-specific feature, so cache-clean-interval is not supported in
> -other systems.
> +This functionality currently relies on the MADV_DONTNEED argument for
> +madvise() to actually free the memory. This is a Linux-specific feature,
> +so cache-clean-interval is not supported on other systems.

Otherwise looks good.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
