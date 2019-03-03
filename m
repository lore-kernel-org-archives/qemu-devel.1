Received: from eggs.gnu.org ([209.51.188.92]:46153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0ab3-0007ks-0o
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0ab2-00045z-BM
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:32:41 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h0ab2-00045g-43
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:32:40 -0500
Received: by mail-pf1-x444.google.com with SMTP id d25so1605475pfn.8
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 15:32:39 -0800 (PST)
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-7-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eebd0552-284d-285b-2cb4-456cf7c6c67e@linaro.org>
Date: Sun, 3 Mar 2019 15:32:35 -0800
MIME-Version: 1.0
In-Reply-To: <20190303172343.13406-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/8] target/ppc: switch fpr/vsrl registers
 so all VSX registers are in host endian order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 3/3/19 9:23 AM, Mark Cave-Ayland wrote:
> When VSX support was initially added, the fpr registers were added at
> offset 0 of the VSR register and the vsrl registers were added at offset
> 1. This is in contrast to the VMX registers (the last 32 VSX registers) which
> are stored in host-endian order.
> 
> Switch the fpr/vsrl registers so that the lower 32 VSX registers are now also
> stored in host endian order to match the VMX registers. This ensures that TCG
> vector operations involving mixed VMX and VSX registers will function
> correctly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/cpu.h      | 4 ++--
>  target/ppc/internal.h | 8 ++++----
>  target/ppc/machine.c  | 8 ++++----
>  3 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
