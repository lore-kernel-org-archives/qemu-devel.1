Received: from eggs.gnu.org ([2001:4830:134:3::10]:43869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvifa-00065u-UT
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 07:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvifW-00029p-PP
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 07:00:10 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvifW-00029O-LJ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 07:00:06 -0400
Received: by mail-qk0-x243.google.com with SMTP id v75so1113545qkb.3
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 04:00:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1491349058.git.alistair.francis@xilinx.com>
	<325f60be9b819f261848db3d69554da640294ca4.1491349058.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5af709a8-3477-2db9-f419-c5c866c09678@amsat.org>
Date: Wed, 5 Apr 2017 08:00:02 -0300
MIME-Version: 1.0
In-Reply-To: <325f60be9b819f261848db3d69554da640294ca4.1491349058.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 3/5] cadence_gem: Only trigger
 interrupts if the status register is set
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
> Only trigger multi-queue GEM interrupts if the interrupt status register
> is set. This logic was already used for non multi-queue interrupts but
> it also applies to multi-queue interrupts.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>
>  hw/net/cadence_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 3e37665..b9eaed4 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -518,7 +518,7 @@ static void gem_update_int_status(CadenceGEMState *s)
>      }
>
>      for (i = 0; i < s->num_priority_queues; ++i) {
> -        if (s->regs[GEM_INT_Q1_STATUS + i]) {
> +        if (s->regs[GEM_INT_Q1_STATUS + i] && s->regs[GEM_ISR]) {
>              DB_PRINT("asserting int. (q=%d)\n", i);
>              qemu_set_irq(s->irq[i], 1);
>          }
>
