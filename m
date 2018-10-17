Received: from eggs.gnu.org ([2001:4830:134:3::10]:57063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCqoc-0003Mo-S2
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCqoc-0003W3-0H
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:45:06 -0400
References: <20181017164200.22344-1-kwolf@redhat.com>
	<20181017164200.22344-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3c1544d3-ef6a-efba-312c-93f1061b753a@redhat.com>
Date: Wed, 17 Oct 2018 13:44:52 -0500
MIME-Version: 1.0
In-Reply-To: <20181017164200.22344-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/9] block: Add auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On 10/17/18 11:41 AM, Kevin Wolf wrote:
> If a management application builds the block graph node by node, the
> protocol layer doesn't inherit its read-only option from the format
> layer any more, so it must be set explicitly.
> 

> The documentation for this option is consciously phrased in a way that
> allows QEMU to switch to a better model eventually: Instead of trying
> when the image is first opened, making the read-only flag dynamic and
> changing it automatically whenever the first BLK_PERM_WRITE user is
> attached or the last one is detached would be much more useful
> behaviour.
> 

> +++ b/qapi/block-core.json
> @@ -3651,6 +3651,12 @@
>   #                 either generally or in certain configurations. In this case,
>   #                 the default value does not work and the option must be
>   #                 specified explicitly.
> +# @auto-read-only: if true and @read-only is false, QEMU may automatically
> +#                  decide not to open the image read-write as requested, but
> +#                  fall back to read-only instead (and switch between the modes
> +#                  later), e.g. depending on whether the image file is writable
> +#                  or whether a writing user is attached to the node
> +#                  (default: false, since 3.1)

Definitely better wording compared to v2.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
