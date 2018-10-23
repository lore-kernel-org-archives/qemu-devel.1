Received: from eggs.gnu.org ([2001:4830:134:3::10]:34101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gEs3w-0001O6-7b
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gEs3s-0007ij-Vy
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:29:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gEs3s-0007hu-OH
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:29:12 -0400
Date: Tue, 23 Oct 2018 09:29:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181023082905.GA16408@work-vm>
References: <20181022164118.5502-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022164118.5502-1-zhangckid@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] qapi: Fix COLOStatus and query-colo-status
 since version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Zhang Chen (zhangckid@gmail.com) wrote:
> This structure and command have missed qemu version 3.0, so fix it to since version 3.1.
> 
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  qapi/migration.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 0928f4b727..38d4c41d88 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1317,7 +1317,7 @@
>  #
>  # @reason: describes the reason for the COLO exit.
>  #
> -# Since: 3.0
> +# Since: 3.1
>  ##
>  { 'struct': 'COLOStatus',
>    'data': { 'mode': 'COLOMode', 'reason': 'COLOExitReason' } }
> @@ -1334,7 +1334,7 @@
>  # -> { "execute": "query-colo-status" }
>  # <- { "return": { "mode": "primary", "active": true, "reason": "request" } }
>  #
> -# Since: 3.0
> +# Since: 3.1
>  ##
>  { 'command': 'query-colo-status',
>    'returns': 'COLOStatus' }
> -- 
> 2.17.GIT
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
