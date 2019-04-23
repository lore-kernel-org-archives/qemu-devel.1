Received: from eggs.gnu.org ([209.51.188.92]:54783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ33J-0001iD-AX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ33I-000143-6O
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:34:09 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ33G-0000tp-3q
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:34:08 -0400
Received: by mail-pl1-x642.google.com with SMTP id o5so3817707pls.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 14:33:54 -0700 (PDT)
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5729634a-fc95-a6bb-cb97-3daa3daeba37@linaro.org>
Date: Tue, 23 Apr 2019 14:33:50 -0700
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/26] target/arm: Handle SFPA and FPCA
 bits in reads and writes of CONTROL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 4/16/19 5:57 AM, Peter Maydell wrote:
> The M-profile CONTROL register has two bits -- SFPA and FPCA --
> which relate to floating-point support, and should be RES0 otherwise.
> Handle them correctly in the MSR/MRS register access code.
> Neither is banked between security states, so they are stored
> in v7m.control[M_REG_S] regardless of current security state.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 57 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 49 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
