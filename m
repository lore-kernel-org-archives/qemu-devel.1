Received: from eggs.gnu.org ([2001:4830:134:3::10]:50395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7KTB-0001Yy-NB
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7KT9-0002il-LB
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:12:09 -0400
References: <20181002113325.12911-1-vsementsov@virtuozzo.com>
	<20181002113325.12911-3-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <fc5a2b78-e6b5-a849-ddc9-324b7fb4d607@virtuozzo.com>
Date: Tue, 2 Oct 2018 16:11:48 +0300
MIME-Version: 1.0
In-Reply-To: <20181002113325.12911-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: drop x- from
 x-block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, jsnow@redhat.com

02.10.2018 14:33, Vladimir Sementsov-Ogievskiy wrote:
> Libvirt part is ready, let's drop x- prefix.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qapi/block-core.json | 4 ++--
>   blockdev.c           | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 4efd60d8ab..e9c0079933 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -482,7 +482,7 @@
>     'data': {'boundaries': ['uint64'], 'bins': ['uint64'] } }
>  =20
>   ##
> -# @x-block-latency-histogram-set:
> +# @block-latency-histogram-set:
>   #
>   # Manage read, write and flush latency histograms for the device.
>   #
> @@ -548,7 +548,7 @@
>   #      "arguments": { "device": "drive0" } }
>   # <- { "return": {} }
>   ##
> -{ 'command': 'x-block-latency-histogram-set',
> +{ 'command': 'block-latency-histogram-set',
>     'data': {'*device': 'str', '*id': 'str',
>              '*boundaries': ['uint64'],
>              '*boundaries-read': ['uint64'],
> diff --git a/blockdev.c b/blockdev.c
> index 87f4ab3316..bc579d8f81 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -4367,7 +4367,7 @@ void qmp_x_blockdev_set_iothread(const char *node_n=
ame, StrOrNull *iothread,
>       aio_context_release(old_context);
>   }
>  =20
> -void qmp_x_block_latency_histogram_set(
> +void qmp_block_latency_histogram_set(
>       bool has_device, const char *device,
>       bool has_id, const char *id,
>       bool has_boundaries, uint64List *boundaries,

please amend (drop x_ from statistic output too):

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e9c0079933..faaaf339a6 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -835,11 +835,11 @@
 =C2=A0# @timed_stats: Statistics specific to the set of previously defined
 =C2=A0#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 intervals of time (Since 2.5)
 =C2=A0#
-# @x_rd_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
+# @rd_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
 =C2=A0#
-# @x_wr_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
+# @wr_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
 =C2=A0#
-# @x_flush_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
+# @flush_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
 =C2=A0#
 =C2=A0# Since: 0.14.0
 =C2=A0##
@@ -854,9 +854,9 @@
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'invali=
d_wr_operations': 'int', 'invalid_flush_operations':=20
'int',
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'accoun=
t_invalid': 'bool', 'account_failed': 'bool',
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'timed_=
stats': ['BlockDeviceTimedStats'],
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*x_rd_latenc=
y_histogram': 'BlockLatencyHistogramInfo',
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*x_wr_latenc=
y_histogram': 'BlockLatencyHistogramInfo',
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*x_flush_lat=
ency_histogram': 'BlockLatencyHistogramInfo' } }
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*rd_latency_=
histogram': 'BlockLatencyHistogramInfo',
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*wr_latency_=
histogram': 'BlockLatencyHistogramInfo',
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*flush_laten=
cy_histogram': 'BlockLatencyHistogramInfo' } }

 =C2=A0##
 =C2=A0# @BlockStats:
diff --git a/block/qapi.c b/block/qapi.c
index c66f949db8..dc7508a06d 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -492,14 +492,14 @@ static void bdrv_query_blk_stats(BlockDeviceStats=20
*ds, BlockBackend *blk)
 =C2=A0=C2=A0=C2=A0=C2=A0 }

bdrv_latency_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_READ],
- &ds->has_x_rd_latency_histogram,
- &ds->x_rd_latency_histogram);
+ &ds->has_rd_latency_histogram,
+ &ds->rd_latency_histogram);
bdrv_latency_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_WRITE],
- &ds->has_x_wr_latency_histogram,
- &ds->x_wr_latency_histogram);
+ &ds->has_wr_latency_histogram,
+ &ds->wr_latency_histogram);
bdrv_latency_histogram_stats(&stats->latency_histogram[BLOCK_ACCT_FLUSH],
- &ds->has_x_flush_latency_histogram,
- &ds->x_flush_latency_histogram);
+ &ds->has_flush_latency_histogram,
+ &ds->flush_latency_histogram);
 =C2=A0}

 =C2=A0static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,


--=20
Best regards,
Vladimir
