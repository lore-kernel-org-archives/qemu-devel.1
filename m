Received: from eggs.gnu.org ([209.51.188.92]:33692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWTa-00069S-Vk
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWTa-0005x8-8X
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:20:10 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwWTZ-0005un-VY
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:20:10 -0500
Received: by mail-pl1-x642.google.com with SMTP id o6so12622787pls.13
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:20:09 -0800 (PST)
References: <20190219125808.25174-1-peter.maydell@linaro.org>
	<20190219125808.25174-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <70f7f6ea-162c-997d-6658-79c66e90e850@linaro.org>
Date: Wed, 20 Feb 2019 10:20:06 -0800
MIME-Version: 1.0
In-Reply-To: <20190219125808.25174-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/8] target/arm/arm-powerctl: Add new
 arm_set_cpu_on_and_reset()
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

On 2/19/19 4:58 AM, Peter Maydell wrote:
> Currently the Arm arm-powerctl.h APIs allow:
>  * arm_set_cpu_on(), which powers on a CPU and sets its
>    initial PC and other startup state
>  * arm_reset_cpu(), which resets a CPU which is already on
>    (and fails if the CPU is powered off)
> 
> but there is no way to say "power on a CPU as if it had
> just come out of reset and don't do anything else to it".
> 
> Add a new function arm_set_cpu_on_and_reset(), which does this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/arm-powerctl.h | 16 +++++++++++
>  target/arm/arm-powerctl.c | 56 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
