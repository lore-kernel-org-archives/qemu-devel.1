Received: from eggs.gnu.org ([2001:4830:134:3::10]:36948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gXJRF-0004HB-R6
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gXJRC-0003SN-Jh
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:21:33 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gXJRC-0003QP-7g
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:21:30 -0500
Date: Thu, 13 Dec 2018 07:19:55 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181213051954.GA2927@lap1>
References: <20181212193039.11445-1-ppandit@redhat.com>
	<20181212193039.11445-6-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212193039.11445-6-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/6] rdma: remove unused
 VENDOR_ERR_NO_SGE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>, yuval.shaia@oracle.com

On Thu, Dec 13, 2018 at 01:00:38AM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> With commit 4481985c (rdma: check num_sge does not exceed MAX_SGE)
> macro VENDOR_ERR_NO_SGE is no longer in use - delete it.
> 
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/rdma/rdma_backend.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Update: change commit log message
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02793.html
> 
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index bd4710d16f..c28bfbd44d 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -37,12 +37,11 @@
>  #define VENDOR_ERR_TOO_MANY_SGES    0x202
>  #define VENDOR_ERR_NOMEM            0x203
>  #define VENDOR_ERR_QP0              0x204
> -#define VENDOR_ERR_NO_SGE           0x205
> +#define VENDOR_ERR_INV_NUM_SGE      0x205
>  #define VENDOR_ERR_MAD_SEND         0x206
>  #define VENDOR_ERR_INVLKEY          0x207
>  #define VENDOR_ERR_MR_SMALL         0x208
>  #define VENDOR_ERR_INV_MAD_BUFF     0x209
> -#define VENDOR_ERR_INV_NUM_SGE      0x210
>  
>  #define THR_NAME_LEN 16
>  #define THR_POLL_TO  5000

Thanks.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

> -- 
> 2.19.2
> 
