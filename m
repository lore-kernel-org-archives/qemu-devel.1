Received: from eggs.gnu.org ([2001:4830:134:3::10]:44291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fspiO-0002bi-5u
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fspiK-0006Cl-0X
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:31:56 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:34002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fspiJ-0006Bs-Kk
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:31:51 -0400
Received: by mail-pl0-x242.google.com with SMTP id f6-v6so2428773plo.1
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 06:31:51 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6963bd38-f7fb-dce0-f857-edc65e619de7@linaro.org>
Date: Thu, 23 Aug 2018 06:31:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/22] hw/misc/mps2-fpgaio: Implement
 PSCNTR and COUNTER
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

On 08/20/2018 07:10 AM, Peter Maydell wrote:
> In the MPS2 FPGAIO, PSCNTR is a free-running downcounter with
> a reload value configured via the PRESCALE register, and
> COUNTER counts up by 1 every time PSCNTR reaches zero.
> Implement these counters.
> 
> We can just increment the counters migration subsection's
> version ID because we only added it in the previous commit,
> so no released QEMU versions will be using it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/hw/misc/mps2-fpgaio.h |  6 +++
>  hw/misc/mps2-fpgaio.c         | 97 +++++++++++++++++++++++++++++++++--
>  2 files changed, 99 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
