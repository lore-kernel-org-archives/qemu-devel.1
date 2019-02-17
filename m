Received: from eggs.gnu.org ([209.51.188.92]:36665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gvHEa-0006fc-Vh
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 02:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gvHEa-00008B-5T
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 02:51:32 -0500
References: <20190214154053.15050-1-marcel.apfelbaum@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <d1b36054-424a-e492-402f-0a3019953d05@gmail.com>
Date: Sun, 17 Feb 2019 09:51:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190214154053.15050-1-marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: another clang compilation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, kamalheib1@gmail.com, qemu-stable@nongnu.org



Cc:qemu-stable@nongnu.org


Thanks,
Marcel

On 2/14/19 5:40 PM, Marcel Apfelbaum wrote:
> Configuring QEMU with:
>     configure --target-list="x86_64-softmmu" --cc=clang --enable-pvrdma
> Results in:
>     qemu/hw/rdma/rdma_rm_defs.h:108:3: error: redefinition of typedef 'RdmaDeviceResources' is a C11 feature [-Werror,-Wtypedef-redefinition]
>     } RdmaDeviceResources;
>       ^
>     qemu/hw/rdma/rdma_backend_defs.h:24:36: note: previous definition is here
>     typedef struct RdmaDeviceResources RdmaDeviceResources;
>
> Fix by removing one of the 'typedef' definitions.
>
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> ---
>   hw/rdma/rdma_rm_defs.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
> index 0ba61d1838..5e877c1fd9 100644
> --- a/hw/rdma/rdma_rm_defs.h
> +++ b/hw/rdma/rdma_rm_defs.h
> @@ -96,7 +96,7 @@ typedef struct RdmaRmPort {
>       enum ibv_port_state state;
>   } RdmaRmPort;
>   
> -typedef struct RdmaDeviceResources {
> +struct RdmaDeviceResources {
>       RdmaRmPort port;
>       RdmaRmResTbl pd_tbl;
>       RdmaRmResTbl mr_tbl;
> @@ -105,6 +105,6 @@ typedef struct RdmaDeviceResources {
>       RdmaRmResTbl cq_tbl;
>       RdmaRmResTbl cqe_ctx_tbl;
>       GHashTable *qp_hash; /* Keeps mapping between real and emulated */
> -} RdmaDeviceResources;
> +};
>   
>   #endif
