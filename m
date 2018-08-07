Received: from eggs.gnu.org ([2001:4830:134:3::10]:38517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <coli@redhat.com>) id 1fmrte-00029B-PP
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 22:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <coli@redhat.com>) id 1fmrte-0002Gz-05
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 22:38:54 -0400
Date: Mon, 6 Aug 2018 22:38:45 -0400 (EDT)
From: Cong Li <coli@redhat.com>
Message-ID: <199002085.38975596.1533609525821.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180806123728.13658-1-kwolf@redhat.com>
References: <20180806123728.13658-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


----- Original Message -----
> From: "Kevin Wolf" <kwolf@redhat.com>
> To: qemu-block@nongnu.org
> Cc: kwolf@redhat.com, coli@redhat.com, qemu-devel@nongnu.org
> Sent: Monday, August 6, 2018 8:37:28 PM
> Subject: [PATCH] qapi/block: Document restrictions for node names
> 
> blockdev-add fails if an invalid node name is given, so we should
> document what a valid node name even is.
> 
> Reported-by: Cong Li <coli@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Cong Li <coli@redhat.com>

> ---
>  qapi/block-core.json | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 62a92fa4f4..fe565ebfaf 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3563,6 +3563,9 @@
>  # @driver:        block driver name
>  # @node-name:     the node name of the new node (Since 2.0).
>  #                 This option is required on the top level of blockdev-add.
> +#                 Valid node names start with an alphabetic character and
> may
> +#                 contain only alphanumeric characters, '-', '.' and '_'.
> Their
> +#                 maximum length is 31 characters.
>  # @discard:       discard-related options (default: ignore)
>  # @cache:         cache-related options
>  # @read-only:     whether the block device should be read-only (default:
>  false).
> --
> 2.13.6
> 
> 
