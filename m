Received: from eggs.gnu.org ([2001:4830:134:3::10]:45528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyvY6-0004n2-9e
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyvY5-000469-I6
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 04:26:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180321211056.3339-1-yuval.shaia@oracle.com>
	<20180321211056.3339-3-yuval.shaia@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <319bb756-8cb2-4a0c-a8db-7d43bffe3335@amsat.org>
Date: Thu, 22 Mar 2018 05:26:03 -0300
MIME-Version: 1.0
In-Reply-To: <20180321211056.3339-3-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/rdma: Use correct print format in
 CHK_ATTR macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, marcel@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 03/21/2018 06:10 PM, Yuval Shaia wrote:
> Macro should not cast the given variable to u64 instead it should use
> the supplied format argument (fmt).
> 
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/rdma/rdma_backend.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index f1a37ba4a2..0391a7dd95 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -656,8 +656,8 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp)
>  #define CHK_ATTR(req, dev, member, fmt) ({ \
>      pr_dbg("%s="fmt","fmt"\n", #member, dev.member, req->member); \
>      if (req->member > dev.member) { \
> -        warn_report("%s = 0x%lx is higher than host device capability 0x%lx", \
> -                    #member, (uint64_t)req->member, (uint64_t)dev.member); \
> +        warn_report("%s = "fmt" is higher than host device capability "fmt, \
> +                    #member, req->member, dev.member); \
>          req->member = dev.member; \
>      } \
>      pr_dbg("%s="fmt"\n", #member, req->member); })
> 
