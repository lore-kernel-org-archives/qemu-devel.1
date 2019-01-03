Received: from eggs.gnu.org ([208.118.235.92]:36656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gf2Bs-0008Tm-KV
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gf2Bp-0004Kf-Ct
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:33:36 -0500
Received: from chuckie.co.uk ([82.165.15.123]:35882
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gf2Bp-00044u-06
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:33:33 -0500
References: <20190103093704.32635-1-ppandit@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <cd325b25-15ee-46e4-896e-e5904340b1bf@ilande.co.uk>
Date: Thu, 3 Jan 2019 12:33:09 +0000
MIME-Version: 1.0
In-Reply-To: <20190103093704.32635-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sun4u: add power_mem_read routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 03/01/2019 09:37, P J P wrote:

> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Define skeleton 'power_mem_read' routine. Avoid NULL dereference.
> 
> Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/sparc64/sun4u.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index f76b19e4e9..cbdb2bb411 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -214,6 +214,11 @@ typedef struct PowerDevice {
>  } PowerDevice;
>  
>  /* Power */
> +static uint64_t power_mem_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return 0xffffffff;
> +}
> +
>  static void power_mem_write(void *opaque, hwaddr addr,
>                              uint64_t val, unsigned size)
>  {
> @@ -224,6 +229,7 @@ static void power_mem_write(void *opaque, hwaddr addr,
>  }
>  
>  static const MemoryRegionOps power_mem_ops = {
> +    .read = power_mem_read,
>      .write = power_mem_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {

Certainly the addition of the missing read function is valid, although I see that
you've defaulted reads to returning 0xffffffff - can you point me towards the source
that indicates that this behaviour matches that of real Ultra-5 hardware?


ATB,

Mark.
