Received: from eggs.gnu.org ([209.51.188.92]:46177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBcv-0000H2-Ny
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBcn-0002pM-Ug
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:15:07 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:38212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnBcl-0002lX-T9
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:15:04 -0500
Received: by mail-pl1-x635.google.com with SMTP id e5so5273873plb.5
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 16:15:02 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ca02f794-4b31-1e2d-7276-b7ffea3904cc@linaro.org>
Date: Fri, 25 Jan 2019 16:14:58 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/23] hw/arm/armsse: Support dual-CPU
 configuration
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
> The SSE-200 has two Cortex-M33 CPUs. These see the same view
> of memory, with the exception of the "private CPU region" which
> has per-CPU devices. Internal device interrupts for SSE-200
> devices are mostly wired up to both CPUs, with the exception of
> a few per-CPU devices. External GPIO inputs on the SSE-200
> device are provided for the second CPU's interrupts above 32,
> as is already the case for the first CPU.
> 
> Refactor the code to support creation of multiple CPUs.
> For the moment we leave all CPUs with the same view of
> memory: this will not work in the multiple-CPU case, but
> we will fix this in the following commit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armsse.h |  21 +++-
>  hw/arm/armsse.c         | 206 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 180 insertions(+), 47 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
