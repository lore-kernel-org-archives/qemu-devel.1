Received: from eggs.gnu.org ([2001:4830:134:3::10]:32792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gXMZO-00072y-Rr
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 03:42:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gXMZL-0005Je-I3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 03:42:10 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gXMZK-0005Ha-KI
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 03:42:06 -0500
Received: by mail-wm1-x342.google.com with SMTP id c126so1455089wmh.0
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 00:42:06 -0800 (PST)
References: <20181212193039.11445-1-ppandit@redhat.com>
	<20181212193039.11445-3-ppandit@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <793d71e9-eeb0-4581-c98c-8e5a3053b50b@gmail.com>
Date: Thu, 13 Dec 2018 10:42:05 +0200
MIME-Version: 1.0
In-Reply-To: <20181212193039.11445-3-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/6] pvrdma: add uar_read routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>



On 12/12/18 9:30 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Define skeleton 'uar_read' routine. Avoid NULL dereference.
>
> Reported-by: Li Qiang <liq3ea@163.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>   hw/rdma/vmw/pvrdma_main.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> Update: change return value from uar_read()
>    -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02787.html
>
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 23dc9926e3..997d7f395a 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -448,6 +448,11 @@ static const MemoryRegionOps regs_ops = {
>       },
>   };
>   
> +static uint64_t uar_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return 0xffffffff;
> +}
> +
>   static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>   {
>       PVRDMADev *dev = opaque;
> @@ -489,6 +494,7 @@ static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>   }
>   
>   static const MemoryRegionOps uar_ops = {
> +    .read = uar_read,
>       .write = uar_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .impl = {


Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Thanks,
Marcel
