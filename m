Received: from eggs.gnu.org ([2001:4830:134:3::10]:49222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxYbN-0004Aw-M4
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxYbM-0005r7-R1
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:39:25 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxYbM-0005qy-LL
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:39:24 -0400
Received: by mail-wm0-x230.google.com with SMTP id u2so36234656wmu.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 05:39:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a0d9c14a38201af8f4838e2c84cadec573d56e13.1491349058.git.alistair.francis@xilinx.com>
References: <cover.1491349058.git.alistair.francis@xilinx.com>
	<a0d9c14a38201af8f4838e2c84cadec573d56e13.1491349058.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 13:39:03 +0100
Message-ID: <CAFEAcA8=0VYkAtNYk3Huz97fXhoNoJx6xN5N1inSh7568tCNfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On 5 April 2017 at 00:40, Alistair Francis <alistair.francis@xilinx.com> wrote:
> Read the correct descriptor instead of hardcoding the first (q=0).
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
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
> --
> 2.9.3
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
