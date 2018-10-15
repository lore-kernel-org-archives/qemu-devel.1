Received: from eggs.gnu.org ([2001:4830:134:3::10]:44841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC4uE-0004h7-7s
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC4u9-0006Bq-9f
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:35:42 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC4u7-00069f-3p
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 11:35:36 -0400
Received: by mail-pf1-x442.google.com with SMTP id f26-v6so9857355pfn.9
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 08:35:32 -0700 (PDT)
References: <20181012144235.19646-1-peter.maydell@linaro.org>
	<20181012144235.19646-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3d114553-21c4-6efe-9e06-a5dff491473e@linaro.org>
Date: Mon, 15 Oct 2018 08:35:28 -0700
MIME-Version: 1.0
In-Reply-To: <20181012144235.19646-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/10] target/arm: Implement HCR.VI and VF
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

On 10/12/18 7:42 AM, Peter Maydell wrote:
> The HCR_EL2 VI and VF bits are supposed to track whether there is
> a pending virtual IRQ or virtual FIQ. For QEMU we store the
> pending VIRQ/VFIQ status in cs->interrupt_request, so this means:
>  * if the register is read we must get these bit values from
>    cs->interrupt_request
>  * if the register is written then we must write the bit
>    values back into cs->interrupt_request
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 47 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
