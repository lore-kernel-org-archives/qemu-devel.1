Received: from eggs.gnu.org ([2001:4830:134:3::10]:60396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejW82-0000KK-TF
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 15:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejW7x-0003Ht-Tz
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 15:15:38 -0500
Received: from mail-db5eur01hn0212.outbound.protection.outlook.com
	([104.47.2.212]:10016
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ejW7x-0003HT-5B
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 15:15:33 -0500
Date: Wed, 7 Feb 2018 23:15:17 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180207201517.GE19541@rkaganb.sw.ru>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-30-rkagan@virtuozzo.com>
	<b9ee4d69-130e-74bc-42f7-0ab372d0070b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9ee4d69-130e-74bc-42f7-0ab372d0070b@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 29/34] net: add Hyper-V/VMBus network
 protocol definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On Wed, Feb 07, 2018 at 01:00:14PM +0100, Paolo Bonzini wrote:
> On 06/02/2018 21:30, Roman Kagan wrote:
> > +/* NdisInitialize message */
> > +struct rndis_initialize_request {
> > +    uint32_t req_id;
> > +    uint32_t major_ver;
> > +    uint32_t minor_ver;
> > +    uint32_t max_xfer_size;
> > +};
> > +
> > +/* Response to NdisInitialize */
> > +struct rndis_initialize_complete {
> > +    uint32_t req_id;
> > +    uint32_t status;
> > +    uint32_t major_ver;
> > +    uint32_t minor_ver;
> > +    uint32_t dev_flags;
> > +    uint32_t medium;
> > +    uint32_t max_pkt_per_msg;
> > +    uint32_t max_xfer_size;
> > +    uint32_t pkt_alignment_factor;
> > +    uint32_t af_list_offset;
> > +    uint32_t af_list_size;
> > +};
> > +
> > +/* Call manager devices only: Information about an address family */
> > +/* supported by the device is appended to the response to NdisInitialize. */
> > +struct rndis_co_address_family {
> > +    uint32_t address_family;
> > +    uint32_t major_ver;
> > +    uint32_t minor_ver;
> > +};
> > +
> > +/* NdisHalt message */
> > +struct rndis_halt_request {
> > +    uint32_t req_id;
> > +};
> > +
> > +/* NdisQueryRequest message */
> > +struct rndis_query_request {
> > +    uint32_t req_id;
> > +    uint32_t oid;
> > +    uint32_t info_buflen;
> > +    uint32_t info_buf_offset;
> > +    uint32_t dev_vc_handle;
> > +};
> > +
> > +/* Response to NdisQueryRequest */
> > +struct rndis_query_complete {
> > +    uint32_t req_id;
> > +    uint32_t status;
> > +    uint32_t info_buflen;
> > +    uint32_t info_buf_offset;
> > +};
> > +
> > +/* NdisSetRequest message */
> > +struct rndis_set_request {
> > +    uint32_t req_id;
> > +    uint32_t oid;
> > +    uint32_t info_buflen;
> > +    uint32_t info_buf_offset;
> > +    uint32_t dev_vc_handle;
> > +};
> > +
> > +/* Response to NdisSetRequest */
> > +struct rndis_set_complete {
> > +    uint32_t req_id;
> > +    uint32_t status;
> > +};
> > +
> > +/* NdisReset message */
> > +struct rndis_reset_request {
> > +    uint32_t reserved;
> > +};
> > +
> > +/* Response to NdisReset */
> > +struct rndis_reset_complete {
> > +    uint32_t status;
> > +    uint32_t addressing_reset;
> > +};
> > +
> > +/* NdisMIndicateStatus message */
> > +struct rndis_indicate_status {
> > +    uint32_t status;
> > +    uint32_t status_buflen;
> > +    uint32_t status_buf_offset;
> > +};
> > +
> > +/* Diagnostic information passed as the status buffer in */
> > +/* struct rndis_indicate_status messages signifying error conditions. */
> > +struct rndis_diagnostic_info {
> > +    uint32_t diag_status;
> > +    uint32_t error_offset;
> > +};
> > +
> > +/* NdisKeepAlive message */
> > +struct rndis_keepalive_request {
> > +    uint32_t req_id;
> > +};
> > +
> > +/* Response to NdisKeepAlive */
> > +struct rndis_keepalive_complete {
> > +    uint32_t req_id;
> > +    uint32_t status;
> > +};
> > +
> 
> Hmm, these are a bit harder to unify with hw/usb/dev-network.c.  Still
> not _that_ hard, just that the USB version has two fields for message
> type/length at the beginning.

This is my "fault".  At some point I got tired of this pattern so I
factored out the header and the payload.  I'll reconsider with this
unification in mind.

Roman.
