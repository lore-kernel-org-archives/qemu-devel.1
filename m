Received: from eggs.gnu.org ([2001:4830:134:3::10]:42709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cviaY-0004Wi-9p
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 06:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cviaT-0000dV-Vr
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 06:54:58 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cviaT-0000dQ-RQ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 06:54:53 -0400
Received: by mail-qk0-x243.google.com with SMTP id k139so1099953qke.2
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 03:54:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1491349058.git.alistair.francis@xilinx.com>
	<a0d9c14a38201af8f4838e2c84cadec573d56e13.1491349058.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6e2c35e7-b610-f343-93cf-f599e59268b8@amsat.org>
Date: Wed, 5 Apr 2017 07:54:50 -0300
MIME-Version: 1.0
In-Reply-To: <a0d9c14a38201af8f4838e2c84cadec573d56e13.1491349058.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/5] cadence_gem: Read the correct queue
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair23@gmail.com

On 04/04/2017 08:40 PM, Alistair Francis wrote:
> Read the correct descriptor instead of hardcoding the first (q=0).
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>
>  hw/net/cadence_gem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index d4de8ad..17c229d 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -790,8 +790,8 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
>  {
>      DB_PRINT("read descriptor 0x%x\n", (unsigned)s->rx_desc_addr[q]);
>      /* read current descriptor */
> -    cpu_physical_memory_read(s->rx_desc_addr[0],
> -                             (uint8_t *)s->rx_desc[0], sizeof(s->rx_desc[0]));
> +    cpu_physical_memory_read(s->rx_desc_addr[q],
> +                             (uint8_t *)s->rx_desc[q], sizeof(s->rx_desc[q]));
>
>      /* Descriptor owned by software ? */
>      if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
>
