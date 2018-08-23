Received: from eggs.gnu.org ([2001:4830:134:3::10]:51441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstUJ-0000kO-2r
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstUE-0005BY-0V
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:33:39 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fstUD-0005B1-Nw
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:33:33 -0400
Received: by mail-pg1-x542.google.com with SMTP id b129-v6so2948064pga.13
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 10:33:33 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-20-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <25543a01-8243-1389-3650-d3bd03fa16b5@linaro.org>
Date: Thu, 23 Aug 2018 10:33:27 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/22] hw/ssi/pl022: Correct wrong value
 for PL022_INT_RT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, patches@linaro.org

On 08/20/2018 07:11 AM, Peter Maydell wrote:
> The PL022 interrupt registers have bits allocated as:
>  0: ROR (receive overrun)
>  1: RT (receive timeout)
>  2: RX (receive FIFO half full or less)
>  3: TX (transmit FIFO half full or less)
> 
> A cut and paste error meant we had the wrong value for
> the PL022_INT_RT constant. This bug doesn't affect device
> behaviour, because we don't implmenet the receive timeout

implement.

> feature and so never set that interrupt bit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/ssi/pl022.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
