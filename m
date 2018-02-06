Received: from eggs.gnu.org ([2001:4830:134:3::10]:59750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ej33U-0007H9-8W
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:13:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ej33Q-0003Zx-9Z
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:13:00 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1516366207-109842-2-git-send-email-anton.nefedov@virtuozzo.com>
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-2-git-send-email-anton.nefedov@virtuozzo.com>
Date: Tue, 06 Feb 2018 14:12:51 +0100
Message-ID: <w51a7wmdzxo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/8] qapi: group
 BlockDeviceStats fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

On Fri 19 Jan 2018 01:50:00 PM CET, Anton Nefedov wrote:
> Make the stat fields definition slightly more readable.
> Cosmetic change only.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  qapi/block-core.json | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index e94a688..2e0665e 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -733,14 +733,26 @@
>  # Since: 0.14.0
>  ##
>  { 'struct': 'BlockDeviceStats',
> -  'data': {'rd_bytes': 'int', 'wr_bytes': 'int', 'rd_operations': 'int',
> -           'wr_operations': 'int', 'flush_operations': 'int',
> +  'data': {'rd_bytes': 'int', 'wr_bytes': 'int',
> +
> +           'rd_operations': 'int', 'wr_operations': 'int',
> +           'flush_operations': 'int',
> +
>             'flush_total_time_ns': 'int', 'wr_total_time_ns': 'int',
> -           'rd_total_time_ns': 'int', 'wr_highest_offset': 'int',
> -           'rd_merged': 'int', 'wr_merged': 'int', '*idle_time_ns': 'int',
> +           'rd_total_time_ns': 'int',

It would be nice to reorder these following the read-write-flush order.
This way these would be rd_total_time_ns, wr_total_time_ns and
flush_total_time_ns.

The order of the fields in the documentation would also need to be
changed.

Berto
