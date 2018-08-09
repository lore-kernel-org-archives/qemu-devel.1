Received: from eggs.gnu.org ([2001:4830:134:3::10]:59091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnhJk-0001lr-PU
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 05:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnhJg-0007eB-HF
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 05:33:16 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180808221138.5770-5-lbloch@janustech.com>
References: <20180808221138.5770-1-lbloch@janustech.com>
	<20180808221138.5770-5-lbloch@janustech.com>
Date: Thu, 09 Aug 2018 11:33:06 +0200
Message-ID: <w51woszc2b1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 4/5] qcow2: Set the default
 cache-clean-interval to 10 minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu 09 Aug 2018 12:11:37 AM CEST, Leonid Bloch wrote:
> The default cache-clean-interval is set to 10 minutes, in order to lower
> the overhead of the qcow2 caches (before the default was 0, i.e.
> disabled).
>
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>

> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2830,7 +2830,8 @@
>  #
>  # @cache-clean-interval:  clean unused entries in the L2 and refcount
>  #                         caches. The interval is in seconds. The default value
> -#                         is 0 and it disables this feature (since 2.5)
> +#                         is 600. Setting 0 disables this feature. (since 2.5)
> +#

It should be "Setting it to 0 ...".

With that corrected,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
