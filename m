Received: from eggs.gnu.org ([2001:4830:134:3::10]:43336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff10J-0000Qv-6w
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ff10G-0000JG-3O
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:45:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ff10F-0000He-Sr
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:45:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id t6-v6so31365557wrn.7
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 03:45:15 -0700 (PDT)
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
	<20180716074038.3364-10-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <e498ac5b-6cef-aba4-c62c-c775e8fd4710@gmail.com>
Date: Mon, 16 Jul 2018 13:45:12 +0300
MIME-Version: 1.0
In-Reply-To: <20180716074038.3364-10-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 09/13] hw/pvrdma: Cosmetic change - indent
 right
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org



On 07/16/2018 10:40 AM, Yuval Shaia wrote:
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/vmw/pvrdma_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 1b1330e113..3d448bffc4 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -430,7 +430,7 @@ static void regs_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>               reset_device(dev);
>               break;
>           }
> -    break;
> +        break;
>       case PVRDMA_REG_IMR:
>           pr_dbg("Interrupt mask=0x%" PRIx64 "\n", val);
>           dev->interrupt_mask = val;
> @@ -439,7 +439,7 @@ static void regs_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>           if (val == 0) {
>               execute_command(dev);
>           }
> -    break;
> +        break;
>       default:
>           break;
>       }
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
