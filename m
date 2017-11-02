Received: from eggs.gnu.org ([2001:4830:134:3::10]:57814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eABwe-0008Ld-Kk
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 05:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eABwd-0005BG-UD
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 05:37:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eABwd-0005Ac-OS
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 05:37:51 -0400
References: <20171102093625.32342-1-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f96b7ffe-83d3-f328-cf74-e05a0acb65ec@redhat.com>
Date: Thu, 2 Nov 2017 10:37:47 +0100
MIME-Version: 1.0
In-Reply-To: <20171102093625.32342-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc: restrict port92 register value to 2
 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Niu Guoxiang <niuguoxiang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 02/11/2017 10:36, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Port 92 configuration register holds an 8-bit value. Of 8-bits,
> bits 0-1 are used and 2-7 are reserved. Restrict the supplied
> value to 2 bits.

This patch is not necessary.  "Do nothing and just report back the value
that was written" is an okay implementation of reserved bits.

Paolo


> Reported-by: Niu Guoxiang <niuguoxiang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/i386/pc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 05985d4927..883384a599 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -515,6 +515,7 @@ static void port92_write(void *opaque, hwaddr addr, uint64_t val,
>      Port92State *s = opaque;
>      int oldval = s->outport;
>  
> +    val &= 0x03;
>      DPRINTF("port92: write 0x%02" PRIx64 "\n", val);
>      s->outport = val;
>      qemu_set_irq(s->a20_out, (val >> 1) & 1);
> 
