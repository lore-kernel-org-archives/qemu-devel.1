Received: from eggs.gnu.org ([2001:4830:134:3::10]:53739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gF3uu-000219-NL
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 17:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gF3uq-0005Wi-GK
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 17:08:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gF3uq-0005Sd-5N
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 17:08:40 -0400
References: <20181022164118.5502-1-zhangckid@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b947ead6-2dbc-1209-68db-8c35d99a10df@redhat.com>
Date: Tue, 23 Oct 2018 09:24:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181022164118.5502-1-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 10/22/18 5:41 PM, Zhang Chen wrote:
> This structure and command have missed qemu version 3.0, so fix it to since version 3.1.
> 
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>   qapi/migration.json | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 0928f4b727..38d4c41d88 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1317,7 +1317,7 @@
>   #
>   # @reason: describes the reason for the COLO exit.
>   #
> -# Since: 3.0
> +# Since: 3.1
>   ##
>   { 'struct': 'COLOStatus',
>     'data': { 'mode': 'COLOMode', 'reason': 'COLOExitReason' } }
> @@ -1334,7 +1334,7 @@
>   # -> { "execute": "query-colo-status" }
>   # <- { "return": { "mode": "primary", "active": true, "reason": "request" } }
>   #
> -# Since: 3.0
> +# Since: 3.1
>   ##
>   { 'command': 'query-colo-status',
>     'returns': 'COLOStatus' }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
