Received: from eggs.gnu.org ([209.51.188.92]:36317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWcC-0003sq-Tn
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWcB-0002TB-5n
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:29:04 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:36852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwWc9-0002S4-EA
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:29:03 -0500
Received: by mail-pg1-x533.google.com with SMTP id r124so12287704pgr.3
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:29:01 -0800 (PST)
References: <20190219125808.25174-1-peter.maydell@linaro.org>
	<20190219125808.25174-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fe9a6375-56be-89e8-0f6c-1d2227cf1211@linaro.org>
Date: Wed, 20 Feb 2019 10:28:57 -0800
MIME-Version: 1.0
In-Reply-To: <20190219125808.25174-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/8] hw/arm/iotkit-sysctl: Implement
 CPUWAIT and INITSVTOR*
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
> The CPUWAIT register acts as a sort of power-control: if a bit
> in it is 1 then the CPU will have been forced into waiting
> when the system was reset (which in QEMU we model as the
> CPU starting powered off). Writing a 0 to the register will
> allow the CPU to boot (for QEMU, we model this as powering
> it on). Note that writing 0 to the register does not power
> off a CPU.
> 
> For this to work correctly we need to also honour the
> INITSVTOR* registers, which let the guest control where the
> CPU will load its SP and PC from when it comes out of reset.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/iotkit-sysctl.c | 41 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
