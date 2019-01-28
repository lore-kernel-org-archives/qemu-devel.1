Received: from eggs.gnu.org ([209.51.188.92]:45227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9pK-00062S-Tl
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9pJ-0006Ox-1K
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:32:02 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9pH-0006E0-5C
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:32:00 -0500
Received: by mail-pg1-x544.google.com with SMTP id m1so7421665pgq.8
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 08:31:53 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-23-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <55a04e92-4d8e-8455-e16f-bdd45b094a68@linaro.org>
Date: Mon, 28 Jan 2019 08:31:48 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-23-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/23] hw/arm/mps2-tz: Add IRQ
 infrastructure to support SSE-200
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 1/21/19 10:51 AM, Peter Maydell wrote:
> In preparation for adding support for the AN521 MPS2 image, we need
> to handle wiring up the MPS2 device interrupt lines to both CPUs in
> the SSE-200, rather than just the one that the IoTKit has.
> 
> Abstract out a "connect to the IoTKit interrupt line" function
> and make it connect to a splitter which feeds both sets of inputs
> for the SSE-200 case.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/mps2-tz.c | 79 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 59 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
