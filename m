Received: from eggs.gnu.org ([2001:4830:134:3::10]:43514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f1kTt-0007lK-Q1
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 23:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f1kTq-0008EV-K4
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 23:13:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f1kTq-0008Dg-G9
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 23:13:30 -0400
Date: Fri, 30 Mar 2018 06:13:21 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180330061213-mutt-send-email-mst@kernel.org>
References: <1522377977-29623-1-git-send-email-changpeng.liu@intel.com>
	<1522377977-29623-2-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522377977-29623-2-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] contrib/vhost-user-blk: enable
 protocol feature for vhost-user-blk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com

On Fri, Mar 30, 2018 at 10:46:17AM +0800, Changpeng Liu wrote:
> This patch reports the protocol feature that is only advertised by
> QEMU if the device implements the config ops.
> 
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>


OK but pls just send a single patch next time.
People often split out just the headers or some
utility functions with little value, but this
does not help review at all.

No need to repost just for this.

> ---
>  contrib/vhost-user-blk/vhost-user-blk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
> index 67dac81..f6e0170 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -311,6 +311,12 @@ vub_get_features(VuDev *dev)
>             1ull << VHOST_USER_F_PROTOCOL_FEATURES;
>  }
>  
> +static uint64_t
> +vub_get_protocol_features(VuDev *dev)
> +{
> +    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG;
> +}
> +
>  static int
>  vub_get_config(VuDev *vu_dev, uint8_t *config, uint32_t len)
>  {
> @@ -372,6 +378,7 @@ vub_set_config(VuDev *vu_dev, const uint8_t *data,
>  
>  static const VuDevIface vub_iface = {
>      .get_features = vub_get_features,
> +    .get_protocol_features = vub_get_protocol_features,
>      .queue_set_started = vub_queue_set_started,
>      .get_config = vub_get_config,
>      .set_config = vub_set_config,
> -- 
> 1.9.3
