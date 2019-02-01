Received: from eggs.gnu.org ([209.51.188.92]:41607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpRKg-0001BA-0n
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpRKe-0001TI-2S
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:25:41 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gpRKS-0001Fv-T4
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:25:32 -0500
Received: by mail-pf1-x444.google.com with SMTP id b7so2591625pfi.8
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 21:25:19 -0800 (PST)
References: <20190130203638.21179-1-mark.cave-ayland@ilande.co.uk>
	<20190130203638.21179-3-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91500162-f81f-e958-3bdf-eaee217e0a00@linaro.org>
Date: Thu, 31 Jan 2019 21:25:15 -0800
MIME-Version: 1.0
In-Reply-To: <20190130203638.21179-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/8] target/ppc: rework vmrg{l, h}{b, h,
 w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 1/30/19 12:36 PM, Mark Cave-Ayland wrote:
> The current implementations make use of the endian-specific macros MRGLO/MRGHI
> and also reference HI_IDX and LO_IDX directly to calculate array offsets.
> 
> Rework the implementation to use the Vsr* macros so that these per-endian
> references can be removed.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/int_helper.c | 54 +++++++++++++++++--------------------------------
>  1 file changed, 19 insertions(+), 35 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
