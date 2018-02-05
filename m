Received: from eggs.gnu.org ([2001:4830:134:3::10]:36001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eihkI-00044q-MG
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eihkD-0007r9-Mb
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:27:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1eihkD-0007qx-GN
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:27:41 -0500
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
	<20180203103727.26457-3-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <d733575d-2825-7d3b-0b2b-2fd125a8b85a@redhat.com>
Date: Mon, 5 Feb 2018 15:27:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180203103727.26457-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/10] cuda: don't allow writes to port
 output pins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org

On 03/02/2018 11:37, Mark Cave-Ayland wrote:
> Use the direction registers as a mask to ensure that only input pins are
> updated upon write.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/misc/macio/cuda.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index 23b7e0f5b0..7214e7adcb 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -359,11 +359,11 @@ static void cuda_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>  
>      switch(addr) {
>      case CUDA_REG_B:
> -        s->b = val;
> +        s->b = (s->b & ~s->dirb) | (val & s->dirb);
>          cuda_update(s);
>          break;
>      case CUDA_REG_A:
> -        s->a = val;
> +        s->a = (s->a & ~s->dira) | (val & s->dira);
>          break;
>      case CUDA_REG_DIRB:
>          s->dirb = val;
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
