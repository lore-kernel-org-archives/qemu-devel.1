Received: from eggs.gnu.org ([2001:4830:134:3::10]:38855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fToJQ-0005pq-3f
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fToJM-0003Qb-7Z
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:58:44 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1528911866-37489-2-git-send-email-anton.nefedov@virtuozzo.com>
References: <1528911866-37489-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1528911866-37489-2-git-send-email-anton.nefedov@virtuozzo.com>
Date: Fri, 15 Jun 2018 14:58:35 +0200
Message-ID: <w51lgbgjjes.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/8] qapi: group BlockDeviceStats fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@virtuozzo.com

On Wed 13 Jun 2018 07:44:19 PM CEST, Anton Nefedov <anton.nefedov@virtuozzo.com> wrote:
> Make the stat fields definition slightly more readable.
> Also reorder total_time_ns stats read-write-flush as done elsewhere.
> Cosmetic change only.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  qapi/block-core.json | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b3e94d8..ee75aef 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -784,12 +784,12 @@
>  # @flush_operations: The number of cache flush operations performed by the
>  #                    device (since 0.15.0)
>  #
> -# @flush_total_time_ns: Total time spend on cache flushes in nano-seconds
> -#                       (since 0.15.0).
> +# @rd_total_time_ns: Total time spent on reads in nanoseconds (since 0.15.0).
>  #
> -# @wr_total_time_ns: Total time spend on writes in nano-seconds (since 0.15.0).
> +# @wr_total_time_ns: Total time spent on writes in nanoseconds (since 0.15.0).
>  #
> -# @rd_total_time_ns: Total_time_spend on reads in nano-seconds (since 0.15.0).
> +# @flush_total_time_ns: Total time spent on cache flushes in nanoseconds
> +#                       (since 0.15.0).
>  #
>  # @wr_highest_offset: The offset after the greatest byte written to the
>  #                     device.  The intended use of this information is for
> @@ -842,14 +842,26 @@
>  # Since: 0.14.0
>  ##
>  { 'struct': 'BlockDeviceStats',
> -  'data': {'rd_bytes': 'int', 'wr_bytes': 'int', 'rd_operations': 'int',
> -           'wr_operations': 'int', 'flush_operations': 'int',
> -           'flush_total_time_ns': 'int', 'wr_total_time_ns': 'int',
> -           'rd_total_time_ns': 'int', 'wr_highest_offset': 'int',
> -           'rd_merged': 'int', 'wr_merged': 'int', '*idle_time_ns': 'int',
> +  'data': {'rd_bytes': 'int', 'wr_bytes': 'int',
> +
> +           'rd_operations': 'int', 'wr_operations': 'int',
> +           'flush_operations': 'int',
> +
> +           'rd_total_time_ns': 'int', 'wr_total_time_ns': 'int',
> +           'flush_total_time_ns': 'int',

This patch looks good, but I don't think the empty lines here are
necessary (is there any other data structure using them?).

Berto
