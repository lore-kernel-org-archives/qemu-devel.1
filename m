Received: from eggs.gnu.org ([209.51.188.92]:55618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj3GN-0006KJ-88
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj3GL-00035A-Jv
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:30:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gj3GL-00033o-7h
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:30:49 -0500
References: <20190114140510.7161-1-chen.zhang@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0b78cb56-aab1-aa20-3e38-bf7db25151af@redhat.com>
Date: Mon, 14 Jan 2019 15:30:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190114140510.7161-1-chen.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] net/colo-compare.c: Remove duplicated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

On 2019-01-14 15:05, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> Fix duplicated code:
> https://bugs.launchpad.net/qemu/+bug/1811499
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  net/colo-compare.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 9156ab3349..fa3fd0632d 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -285,14 +285,6 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet *spkt,
>  {
>      *mark = 0;
>  
> -    if (ppkt->tcp_seq == spkt->tcp_seq && ppkt->seq_end == spkt->seq_end) {
> -        if (colo_compare_packet_payload(ppkt, spkt,
> -                                        ppkt->header_size, spkt->header_size,
> -                                        ppkt->payload_size)) {
> -            *mark = COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_PRIMARY;
> -            return true;
> -        }
> -    }
>      if (ppkt->tcp_seq == spkt->tcp_seq && ppkt->seq_end == spkt->seq_end) {
>          if (colo_compare_packet_payload(ppkt, spkt,
>                                          ppkt->header_size, spkt->header_size,
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
