Received: from eggs.gnu.org ([209.51.188.92]:54765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1xnD-0003hi-KM
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1xnC-0000t5-UY
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:30:55 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1xnC-0000sK-Nh
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:30:54 -0500
Received: by mail-pf1-x442.google.com with SMTP id i20so12081762pfo.6
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:30:54 -0800 (PST)
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
	<20190307180520.13868-8-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2854ee32-3fff-2dce-6af0-b07d1f86ac5b@linaro.org>
Date: Thu, 7 Mar 2019 10:30:50 -0800
MIME-Version: 1.0
In-Reply-To: <20190307180520.13868-8-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/7] target/ppc: introduce
 vsr64_offset() to simplify get_cpu_vsr{l, h}() and set_cpu_vsr{l, h}()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 3/7/19 10:05 AM, Mark Cave-Ayland wrote:
> Now that all VSX registers are stored in host endian order, there is no need
> to go via different accessors depending upon the register number. Instead we
> introduce vsr64_offset() and use it directly from within get_cpu_vsr{l,h}() and
> set_cpu_vsr{l,h}().
> 
> This also allows us to rewrite avr64_offset() and fpr_offset() in terms of the
> new vsr64_offset() function to more clearly express the relationship between the
> VSX, FPR and VMX registers, and also remove vsrl_offset() which is no longer
> required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/cpu.h                    | 20 ++++++++++----------
>  target/ppc/translate/vsx-impl.inc.c | 34 ++++------------------------------
>  2 files changed, 14 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
