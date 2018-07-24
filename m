Received: from eggs.gnu.org ([2001:4830:134:3::10]:38670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fi4l7-0007pY-Ow
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 17:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fi4l6-0001FQ-QS
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 17:22:17 -0400
References: <20180724200343.13733-1-lbloch@janustech.com>
	<20180724200343.13733-6-lbloch@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <321072a8-b2fa-2b2a-b985-b2ada3f2b877@redhat.com>
Date: Tue, 24 Jul 2018 16:22:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180724200343.13733-6-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] docs: Document the l2-cache-full
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 07/24/2018 03:03 PM, Leonid Bloch wrote:
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>   docs/qcow2-cache.txt | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)

I'd probably squash this with 3/5 introducing the option.

> 
> diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
> index 9d261b7da9..ea61585a4b 100644
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
> @@ -130,6 +131,12 @@ There are a few things that need to be taken into account:
>      memory as possible to the L2 cache before increasing the refcount
>      cache size.
>   
> +- If "l2-cache-full" is specified, QEMU will assign enough memory
> +  to the L2 cache to cover the entire size of the image.
> +
> +- "l2-cache-size" and "l2-cache-full" can not be set simultaneously, as
> +  setting "l2-cache-full" already implies a specific size for the L2 cache.
> +
>   - All three "l2-cache-size", "refcount-cache-size", and "cache-size" options
>     can not be set simultaneously.
>   

Might be a rebase conflict here once you polish the wording in 2/5.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
