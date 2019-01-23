Received: from eggs.gnu.org ([209.51.188.92]:50479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmS6G-0004J5-Ll
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:38:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmS6F-00047T-6t
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:38:28 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmS6E-00044r-By
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:38:26 -0500
Received: by mail-pg1-x544.google.com with SMTP id g189so1796421pgc.5
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 15:38:26 -0800 (PST)
References: <20190123213227.17077-1-aaron@os.amperecomputing.com>
	<20190123213227.17077-3-aaron@os.amperecomputing.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1627fb0b-b2a0-1cb5-71b3-ddeb1f07bf8c@linaro.org>
Date: Wed, 23 Jan 2019 15:38:22 -0800
MIME-Version: 1.0
In-Reply-To: <20190123213227.17077-3-aaron@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 2/2] target/arm: Add a timer to predict
 PMU counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 1/23/19 1:32 PM, Aaron Lindsay OS wrote:
> Make PMU overflow interrupts more accurate by using a timer to predict
> when they will overflow rather than waiting for an event to occur which
> allows us to otherwise check them.
> 
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> ---
>  target/arm/cpu.c    | 12 ++++++++
>  target/arm/cpu.h    | 10 +++++++
>  target/arm/helper.c | 72 +++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 92 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
