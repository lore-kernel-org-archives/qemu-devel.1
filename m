Received: from eggs.gnu.org ([209.51.188.92]:48107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=924257913=Paul.Durrant@citrix.com>)
	id 1go494-0004I1-38
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=924257913=Paul.Durrant@citrix.com>)
	id 1go493-0005iL-1H
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:28:02 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 28 Jan 2019 10:27:53 +0000
Message-ID: <cde6559b10564ec2aaa8e5d43ae3008f@AMSPEX02CL03.citrite.net>
References: <20190122145132.12571-1-paul.durrant@citrix.com>
In-Reply-To: <20190122145132.12571-1-paul.durrant@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Paul Durrant <Paul.Durrant@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Ping?

I realize that I typo-ed the commit comment but, assuming that can be fixed=
, can I get an ack or otherwise on this?

Thanks,

  Paul

> -----Original Message-----
> From: Paul Durrant [mailto:paul.durrant@citrix.com]
> Sent: 22 January 2019 14:52
> To: qemu-devel@nongnu.org; qemu-block@nongnu.org
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; Kevin Wolf <kwolf@redhat.com>=
;
> Max Reitz <mreitz@redhat.com>
> Subject: [PATCH] hw/block: clean up stake xen_disk trace entries
>=20
> This should have been removed then xen_disk.c was removed but I missed
> them.
>=20
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> ---
>  hw/block/trace-events | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 55e5a5500c..d0851953c5 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -121,13 +121,6 @@ nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t
> new_head) "completion queue
>  nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write
> for nonexistent queue, sqid=3D%"PRIu32", ignoring"
>  nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submissio=
n
> queue doorbell write value beyond queue size, sqid=3D%"PRIu32",
> new_head=3D%"PRIu16", ignoring"
>=20
> -# hw/block/xen_disk.c
> -xen_disk_alloc(char *name) "%s"
> -xen_disk_init(char *name) "%s"
> -xen_disk_connect(char *name) "%s"
> -xen_disk_disconnect(char *name) "%s"
> -xen_disk_free(char *name) "%s"
> -
>  # hw/block/xen-block.c
>  xen_block_realize(const char *type, uint32_t disk, uint32_t partition)
> "%s d%up%u"
>  xen_block_connect(const char *type, uint32_t disk, uint32_t partition)
> "%s d%up%u"
> --
> 2.20.1.2.gb21ebb6
