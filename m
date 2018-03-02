Received: from eggs.gnu.org ([2001:4830:134:3::10]:38652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erosz-0004tR-SN
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erosw-0000HV-2C
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:54:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55316 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1erosv-0000G1-Tn
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:54:22 -0500
Date: Fri, 2 Mar 2018 19:54:14 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180302195256-mutt-send-email-mst@kernel.org>
References: <cover.1519961667.git.jbaron@akamai.com>
	<864430f2a613c4d3c82b591ed7bc27068ddad369.1519961667.git.jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864430f2a613c4d3c82b591ed7bc27068ddad369.1519961667.git.jbaron@akamai.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] eth: add speed and duplex definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Baron <jbaron@akamai.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

On Thu, Mar 01, 2018 at 10:46:33PM -0500, Jason Baron wrote:
> Pull in definitions for SPEED_UNKNOWN, DUPLEX_UNKNOWN, DUPLEX_HALF,
> and DUPLEX_FULL.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtio-dev@lists.oasis-open.org
> ---
>  include/net/eth.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/net/eth.h b/include/net/eth.h
> index 09054a5..9843678 100644
> --- a/include/net/eth.h
> +++ b/include/net/eth.h
> @@ -417,4 +417,11 @@ bool
>  eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
>                     size_t ip6hdr_off, eth_ip6_hdr_info *info);
>  
> +/* ethtool defines - from linux/ethtool.h */
> +#define SPEED_UNKNOWN           -1
> +
> +#define DUPLEX_HALF             0x00
> +#define DUPLEX_FULL             0x01
> +#define DUPLEX_UNKNOWN          0xff
> +
>  #endif

While that's not a lot, I think we should import linux/ethtool.h into
include/standard-headers/linux/ using scripts/update-linux-headers.sh

> -- 
> 2.7.4
