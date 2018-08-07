Received: from eggs.gnu.org ([2001:4830:134:3::10]:55034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fn8gM-0006EL-1J
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 16:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fn8gL-0001tX-0E
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 16:34:18 -0400
References: <20180807202122.27006-1-lbloch@janustech.com>
	<20180807202122.27006-5-lbloch@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2d31c265-e84a-58d2-506e-a8aae8343d1b@redhat.com>
Date: Tue, 7 Aug 2018 15:34:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180807202122.27006-5-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] qcow2: Set the default
 cache-clean-interval to 30 seconds
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

On 08/07/2018 03:21 PM, Leonid Bloch wrote:
> The default cache-clean-interval is set to 30 seconds, in order to lower
> the overhead of the qcow2 caches.
> 
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---

> +++ b/qapi/block-core.json
> @@ -2830,7 +2830,8 @@
>   #
>   # @cache-clean-interval:  clean unused entries in the L2 and refcount
>   #                         caches. The interval is in seconds. The default value
> -#                         is 0 and it disables this feature (since 2.5)
> +#                         is 30. (since 2.5)
> +#
>   # @encrypt:               Image decryption options. Mandatory for
>   #                         encrypted images, except when doing a metadata-only
>   #                         probe of the image. (since 2.10)
> diff --git a/qemu-options.hx b/qemu-options.hx
> index d6e15b2f06..0cda3d3c3a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -767,7 +767,7 @@ it which is not used for the L2 cache)
>   
>   @item cache-clean-interval
>   Clean unused entries in the L2 and refcount caches. The interval is in seconds.
> -The default value is 0 and it disables this feature.
> +The default value is 30.

May be worth wording as:

The default value is 30, while setting it to 0 disables this feature.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
