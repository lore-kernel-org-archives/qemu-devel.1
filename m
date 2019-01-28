Received: from eggs.gnu.org ([209.51.188.92]:42655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9if-0000Cl-D0
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9ib-0006Hx-Ii
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:25:09 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:39010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9ib-0006Gp-AD
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:25:05 -0500
Received: by mail-pg1-x52c.google.com with SMTP id w6so7413787pgl.6
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 08:25:05 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-19-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <08e7d0bd-8f29-d867-436e-e229ddfb6335@linaro.org>
Date: Mon, 28 Jan 2019 08:25:00 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/23] hw/arm/armsse: Add
 unimplemented-device stub for CPU local control registers
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
> The SSE-200 has a "CPU local security control" register bank; add an
> unimplemented-device stub for it. (The register bank has only one
> interesting register, which allows the guest to lock down changes
> to various CPU registers so they cannot be modified further. We
> don't support that in our Cortex-M33 model anyway.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armsse.h |  1 +
>  hw/arm/armsse.c         | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
