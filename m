Received: from eggs.gnu.org ([209.51.188.92]:59543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go796-0004wM-RQ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go790-0007gf-Sq
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:40:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1go790-0007Zu-MT
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:40:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so18076064wrx.9
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 05:40:10 -0800 (PST)
References: <20190122145132.12571-1-paul.durrant@citrix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <57cd3429-41a3-48c5-4d06-5d203cf70f97@redhat.com>
Date: Mon, 28 Jan 2019 14:40:05 +0100
MIME-Version: 1.0
In-Reply-To: <20190122145132.12571-1-paul.durrant@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/block: clean up stake xen_disk trace
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

Cc'ing QEMU Trivial.

On 1/22/19 3:51 PM, Paul Durrant wrote:
> This should have been removed then xen_disk.c was removed but I missed them.

... when xen_disk.c was removed (19f87870baa) ...

> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> ---
>  hw/block/trace-events | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 55e5a5500c..d0851953c5 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -121,13 +121,6 @@ nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completion queue
>  nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write for nonexistent queue, sqid=%"PRIu32", ignoring"
>  nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submission queue doorbell write value beyond queue size, sqid=%"PRIu32", new_head=%"PRIu16", ignoring"
>  
> -# hw/block/xen_disk.c
> -xen_disk_alloc(char *name) "%s"
> -xen_disk_init(char *name) "%s"
> -xen_disk_connect(char *name) "%s"
> -xen_disk_disconnect(char *name) "%s"
> -xen_disk_free(char *name) "%s"
> -
>  # hw/block/xen-block.c
>  xen_block_realize(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
>  xen_block_connect(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
> 
