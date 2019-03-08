Received: from eggs.gnu.org ([209.51.188.92]:40148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2FZ8-0000M6-Op
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2FZ5-0001c0-Ro
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:29:33 -0500
Date: Fri, 8 Mar 2019 14:29:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190308132919.GB31583@localhost.localdomain>
References: <20190305125317.607155-1-vsementsov@virtuozzo.com>
	<20190305125317.607155-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305125317.607155-2-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qapi: move to QOM path for
 x-block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, mreitz@redhat.com, armbru@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

Am 05.03.2019 um 13:53 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json |  4 ++--
>  blockdev.c           | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 2b8afbb924..8187de0836 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -541,7 +541,7 @@
>  # If only @device parameter is specified, remove all present latency histograms

@device doesn't exist any more, so this should become @id.

The examples below need to be changed, too.

>  # for the device. Otherwise, add/reset some of (or all) latency histograms.
>  #
> -# @device: device name to set latency histogram for.
> +# @id: The name or QOM path of the guest device.
>  #
>  # @boundaries: list of interval boundary values (see description in
>  #              BlockLatencyHistogramInfo definition). If specified, all
> @@ -599,7 +599,7 @@
>  # <- { "return": {} }
>  ##
>  { 'command': 'x-block-latency-histogram-set',
> -  'data': {'device': 'str',
> +  'data': {'id': 'str',
>             '*boundaries': ['uint64'],
>             '*boundaries-read': ['uint64'],
>             '*boundaries-write': ['uint64'],

The rest of the series looks good to me.

Kevin
