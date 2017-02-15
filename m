Received: from eggs.gnu.org ([2001:4830:134:3::10]:42358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cdvPd-0001nR-Sb
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cdvPa-0000EB-0Q
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:58:09 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1cdvPZ-0000Ce-OK
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:58:05 -0500
Received: by mail-wm0-x242.google.com with SMTP id c85so7087865wmi.1
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 00:58:03 -0800 (PST)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <7A52E0CB-9F86-4BFF-B641-C820CB9107FE@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Wed, 15 Feb 2017 10:58:03 +0200
In-Reply-To: <20170215083143.15897-1-famz@redhat.com>
References: <20170215083143.15897-1-famz@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] net: Remove useless local var pkt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>

Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>

This patch also fixes compilation with NET_RX_PKT_DEBUG defined.

> On 15 Feb 2017, at 10:31 AM, Fam Zheng <famz@redhat.com> wrote:
> 
> This has been pointless since commit 605d52e62, which was a
> search-and-replace, overlooked the redundancy.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
> hw/net/net_rx_pkt.c | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
> index 1019b50..7f928d7 100644
> --- a/hw/net/net_rx_pkt.c
> +++ b/hw/net/net_rx_pkt.c
> @@ -159,7 +159,6 @@ void net_rx_pkt_attach_iovec_ex(struct NetRxPkt *pkt,
> void net_rx_pkt_dump(struct NetRxPkt *pkt)
> {
> #ifdef NET_RX_PKT_DEBUG
> -    NetRxPkt *pkt = (NetRxPkt *)pkt;
>     assert(pkt);
> 
>     printf("RX PKT: tot_len: %d, vlan_stripped: %d, vlan_tag: %d\n",
> -- 
> 2.9.3
> 
