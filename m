Received: from eggs.gnu.org ([2001:4830:134:3::10]:44304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDLbH-00070j-4I
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 23:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDLbD-0001UJ-63
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 23:05:07 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:38522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDLbD-0001U1-1X
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 23:05:03 -0400
Received: by mail-qk0-x244.google.com with SMTP id b39so8133509qkb.5
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 20:05:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
	<20180430200223.4119-3-marcel.apfelbaum@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <00227645-5568-c8ac-5c50-c2ed246ad3da@amsat.org>
Date: Tue, 1 May 2018 00:04:48 -0300
MIME-Version: 1.0
In-Reply-To: <20180430200223.4119-3-marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/7] hw/rdma: Fix possible usage of a NULL
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, yuval.shaia@oracle.com

On 04/30/2018 05:02 PM, Marcel Apfelbaum wrote:
> Coverity CID 1390586; The cq handle is provided by the guest
> and cannot be trusted to be previuosly allocated.
> Fix it by exiting the completion flow.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/rdma/vmw/pvrdma_qp_ops.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> index 750ade6c31..99bb51111e 100644
> --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> @@ -216,6 +216,7 @@ void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle)
>      cq = rdma_rm_get_cq(dev_res, cq_handle);
>      if (!cq) {
>          pr_dbg("Invalid CQ# %d\n", cq_handle);
> +        return;
>      }
>  
>      rdma_backend_poll_cq(dev_res, &cq->backend_cq);
> 
