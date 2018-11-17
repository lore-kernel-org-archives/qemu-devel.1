Received: from eggs.gnu.org ([2001:4830:134:3::10]:60361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNzSA-0008C4-74
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNzS5-0005Mv-9c
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:11:58 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gNzS5-0005IG-1y
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:11:53 -0500
Received: by mail-wr1-x442.google.com with SMTP id b13so27422091wrx.6
	for <qemu-devel@nongnu.org>; Sat, 17 Nov 2018 04:11:52 -0800 (PST)
References: <20181113071336.6242-1-yuval.shaia@oracle.com>
	<20181113071336.6242-16-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <43902f4d-d00d-6cba-386e-92797c1bec01@gmail.com>
Date: Sat, 17 Nov 2018 14:11:49 +0200
MIME-Version: 1.0
In-Reply-To: <20181113071336.6242-16-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 15/23] hw/pvrdma: Make device state
 depend on Ethernet function state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com



On 11/13/18 9:13 AM, Yuval Shaia wrote:
> User should be able to control the device by changing Ethernet function
> state so if user runs 'ifconfig ens3 down' the PVRDMA function should be
> down as well.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma_cmd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index 2979582fac..0d3c818c20 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -139,7 +139,8 @@ static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
>       resp->hdr.ack = PVRDMA_CMD_QUERY_PORT_RESP;
>       resp->hdr.err = 0;
>   
> -    resp->attrs.state = attrs.state;
> +    resp->attrs.state = dev->func0->device_active ? attrs.state :
> +                                                    PVRDMA_PORT_DOWN;
>       resp->attrs.max_mtu = attrs.max_mtu;
>       resp->attrs.active_mtu = attrs.active_mtu;
>       resp->attrs.phys_state = attrs.phys_state;

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
