Received: from eggs.gnu.org ([2001:4830:134:3::10]:60713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fmgM4-0008VK-J5
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fmgM3-00043L-NB
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:19:28 -0400
References: <20180806123728.13658-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cdc871bd-f8c4-0102-2d5c-ca1443ff1684@redhat.com>
Date: Mon, 6 Aug 2018 09:19:15 -0500
MIME-Version: 1.0
In-Reply-To: <20180806123728.13658-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qapi/block: Document restrictions for node
 names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: coli@redhat.com, qemu-devel@nongnu.org

On 08/06/2018 07:37 AM, Kevin Wolf wrote:
> blockdev-add fails if an invalid node name is given, so we should
> document what a valid node name even is.
> 
> Reported-by: Cong Li <coli@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 62a92fa4f4..fe565ebfaf 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3563,6 +3563,9 @@
>   # @driver:        block driver name
>   # @node-name:     the node name of the new node (Since 2.0).
>   #                 This option is required on the top level of blockdev-add.
> +#                 Valid node names start with an alphabetic character and may
> +#                 contain only alphanumeric characters, '-', '.' and '_'. Their
> +#                 maximum length is 31 characters.
>   # @discard:       discard-related options (default: ignore)
>   # @cache:         cache-related options
>   # @read-only:     whether the block device should be read-only (default: false).
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
