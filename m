Received: from eggs.gnu.org ([209.51.188.92]:58386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h09us-0000PO-Qa
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h09ur-0003p1-Rm
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:03:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h09ur-0003oF-K8
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 14:03:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id w2so1242848wrt.11
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 11:03:21 -0800 (PST)
References: <20190122121413.31437-1-ysato@users.sourceforge.jp>
	<20190302062138.10713-1-ysato@users.sourceforge.jp>
	<20190302062138.10713-12-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7d420080-092d-9baf-e503-953cbebbdad2@redhat.com>
Date: Sat, 2 Mar 2019 20:03:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190302062138.10713-12-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v3 11/11] MAINTAINERS: Add RX entry.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org

On 3/2/19 7:21 AM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  MAINTAINERS | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5040d9dfb1..141c4994b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -270,6 +270,14 @@ F: include/hw/riscv/
>  F: linux-user/host/riscv32/
>  F: linux-user/host/riscv64/
>  
> +RX

RX sounds very generic, what about:

  Renesas Extreme (RX)

Or

  RX (Renesas Extreme)

> +M: Yoshinori Sato <ysato@users.sourceforge.jp>
> +S: Maintained
> +F: target/rx/
> +F: hw/rx/
> +F: include/hw/rx/
> +F: disas/rx.c
> +
>  S390
>  M: Richard Henderson <rth@twiddle.net>
>  M: David Hildenbrand <david@redhat.com>
> @@ -1084,6 +1092,18 @@ F: pc-bios/canyonlands.dt[sb]
>  F: pc-bios/u-boot-sam460ex-20100605.bin
>  F: roms/u-boot-sam460ex
>  
> +RX Machines
> +-----------
> +RX-QEMU
> +M: Yoshinori Sato <ysato@users.sourceforge.jp>
> +S: Maintained
> +F: hw/rx/rxqemu.c
> +F: hw/intc/rx_icu.c
> +F: hw/timer/renesas_*.c
> +F: hw/char/renesas_sci.c
> +F: include/hw/timer/renesas_*.h
> +F: include/hw/char/renesas_sci.h
> +
>  SH4 Machines
>  ------------
>  R2D
> 
