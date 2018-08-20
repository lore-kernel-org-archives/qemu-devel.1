Received: from eggs.gnu.org ([2001:4830:134:3::10]:44652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1froxh-0000TK-Hw
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1frols-0002aS-3D
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:19:23 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1frolr-0002Yt-3i
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:19:19 -0400
Received: by mail-pf1-x444.google.com with SMTP id i26-v6so7160066pfo.12
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 11:19:17 -0700 (PDT)
References: <20180820153020.21478-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7010289b-19ee-f5a5-93c0-0ceb4409b111@linaro.org>
Date: Mon, 20 Aug 2018 11:19:12 -0700
MIME-Version: 1.0
In-Reply-To: <20180820153020.21478-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/6] target/arm: Some pieces of support
 for 32-bit Hyp mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Luc Michel <luc.michel@greensocs.com>, patches@linaro.org

On 08/20/2018 08:30 AM, Peter Maydell wrote:
> Peter Maydell (6):
>   target/arm: Implement RAZ/WI HACTLR2
>   target/arm: Implement AArch32 HCR and HCR2
>   target/arm: Factor out code for taking an AArch32 exception
>   target/arm: Implement support for taking exceptions to Hyp mode
>   target/arm: Clear CPSR.IL and CPSR.J on 32-bit exception entry
>   hw/arm/boot: AArch32 kernels should be started in Hyp mode if
>     available

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
