Received: from eggs.gnu.org ([2001:4830:134:3::10]:36250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fcQHC-0004So-NC
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fcQHB-0003mb-Mu
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:08:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37562 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fcQHB-0003mN-In
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:08:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1530879678-20487-1-git-send-email-ari@tuxera.com>
Date: Mon, 09 Jul 2018 09:07:59 +0200
In-Reply-To: <1530879678-20487-1-git-send-email-ari@tuxera.com> (Ari
	Sundholm's message of "Fri, 6 Jul 2018 15:21:18 +0300")
Message-ID: <87lgakopio.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qapi/block-core.json: Add missing
 documentation for blklogwrites log-append option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>
Cc: qemu-devel@nongnu.org

Ari Sundholm <ari@tuxera.com> writes:

> This was accidentally omitted. Thanks to Eric Blake for spotting this.
>
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> ---
>  qapi/block-core.json | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 38b3125..62a92fa 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3057,6 +3057,8 @@
>  # @log-sector-size: sector size used in logging writes to @file, determines
>  #                   granularity of offsets and sizes of writes (default: 512)
>  #
> +# @log-append:      append to an existing log (default: false)
> +#
>  # @log-super-update-interval: interval of write requests after which the log
>  #                             super block is updated to disk (default: 4096)
>  #

Applied to qapi-next.  Thanks!
