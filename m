Received: from eggs.gnu.org ([2001:4830:134:3::10]:34805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNzfj-0005c5-Pp
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNzfj-00032n-44
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:25:59 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gNzfi-00030v-Th
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:25:59 -0500
Received: by mail-wm1-x342.google.com with SMTP id t15-v6so1054592wmt.0
	for <qemu-devel@nongnu.org>; Sat, 17 Nov 2018 04:25:58 -0800 (PST)
References: <20181113071336.6242-1-yuval.shaia@oracle.com>
	<20181113071336.6242-23-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <c061e6b3-2485-652a-b7da-8d5c5f3a739f@gmail.com>
Date: Sat, 17 Nov 2018 14:25:55 +0200
MIME-Version: 1.0
In-Reply-To: <20181113071336.6242-23-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 22/23] hw/rdma: Do not call
 rdma_backend_del_gid on an empty gid
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
> When device goes down the function fini_ports loops over all entries in
> gid table regardless of the fact whether entry is valid or not. In case
> that entry is not valid we'd like to skip from any further processing in
> backend device.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_rm.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> index 35a96d9a64..e3f6b2f6ea 100644
> --- a/hw/rdma/rdma_rm.c
> +++ b/hw/rdma/rdma_rm.c
> @@ -555,6 +555,10 @@ int rdma_rm_del_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
>   {
>       int rc;
>   
> +    if (!dev_res->port.gid_tbl[gid_idx].gid.global.interface_id) {
> +        return 0;
> +    }
> +
>       rc = rdma_backend_del_gid(backend_dev, ifname,
>                                 &dev_res->port.gid_tbl[gid_idx].gid);
>       if (rc < 0) {

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
