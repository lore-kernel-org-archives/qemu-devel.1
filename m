Received: from eggs.gnu.org ([2001:4830:134:3::10]:47429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgC5b-00026K-1Z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgC5X-0003u6-1Y
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:10:51 -0500
Date: Tue, 21 Feb 2017 15:10:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170221151040.GA9376@work-vm>
References: <20170120230359.4244-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170120230359.4244-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hmp: fix block_set_io_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-stable@nongnu.org

* Eric Blake (eblake@redhat.com) wrote:
> Commit 7a9877a made the 'device' parameter to BlockIOThrottle
> optional, favoring 'id' instead.  But it forgot to update the
> HMP usage to set has_device, which makes all attempts to change
> throttling via HMP fail with "Need exactly one of 'device' and 'id'"
> 
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>

Queued for HMP

> ---
> 
>  hmp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hmp.c b/hmp.c
> index b869617..a3dc9d6 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1551,6 +1551,7 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
>      BlockIOThrottle throttle = {
> +        .has_device = true,
>          .device = (char *) qdict_get_str(qdict, "device"),
>          .bps = qdict_get_int(qdict, "bps"),
>          .bps_rd = qdict_get_int(qdict, "bps_rd"),
> -- 
> 2.9.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
