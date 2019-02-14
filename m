Received: from eggs.gnu.org ([209.51.188.92]:38952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1guNHm-00023i-AF
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1guN2A-0007Zg-CY
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:50:59 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kamalheib1@gmail.com>)
	id 1guN2A-0007WH-1H
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:50:58 -0500
Received: by mail-wm1-x342.google.com with SMTP id j125so7326793wmj.1
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:50:52 -0800 (PST)
References: <20190214154053.15050-1-marcel.apfelbaum@gmail.com>
From: Kamal Heib <kamalheib1@gmail.com>
Message-ID: <5f91b4c3-0805-e231-eadf-fd6ce8a1ba3c@gmail.com>
Date: Thu, 14 Feb 2019 21:50:48 +0200
MIME-Version: 1.0
In-Reply-To: <20190214154053.15050-1-marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: another clang compilation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com



On 2/14/19 5:40 PM, Marcel Apfelbaum wrote:
> Configuring QEMU with:
>    configure --target-list="x86_64-softmmu" --cc=clang --enable-pvrdma
> Results in:
>    qemu/hw/rdma/rdma_rm_defs.h:108:3: error: redefinition of typedef 'RdmaDeviceResources' is a C11 feature [-Werror,-Wtypedef-redefinition]
>    } RdmaDeviceResources;
>      ^
>    qemu/hw/rdma/rdma_backend_defs.h:24:36: note: previous definition is here
>    typedef struct RdmaDeviceResources RdmaDeviceResources;
> 
> Fix by removing one of the 'typedef' definitions.
> 
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> ---
>  hw/rdma/rdma_rm_defs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
> index 0ba61d1838..5e877c1fd9 100644
> --- a/hw/rdma/rdma_rm_defs.h
> +++ b/hw/rdma/rdma_rm_defs.h
> @@ -96,7 +96,7 @@ typedef struct RdmaRmPort {
>      enum ibv_port_state state;
>  } RdmaRmPort;
>  
> -typedef struct RdmaDeviceResources {
> +struct RdmaDeviceResources {
>      RdmaRmPort port;
>      RdmaRmResTbl pd_tbl;
>      RdmaRmResTbl mr_tbl;
> @@ -105,6 +105,6 @@ typedef struct RdmaDeviceResources {
>      RdmaRmResTbl cq_tbl;
>      RdmaRmResTbl cqe_ctx_tbl;
>      GHashTable *qp_hash; /* Keeps mapping between real and emulated */
> -} RdmaDeviceResources;
> +};
>  
>  #endif
> 

Acked-by: Kamal Heib <kamalheib1@gmail.com>
